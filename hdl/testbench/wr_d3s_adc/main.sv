`timescale 1ns/1ps

import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"

`include "d3s_acq_buffer_wb.vh"


class RFGenerator;

   real sample_freq;
  int lp_ratio;
   real lp_sample_freq;
   real lp_sample_period;
   real tune_start;
   real tune_end;
   real tune_t_max;
   real mod_period;
   real mod_f1, mod_f2;
   real t, dt, phi;
   
   uint64_t t_int;
   uint64_t mod_period_int;
   
   real y_under[$];
   real y_orig[$];
   

   function new();
      
      sample_freq = 1e10 ;
      lp_ratio = 80 ;
      lp_sample_freq = sample_freq/lp_ratio;
      lp_sample_period = (1.0/lp_sample_freq);
      tune_start = 0e6 ;
      tune_end = 3e6;
      tune_t_max = 20;
      mod_period = 1.0/44e3;
      mod_f1 = 197e6;
      mod_f2 = 202e6;
      t=0;
      t_int=0;
      phi=0;

      $display("Undersampling freq %.0f", lp_sample_freq);
      
      
      dt = 1.0/sample_freq;
      
      mod_period_int = mod_period * sample_freq;
         
   endfunction
   
   function real f_rf (real t);
      
      real f_base = tune_start + (t / tune_t_max) * (tune_end-tune_start);
      
      if( t_int % mod_period_int < mod_period_int / 2 )
	return mod_f1 + f_base;
      else
	return mod_f2 + f_base;

   endfunction // f_rf


   
   
   function run(int n);
      int  i;
      real y;
      
      for(i=0;i<n;i++)begin
	 y=$cos(phi);
	 phi += 2.0*3.14159265358*f_rf(t) * dt;

	 y_orig.push_back(y);
      
	 if( (t_int % lp_ratio) == 0)
	   y_under.push_back(y);

	 t_int++;
	 t+=dt;
      end

   endfunction // run

   function real y();
      if ( y_orig.size() == 0 )
	run(10000);
      

      return y_orig.pop_front();
   endfunction // y_orig
   
   function real y_under_sample();
      if ( y_under.size() == 0 )
	run(10000);
      

      return y_under.pop_front();
      
   endfunction // y_under_sample
   

      


      
   
endclass // RFGenerator



module main;

   reg rst_n = 0;
   reg clk_dac = 0;
   
   reg clk_sys = 0;
   reg clk_wr =0, clk_wr_2x = 0;

   reg frev_in = 0;


   initial begin
      #3us frev_in <= 1;
      #10ns frev_in <= 0;
   end
   

   
   always #1ns clk_dac <= ~clk_dac; // 500 MHz DAC clock
   
   always@(posedge clk_dac)
     clk_wr_2x <= ~clk_wr_2x;

   always@(posedge clk_wr_2x)
     clk_wr <= ~clk_wr;

   always@(posedge clk_wr)
     clk_sys <= ~clk_sys;

   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   IVHDWishboneMaster Host1 ( clk_sys, rst_n );
   IVHDWishboneMaster Host2 ( clk_sys, rst_n );

   reg [39:0]  tm_tai = 100;
   reg [31:0]  tm_nsec = 0;
   
   // 1GHz nsec counter
   always@(posedge clk_dac or negedge clk_dac) begin
      if(tm_nsec == 1000000000-1) begin
	 tm_tai <= tm_tai + 1;
	 tm_nsec <= 0;
      end      else
	tm_nsec <= tm_nsec + 1;
   end


   RFGenerator gen = new;

   reg clk_adc = 0;
   reg clk_samp = 0;
   
   always #1ns clk_adc <= ~clk_adc;

   real t = 0;

   reg [13:0] sine;
   

   int samples[$];
   int pos = 0;

   real sine_in;
   
   
   initial forever begin
      sine_in = gen.y();
      #100ps;
   end
   

   real y_under;
   
   
   
   always@(posedge clk_wr)
     begin
	y_under = gen.y_under_sample();
	
	sine <= int'(2000.0*y_under);
     end

   reg [31:0] frev_ts_ns;
   reg [31:0] frev_ts_tai;
   
   reg frev_ts_valid = 0; 


   always@(posedge frev_in)
     begin
	frev_ts_ns <= tm_nsec;
	frev_ts_tai <= tm_tai;

	@(posedge clk_wr);
	frev_ts_valid <= 1;
	@(posedge clk_wr);
	frev_ts_valid <= 0;
	@(posedge clk_wr);
	
     end
   
   
   
   wr_d3s_adc
     
     #(
.g_use_fake_data(1)
       )
DUT (
	  .rst_n_sys_i(rst_n),
	  .clk_sys_i (clk_wr),
	  .adc_dco_p_i(clk_adc),
	  .adc_dco_n_i(~clk_adc),

	  .fake_data_i(sine),

	  .slave_i(Host1.master.out),
	  .slave_o(Host1.master.in)

 
     );


   d3s_upsample_divide DUT2
     (
      .clk_i(clk_wr),
      .rst_n_i(rst_n),
      .phase_i (DUT.raw_phase[13:0]),

      .frev_ts_tai_i(frev_ts_tai),
      .frev_ts_nsec_i(frev_ts_ns),
      .frev_ts_valid_i(frev_ts_valid),

      .tm_time_valid_i(1'b1),
      .tm_tai_i(tm_tai),
      .tm_cycles_i(tm_nsec[30:3])
      );
   
     
  


   


   initial begin
      uint64_t rv;
      CBusAccessor acc = Host1.get_accessor();
      
      
      #10us;
      

	acc.write('h100 + `ADDR_ACQ_CR, `ACQ_CR_START);

      #10us;
      acc.read('h100 + `ADDR_ACQ_CR, rv);

      $display("Rv %x", rv);
      
      
		    

   end
   
   
endmodule

`timescale 1ns/1ps

import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"

`include "d3s_acq_buffer_wb.vh"
`include "wr_d3s_adc.vh"
`include "wr_d3s_adc_slave.vh"

// from ADC to raw_phase : 3262ns

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
   real y_sign_q[$];
   

   function new();
      
      sample_freq = 1e10 ;
      lp_ratio = 80 ;
      lp_sample_freq = sample_freq/lp_ratio;
      lp_sample_period = (1.0/lp_sample_freq);
      tune_start = 0e6 ;
      tune_end = 3e6;
      tune_t_max = 20;
      mod_period = 1.0/44e3;
      mod_f1 = 190e6;
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

    function real a_rf (real t);


       
      if( t_int % mod_period_int < mod_period_int / 2 )
	return 1;
      else
	return -1;

    endfunction // a_rf
   

   
   
   
   function run(int n);
      int  i;
      real y;
      
      for(i=0;i<n;i++)begin
	 y_sign_q.push_back(a_rf(t));

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

   function real y_sign();
      if ( y_sign_q.size() == 0 )
	run(10000);
      

      return y_sign_q.pop_front();
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

   parameter g_h_divider = 2000;
   parameter g_delay_us = 300;
   

   
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

   real sine_in, sine_in_d0;
   
   reg 	clk_rf = 0;
   

   real a_rf = 0;
   
   
   initial forever begin
      a_rf <= gen.y_sign();
      
      sine_in <= gen.y();
      sine_in_d0 <= sine_in;
      if(sine_in_d0 < 0 && sine_in >= 0)
	clk_rf <= 1;
      else if (sine_in_d0 >=0 && sine_in < 0)
	clk_rf <= 0;
      
      #100ps;
   end
   

   // produce the fake fRev

   int frev_count = 0;

   always@(posedge clk_rf) begin
      if (frev_count == g_h_divider - 1)
	begin
	   frev_count <= 0;
	   frev_in <= 1;
	end else begin
	   frev_count <= frev_count + 1;
	   frev_in <= 0;
	end
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
     .tm_cycles_i(tm_nsec[30:3]),
	  .fake_data_i(sine),

	  .slave_i(Host1.master.out),
	  .slave_o(Host1.master.in)

 
     );


      wr_d3s_adc_slave
     
	DUT_S (
	  .rst_n_sys_i(rst_n),
	  .clk_sys_i (clk_wr),

     .tm_cycles_i(tm_nsec[30:3]),
	       
	    .wr_ref_clk_p_i (clk_wr),
	    .wr_ref_clk_n_i (~clk_wr),

	  .slave_i(Host2.master.out),
	  .slave_o(Host2.master.in)

 
     );

/* -----\/----- EXCLUDED -----\/-----

   d3s_upsample_divide DUT2
     (
      .clk_i(clk_wr),
      .rst_n_sys_i(rst_n),
      .phase_i (DUT.raw_phase[13:0]),

      .frev_ts_tai_i(frev_ts_tai),
      .frev_ts_nsec_i(frev_ts_ns),
      .frev_ts_valid_i(frev_ts_valid),

      .tm_time_valid_i(1'b1),
      .tm_tai_i(tm_tai),
      .tm_cycles_i(tm_nsec[30:3])
      );
 -----/\----- EXCLUDED -----/\----- */
   
     
  

     

   typedef struct {
      bit 	  is_rl;
      int 	  phase;
      int 	  length;
      uint32_t cycles;
      uint64_t r0, r1, r2;
   } phase_rl_record_t;


class PhaseData;
   logic [22:0]   integ;

   int 		  start_time;
   int 		  current_time;

   int 		  samples[$];

   
   function  new();
      current_time = 0;
   endfunction // uncompress

   task automatic set_start_time(int start_time_);
      start_time = start_time_;
   endtask // set_start_time

   task automatic set_current_time(int current_time_);
      current_time = current_time_;
   endtask // set_current_time
   

   task add(int sample);
      samples.push_back(sample);
   endtask // add

   task uncompress(ref phase_rl_record_t rec);
//      $display("Uncompress!");
      
      if(!rec.is_rl) begin
	 integ = rec.phase;
	 samples.push_back(rec.phase);
      end else begin
	 int i;
//	 if(samples.size() < 100)
//	   $display("dphase %d %d", rec.phase, rec.length);
	 
	 for(i = 0; i<rec.length;i++) begin
	    
	    integ = integ+rec.phase;
	    samples.push_back(integ);
	    
//	    $display("i %d integ %d", i, integ);
	    
	 end
      end
   endtask // uncompress
   
   
   
   
endclass // Decompressor
   
   
   task automatic uncompress ( ref phase_rl_record_t rec, ref out_samples[$] );
      
   endtask // uncompress
   

   PhaseData ph_unc = new, ph_rec = new;


   initial begin
      forever begin
	 @(posedge clk_wr);
	 if(DUT.U_Phase_Enc.fifo_en_i)
	   ph_unc.add(DUT.U_Phase_Enc.rl_phase_ext);
      end
   end


   phase_rl_record_t compr_records[$];
   
   
   
   initial begin
      uint64_t rv;
      CBusAccessor acc = Host1.get_accessor();
      int max_error_deg = 3;
      int max_err = (1<<(9+14))  * max_error_deg / 360;
      
      
      #50us;

      
      acc.write(`ADDR_D3S_CR, `D3S_CR_ENABLE);
      

      acc.write(`ADDR_D3S_RL_ERR_MIN, -max_err);
      acc.write(`ADDR_D3S_RL_ERR_MAX, max_err);
      acc.write(`ADDR_D3S_RL_LENGTH_MAX, 2000);
      
      
		     
      while(1)
	begin
	   uint64_t rv,r0,r1,r2;


	   
	   
	   acc.read(`ADDR_D3S_ADC_CSR, rv);

	   if(!(rv & `D3S_ADC_CSR_EMPTY)) begin
	      phase_rl_record_t  rec;
	      
	      acc.read(`ADDR_D3S_ADC_R0, r0);
	      acc.read(`ADDR_D3S_ADC_R1, r1);
	      acc.read(`ADDR_D3S_ADC_R2, r2);

	      rec.r0 = r0;
	      rec.r1=r1;
	      rec.r2=r2;
	      
	      
	      rec.is_rl = (r0 & `D3S_ADC_R0_IS_RL) ? 1 : 0;
	      rec.cycles = r0 & `D3S_ADC_R0_TSTAMP ;
	      rec.phase = r2;
	      rec.length = r1 & `D3S_ADC_R1_RL_LENGTH;

	  //    $display("is_rl %d cyc %d phase %d len %d", rec.is_rl, rec.cycles, rec.phase, rec.length);
	      compr_records.push_back(rec);
	      
	      ph_rec.uncompress(rec);
	      
	      
  
	   end
	   
	end
      
      
		    

   end // initial begin

   initial begin
      CBusAccessor acc_slave = Host2.get_accessor();

      #10us;
      acc_slave.write(`ADDR_D3SS_REC_DELAY_COARSE, (200000/8)); // 20us
      acc_slave.write(`ADDR_D3SS_CR, `D3SS_CR_ENABLE);

      forever begin
	 uint64_t fifo_stat;

	 acc_slave.read(`ADDR_D3SS_PHFIFO_CSR, fifo_stat);
	 
	 
	 if(compr_records.size() > 0 && !(fifo_stat & `D3SS_PHFIFO_CSR_FULL))
	   begin
	      phase_rl_record_t  rec;
	      rec = compr_records.pop_front();
	      
	      
	      acc_slave.write(`ADDR_D3SS_PHFIFO_R0, rec.r0);
	      acc_slave.write(`ADDR_D3SS_PHFIFO_R1, rec.r1);
	      acc_slave.write(`ADDR_D3SS_PHFIFO_R2, rec.r2);

	end  else begin
	   #100ns;
	end // if (!compr_records.empty() && !(fifo_stat & `D3SS_PHFIFO_CSR_FULL))
	 
      end // forever begin
      
   end // initial begin
   
   
   
   initial
     begin
	int i;
	int max_err= 0, err;
	
	#200us;
	for(i=0;i<ph_rec.samples.size();i++) begin
	  err = ph_unc.samples[i] - ph_rec.samples[i];
	   
	  $display("%d %d %d %d", i, ph_unc.samples[i], ph_rec.samples[i], err);
	   if((err > 0 ? err : -err) > max_err)
	     max_err = (err > 0 ? err : -err);
	   
	   end

	$display("MaxErr %d %.3f [%d/%d samples, %d records]\n", max_err, real'(max_err)/real'(1<<23), ph_unc.samples.size(), ph_rec.samples.size(), compr_records.size());
	
	
   end
   
   
   
endmodule

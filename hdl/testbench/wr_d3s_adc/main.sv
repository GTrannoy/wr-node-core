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
      
      sample_freq = 1e9 ;
      lp_ratio = 8 ;
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
	 if( t_int % lp_ratio == 0)
	   y_under.push_back(y);

	 t_int++;
	 t+=dt;
      end

   endfunction // run

   function real y_under_sample();
      if ( y_under.size() == 0 )
	run(100);
      

      return y_under.pop_front();
      
   endfunction // y_under_sample
   

      


      
   
endclass // RFGenerator



module main;

   reg rst_n = 0;
   reg clk_dac = 0;
   
   reg clk_sys = 0;
   reg clk_wr =0, clk_wr_2x = 0;

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
   reg [27:0]  tm_cycles = 125000000-3000;

   always@(posedge clk_wr) begin
      if(tm_cycles == 125000000-1) begin
	 tm_tai <= tm_tai + 1;
	 tm_cycles <= 0;
      end      else
	tm_cycles <= tm_cycles + 1;
   end
   
   RFGenerator gen = new;
   

/* -----\/----- EXCLUDED -----\/-----
   reg[13:0] y_int;
   
   
   always@(posedge clk_wr) begin
      y_int <= int'( 8191.0 * gen.y_under_sample() );
   end

   reg fifo_en = 0;
   wire fifo_we;

   const real phase_scalefactor = real'(1<<23);
   const real max_phase_error_deg = 3.0;
   const real m_pi = 3.14159265358;
   
	     
   const bit [22:0] r_max_error = int' (max_phase_error_deg / 360.0 * phase_scalefactor );
   const bit [22:0] r_min_error = int' (-max_phase_error_deg / 360.0 * phase_scalefactor );
   
   
   d3s_phase_encoder DUT (
			  .clk_i  (clk_wr),
			  .rst_n_i (rst_n),

			  .adc_data_i (y_int),
			  .fifo_en_i(fifo_en),
			  .fifo_we_o(fifo_we),

			  .r_max_error_i(r_max_error),
			  .r_min_error_i(r_min_error),
			  .r_max_run_len_i(16'd10000)
			  );

   reg[7:0] delay_d = 0 ;

   always@(posedge clk_wr)
     delay_d <= delay_d + 1;
   

   initial #10us fifo_en <= 1;

   int 	    n_records = 0;
   
   
   always@(posedge clk_wr)
     if(fifo_we)
       n_records++;
   
       
   
   
   gc_moving_average
     #(
       .g_avg_log2(4),
       .g_data_width(8)
       ) DUT2 (
	      .clk_i (clk_wr),
	      .rst_n_i (rst_n),
	      

	      .din_i (8'h1)
	      );
   

 -----/\----- EXCLUDED -----/\----- */

   
/* -----\/----- EXCLUDED -----\/-----

    r_win_lo_i      : in std_logic_vector(15 downto 0);
    r_win_hi_i      : in std_logic_vector(15 downto 0);
    r_max_run_len_i : in std_logic_vector(15 downto 0);

    fifo_full_i : in std_logic;
    fifo_lost_o: out std_logic;
    fifo_rl_o    : out std_logic_vector(15 downto 0);
    fifo_phase_o : out std_logic_vector(31 downto 0);
    fifo_is_rl_o : out std_logic

    );
 -----/\----- EXCLUDED -----/\----- */

   reg clk_adc = 0;
   reg clk_samp = 0;
   
   always #1.25ns clk_adc <= ~clk_adc;
   always #5ns clk_samp <= ~clk_samp;

   real t = 0;

   reg [13:0] sine;
   
   
   always@(posedge clk_samp)
     begin
	sine <= 3000+3000 * $sin(real'($time) / real'(1000ms) * 2 * 3.1415926535 * 4e6);
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

`timescale 1ns/1ps

import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"
`include "d3s_acq_buffer_wb.vh"
`include "wr_d3s_adc.vh"
`include "wr_d3s_adc_slave.vh"

// from ADC to raw_phase : 3262ns

// Generates a modulated RF sinewave
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

   typedef struct {
      bit 	  is_rl;
      int 	  phase;
      int 	  length;
      uint32_t cycles;
      uint64_t r0, r1, r2;
   } phase_rl_record_t;


function automatic int max(int a, int b);
   return (a > b ? a : b);
endfunction // max

function automatic int min(int a, int b);
   return (a < b ? a : b);
endfunction // max

function automatic int abs(int x);
   return (x < 0 ? -x : x);
endfunction // max

class PhaseData;
   logic [22:0]   integ;

   int 		  start_time;
   int 		  current_time;

   int 		  samples[$];
   bit 		  got_a_fix;
   

   function  new();
      current_time = 0;
      start_time = -1;
      got_a_fix = 0;
      
   endfunction // uncompress

   task automatic set_start_time(int start_time_);
      start_time = start_time_;
   endtask // set_start_time

   task automatic set_current_time(int current_time_);
      current_time = current_time_;
   endtask // set_current_time

   function int get_start_time();
      return start_time;
   endfunction

   

   task add(int sample);
      samples.push_back(sample);
   endtask // add


   task uncompress(ref phase_rl_record_t rec);
//      $display("Uncompress!");

      int t0_last = -1;

      
//      $display("RL %d fix %d", rec.is_rl, got_a_fix);

      
      
      if(!rec.is_rl) begin
	 integ = rec.phase;
	 samples.push_back(rec.phase);
	 if(t0_last > 0 && rec.cycles != t0_last + 1)
	   $error("strange, gap in the timstamps: %d %d", t0_last + 1, rec.cycles);
	 
	 t0_last = rec.cycles;
	 got_a_fix = 1;
	 
//	 $display("uncompress fix: %d", rec.phase);
	 
      end else begin

	 
	 
	 int i;

	 if(!got_a_fix)
	   begin
	      $display("skipping RL record without a previous fixed record");
	      return;
	   end

//	 if(samples.size() < 100)
//	   $display("dphase %d %d", rec.phase, rec.length);

	 if(t0_last > 0 && rec.cycles != t0_last + 1)
	   $error("strange, gap in the timstamps: %d %d", t0_last + 1, rec.cycles);


	 
	 t0_last = rec.cycles;
//	 $display("uncompress rl: %d %d", rec.length, rec.phase);
	 	 
	 for(i = 0; i<rec.length;i++) begin
	    
	    integ = integ+(rec.phase);
	    samples.push_back(integ);
	    t0_last++;
	    
//	    $display("i %d integ %d", i, integ);
	    
	 end
      end

      if(t0_last > 0 && start_time < 0)
	begin
	   start_time = t0_last;
	   $display("Uncompress: 1st sample timestamp: %d\n", start_time);
	end
      

   endtask // uncompress

   function int sample_at(int t);
      return samples[t-start_time];
   endfunction // sample_at

   
   function int compare ( PhaseData other, real max_allowed_error );
      
      int st_max = max ( other.start_time, start_time );
      int i;
      real err_max = 0.0;
   
      int max_samples = min ( samples.size(), other.samples.size() )  - st_max;

      //$display("start_time %d max %d", st_max, max_samples);

//      max_samples = 100;
      

   //   max_samples = st_max + 100;
      
      for(i=st_max;i<max_samples;i++)
	begin
	   int err = ( sample_at(i) - other.sample_at(i) );
	   real err_deg;
	   
	   if(err < -8200000 ) // wrap-around
	     err += (1<<23);
	   if(err > 8200000 ) // wrap-around
	     err -= (1<<23);

//	   $display("Err %d %d %d %d %d", err, sample_at(i), other.sample_at(i), start_time, other.start_time);
	   
	   
	   err = abs(err);
	   err_deg = real'(err) / real'(1<<23) * 360.0;

	   if (err_deg > err_max)
	     err_max = err_deg;
	   
	   
	   
//	   $display("%d %d %d", sample_at(i), other.sample_at(i), delta );
	   
	end
  
      $display("compared %d samples, max error = %.3f deg", max_samples-st_max, err_max);
      
      return (err_max > max_allowed_error ? 1 : 0);
      
      
   endfunction // compare
   
   
   
   
   
endclass // Decompressor

module fake_dac
  (
   input 	clk_i,
   input [13:0] data_i
   );

   parameter g_bits = 14;
   parameter g_delay = 0;
   parameter g_oversample = 20;
   parameter g_step = 100;

   real 	data_o;
   
   function integer f_interp(input integer k, input integer n, input integer y0, input integer y1);
      reg[13:0] y;
      
      begin
	 if(y1 < y0)
	   y = y0 + k*((y1+(1<<g_bits))-y0)/n;
	 else
	   y = y0 + k*(y1-y0)/n;
//	 $display("%d %d %d %d -> %d", k,n,y0,y1,y);
	 
	 f_interp = y;
      end
      
   endfunction // f_interp



   reg [13:0]  y_over, y_d;
	   
   always@(posedge clk_i)
     y_d <= data_i;
   

   
   
   initial forever begin : reconstruct_undiv
      integer i,p;

      
      @(posedge clk_i);

	for( i = 0; i < g_oversample; i=i+1)
	  begin
	     #(g_step/2);
	       y_over <= f_interp(i, g_oversample  , data_i, y_d );
	     #(g_step/2);
	  end
      
   end // block: reconstruct_undiv
endmodule // fake_dac

//// Attempt to read the file with real aquired and saved data
module read_file
  (
   input clk_wr,
   input enc_started,
   output reg[13:0] sine2
   );
     
     integer data_file, scan_file;
     logic  signed[13:0] captdata;
     integer sample_n;
     integer read;
     
     initial begin
         data_file = $fopen("adc.dat", "r"); //place here file with acq.samples
         if (data_file == 0) begin
             $display("ERROR : CAN NOT OPEN THE FILE");
             $finish;
         end else 
             read = 0;
     end
     
     always @(posedge clk_wr) begin
         if ((enc_started == 1) && (read==0)) begin
             if (!$feof(data_file)) begin 
                scan_file = $fscanf(data_file, "%d %d\n", sample_n, sine2);
                //$display("Data read from file: %d\n",sine2);
             end else begin 
                $fclose(data_file);
                sine2 <= 0;
                read = 1;
                //$finish;
             end
         end
     end
     
endmodule



   
module main;

   const real max_error_deg = 3.0;

   parameter int g_clock_freq = 125000;
   parameter g_h_divider = 2000;
   parameter g_delay_us = 100;
   
   reg rst_n = 0;
   reg clk_adc = 0;
   reg clk_sys = 0;
   reg clk_wr =0, clk_wr_2x = 0;

   reg frev_in = 0;

   // =-=-=-=-=-=-=-=- CLOCK GENERATION -==-=-=-=-=-=-=-=-=-=-
   always #1ns clk_adc <= ~clk_adc; // 500 MHz ADC/DAC clock
   
   always@(posedge clk_adc)
     clk_wr_2x <= ~clk_wr_2x;  // 250 MHz

   always@(posedge clk_wr_2x)
     clk_wr <= ~clk_wr;        // 125 MHz

   always@(posedge clk_wr)
     clk_sys <= ~clk_sys;      // 62.5 MHz

   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end
   // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   
   IVHDWishboneMaster Host1 ( clk_sys, rst_n );
   IVHDWishboneMaster Host2 ( clk_sys, rst_n );

   reg [39:0]  tm_tai = 100;
   reg [31:0]  tm_nsec = 0;
   
   // =-=-=-=-=-=-=-=-=-  1GHz nsec counter    =-=-=-=-=-=-=-=
   always@(posedge clk_adc or negedge clk_adc) 
   begin
      if(tm_nsec == (g_clock_freq * 8 - 1)) 
      begin
	        tm_tai <= tm_tai + 1;
	        tm_nsec <= 0;
      end else
	        tm_nsec <= tm_nsec + 1;
   end
   // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

   RFGenerator gen = new;
   
   reg [13:0] sine, sine2;
   
//   int samples[$];{RFGenerator gen = new;}
   int pos = 0;
   real sine_in, sine_in_d0;
   reg 	clk_rf = 0;
   real a_rf = 0;


   // produce a pseudo-analog ( 10GHz sampling freq)  RF signal
   // for display purposes and to fake the square RF clock
   initial forever 
   begin
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

   always@(posedge clk_rf) 
   begin
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

   // produce the undersampled clock for the WR-DDS Master (ADC Input)
   always@(posedge clk_wr)
   begin
	        y_under = gen.y_under_sample();
	        sine <= int'(2000.0*y_under);
   end


   reg [31:0] frev_ts_ns;
   reg [31:0] frev_ts_tai;
   
   reg frev_ts_valid = 0; 

   reg enc_started;
   
   // Fake timestamper for the FRev
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
      
      
   // =-=-=-=-=- Cores under test  =-=-=-=-=-=-=-=-
   wr_d3s_adc
      
     #(
       .g_use_fake_data(1)
       )
   DUT_M (
	.rst_n_sys_i(rst_n),
	.clk_sys_i (clk_sys),
	.adc_dco_p_i(clk_adc),
	.adc_dco_n_i(~clk_adc),
	.tm_cycles_i(tm_nsec[30:3]),
	
	.fake_data_i(sine),
  .enc_started_o(enc_started),  
  
	.slave_i(Host1.master.out),
	.slave_o(Host1.master.in)
	);

   wire [14-1: 0] dac_p;

   fake_dac U_DAC(clk_adc, dac_p);
   

   wr_d3s_adc_slave
      #(
	.g_clock_freq(g_clock_freq) )
     DUT_S 
       (
	.rst_n_sys_i(rst_n),
	.clk_sys_i (clk_sys),

	.tm_time_valid_i(1'b1),
	.tm_tai_i(tm_tai),
	.tm_cycles_i(tm_nsec[30:3]),
	
	.dac_p_o(dac_p),
	
	
	.wr_ref_clk_p_i (clk_wr),
	.wr_ref_clk_n_i (~clk_wr),

	.slave_i(Host2.master.out),
	.slave_o(Host2.master.in)
	);

    read_file ReadFile(
      .clk_wr, 
      .enc_started,
      .sine2);

  //  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

   
   PhaseData ph_master = new;
   PhaseData ph_slave = new;
   PhaseData ph_check = new;
    
   // store whatever goes to the Phase Encoder's FIFO also to the ph_unc object.
   always @(posedge clk_wr)
     if(DUT_M.U_Phase_Enc.fifo_en_i)
     begin
	      if( ph_master.get_start_time() < 0 )
	      begin
	            ph_master.set_start_time(DUT_M.U_Phase_Enc.tm_cycles_i);
	            $display("Master: 1st sample timestamp: %d\n", ph_master.get_start_time());
	      end
	  
	      ph_master.add(DUT_M.U_Phase_Enc.rl_phase_ext);
   end
   
	  
   // store whatever goes to the Phase Encoder's FIFO also to the ph_unc object.
   always @(posedge clk_wr)
     if(DUT_S.U_Phase_Dec.s3_valid)
     begin
	      if( ph_slave.get_start_time() < 0 )
	      begin
	         ph_slave.set_start_time(DUT_S.U_Phase_Dec.tm_cycles_i);
	         $display("Slave: 1st sample timestamp: %d\n", ph_slave.get_start_time());
	      end
	  
	      ph_slave.add(DUT_S.U_Phase_Dec.s3_phase);
     end // if (DUT_S.U_Phase_Dec.s3_valid)
   
     phase_rl_record_t compr_records[$];
     int n_records = 0;
   
   // Master process: configure the compressor, start sampling, push all records to a queue
   initial begin
      uint64_t rv;
      automatic CBusAccessor acc = Host1.get_accessor();
      automatic int max_err = int' ( real'(1<<(9+14))  * real'(max_error_deg) / 360.0 );
      automatic int 	last_ts_cycles = -1;
      
      #5us;

      $display ("Starting DDS Master");
      
      
      acc.write(`ADDR_D3S_RL_ERR_MIN, -max_err);
      acc.write(`ADDR_D3S_RL_ERR_MAX, max_err);
      acc.write(`ADDR_D3S_RL_LENGTH_MAX, 4000);
      acc.write(`ADDR_D3S_CR, `D3S_CR_ENABLE);
      		     
      while(1)
	    begin
	        uint64_t rv,r0,payload;
	        time t_start, t_end;
	        bit 	is_ts, is_rl, is_fixed;
	        automatic	   int 	count;
	  
	   	   
	       acc.read(`ADDR_D3S_ADC_CSR, rv);
	       count = rv & 'hffff;
	   	   
//	   if(rv & `D3S_ADC_CSR_FULL)
//		  $warning("master: full FIFO\n");

//	   $display("Got %d\n", count);
	   
	       while(count > 0)
	       begin
		
		        phase_rl_record_t  rec;
		        t_start = $time;

		        acc.read(`ADDR_D3S_ADC_R0, payload);
		
		        t_end = $time;

		//	      $display("Read from FIFO took %.0f ns", real'(t_end-t_start)/real'(1ns) );

		        rec.r0 = payload;

		        is_rl = (payload & (1 << 31)) ? 1 : 0;
		        is_ts = !is_rl && ( (payload & (1<< 30)) ? 1 : 0 );
		        is_fixed = !is_rl && ( (payload & (1<<30)) ? 0 : 1 );

//		$display("payload %x rl %d ts %d fix %d\n", payload, is_rl, is_ts, is_fixed);
		
		
		        rec.is_rl = is_rl;
		
	 	        if (is_ts)
		        begin
		          last_ts_cycles = payload & 'hfffffff;
		          compr_records.push_back(rec);

//		     $display("report timestamp: %x", last_ts_cycles);
		        end
		
		        if (is_fixed)
		        begin
		          rec.phase = (payload & 'h3fffffff);
		          rec.is_rl = 0;

//		     $display("LTS %d", last_ts_cycles);
		     
		          if( last_ts_cycles >= 0 )
		          begin
			           rec.cycles = last_ts_cycles;
			           last_ts_cycles ++;
			           n_records++;
//			  $display("Fix: phase %d", rec.phase);
//		     $display("FFF phase %d payload %x", rec.phase, payload);

			           compr_records.push_back(rec);
			           ph_check.uncompress(rec);
		          end  
		        end

        	   if (is_rl)
        	   begin
        		     rec.phase = (payload & 'h7ffff) << 4;
        		     rec.length = (payload >> 19) & 'hfff;
        		     rec.is_rl = 1;
        //		     $display("LTS %d", last_ts_cycles);
        
        		     if( last_ts_cycles >= 0 )
        		     begin
        			        rec.cycles = last_ts_cycles;
        			        last_ts_cycles += rec.length;
        //			  $display("RL: phase %d len %d", rec.phase, rec.length);
        			  
        			        n_records++;
        			        compr_records.push_back(rec);
        			        ph_check.uncompress(rec);
        		     end
        	   end
        		
		   count--;
	     end
	   end
  end // initial begin

   
   
    initial begin
      automatic CBusAccessor acc_slave = Host2.get_accessor();

      $display ("Starting DDS Slave");
      
      #5us;
      acc_slave.write(`ADDR_D3SS_RSTR, 'hffffffff); // reset
      acc_slave.write(`ADDR_D3SS_RSTR, 'h0); // un-reset
      acc_slave.write(`ADDR_D3SS_REC_DELAY_COARSE, (g_delay_us * 1000 /8)); // 200us reconstruction delay
      acc_slave.write(`ADDR_D3SS_CR, `D3SS_CR_ENABLE);


      // push the stuff to the decompressor FIFO
      forever begin
	 uint64_t fifo_stat;

	 acc_slave.read(`ADDR_D3SS_PHFIFO_CSR, fifo_stat);


	
	 if(compr_records.size() > 0 && !(fifo_stat & `D3SS_PHFIFO_CSR_FULL))
	   begin
	      
	      
	      phase_rl_record_t  rec;
	      rec = compr_records.pop_front();

//	      $display("Write record!", compr_records.size());
	      

//	      if(fifo_stat & `D3SS_PHFIFO_CSR_EMPTY)
//		$warning("slave : empty FIFO\n");
	      
	      
	      acc_slave.write(`ADDR_D3SS_PHFIFO_R0, rec.r0);

	end  else begin
	   #16ns;
	end // if (!compr_records.empty() && !(fifo_stat & `D3SS_PHFIFO_CSR_FULL))
      end // forever begin
   end // initial begin

 
   

   // Calculate worst phase error 
   initial
     begin
	automatic int f = $fopen("phase_err.txt","w");
	
	automatic int size =0;
	int i, size_m, size_s, size_check;
	automatic int max_err = 3, err;
	const int sample_count = 1000;
	int   st;
	
	


	while ( size < sample_count )
	  begin
	     size_m = ph_master.samples.size();
	     size_s = ph_slave.samples.size();
	     size_check = ph_check.samples.size();

	     size =min( min (size_m, size_s), size_check );
	     

	     #10us;
	     $display("got %d samples so far.", size);
	     	     
	  end // while ( size < 200 )


	
	if ( ph_master.compare( ph_check, max_error_deg ) )
	  $error("master-slave error exceeding the limit (%.1f deg)", max_error_deg);
	

	
	ph_slave.set_start_time(0);
	ph_check.set_start_time(0);
	
	st = max(ph_master.get_start_time(), ph_slave.get_start_time());
	
/*	for(i = st; i < st + size; i++)
	  $display("%d %d %d", ph_master.sample_at(i), ph_slave.sample_at(i),ph_master.sample_at(i)- ph_slave.sample_at(i));*/

	

	
	if ( ph_slave.compare( ph_check, 0.0 ) )
	  $error("slave and check samples not equal, something wrong with the decompressor!");
	

	for(i=0; i<size ;i++) begin
	 //  $display("%d %d %d", ph_slave.sample_at(i), ph_check.sample_at(i),ph_slave.sample_at(i)- ph_check.sample_at(i));
	end
	
	forever #100us;

	
		
	for(i=0; i<sample_count ;i++) begin
	   automatic real err_deg;
	   automatic int err_s;
	   	   
	   err = ph_master.samples[i] - ph_check.samples[i];
	   err_s = ph_slave.samples[i] - ph_check.samples[i];

//	   if (err_s != 0)
//	     $error ("Slave decompression error!");
	   

	
	   err_deg = real'(err)	/real'(1<<23) * 360.0;
	   
	   $display("%d %d %d %d %.1f [%d %d]" , i, ph_master.samples[i], ph_check.samples[i], err, err_deg, ph_slave.samples[i],err_s);
	   $fdisplay(f, "%d %d %d %d %.1f [%d]", i, ph_master.samples[i], ph_check.samples[i], err,err_deg, err_s);

	   if(err_deg < 0)
	     err_deg = -err_deg;
	   
	   if(err_deg > max_error_deg)
	     $display("Error too big!");
	    
	   
	   if((err > 0 ? err : -err) > max_err)
	     max_err = (err > 0 ? err : -err);
	end
	$fclose(f);
	f = $fopen("phase_data.txt","w");

	for(i=0;i<size;i++)
	  begin
	     $fdisplay(f,"%d", ph_master.samples[i] );
	     
	  end
	
	
	$fclose(f);

	
	$display("t = %f us : MaxErr %d %.3f deg [%d/%d samples, %d records]\n", real'($time)/real'(1us), max_err, real'(max_err)/real'(1<<23) * 360.0, size_m, size_check, n_records);

	

	
     end
   
   
   
endmodule

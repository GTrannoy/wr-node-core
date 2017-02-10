`timescale 1ns/1ps

import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"
`include "d3s_acq_buffer_wb.vh"
`include "wr_d3s_adc.vh"
`include "wr_d3s_adc_slave.vh"

`include "stdc_wb_slave.vh"
`include "TrevGen_wb_slave.vh"

`include "RF_Gen2_class.svh" // Attempt to descrive a more realistic RF modulation
//`include "RF_Gen_class.svh" // Attempt to descrive a more realistic RF modulation

// from ADC to raw_phase : 3262ns


// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// A second way of generating some signals 
// Read a file with real aquired and saved data
// 
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
// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


function automatic int max(int a, int b);
   return (a > b ? a : b);
endfunction // max

function automatic int min(int a, int b);
   return (a < b ? a : b);
endfunction // max

function automatic int abs(int x);
   return (x < 0 ? -x : x);
endfunction // max


// RF record type definition
typedef struct {
      bit 	  is_rl;
      int 	  phase;
      int 	  length;
      uint32_t cycles;
      uint64_t r0, r1, r2;
   } phase_rl_record_t;


// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// PhaseData class : Decompresses the rx data and compares with 
// the initial signal.
// Monitor + Scoreboard

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
      
   endfunction // new
  
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
      //$display("Uncompress!");

      int t0_last = -1;
      
      //$display("RL %d fix %d", rec.is_rl, got_a_fix);

      if(!rec.is_rl) 
      begin
        integ = rec.phase;
        samples.push_back(rec.phase);
        if(t0_last > 0 && rec.cycles != t0_last + 1)
           $error("strange, gap in the timstamps: %d %d", t0_last + 1, rec.cycles);
        
        t0_last = rec.cycles;
        got_a_fix = 1;
        
        //$display("uncompress fix: %d", rec.phase);
     
      end else 
      begin
         int i;
         
         if(!got_a_fix)
         begin
            $display("skipping RL record without a previous fixed record");
            return;
         end
        
         //if(samples.size() < 100)
         //$display("dphase %d %d", rec.phase, rec.length);
         
         if(t0_last > 0 && rec.cycles != t0_last + 1)
            $error("strange, gap in the timstamps: %d %d", t0_last + 1, rec.cycles);
         
         t0_last = rec.cycles;
         //$display("uncompress rl: %d %d", rec.length, rec.phase);
        
         for(i = 0; i<rec.length;i++) begin
            integ = integ+(rec.phase);
            samples.push_back(integ);
            t0_last++;
           
            //$display("i %d integ %d", i, integ);
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
   
   function int compare ( PhaseData other, real max_allowed_error, string filename );
      
      int st_max = max ( other.start_time, start_time );
      int i;
      real err_max = 0.0;
      
      int max_samples = min ( samples.size(), other.samples.size() )  - st_max;
      int f = $fopen(filename,"w");
      
      //$display("start_time %d max %d", st_max, max_samples);
      //max_samples = 100;
      //max_samples = st_max + 100;
      
      for(i=st_max;i<max_samples;i++)
      begin
         int err = ( sample_at(i) - other.sample_at(i) );
         real err_deg;
        
        if(err < -8200000 ) // wrap-around
           err += (1<<23);
        if(err > 8200000 ) // wrap-around
           err -= (1<<23);
        
         //$display("Err %d %d %d %d %d", err, sample_at(i), other.sample_at(i), start_time, other.start_time);
       
         err = abs(err);
         err_deg = real'(err) / real'(1<<23) * 360.0;
         
         if (err_deg > err_max)
           err_max = err_deg;
       
         $fdisplay(f,"%d %d %d", sample_at(i), other.sample_at(i), err);
         //$display("%d %d %d", sample_at(i), other.sample_at(i), delta );
       
      end  // for i=st_max;i<max_samples;i++
      
      $display("compared %d samples, max error = %.3f deg", max_samples-st_max, err_max);
      $fclose(f);
      
      return (err_max > max_allowed_error ? 1 : 0);
      
   endfunction // compare
   
endclass // Decompressor

// =-=-=-=-=-=-=-=-=-=-      END Phase Data    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

module fake_dac
  (
   input 	clk_i,
   input [13:0] data_i,
   output real data_o
  );
   
   parameter g_bits = 14;
   parameter g_delay = 0;
   parameter g_oversample = 20;  // 10GHz / 500MHz
   parameter g_step = 100;
   
   function integer f_interp(input integer k, input integer n, input integer y0, input integer y1);
      reg[13:0] y;
      
      begin
      if(y1 < y0)
         y = y0 + k*((y1+(1<<g_bits))-y0)/n;
      else
         y = y0 + k*(y1-y0)/n;
         //$display("%d %d %d %d -> %d", k,n,y0,y1,y);
         
         f_interp = y;
      end
      
   endfunction // f_interp
   
   reg [13:0]  y_over, y_d;
      
   always@(posedge clk_i)
      y_d <= data_i;       // 500 MS/s reconstructed signal
   
   initial forever 
   begin : reconstruct_undiv
      integer i,p;
       
      @(posedge clk_i);
      
      for( i = 0; i < g_oversample; i=i+1)
      begin
         #(g_step/2);
         y_over <= f_interp(i, g_oversample  , data_i, y_d );  // 10GS/s reconstructed signal
         #(g_step/2);
      end
      
      data_o = $bitstoreal(y_over) ;
      
   end  // block: reconstruct_undiv
endmodule // fake_dac



// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// =-=-=-=-=-=-=-=          MAIN          -=-=-=-=-=-=-=-=-=-=-
// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
module main;
   
   // =-=-=-=-=-=-=-=- CLOCKs GENERATION -==-=-=-=-=-=-=-=-=-=-
   
   reg clk_adc ;
   initial forever
   begin
     clk_adc <= 1;
     #1ns;
     clk_adc <= 0;
     #1ns;
   end
   
   // =-=-=-=-=-=-=   INITAL RESET PULSE    =-=-=-=-=-=-=-=-=-=
   reg rst_n = 0;
   initial begin
      repeat(20*8) @(posedge clk_adc);
      rst_n = 1;
   end
   
   // =-=-=-=-=-=-=-=- CLOCKs GENERATION -==-=-=-=-=-=-=-=-=-=-
   
//   reg clk_wr_2x;
//   initial 
//   begin
//     @(posedge rst_n);
//     repeat(11) @(posedge clk_adc);
//     while(1)
//     begin
//        clk_wr_2x = 1;
//        repeat(1) @(posedge clk_adc);
//        clk_wr_2x = 0;
//        repeat(1) @(posedge clk_adc);
//     end
//   end
//
//   reg clk_wr;
//   initial 
//   begin
//     @(posedge clk_wr_2x);
//     while(1) 
//     begin 
//        clk_wr = 0;
//        @(posedge clk_wr_2x);
//        clk_wr = 1;
//        @(posedge clk_wr_2x);
//     end
//   end
//
   reg clk_wr_2x = 0 ;
   always@(posedge clk_adc)
      clk_wr_2x <= ~clk_wr_2x;  // 250 MHz
   
   reg clk_wr = 0 ;   
   always@(posedge clk_wr_2x)   begin
      clk_wr <= ~clk_wr;        // 125 MHz
   end
   
   reg clk_wr_out;
   reg clk_sys = 0;
   always@(posedge clk_wr)
   begin
      clk_sys <= ~clk_sys;   // 62.5MHz
   end
   
   // =-=-=-   TAI and WR_cyc generator    -=-=-=-=
   reg [27:0]  tm_cyc ;
   reg [39:0]  tm_tai ;
   initial 
   begin
      tm_cyc  <= $urandom_range(125000000-1);
      tm_tai  <= $urandom(10);
      while(1)
      begin
         // I need the cycles to change sync. to clk_wr_out!!
         // to test the STDC and the Trev
         @(posedge clk_wr_out)
         if (tm_cyc == 125000000-1)
         begin
            tm_cyc <= 0;
            tm_tai <= tm_tai+1;
         end else begin
            tm_cyc <= tm_cyc + 1;   
         end
      end
   end

   // =-=-=-=-   Nanosecond counter generator    =-=-=-=-=-
   parameter int g_clock_freq = 125000;
   reg [30:0]  tm_nsec = 0;
     
   initial
   begin
       #5.3us
       @(posedge clk_wr_out);
       tm_nsec <= (tm_cyc<<3)+7;
       while(1) 
       begin
          @(posedge clk_adc or negedge clk_adc) 
          if (tm_cyc == 125000000-1) 
          begin
             tm_nsec <= 0;
          end else begin
             tm_nsec <= tm_nsec + 1;
          end
       end
   end
   
   
   // =-=-=-=-=-=-=     Frf clock Generator     -=-=-=-=-=-=-=-
   // produce a pseudo-analog (10GHz sampling freq) RF signal
   // for display purposes ()
   // And from it generates a square RF clock and a square Frev clock
   

   // RFGenerator gen = new; // Old class
   RFGenerator2 gen = new;   //This class tries to simulate the ramp, more realistically
   
   real a_rf, a_rf_d0;
   real sine_in, sine_in_d0;
   reg  clk_rf = 0; 
   reg  frev_in = 0;

   initial forever 
   begin
      a_rf    <= gen.y_sign();
      sine_in <= gen.y(); //Returns RF original data sample
      
      sine_in_d0 <= sine_in;
      a_rf_d0 <= a_rf;
      
      if(sine_in_d0 < 0 && sine_in >= 0) // rising edge
            clk_rf <= 1;
      else if (sine_in_d0 >= 0 && sine_in < 0) // falling edge
            clk_rf <= 0;
      
      if(a_rf_d0 < 0 && a_rf > 0) // rising edge
            frev_in <= 1;
      else if (a_rf_d0 > 0 && a_rf < 0) // falling edge
            frev_in <= 0;
      // frev_in will have 100ps delay w.r.t. clk_frf.
      
      #100ps;
   end

   typedef struct {
      int Ns, fRF1_Ns, fRF2_Ns, frev_Nsamples;
      real fRF1, fRF2, frev, favg;
      int Nper1, Nper2;
      real phi;
   } RFparam;

   RFparam RFGen;
   initial forever 
   begin
      RFGen.Ns           <= gen.Get_Ns();
      RFGen.fRF1_Ns      <= gen.Get_fRF1_Ns();
      RFGen.fRF2_Ns      <= gen.Get_fRF2_Ns();
      RFGen.frev_Nsamples<= gen.Get_frev_Nsamples();
      RFGen.fRF1         <= gen.Get_fRF1();
      RFGen.fRF2         <= gen.Get_fRF2();
      RFGen.frev         <= gen.Get_frev();
      RFGen.favg         <= gen.Get_favg();
      RFGen.Nper1        <= gen.Get_Nper1();
      RFGen.Nper2        <= gen.Get_Nper2();
      RFGen.phi          <= gen.Get_phi();

      #100ps;
   end


// =-=-=-=-=-=-=-     Bunch clock Generator     =-=-=-=-=-=-=-=-
   parameter g_rf_divider = 5;  
   int fbunch_count = 0;
   reg fbunch_in = 0;
   reg reset_bunch_cnt = 0;

   initial forever 
   begin
      @(posedge frev_in);
      reset_bunch_cnt <= 1;
      fbunch_in <= 1;
      fbunch_count <= 0;
      #2.3ns;
      reset_bunch_cnt <= 0;
   end

   always@(posedge clk_rf or negedge clk_rf) // ~Every 2.5ns
   begin
      if (reset_bunch_cnt == 0) 
      begin
         fbunch_count <= fbunch_count + 1;  
      end

      if (fbunch_count % 5 == 4 ) 
      begin
         fbunch_in <= ~fbunch_in;
      end
   end

// =-=-=-=-=-=-=-     Old fREV clock Generator     =-=-=-=-=-=-=-=-
//
//   This is not synchronous to frev !
//
//   parameter g_h_divider = 2000;  //Why this is 2000 and not the harmonic number 4620?
//   int frev_count = 0;
//   reg frev_in = 0;
//   
//   always@(posedge clk_rf) 
//   begin
//      if (frev_count == g_h_divider - 1)
//      begin
//         frev_count <= 0;
//         frev_in <= 1;
//      end else begin
//         frev_count <= frev_count + 1;
//         frev_in <= 0;
//      end
//   end
   




   // =-=-=-=-=-        Undersampled Signal Generator     =-=-=-=-=-=-
   // Produces the undersampled data for the WR-DDS Master node 
   // Simulates the ADC Input
   real y_under;
   reg [13:0] sine;
   
   always@(posedge clk_wr_out)
   begin
      y_under = gen.y_under_sample();
      sine <= int'(2000.0*y_under);
   end

      

   // =-=-=-=-=-=-=-     Trev record type definition    =-=-=-=-=-=-=-
   typedef struct {
      uint64_t ts_ns;   // ns (withing the tai) where last Trev tick was detected
      uint64_t ts_tai;  // Second where last Trev tick was detected
      uint64_t frev_period_ns; // Last Frev_period calculated
   } frev_rec;
   
   // =-=-=-=-=-=-=-    Fake timestamper for the FRev   =-=-=-=-=-=-=-
   // Generates fake Trev time stamps to check the results

   //uint64_t C_last_Trev_ts_ns;
   //uint64_t C_last_Trev_ts_tai;
   //uint64_t C_frev_period_ns;
   reg [30:0] C_last_Trev_ts_ns = 0;
   reg [39:0] C_last_Trev_ts_tai = 0;
   reg [30:0] C_frev_period_ns = 0;
   int C_Trev_updates = -1;

   frev_rec C_ts_rec;
   frev_rec C_frev_q[$];  // Frev time stamp queue 

   initial forever 
   begin
      
      @(posedge frev_in)
      // Calc Trev period
      if (C_Trev_updates > 0 )
      begin
         if (C_last_Trev_ts_tai == tm_tai)
            C_frev_period_ns = tm_nsec - C_last_Trev_ts_ns;
         else
            C_frev_period_ns = (125000000<<3) + tm_nsec - C_last_Trev_ts_ns;
      end else begin
            C_frev_period_ns = 23270;  // Initial value
      end
      // store this Trev tick to next period calculation
      C_last_Trev_ts_ns  = tm_nsec;
      C_last_Trev_ts_tai = tm_tai;
      C_Trev_updates = C_Trev_updates +1;

      // Build record and send it
      C_ts_rec.ts_ns  = C_last_Trev_ts_ns;
      C_ts_rec.ts_tai = C_last_Trev_ts_tai;
      C_ts_rec.frev_period_ns = C_frev_period_ns;
      C_frev_q.push_back(C_ts_rec);  // Push to checker queue
      
   end
   
   
   //Generates a signal (sin2) from a file which has stored sampled real data
   //read_file ReadFile(
   //                   .clk_wr_out, 
   //                   .enc_started,
   //                   .sine2);
   

   // =-=-=-=-=-=-=-   Cores under test    =-=-=-=-=-=-=-=-=-=-
    
   // =-=-=-=-=-=-=-       MASTER          =-=-=-=-=-=-=-=-=-=-

   reg enc_started;   // Signal used to synchronise in the sim. the 
                      // moment to apply the data read from the file
   reg [13:0] sine2;  // Simulate with real data
   
   IVHDWishboneMaster Host1 ( clk_sys, rst_n );

   wr_d3s_adc 
        #(.g_use_fake_data(1))
        DUT_M (
               .rst_n_sys_i(rst_n),
   	           .clk_sys_i (clk_sys),

               .clk_wr_o(clk_wr_out),      // Derived from the 500MHz
               .adc_dco_p_i(clk_adc),      // 500 MHz
               .adc_dco_n_i(~clk_adc),

               .tm_time_valid_i(1'b1),
               .tm_cycles_i(tm_cyc),
               .tm_tai_i(tm_tai),

               .fake_data_i(sine),  // use sine2 for file read data
               .enc_started_o(enc_started),  

               .adc_ext_trigger_p_i(frev_in),
               .adc_ext_trigger_n_i(~frev_in),

               .slave_i(Host1.master.out),
               .slave_o(Host1.master.in)
        );


   // =-=-=-=-=-=-=-        SLAVE         =-=-=-=-=-=-=-=-=-=-

   wire [14-1: 0] dac_p;
   
   IVHDWishboneMaster Host2 ( clk_sys, rst_n );

   wr_d3s_adc_slave
        #(.g_clock_freq(g_clock_freq) )
        DUT_S (
                .rst_n_sys_i(rst_n),
                .clk_sys_i (clk_sys),

        	    .tm_time_valid_i(1'b1),
                .tm_tai_i(tm_tai),
                .tm_cycles_i(tm_cyc), //.tm_cycles_i(tm_nsec[30:3]),
    
                .dac_p_o(dac_p),
    
                .wr_ref_clk_p_i (clk_wr_out),
                .wr_ref_clk_n_i (~clk_wr_out),
                
                .synth_p_i(fbunch_in),
                .synth_n_i(~fbunch_in),
                
                .slave_i(Host2.master.out),
                .slave_o(Host2.master.in)
    );

   // Oversampling dac_p
   real y_over;
   fake_dac U_DAC(clk_adc, dac_p, y_over);
 
   PhaseData ph_master = new;
   PhaseData ph_slave = new;
   PhaseData ph_check = new;
    
   // store whatever goes to the Phase Encoder's FIFO also to the ph_unc object.
   always @(posedge clk_wr_out)
      if(DUT_M.U_Phase_Enc.fifo_en_i) 
      begin
         if( ph_master.get_start_time() < 0 )
         begin
            ph_master.set_start_time(DUT_M.U_Phase_Enc.tm_cycles_i);
            $display("Master: 1st sample timestamp: %d\n", ph_master.get_start_time());
         end
      
         ph_master.add(DUT_M.U_Phase_Enc.rl_phase_ext);
      end  //  if(DUT_M.U_Phase_Enc.fifo_en_i)
   
      
   // store whatever goes to the Phase Encoder's FIFO also to the ph_unc object.
   always @(posedge clk_wr_out)
      if(DUT_S.U_Phase_Dec.s3_valid)
      begin
         if( ph_slave.get_start_time() < 0 )
         begin
            ph_slave.set_start_time(DUT_S.U_Phase_Dec.tm_cycles_i);
            $display("Slave: 1st sample timestamp: %d\n", ph_slave.get_start_time());
         end
          
         ph_slave.add(DUT_S.U_Phase_Dec.s3_phase);
      end // if (DUT_S.U_Phase_Dec.s3_valid)
     
     
//  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Master process: configure the compressor, start sampling and push all 
//  records to a queue
//  Simulates the code running in MT master node
   
   const real max_error_deg = 3.0;
   phase_rl_record_t compr_records[$];  // Queue with RF records send
   int n_records = 0;
    
   frev_rec M_frev_q[$];       // Queue with frev records sent

   initial begin
      uint64_t rv;
      frev_rec M_ts_rec;
      uint64_t M_last_Trev_ts_ns;
      uint64_t M_last_Trev_ts_tai;
      uint64_t M_prev_Trev_ts_ns;
      uint64_t M_prev_Trev_ts_tai;
      uint64_t M_frev_period_ns;
      int M_Trev_updates;

      uint64_t rv2,r0,payload;
      time t_start, t_end;
      bit  is_ts, is_rl, is_fixed;
      uint64_t stdc_status, stdc_ctrl;
      uint64_t ts_tai_l;
      uint64_t ts_tai_h;
      automatic int count;
      
      automatic CBusAccessor acc = Host1.get_accessor();
      
      automatic int max_err = int' ( real'(1<<(9+14))  * real'(max_error_deg) / 360.0 );
      automatic int last_ts_cycles = -1;
      
      #5us;
      
      M_last_Trev_ts_ns = 0;
      M_last_Trev_ts_tai = 0;
      M_prev_Trev_ts_ns = 0;
      M_prev_Trev_ts_tai = 0;
      M_frev_period_ns = 0;
      M_Trev_updates = 0;
      ts_tai_l = 0;
      ts_tai_h = 0;
      
      $display ("Starting DDS Master");
      
      // Initialization
      acc.write(`ADDR_D3S_RSTR, 'hffffffff); // reset
      acc.write(`ADDR_D3S_RSTR, 'h0); // un-reset

      //Configure Phase encoder
      acc.write(`ADDR_D3S_RL_ERR_MIN, -max_err);
      acc.write(`ADDR_D3S_TRANSIENT_THRESHOLD_PHASE, 50);
      acc.write(`ADDR_D3S_TRANSIENT_THRESHOLD_COUNT, 6);
      acc.write(`ADDR_D3S_RL_ERR_MAX, max_err);
      acc.write(`ADDR_D3S_RL_LENGTH_MAX, 4000);

      // Configure the STDC 
      acc.write(`ADDR_STDC_CTRL + 'h400, 9);  // Clear STDC fifo
      acc.write(`ADDR_STDC_CTRL + 'h400, 8);  // Configure rising edges

      // Start encoding
      acc.write(`ADDR_D3S_CR, `D3S_CR_ENABLE);
      
      while(1)
      begin
         
         acc.read(`ADDR_D3S_ADC_CSR, rv2);
         count = rv2 & 'hffff;  // number of elements in
            
         //if(rv2 & `D3S_ADC_CSR_FULL)
         //$warning("master: full FIFO\n");

         //$display("Got %d\n", count);
       
         // =-=-=- Process RF records =-=-=-
         while(count > 0)
         begin
            phase_rl_record_t  rec;
            t_start = $time;
            
            acc.read(`ADDR_D3S_ADC_R0, payload);
            
            t_end = $time;
            
            //$display("Read from FIFO took %.0f ns", real'(t_end-t_start)/real'(1ns) );
            
            rec.r0 = payload;
            
            is_rl = (payload & (1 << 31)) ? 1 : 0;
            is_ts = !is_rl && ( (payload & (1<< 30)) ? 1 : 0 );
            is_fixed = !is_rl && ( (payload & (1<<30)) ? 0 : 1 );
               
            //$display("payload %x rl %d ts %d fix %d\n", payload, is_rl, is_ts, is_fixed);
               
            rec.is_rl = is_rl;
            
            if (is_ts)
            begin
               last_ts_cycles = payload & 'hfffffff;
               compr_records.push_back(rec);   // Pushing record to the monitor
               //$display("report timestamp: %x", last_ts_cycles);
            end  //if (is_ts)
               
            if (is_fixed)
            begin
               rec.phase = (payload & 'h3fffffff);
               rec.is_rl = 0;
               //$display("LTS %d", last_ts_cycles);
               
               if( last_ts_cycles >= 0 )
               begin
                  rec.cycles = last_ts_cycles;
                  last_ts_cycles ++;
                  n_records++;
                  //$display("Fix: phase %d", rec.phase);
                  //$display("FFF phase %d payload %x", rec.phase, payload);
                     
                  compr_records.push_back(rec);
                  ph_check.uncompress(rec);
               end  //( last_ts_cycles >= 0 )
            end   //if (is_fixed)

            if (is_rl)
            begin
               rec.phase = (payload & 'h7ffff) << 4;
               rec.length = (payload >> 19) & 'hfff;
               rec.is_rl = 1;
               //$display("LTS %d", last_ts_cycles);
               
               if( last_ts_cycles >= 0 )
               begin
                  rec.cycles = last_ts_cycles;
                  last_ts_cycles += rec.length;
                  //$display("RL: phase %d len %d", rec.phase, rec.length);
                     
                  n_records++;
                  compr_records.push_back(rec);
                  ph_check.uncompress(rec);
               end  //if( last_ts_cycles >= 0 )
            end  // if (is_rl) 
            
            count--;
         end  // while (count>0)

         // =-=-=- Process Trev records =-=-=-
         acc.read(`ADDR_STDC_STATUS + 'h400, stdc_status); 
         if (!(stdc_status & `STDC_STATUS_EMPTY ))  //if there events to process
         begin
            // Read Trev event from STDC registers
            acc.read('h400 + `ADDR_STDC_TDC_TS_TAI_L, ts_tai_l);
            acc.read('h400 + `ADDR_STDC_TDC_TS_TAI_H, ts_tai_h);
            M_last_Trev_ts_tai = (ts_tai_h <<32) | ts_tai_l;
            acc.read('h400 + `ADDR_STDC_TDC_TS_NS, M_last_Trev_ts_ns);
            acc.read('h400 + `ADDR_STDC_CTRL, stdc_ctrl); 
            // Process next event
            acc.write('h400 + `ADDR_STDC_CTRL, stdc_ctrl | `STDC_CTRL_NEXT ); 
            
            // Calc period
            if (M_Trev_updates > 0 )  // if this is not the first measured
            begin
               if (M_prev_Trev_ts_tai == M_last_Trev_ts_tai)
               begin
                  M_frev_period_ns = M_last_Trev_ts_ns - M_prev_Trev_ts_ns ;
               end else begin
                  M_frev_period_ns = (125000000<<3) + M_last_Trev_ts_ns - M_prev_Trev_ts_ns ;
               end
            end else begin // if (M_Trev_updates > 1 )
               M_frev_period_ns = 23270;  // First time period
            end
             
            // Store event to calc. next period
            M_prev_Trev_ts_tai = M_last_Trev_ts_tai;
            M_prev_Trev_ts_ns = M_last_Trev_ts_ns;
            M_Trev_updates = M_Trev_updates +1 ;

            // Calc next Trev tick
            M_ts_rec.ts_ns  = M_last_Trev_ts_ns + M_frev_period_ns;
            M_ts_rec.ts_tai = M_last_Trev_ts_tai;
            M_ts_rec.frev_period_ns = M_frev_period_ns;
            
            if (M_ts_rec.ts_ns > (125000000<<3)-1)
            begin
               M_ts_rec.ts_ns = M_ts_rec.ts_ns - (125000000<<3);
               M_ts_rec.ts_tai = M_ts_rec.ts_tai + 1;
            end 
               
            // Send next event
            M_frev_q.push_back(M_ts_rec);      //Push to the event queue
         
         end  //if (!(stdc_status & `STDC_STATUS_EMPTY ))
         
         if (stdc_status & `STDC_STATUS_OVF)  
         begin
            $display("STDC fifo overflowed!");
         end
      
      end  // while (1)
   end // initial begin

   //  =-=-=-=-=-=-=      END MASTER MT code      =-=-=-=-=-=-=


   //  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   //  Slave process: configure the decompressor, push data to the decompressor
   //  Simulates the code running in MT slave node

   parameter g_delay_us = 100;

   initial 
   begin

      frev_rec S_ts_rec; // Trev event received
     
      uint32_t S_last_Trev_ts_tai ;  // Last Trev event detected
      uint32_t S_last_Trev_ts_ns ;
      uint32_t S_next_Trev_ts_tai ;  // Next Trev event calculated
      uint32_t S_next_Trev_ts_ns ;
      uint32_t S_frev_period_ns ;    // Trev period
      int S_Trev_updates ;

      automatic CBusAccessor acc_slave = Host2.get_accessor();

      $display ("Starting DDS Slave");
      
      #5us;
      
      S_last_Trev_ts_tai = 0;  // Last Trev event detected
      S_last_Trev_ts_ns = 0;
      S_next_Trev_ts_tai = 0;  // Next Trev event calculated
      S_next_Trev_ts_ns = 0;
      S_frev_period_ns = 0;    // Trev period
      S_Trev_updates = 0;

      // Initialization
      acc_slave.write(`ADDR_D3SS_RSTR, 'hffffffff); // reset
      acc_slave.write(`ADDR_D3SS_RSTR, 'h0); // un-reset

      acc_slave.write(`ADDR_D3SS_REC_DELAY_COARSE, (g_delay_us * 1000 /8)); // 200us reconstruction delay
      
      acc_slave.write(`ADDR_D3SS_PHFIFO_CSR, `D3SS_PHFIFO_CSR_CLEAR_BUS);  // Clears RF fifo
      
      // Start decoder
      acc_slave.write(`ADDR_D3SS_CR, `D3SS_CR_ENABLE);

      // push the stuff to the decompressor FIFO
      forever
      begin
         uint64_t fifo_stat;

         acc_slave.read(`ADDR_D3SS_PHFIFO_CSR, fifo_stat);
         
         // =-=-=- Process RF records =-=-=-
         if(compr_records.size() > 0 && !(fifo_stat & `D3SS_PHFIFO_CSR_FULL))
         begin 
            phase_rl_record_t  rec;
            rec = compr_records.pop_front();
            
            //$display("Write record!", compr_records.size());
            
            //if(fifo_stat & `D3SS_PHFIFO_CSR_EMPTY)
            //$warning("slave : empty FIFO\n");
            
            acc_slave.write(`ADDR_D3SS_PHFIFO_R0, rec.r0);
            
         end // =-=-=- Process Trev records =-=-=-
         else if(M_frev_q.size() > 0)  // if there are Trev events waiting
         begin
            S_ts_rec = M_frev_q.pop_front();  // Receive event
              
            // Iterative calc. of next Trev. tick
            S_next_Trev_ts_tai = S_ts_rec.ts_tai;
            S_next_Trev_ts_ns = S_ts_rec.ts_ns ;
               
          // Write next tick data on TrevGen registers
          acc_slave.write('h100 + `ADDR_TREVGEN_RM_NEXT_TICK, S_next_Trev_ts_ns);
          acc_slave.write('h100 + `ADDR_TREVGEN_STROBE_P, 'h1);
          S_Trev_updates ++;

         end else   //if(M_frev_q.size() > 0)
         begin
            #16ns;
         end 

      end // forever begin

   end // initial begin
    
     
   //  =-=-=-=-=-=-=-=      END SLAVE MT code      =-=-=-=-=-=-=-=


   //  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
   //                       CHECKER PROCESS 
   // Calculates worst phase error 

   initial 
   begin
      automatic int f = $fopen("phase_err.txt","w");
      automatic int size =0;
      int i, size_m, size_s, size_check;
      automatic int max_err = 3, err;
      const int sample_count = 50000;
      int   st;

      while ( size < sample_count )
      begin
         size_m = ph_master.samples.size();
         size_s = ph_slave.samples.size();
         size_check = ph_check.samples.size();
         size =min( min (size_m, size_s), size_check );
         
         #10us;
         $display("got %d samples so far.", size);
         
      end // ( size < sample_count )
      
      
      if ( ph_master.compare( ph_check, max_error_deg, "ms_phase.txt" ) )
         $error("master-slave error exceeding the limit (%.1f deg)", max_error_deg);
      
      ph_slave.set_start_time(0);
      ph_check.set_start_time(0);
      
      st = max(ph_master.get_start_time(), ph_slave.get_start_time());
      
//	  for(i = st; i < st + size; i++)
//	     $display("%d %d %d", ph_master.sample_at(i), ph_slave.sample_at(i),ph_master.sample_at(i)- ph_slave.sample_at(i));

      
      if ( ph_slave.compare( ph_check, 0.0, "check_phase.txt" ) )
         $error("slave and check samples not equal, something wrong with the decompressor!");
      
      for(i=0; i<size ;i++) 
      begin
         //$display("%d %d %d", ph_slave.sample_at(i), ph_check.sample_at(i),ph_slave.sample_at(i)- ph_check.sample_at(i));
      end
      
      
      for(i=0; i<sample_count ;i++) 
      begin
         automatic real err_deg;
         automatic int err_s;
         
         err = ph_master.samples[i] - ph_check.samples[i];
         err_s = ph_slave.samples[i] - ph_check.samples[i];
         
         //if (err_s != 0)
         //$error ("Slave decompression error!");
         
         
         err_deg = real'(err)	/real'(1<<23) * 360.0;
         
         //$display("%d %d %d %d %.1f [%d %d]" , i, ph_master.samples[i], ph_check.samples[i], err, err_deg, ph_slave.samples[i],err_s);
         $fdisplay(f, "%d %d %d %d %.1f [%d]", i, ph_master.samples[i], ph_check.samples[i], err,err_deg, err_s);
         
         if(err_deg < 0)
            err_deg = -err_deg;
         
         //if(err_deg > max_error_deg)
         // $display("Error too big!");
         
        
         if((err > 0 ? err : -err) > max_err)
            max_err = (err > 0 ? err : -err);
            
      end  // for(i=0; i<sample_count ;i++) 

      $fclose(f);
      
      f = $fopen("phase_data.txt","w");
      
      for(i=0;i<size;i++)
      begin
         $fdisplay(f,"%d", ph_master.samples[i] );
      end
    
      $fclose(f);

      $display("t = %f us : MaxErr %d %.3f deg [%d/%d samples, %d records]\n", real'($time)/real'(1us), max_err, real'(max_err)/real'(1<<23) * 360.0, size_m, size_check, n_records);

   end  // initial begin Checker

   //  =-=-=-=-=-=-=-=      CHECKER process END      =-=-=-=-=-=-=-=

endmodule  // End main module

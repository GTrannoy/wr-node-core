`timescale 1ns/1ps

import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"
`include "cpu_csr_driver.svh"
`include "mqueue_host.svh"

`include "dds_regs.vh"
`include "TrevGen_wb_slave.vh"
`include "stdc_wb_slave.vh"

module fake_dac
  (
   input 	clk_i,
   input [13:0] data_i,
   output reg 	dds_clk_o );
   

   always@(posedge clk_i)
     dds_clk_o <= (data_i > (1<<13));
   
endmodule // fake_dac



module main;

   reg rst_n = 0;
   reg clk_dac = 0;
   
   reg clk_sys = 0;
   reg clk_wr =0, clk_wr_2x = 0;

   reg B_clk = 0;

   reg [39:0] tm_tai = 100;
   reg [27:0] tm_cycles = 125000000-3000;
   reg [2:0] Trev_phase;
   reg [13:0] count = 0;

   wire [13:0] dac_data, dac_data2;
   wire        dac_clock_out, dac_clock_out2;

   reg Trev_p =0;
   reg Trev_o;

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
//   IVHDWishboneMaster Host2 ( clk_sys, rst_n );

   always@(posedge clk_wr) begin
      if(tm_cycles == 125000000-1) begin
	       tm_tai <= tm_tai + 1;
	       tm_cycles <= 0;
      end      
      else
	       tm_cycles <= tm_cycles + 1;
   end

   fake_dac DAC
     (
      .clk_i(clk_dac),
      .data_i(dac_data),
      .dds_clk_o(dac_clock_out)
      );

    fake_dac DAC2
     (
      .clk_i(clk_dac),
      .data_i(dac_data2),
      .dds_clk_o(dac_clock_out2)
      );

   always #25ns B_clk <= ~B_clk; // 40 MHz 
   
   initial begin
      integer counter;
      counter = 0; 
      Trev_p <= 0;
      #200ns;
      while(1) begin
         if ($stime>=200us) begin
            $stop;
          end
         @(posedge B_clk);
           if (counter <460) 
              Trev_p <= 1;
           else if (counter<920) 
              Trev_p <= 0;
           
           if (counter==919)
              counter = 0;
           else
              counter = counter +1; 
      end
   end
   
   wr_d3s_core 
       #(.g_simulation(1),
	 .g_sim_pps_period(125000000) )
       DUT1 (.rst_n_i (rst_n),
             .clk_sys_i   (clk_sys),
             .clk_125m_pllref_i   (clk_wr),
	   //.wr_ref_clk_p_i(clk_wr),
	   //.wr_ref_clk_n_i(~clk_wr),
	    .tm_link_up_i(1'b1),
	    .tm_time_valid_i(1'b1),
	    .tm_tai_i(tm_tai),
	    .tm_cycles_i(tm_cycles),

            .synth_clk_p_i(dac_clock_out),
	    .synth_clk_n_i(~dac_clock_out),

            .dac_p_o(dac_data),

            .slave_i (Host1.master.out),
            .slave_o (Host1.master.in),

            .Trev_i(Trev_p),
            .Rev_clk_o(Trev_o),
            .B_clk_i(B_clk)
    );

/*
      wr_d3s_core #(
		 .g_simulation(1),
		 .g_sim_pps_period(125000000) )
   DUT2 (
                    .clk_sys_i   (clk_sys),
		    .clk_125m_pllref_i   (clk_wr),
		    //.wr_ref_clk_p_i(clk_wr),
		    //.wr_ref_clk_n_i(~clk_wr),

		    .tm_link_up_i(1'b1),
		    .tm_time_valid_i(1'b1),
		    .tm_tai_i(tm_tai),
		    .tm_cycles_i(tm_cycles),

	.synth_clk_p_i(dac_clock_out2),
	.synth_clk_n_i(~dac_clock_out2),

	.trig_p_i(trig_p),
	.trig_n_i(~trig_p),
	
	.dac_p_o(dac_data2),
			 
		    .rst_n_i (rst_n),
                    .slave_i (Host2.master.out),
                    .slave_o (Host2.master.in)

    );
*/
   

   task wait_sample(CBusAccessor acc, int sample = -1);
      uint64_t rv;
      forever begin
	 
	 forever begin
	    acc.read(`ADDR_DDS_PD_DATA, rv); // unreset the core
	    if(rv & `DDS_PD_DATA_VALID)
	      break;
	    end

	 acc.write(`ADDR_DDS_PD_DATA, 0);
	 acc.read(`ADDR_DDS_SAMPLE_IDX, rv);
	if( sample < 0 || sample == rv )
	   break;
	 
      end // forever begin
      

      $display("Current sample IDX: %d", rv);
      

   endtask // wait_next_sample

`define DDS_ACC_MASK ( (1<<43) -1 )   
`define DDS_ACC_BITS ( 43 )   
      
   initial begin
      static uint64_t base_tune = 'h199d12caddd; // 200.106 MHz
//    uint64_t base_tune = 'h20000000000; // 200.000 MHz
      static uint64_t sampling_div = 100;
      static uint64_t ticks_per_sample = 125 * sampling_div;
      uint64_t rv, snap_hi, snap_lo;
      uint64_t phase_correction;
      static uint64_t slave_delay = 1;
      real phase_corr_deg;
      
      int i;
      static uint64_t fixup = 0;
      
      uint64_t status;
      uint64_t timestamp;
      uint32_t next_tick;
      
      CBusAccessor host_acc, host_acc2;
      
      #1us;

      host_acc = Host1.get_accessor();
// ------- Testing STDC 
/*
     `define BASE_STDC 'h1000

     host_acc.write(`BASE_STDC + `ADDR_STDC_CTRL, 1<<3);  // Write ctrl filter to report rising edges
            
      while(1) begin
                
          host_acc.read(`BASE_STDC + `ADDR_STDC_STATUS, status);  // Write ctrl filter to report rising edges
          $display("Event @ %x", status);
          
          if (~(status & 32'h01)) begin   // if not empty
            host_acc.read(`BASE_STDC + `ADDR_STDC_TDC_DATA, timestamp);
            //$display("Event @ %x", timestamp);
            #16ns;
            host_acc.write(`BASE_STDC + `ADDR_STDC_CTRL, 1<<3 | 1<<2 );
          end
          #100ns;
      end
*/
// ------- Testing Trev generator 
 
    `define BASE_TREV 'h2000
    
    while(1) begin
      repeat(5) begin  
         @(posedge B_clk);
         Trev_phase = $urandom_range(0, 7);
         next_tick = 32'h0 | (tm_cycles+50)<<3 | Trev_phase;
         $display("tm_cycles: %d, phase: %h, next tick: %h", tm_cycles+50, Trev_phase, next_tick);
         $display("target cycles: %d", next_tick>>3);
         host_acc.write(`BASE_TREV + `ADDR_TREVGEN_RM_NEXT_TICK, next_tick );
         host_acc.write(`BASE_TREV + `ADDR_TREVGEN_STROBE_P, 32'h01 );
         //$display("Tick written @ %t", $stime);
         #1us;
      end
      $stop;
    end

// ------- Testing DDS ------------------
//      host_acc2 = Host2.get_accessor();
      
      host_acc.write(`ADDR_DDS_RSTR, 0); // unreset the core
      host_acc.write(`ADDR_DDS_CR, ((sampling_div-1) << 1) | 1); // set prescaler, enable sampling
      host_acc.write(`ADDR_DDS_FREQ_HI, base_tune >> 32);
      host_acc.write(`ADDR_DDS_FREQ_LO, base_tune & 'hffffffff);
      host_acc2.write(`ADDR_DDS_RSTR, 0); // unreset the core
      host_acc2.write(`ADDR_DDS_CR, ((sampling_div-1) << 1) | 1); // set prescaler, enable sampling

      host_acc.write(`ADDR_DDS_FREQ_MEAS_GATE, 1000);

      host_acc.write(`ADDR_DDS_GAIN, 1<<12);
      host_acc.write(`ADDR_DDS_ACC_LOAD_HI, 'h0);
      host_acc.write(`ADDR_DDS_ACC_LOAD_LO, 'h0);
      
      wait_sample(host_acc);
      #1us;

      host_acc.write(`ADDR_DDS_TUNE_VAL, 0 | `DDS_TUNE_VAL_LOAD_ACC); 

      wait_sample(host_acc);

      wait_sample(host_acc);
	   
      host_acc.read(`ADDR_DDS_ACC_SNAP_HI, snap_hi);
      host_acc.read(`ADDR_DDS_ACC_SNAP_LO, snap_lo);

      host_acc.read(`ADDR_DDS_SAMPLE_IDX, rv);
      $display("Fixup taken for sample %d\n", rv);

     
      fixup = (snap_hi << 32) + snap_lo + 3 * base_tune;

      fixup &= `DDS_ACC_MASK;

      phase_correction = fixup + (ticks_per_sample * slave_delay) * base_tune;      
      
      host_acc2.write(`ADDR_DDS_FREQ_HI, base_tune >> 32);
      host_acc2.write(`ADDR_DDS_FREQ_LO, base_tune & 'hffffffff);
      
      host_acc2.write(`ADDR_DDS_ACC_LOAD_HI, phase_correction >> 32);
      host_acc2.write(`ADDR_DDS_ACC_LOAD_LO, phase_correction & 'hffffffff);
      host_acc2.write(`ADDR_DDS_PD_DATA, 0);
            
      host_acc2.write(`ADDR_DDS_TUNE_VAL, 0 | `DDS_TUNE_VAL_LOAD_ACC); 
      wait_sample(host_acc2);


      phase_corr_deg = real'(phase_correction % base_tune) / real'(base_tune) * 360.0;
      $display("PhaseCorr %x [%.0f deg]", phase_correction, phase_corr_deg );
      host_acc.read(`ADDR_DDS_SAMPLE_IDX, rv);
      $display("Correction applied for sample %d\n", rv);

      
      
      /*
      host_acc.write(`ADDR_DDS_RF_RST_PHASE, 
		     (40 << `DDS_RF_RST_PHASE_LO_OFFSET ) 
		     | (200 << `DDS_RF_RST_PHASE_HI_OFFSET ) );


      #10us;


      host_acc.write(`ADDR_DDS_RF_CNT_SYNC_VALUE, 123);
      host_acc.write(`ADDR_DDS_RF_CNT_PERIOD, 512);
      
      host_acc.write(`ADDR_DDS_RF_CNT_TRIGGER, 1000 | `DDS_RF_CNT_TRIGGER_ARM);

      while(1)
	begin
	   host_acc.read(`ADDR_DDS_RF_CNT_TRIGGER, rv);
	   if(rv & `DDS_RF_CNT_TRIGGER_DONE )
	     break;
	end

      host_acc.read(`ADDR_DDS_RF_CNT_SYNC_VALUE, rv);
      $display("RF counter reset @ TAI Cycles %d", rv);
      
      host_acc.write(`ADDR_DDS_TRIG_IN_CSR, `DDS_TRIG_IN_CSR_ARM);


      while(1)
	begin
	   host_acc.read(`ADDR_DDS_TRIG_IN_CSR, rv);
	   if(rv & `DDS_TRIG_IN_CSR_DONE )
	     break;
	end

      host_acc.read(`ADDR_DDS_TRIG_IN_SNAPSHOT, rv);
      $display("Trigger pulse in @ RF Cycles %d", rv);
      
      */
      
   end // initial begin
   

   
   
endmodule

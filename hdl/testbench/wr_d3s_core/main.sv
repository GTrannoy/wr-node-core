import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"
`include "cpu_csr_driver.svh"
`include "mqueue_host.svh"

`include "dds_regs.vh"

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

   IVHDWishboneMaster Host ( clk_sys, rst_n );


   t_wishbone_master_out host_wb_out;
   t_wishbone_master_in host_wb_in;

   reg [39:0]  tm_tai = 100;
   reg [27:0]  tm_cycles = 0;

   always@(posedge clk_wr) begin
      if(tm_cycles == 1249) begin
	 tm_tai <= tm_tai + 1;
	 tm_cycles <= 0;
      end      else
	tm_cycles <= tm_cycles + 1;
   end

   wire [13:0] dac_data;
   wire        dac_clock_out;

   fake_dac DAC
     (
      .clk_i(clk_dac),
      .data_i(dac_data),
      .dds_clk_o(dac_clock_out)
      );

   reg 	       trig_p =0;

   initial forever begin
      #100us;
      trig_p <= 1;
      #1us;
      trig_p <= 0;
   end
   
   
      
     
   
   
   wr_d3s_core #(
		 .g_simulation(1),
		 .g_sim_pps_period(1250) )
   DUT (
                    .clk_sys_i   (clk_sys),
		    .clk_ref_i   (clk_wr),
		    .wr_ref_clk_p_i(clk_wr),
		    .wr_ref_clk_n_i(~clk_wr),

		    .tm_link_up_i(1'b1),
		    .tm_time_valid_i(1'b1),
		    .tm_tai_i(tm_tai),
		    .tm_cycles_i(tm_cycles),

	.synth_clk_p_i(dac_clock_out),
	.synth_clk_n_i(~dac_clock_out),

	.trig_p_i(trig_p),
	.trig_n_i(~trig_p),
	
	.dac_p_o(dac_data),
			 
		    .rst_n_i (rst_n),
                    .slave_i (Host.master.out),
                    .slave_o (Host.master.in)

    );

   
  
   initial begin
      uint64_t rv;
      
      CBusAccessor host_acc;
      
      #10us;

      host_acc = Host.get_accessor();
      

      
      host_acc.write(`ADDR_DDS_RSTR, 0); // unreset the core
      host_acc.write(`ADDR_DDS_CR, (4 << 1) | 1); // set prescaler, enable sampling
      host_acc.write(`ADDR_DDS_FREQ_HI, 'h28f);
      host_acc.write(`ADDR_DDS_FREQ_LO, 'ha73cf04b);
      host_acc.write(`ADDR_DDS_FREQ_MEAS_GATE, 1000);

      host_acc.write(`ADDR_DDS_GAIN, 1<<12);
      host_acc.write(`ADDR_DDS_ACC_LOAD_HI, 'hdead);
      host_acc.write(`ADDR_DDS_ACC_LOAD_LO, 'hcafebabe);
      host_acc.write(`ADDR_DDS_TUNE_VAL, 12345 | `DDS_TUNE_VAL_LOAD_ACC);

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
      
      
      
   end // initial begin
   

   
   
endmodule

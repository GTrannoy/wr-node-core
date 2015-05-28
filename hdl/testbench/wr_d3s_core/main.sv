import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"
`include "cpu_csr_driver.svh"
`include "mqueue_host.svh"

`include "dds_regs.vh"

module main;

   reg rst_n = 0;
   reg clk_sys = 0;
   reg clk_wr =0;
      
   always #4ns clk_wr <= ~clk_wr;
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
   
   
   
   wr_d3s_core #(
		 .g_simulation(1),
		 .g_sim_pps_period(1250) )
   DUT (
                    .clk_sys_i   (clk_sys),
		    .clk_ref_i   (clk_wr),
		    .wr_ref_clk_p_i(clk_wr),
		    .wr_ref_clk_n_i(~clk_wr),
			 
		    .rst_n_i (rst_n),
                    .slave_i (Host.master.out),
                    .slave_o (Host.master.in),

		    .tm_link_up_i(1'b1),
		    .tm_time_valid_i(1'b1),
		    .tm_tai_i(tm_tai),
		    .tm_cycles_i(tm_cycles)
		    
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
      
      
   end // initial begin
   

   
   
endmodule

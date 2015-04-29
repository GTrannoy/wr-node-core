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
      if(tm_cycles == 999) begin
	 tm_tai <= tm_tai + 1;
	 tm_cycles <= 0;
      end      else
	tm_cycles <= tm_cycles + 1;
   end
   
   
   
   wr_d3s_core #(
		 .g_simulation(1),
		 .g_sim_pps_period(1000) )
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
      host_acc.write(`ADDR_DDS_CR, (20 << 1) | 1); // set prescaler, enable sampling
      
   end // initial begin
   

   
   
endmodule

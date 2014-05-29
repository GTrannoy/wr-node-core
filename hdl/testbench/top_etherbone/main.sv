import wishbone_pkg::*;
import wr_node_pkg::*;
import wr_fabric_pkg::*;


`include "vhd_wishbone_master.svh"
`include "cpu_csr_driver.svh"
`include "mqueue_host.svh"

class CWRNode;

   function  new ( CBusAccessor acc_, input uint32_t base_);

   endfunction // new
   
      
endclass // CWRNode

module
 VHDWBMonitor
   #(
     parameter string g_name = "" 
     )
   (
 input clk_i,
 input t_wishbone_master_out in,
 input t_wishbone_master_in out);

   reg cyc_d0 = 0;
   int xfer_count = 0;
   
   
   
   
   always@(posedge clk_i)
     cyc_d0 <= in.cyc;

   always@(posedge clk_i)
     begin
	if(!cyc_d0 && in.cyc)
	  begin
	     $display("%s: start-of-cycle", g_name);
	     xfer_count = 0;
	  end
	
	
	if(in.cyc && in.stb && !out.stall && in.we)
	  begin
	     $display("%s: write[%d]: addr %x data %x", g_name, xfer_count, in.adr, in.dat);
	     xfer_count++;
	     
	     end
	
	if(cyc_d0 && !in.cyc)
	  $display("%s: end-of-cycle", g_name);
     end
   
   

endmodule // VHDWBMonitor



module main;

   reg rst_n = 0;
   reg clk_sys = 0;

   reg clk_ref = 0;

   reg [31:0] tai = 0;
   reg [27:0] cycles = 0;
   
   
   
   always #4.1ns clk_ref <= ~clk_ref;
   
   always #8ns clk_sys <= ~clk_sys;


   always@(posedge clk_ref)
     if(cycles == 100) begin
	cycles <= 0;
	tai <= tai + 1;
     end else
       cycles <= cycles + 1;
   
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   IVHDWishboneMaster Host ( clk_sys, rst_n );
   IVHDWishboneMaster EBConfig ( clk_sys, rst_n );


   t_wishbone_master_out host_wb_out;
   t_wishbone_master_in host_wb_in;

   t_wrf_source_out wr_src_out;
   t_wrf_source_in wr_src_in;

   assign  wr_src_in.stall = 0;
   assign  wr_src_in.err = 0;
   assign  wr_src_in.rty = 0;
   always@(posedge clk_sys)
     wr_src_in.ack <= wr_src_out.cyc & wr_src_out.stb;
   

   wire t_wrn_timing_if timing;

   assign timing.tai = tai;
   assign timing.cycles = cycles;
   
   wr_node_core_with_etherbone DUT (
				    .clk_i   (clk_sys),
				    .rst_n_i (rst_n),

				    .clk_ref_i(clk_ref),
				
				    .host_slave_i (Host.master.out),
				    .host_slave_o (Host.master.in),

				    .eb_config_i (EBConfig.master.out),
				    .eb_config_o (EBConfig.master.in),

				    .wr_src_i(wr_src_in),
				    .wr_src_o(wr_src_out),
				    .tm_i(timing)
				    );

   wire t_wishbone_master_in m_in;
   wire t_wishbone_master_out m_out;

   assign m_out.cyc = DUT.ebm_mux_out.cyc;
   assign m_out.stb = DUT.ebm_mux_out.stb;
   assign m_out.we = DUT.ebm_mux_out.we;
   assign m_out.sel = DUT.ebm_mux_out.sel;
   assign m_out.adr = DUT.ebm_mux_out.adr;
   assign m_out.dat = DUT.ebm_mux_out.dat;

   assign m_in.ack = DUT.ebm_mux_in.ack;
   assign m_in.stall = DUT.ebm_mux_in.stall;
   
   


   
   VHDWBMonitor #("ebm") Mon_EB (
			.clk_i(clk_sys),
			.in(m_out),
			.out(m_in));

  
  
 
   
   initial begin
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      CBusAccessor eb = EBConfig.get_accessor();
      
      
      #10us;

      
      cpu_csr = new ( Host.get_accessor(), 'h10000 );
      hmq = new ( Host.get_accessor(), 0 );

      eb.write('h30, 0);
      
      cpu_csr.init();

      cpu_csr.load_firmware (0, "../../sw/hmq_test/hmq-test.ram");
      cpu_csr.reset_core(0, 0);



/* -----\/----- EXCLUDED -----\/-----

      hmq.send(0, '{1,2,3} );

      eb.write(0, 'hdeadbeef);
 -----/\----- EXCLUDED -----/\----- */
      
      
      forever begin
         hmq.update();
         #1us;
      end
      
         
         
      
      
/* -----\/----- EXCLUDED -----\/-----
      #1us;

      forever begin
         hmq.update();
         #100ns;
      end
 -----/\----- EXCLUDED -----/\----- */

   end // initial begin
   
         
   
endmodule

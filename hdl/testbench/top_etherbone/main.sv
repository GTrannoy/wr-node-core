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


module main;

   reg rst_n = 0;
   reg clk_sys = 0;

   always #4ns clk_sys <= ~clk_sys;
   
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
   
   
   wr_node_core_with_etherbone DUT (
				    .clk_i   (clk_sys),
				    .rst_n_i (rst_n),

				    .host_slave_i (Host.master.out),
				    .host_slave_o (Host.master.in),

				    .eb_config_i (EBConfig.master.out),
				    .eb_config_o (EBConfig.master.in),

				    .wr_src_i(wr_src_in),
				    .wr_src_o(wr_src_out)
				    );

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

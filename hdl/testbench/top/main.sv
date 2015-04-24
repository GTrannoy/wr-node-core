import wishbone_pkg::*;
import wr_node_pkg::*;

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
   reg clk_cpu = 0;

   always #4ns clk_cpu <= ~clk_cpu;
   always@(posedge clk_cpu)
     clk_sys <= ~clk_sys;
   
	       
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   IVHDWishboneMaster Host ( clk_sys, rst_n );


   t_wishbone_master_out host_wb_out;
   t_wishbone_master_in host_wb_in;

   wr_node_core # (
		   .g_double_core_clock(1'b0)
		   )DUT (
                     .clk_i   (clk_sys),
		     .clk_cpu_i(clk_cpu),
		     .rst_n_i (rst_n),
                     .host_slave_i (Host.master.out),
                     .host_slave_o (Host.master.in)
    );

   
  
   initial begin
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      uint64_t rv;
      CBusAccessor host_acc;
      
      
      #10us;

      
      host_acc = Host.get_accessor();
      
      
      cpu_csr = new ( Host.get_accessor(), 'h10000 );
      hmq = new ( Host.get_accessor(), 0 );

      
      cpu_csr.init();

      cpu_csr.load_firmware (0, "../../sw/debug-test/debug-test.ram");
      cpu_csr.reset_core(0, 0);
      cpu_csr.load_firmware (1, "../../sw/debug-test/debug-test.ram");
      cpu_csr.reset_core(1, 0);

//      cpu_csr.debug_int_enable(0, 1);
 //     cpu_csr.debug_int_enable(1, 1);

      $display("CPU0 started\n");
      
      forever begin
	 cpu_csr.update();

	 @(posedge clk_sys);
	 
      end
           
      

      host_acc.read('h08, rv);
      $display("GCR_IRQ_MASK %x", rv);
      
      host_acc.read('h04, rv);
     
      $display("GCR_STATUS %x", rv);
      
      hmq.send(0, '{1,2,3} );

      #20us;
      
      $display("GCR_STATUS %x", rv);
      
/* -----\/----- EXCLUDED -----\/-----
      forever begin

	 host_acc.read('h08, rv);
	 $display("GCR_IRQ_MASK %x", rv);
 

         hmq.update();
         #1us;
      end
 -----/\----- EXCLUDED -----/\----- */

      host_acc.write('h20000, 1234);
      host_acc.write('h20004, 5678);

      host_acc.read('h20000, rv);
      $display("smem-read: %d", rv);
      host_acc.read('h20004, rv);
      
      $display("smem-read: %d", rv);
      
         
     
      
      
/* -----\/----- EXCLUDED -----\/-----
      #1us;

      forever begin
         hmq.update();
         #100ns;
      end
 -----/\----- EXCLUDED -----/\----- */

   end // initial begin
   

   
   
endmodule

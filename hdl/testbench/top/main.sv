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

   wire host_irq;   

   IVHDWishboneMaster Host ( clk_sys, rst_n );

   wr_node_core # (
		   .g_double_core_clock(1'b0)
		   )DUT (
			 .clk_i   (clk_sys),
			 .clk_cpu_i(clk_cpu),
			 .rst_n_i (rst_n),
			 .host_slave_i (Host.master.out),
			 .host_slave_o (Host.master.in),
			 .host_irq_o(host_irq)
			 );

   initial begin
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      uint64_t rv;
      CBusAccessor host_acc;
      
      
      #10us;

      
      host_acc = Host.get_accessor();
      
      
      cpu_csr = new ( Host.get_accessor(), 'hc000 );
      hmq = new ( Host.get_accessor(), 0 );

      // enable all IRQs
      host_acc.write(`MQUEUE_GCR_IRQ_MASK, 'hffff);
      
      cpu_csr.init();

      cpu_csr.load_firmware (0, "../../sw/debug-test/debug-test.ram");
      cpu_csr.reset_core(0, 0);

/* -----\/----- EXCLUDED -----\/-----
      cpu_csr.load_firmware (1, "../../sw/debug-test/debug-test.ram");
      cpu_csr.reset_core(1, 0);
 -----/\----- EXCLUDED -----/\----- */

      

      $display("CPU0 started\n");
      
/* -----\/----- EXCLUDED -----\/-----
      forever begin
	 cpu_csr.update();

	 @(posedge clk_sys);
	 
      end
 -----/\----- EXCLUDED -----/\----- */
           

/* -----\/----- EXCLUDED -----\/-----
      host_acc.read('h08, rv);
      $display("GCR_IRQ_MASK %x", rv);
      host_acc.read('h04, rv);
     
      $display("GCR_STATUS %x", rv);
      
      hmq.send(0, '{1,2,3} );

      #20us;
      
      $display("GCR_STATUS %x", rv);
      
      forever begin
         hmq.update();
         #1us;
      end
 -----/\----- EXCLUDED -----/\----- */


/* -----\/----- EXCLUDED -----\/-----
      cpu_csr.set_smem_op(`SMEM_OP_DIRECT);

      host_acc.write('h10000, 'hcafebabe);
      host_acc.write('h10004, 'hdeadbeef);

      
      host_acc.read('h10000, rv);
      $display("smem-read: %x", rv);
      host_acc.read('h10004, rv);
      $display("smem-read: %x", rv);
      
         
      cpu_csr.set_smem_op(`SMEM_OP_ADD);
      $display("Atomic add...\n");
      
      host_acc.write('h10000, 'h1);
      host_acc.write('h10004, 'h2);

      host_acc.read('h10000, rv);
      $display("smem-read: %x", rv);
      host_acc.read('h10004, rv);
      $display("smem-read: %x", rv);
 -----/\----- EXCLUDED -----/\----- */
      
      $error("Loop");
      
      
      forever begin
	 cpu_csr.update();
	 while(host_irq)
           hmq.update();
         #1us;
	 @(posedge clk_sys);
	 
      end

      
   end // initial begin
   

   
   
endmodule

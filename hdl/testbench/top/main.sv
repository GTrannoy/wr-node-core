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

   always #4ns clk_sys <= ~clk_sys;
   
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   IVHDWishboneMaster Host ( clk_sys, rst_n );


   t_wishbone_master_out host_wb_out;
   t_wishbone_master_in host_wb_in;

   wr_node_core DUT (
                     .clk_i   (clk_sys),
                     .rst_n_i (rst_n),

                     .host_slave_i (Host.master.out),
                     .host_slave_o (Host.master.in)
    );
   
/* -----\/----- EXCLUDED -----\/-----
   wire load_x = DUT.gen_cpus[0].U_CPU_Block.U_TheCoreCPU.U_Wrapped_CPU.load_store_unit.load_x;
   wire kill_x = DUT.gen_cpus[0].U_CPU_Block.U_TheCoreCPU.U_Wrapped_CPU.load_store_unit.kill_x;
   wire irom_select_x = DUT.gen_cpus[0].U_CPU_Block.U_TheCoreCPU.U_Wrapped_CPU.load_store_unit.irom_select_x;
   wire[31:0] load_a_x = DUT.gen_cpus[0].U_CPU_Block.U_TheCoreCPU.U_Wrapped_CPU.load_store_unit.load_store_address_x;
   wire [31:0] irom_data_m = DUT.gen_cpus[0].U_CPU_Block.U_TheCoreCPU.U_Wrapped_CPU.load_store_unit.irom_data_m;
   
   reg 	      load_xd = 0, kill_xd, irom_select_xd;
;
   reg [31:0] load_ad;

   always@(posedge clk_sys)
     begin
	load_xd <= load_x;
	load_ad <= load_a_x;
	kill_xd <= kill_x;
	irom_select_xd <= irom_select_x;
	

	
	if(load_xd && !kill_xd && irom_select_xd)
	  begin
	     $display("-> Load: addr %x data %x", load_ad, irom_data_m);
	     
	  end
     end
   
	  
 -----/\----- EXCLUDED -----/\----- */
   	  
   
   

  
   initial begin
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      
      #10us;

      
      cpu_csr = new ( Host.get_accessor(), 'h10000 );
      hmq = new ( Host.get_accessor(), 0 );

      cpu_csr.init();

      cpu_csr.load_firmware (0, "../../sw/fmc-test/tdc/rt-tdc.ram");
      cpu_csr.reset_core(0, 0);

//      hmq.send(0, '{1,2,3} );
      
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

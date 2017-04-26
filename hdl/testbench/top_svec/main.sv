import wishbone_pkg::*;


`include "simdrv_defs.svh"
`include "cpu_csr_driver.svh"
`include "mqueue_host.svh"
`include "vhd_wishbone_master.svh"

      
         
   

module main;

   reg rst_n = 0;
   reg clk_125m = 0, clk_20m = 0;

   always #4ns clk_125m <= ~clk_125m;
   always #25ns clk_20m <= ~clk_20m;
   
   initial begin
      repeat(20) @(posedge clk_125m);
      rst_n = 1;
   end

      
   svec_top #(
              .g_with_wr_phy(0),
              .g_simulation(1),
	      .g_bypass_vme_core(1)
              ) DUT (
		     .clk_125m_pllref_p_i(clk_125m),
		     .clk_125m_pllref_n_i(~clk_125m),
		     .clk_125m_gtp_p_i(clk_125m),
		     .clk_125m_gtp_n_i(~clk_125m),

		     .clk_20m_vcxo_i(clk_20m),
		     .rst_n_a_i(rst_n),

		     .sim_wb_i(Host.master.out),
		     .sim_wb_o(Host.master.in)
		     );
   IVHDWishboneMaster Host ( DUT.clk_sys, DUT.rst_n_sys );


   

   reg force_irq = 0;
   
   initial begin
      automatic CBusAccessor acc = Host.get_accessor();
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      uint64_t d;

      @(posedge DUT.rst_n_sys);
      
      #5us;
      
      cpu_csr = new ( acc, 'h0x02c000 );
      cpu_csr.init();
      cpu_csr.reset_core(0, 1);

      #400us;
      
      cpu_csr.load_firmware(0, "../../sw/rmq-test/rmq-test.ram");
      cpu_csr.reset_core(0, 0);


      
      forever begin
         cpu_csr.update();
         #1us;
      end
      
   end
 
   

  
endmodule // main





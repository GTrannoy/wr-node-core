`include "simdrv_defs.svh"
`include "cpu_csr_driver.svh"
`include "mqueue_host.svh"
`include "vme64x_bfm.svh"
`include "svec_vme_buffers.svh"


   /*
   initial begin
    
         
         
     */ 
      
         
   

module main;

   reg rst_n = 0;
   reg clk_125m = 0, clk_20m = 0;

   always #4ns clk_125m <= ~clk_125m;
   always #25ns clk_20m <= ~clk_20m;
   
   initial begin
      repeat(20) @(posedge clk_125m);
      rst_n = 1;
   end

   IVME64X VME(rst_n);

   `DECLARE_VME_BUFFERS(VME.slave);

   reg tdc_ef1 = 1;
   reg tdc_pulse = 0;
   wire tdc_rd_n;


   always@(posedge tdc_pulse) begin
      #100ns;
      tdc_ef1 <= 0;
      while(tdc_rd_n != 0)
	#1ns;
      #10ns;
      tdc_ef1 <= 1;
   end

   reg clk_acam = 0;
   reg clk_62m5 = 0;
   

   always@(posedge clk_125m)
     clk_62m5 <= ~clk_62m5;

   always@(posedge clk_62m5)
     clk_acam <= ~clk_acam;
   
   
   svec_top #(
              .g_with_wr_phy(0),
              .g_simulation(1)
              ) DUT (
		     .clk_125m_pllref_p_i(clk_125m),
		     .clk_125m_pllref_n_i(~clk_125m),
		     .clk_125m_gtp_p_i(clk_125m),
		     .clk_125m_gtp_n_i(~clk_125m),

		     .fmc1_fd_clk_ref_p_i(clk_125m),
		     .fmc1_fd_clk_ref_n_i(~clk_125m),

		     .fmc0_tdc_125m_clk_p_i(clk_125m),
		     .fmc0_tdc_125m_clk_n_i(~clk_125m),

		     .fmc0_tdc_acam_refclk_p_i(clk_acam),
		     .fmc0_tdc_acam_refclk_n_i(~clk_acam),

		     .clk_20m_vcxo_i(clk_20m),
                     .fmc0_tdc_pll_status_i(1'b1),
		     .rst_n_a_i(rst_n),

		     .fmc0_tdc_ef1_i(tdc_ef1),
		     .fmc0_tdc_ef2_i(1'b1),
		     .fmc0_tdc_err_flag_i(1'b0),
		     .fmc0_tdc_int_flag_i(1'b0),
		     .fmc0_tdc_rd_n_o(tdc_rd_n),
		     .fmc0_tdc_in_fpga_1_i(tdc_pulse),
		     .fmc0_tdc_in_fpga_2_i(1'b0),
		     .fmc0_tdc_in_fpga_3_i(1'b0),
		     .fmc0_tdc_in_fpga_4_i(1'b0),
		     .fmc0_tdc_in_fpga_5_i(1'b0),
		     

		     `WIRE_VME_PINS(8)
		     );
   

   
   
   

  task automatic config_vme_function(ref CBusAccessor_VME64x acc, input int func, uint64_t base, int am);
      uint64_t addr = 'h7ff63 + func * 'h10;
      uint64_t val = (base) | (am << 2);

      $display("Func%d ADER=0x%x", func, val);

     if(am == 0)
       val = 1;
      
      acc.write(addr + 0, (val >> 24) & 'hff, CR_CSR|A32|D08Byte3);
      acc.write(addr + 4, (val >> 16) & 'hff, CR_CSR|A32|D08Byte3);
      acc.write(addr + 8, (val >> 8)  & 'hff, CR_CSR|A32|D08Byte3);
      acc.write(addr + 12, (val >> 0) & 'hff, CR_CSR|A32|D08Byte3);
 
      
   endtask // config_vme_function
   
   
   task automatic init_vme64x_core(ref CBusAccessor_VME64x acc);
      uint64_t rv;


      /* map func0 to 0x80000000, A32 */
//      config_vme_function(acc, 0, 'h80000000, 'h09);
      /* map func1 to 0xc00000, A24 */
      config_vme_function(acc, 1, 'hc00000, 'h39);
      config_vme_function(acc, 0, 0, 0);

      acc.write('h7ff33, 1, CR_CSR|A32|D08Byte3);
      acc.write('h7fffb, 'h10, CR_CSR|A32|D08Byte3); /* enable module (BIT_SET = 0x10) */

      acc.set_default_modifiers(A24 | D32 | SINGLE);
   endtask // init_vme64x_core
   

   reg force_irq = 0;
   
   initial begin
      CBusAccessor_VME64x acc = new(VME.master);
      CBusAccessor acc_casted = CBusAccessor'(acc);
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      uint64_t d;
      
      #100us;

      init_vme64x_core(acc);
      acc_casted.set_default_xfer_size(A24|SINGLE|D32);

      #150us;
      
      cpu_csr = new ( acc, 'h0xcd0000 );
      cpu_csr.init();
      cpu_csr.reset_core(0, 0);

      #150us;

/* -----\/----- EXCLUDED -----\/-----
      acc.read('hc20000, d); 
      $display("TDC SDB ID : %x", d);

      acc.write('hc310a0, 1234);  // set UTC
      acc.write('hc310fc, 1<<9); // load UTC

      acc.write('hc32004, 'hf); // enable EIC irq
      acc.write('hc70000, 'h1); // enable VIC
      acc.write('hc70008, 'h1); // enable VIC irq line 0

//      acc.write('hc31090, 1); // irq threshold = 1

      acc.write('hc31084, 'h1f); // enable all ACAM inputs
      acc.write('hc310fc, (1<<0)); // start acquisition
 -----/\----- EXCLUDED -----/\----- */
      
         
/* -----\/----- EXCLUDED -----\/-----
      #300us;
      forever begin
	 tdc_pulse <= 1;
	 #1000ns;
	 tdc_pulse <= 0;
	 #10ns;
      end
 -----/\----- EXCLUDED -----/\----- */
      
     
      
     
      
      
      
    //  hmq.send(0, '{1,2,3} );
    //  hmq.send(0, '{3,6,9} );

      //eb.write(0, 'hdeadbeef);

   
      
      
/* -----\/----- EXCLUDED -----\/-----
      forever begin
         hmq.update();
         #1us;
      end
 -----/\----- EXCLUDED -----/\----- */
      
   end
 
   

  
endmodule // main





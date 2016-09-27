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


   reg clk_acam = 0;
   reg clk_62m5 = 0;
   

   always@(posedge clk_125m)
     clk_62m5 <= ~clk_62m5;

   always@(posedge clk_62m5)
     clk_acam <= ~clk_acam;

   reg adc_dco = 0;
   
   always #1ns adc_dco <= ~adc_dco;
   
   
   svec_top #(
              .g_with_wr_phy(0),
              .g_simulation(1)
              ) DUT (
		     .clk_125m_pllref_p_i(clk_125m),
		     .clk_125m_pllref_n_i(~clk_125m),
		     .clk_125m_gtp_p_i(clk_125m),
		     .clk_125m_gtp_n_i(~clk_125m),

		     .adc0_dco_p_i(adc_dco),
		     .adc0_dco_n_i(~adc_dco),
		     

//		     .fmc0_wr_ref_clk_p_i(clk_125m),
//		     .fmc0_wr_ref_clk_n_i(~clk_125m),

		     .clk_20m_vcxo_i(clk_20m),
		     .rst_n_a_i(rst_n),


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
      automatic CBusAccessor_VME64x acc = new(VME.master);
      automatic CBusAccessor acc_casted = CBusAccessor'(acc);
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      uint64_t d;
      
      #100us;

      init_vme64x_core(acc);
      acc_casted.set_default_xfer_size(A24|SINGLE|D32);

      #150us;
      

      acc.write('hc11000 + 0, 'h10000000); // RFREQL
      acc.write('hc11000 + 'h4, 'h0); // RFREQH

      acc.write('hc60200 + 'h24, (0 | (1<<16)));
		
      
      
      
      #150us;

      
   end
 
   

  
endmodule // main





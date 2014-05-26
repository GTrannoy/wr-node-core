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

		     .clk_20m_vcxo_i(clk_20m),
                     .fmc0_tdc_pll_status_i(1'b1),
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
   
   
   initial begin
      CBusAccessor_VME64x acc = new(VME.master);
      CBusAccessor acc_casted = CBusAccessor'(acc);
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      uint64_t d;
      
      
      #100us;

      init_vme64x_core(acc);
      acc_casted.set_default_xfer_size(A24|SINGLE|D32);
 

/* -----\/----- EXCLUDED -----\/-----
      acc.read('hc00000, d); $display("%x", d);
      acc.read('hc40000, d); $display("%x", d);
      acc.read('hc40004, d); $display("%x", d);
      acc.read('hc40008, d); $display("%x", d);
 -----/\----- EXCLUDED -----/\----- */

      #10us;

      #400us;

/* -----\/----- EXCLUDED -----\/-----
      acc.read('hc20000, d); $display("TDC SDB ID : %x", d);

      
      $stop;
      
      
      #10us;
 -----/\----- EXCLUDED -----/\----- */

      

      
      cpu_csr = new ( acc, 'h0xcd0000 );
      hmq = new ( acc, 'h0xcc0000);

      cpu_csr.init();

      cpu_csr.load_firmware (0, "../../sw/hmq_test/hmq-test.ram");
      cpu_csr.reset_core(0, 0);

/* -----\/----- EXCLUDED -----\/-----
      acc.write('hc10000, 1);
      acc.write('hc10000, 0);
      acc.write('hc10000, 1);
      acc.write('hc10000, 0);
 -----/\----- EXCLUDED -----/\----- */
      
      
    //  hmq.send(0, '{1,2,3} );
    //  hmq.send(0, '{3,6,9} );

      //eb.write(0, 'hdeadbeef);

   
      
      
      forever begin
         hmq.update();
         #1us;
      end
      
   end
   
   

  
endmodule // main





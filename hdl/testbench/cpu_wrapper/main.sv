//`include "mqueue_regs.vh"
`timescale 1ps/1ps

import wishbone_pkg::*;
import wrn_cpu_csr_wbgen2_pkg::*;
import wr_node_pkg::*;


module main;

   reg rst_n = 0;
   reg clk_sys = 0;
   reg clk_ref = 0;
   
   always #8ns clk_sys <= ~clk_sys;
   always #4.023ns clk_ref <= ~clk_ref;
   
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   
   
   t_wrn_timing_if tm;

   initial begin
      tm.tai = 0;
      tm.cycles = 0;
   end

   always@(posedge clk_ref)
     begin
	if(tm.cycles == 1000)
	  begin
	     tm.cycles <= 0;
	     tm.tai<=tm.tai+1;
	  end
	else
	  tm.cycles<=tm.cycles+1;
	
	
	    
     end
   
   
      
      
   

   t_wishbone_master_out cpu_wb_out;
   t_wishbone_master_in cpu_wb_in;

   t_wrn_cpu_csr_out_registers cpu_csr_out;
   t_wrn_cpu_csr_in_registers cpu_csr_in;

   
   wrn_cpu_cb #(
                      .g_iram_size(16384),
                      .g_cpu_id(0)
                      ) DUT (
                             .clk_sys_i (clk_sys),
                             .rst_n_i   (rst_n),

			     .clk_ref_i(clk_ref),
			     .rst_n_ref_i(rst_n),
			     
//                             .dwb_o(cpu_wb_out),
//                             .dwb_i (cpu_wb_in),
			     .tm_i(tm),
                             .cpu_csr_i(cpu_csr_out),
                             .cpu_csr_o(cpu_csr_in)
                             );

   task automatic load_firmware( string filename, int cpu, ref t_wrn_cpu_csr_out_registers regs );
      integer f = $fopen(filename,"r");

      regs.core_sel_o = cpu;
      regs.enable_o[cpu] = 0;
      regs.reset_o[cpu] = 1;
      @(posedge clk_sys);

      $display("f: %d\n", f);

      while(!$feof(f))
        begin
           int addr, data;
           string cmd;
           
           $fscanf(f,"%s %08x %08x", cmd,addr,data);
           if(cmd == "write")
             begin
                regs.udata_o = data;
                regs.udata_load_o = 1;
                regs.uaddr_addr_o = addr;
                @(posedge clk_sys);
                regs.udata_load_o = 0;
                @(posedge clk_sys);
             end
        end
      
      $fclose(f);

      regs.enable_o[cpu] = 1;
      regs.reset_o[cpu] = 0;
      @(posedge clk_sys);
      
      
      
   endtask // load_firmware

   initial begin
      load_firmware ( "../../sw/lr-test/lr-test.ram", 0, cpu_csr_out);
      
      
   end
   
   
endmodule

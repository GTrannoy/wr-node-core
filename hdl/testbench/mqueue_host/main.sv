`include "simdrv_defs.svh"
`include "if_wb_master.svh"

import wishbone_pkg::*;
import wrn_cpu_csr_wbgen2_pkg::*;

`include "mqueue_regs.vh"

interface IVHDWishboneMaster
  (
   input clk_i,
   input rst_n_i
   );

   parameter g_addr_width 	   = 32;
   parameter g_data_width 	   = 32;

   typedef virtual IWishboneMaster VIWishboneMaster;
   
   IWishboneMaster #(g_addr_width, g_data_width) TheMaster (clk_i, rst_n_i);

   t_wishbone_master_in in;
   t_wishbone_master_out out;

   modport master
     (
      input  in,
      output out
      );
   
   assign out.cyc = TheMaster.cyc;
   assign out.stb = TheMaster.stb;
   assign out.we = TheMaster.we;
   assign out.sel = TheMaster.sel;
   assign out.adr = TheMaster.adr;
   assign out.dat = TheMaster.dat_o;
   assign TheMaster.ack = in.ack;
   assign TheMaster.stall = in.stall;
   assign TheMaster.rty = in.rty;
   assign TheMaster.err = in.err;
   assign TheMaster.dat_i = in.dat;

   
   function CBusAccessor get_accessor();
      return TheMaster.get_accessor();
   endfunction // get_accessor

   initial begin
      CWishboneAccessor acc;
      
      @(posedge rst_n_i);
      @(posedge clk_i);

      TheMaster.settings.addr_gran = BYTE;
      acc = TheMaster.get_accessor();
      acc.set_mode( PIPELINED );
      
   end
   
      
endinterface // IVHDWishboneMaster

     
module main;

   reg rst_n = 0;
   
   reg clk_sys = 0;

   always #4ns clk_sys <= ~clk_sys;
   
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   IVHDWishboneMaster SI ( clk_sys, rst_n );
   IVHDWishboneMaster Host ( clk_sys, rst_n );
   

   wrn_mqueue_host DUT (
                        .clk_i   (clk_sys),
                        .rst_n_i (rst_n),

                        .si_slave_i (SI.master.out),
                        .si_slave_o (SI.master.in),

                        .host_slave_i (Host.master.out),
                        .host_slave_o (Host.master.in)
    );

   
   initial begin
      uint32_t test_d[] = '{1,2,3,4,5};
      MQueueCB cpu0;

      cpu0 = new ( SI.get_accessor(), 0 );
      
      
      #1us;

      cpu0.send(0, test_d);
      cpu0.send(0, test_d);
      cpu0.send(0, '{10,11,12});
      

      cpu0.send(1, '{'hde, 'had});

      
   end
   initial begin
      MQueueHost hmq;
      hmq = new ( Host.get_accessor(), 0 );

      hmq.send(0, '{123,345,45,4655,21,4});
      
      
      #1us;

      forever begin
         hmq.update();
         #100ns;
      end
      
         
      
   end
   

   
endmodule

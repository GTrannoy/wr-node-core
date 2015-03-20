`include "simdrv_defs.svh"
`include "if_wb_master.svh"

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
      TheMaster.settings.cyc_on_stall = 1;
      
      acc = TheMaster.get_accessor();
      acc.set_mode( PIPELINED );
      
   end
   
      
endinterface // IVHDWishboneMaster

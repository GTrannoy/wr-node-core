`include "simdrv_defs.svh"
`include "if_wb_master.svh"

import wishbone_pkg::*;
import etherbone_pkg::*;
import wr_fabric_pkg::*;




`include "vhd_wishbone_master.svh"
`include "mqueue_host.svh"

module main;

   reg rst_n = 0;
   
   reg clk_sys = 0;

   always #4ns clk_sys <= ~clk_sys;
   
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   IVHDWishboneMaster SI ( clk_sys, rst_n );
   IVHDWishboneMaster EbsCfg ( clk_sys, rst_n );

   t_wishbone_master_out ebm_out;
   t_wishbone_master_in ebm_in;

   t_wishbone_master_out ebs_master_out;
   t_wishbone_master_in ebs_master_in;


   t_wrf_source_in src_in;
   t_wrf_source_out src_out;
   
   wrn_mqueue_remote  DUT (
                           .clk_i   (clk_sys),
                           .rst_n_i (rst_n),

                           .si_slave_i (SI.master.out),
                           .si_slave_o (SI.master.in),

                           .ebm_master_o (ebm_out),
                           .ebm_master_i (ebm_in)
                           );


   eb_master_top
     #(
       .g_mtu(1024)
       )
   EBM 
     (
            .clk_i        (clk_sys),
            .rst_n_i      (rst_n),

            .slave_i      (ebm_out),
            .slave_o      (ebm_in),
     
            .src_i        (src_in),
            .src_o        (src_out)
            );



   eb_ethernet_slave #(
                       .g_sdb_address    (64'h0),
                       .g_timeout_cycles (1000),
                       .g_mtu            (1024))
   U_Slave (
            .clk_i       (clk_sys),
            .nRst_i      (rst_n),
      
            .snk_i       (src_out),
            .snk_o       (src_in),
            .src_o       (),
            .src_i       (),
            .cfg_slave_o (EbsCfg.master.in),
            .cfg_slave_i (EbsCfg.master.out),
            .master_o    (ebs_master_out),
            .master_i    (ebs_master_in)
            );

   
/* -----\/----- EXCLUDED -----\/-----
   assign src_in.stall = 0;
   assign src_in.ack = 1;
   assign src_in.err = 0;
   assign src_in.rty = 0;
 -----/\----- EXCLUDED -----/\----- */

   assign ebs_master_in.stall = 0;
   assign ebs_master_in.err = 0;
   assign ebs_master_in.rty = 0;

   always@(posedge clk_sys)
     ebs_master_in.ack <= ebs_master_out.cyc & ebs_master_out.stb;

   always@(posedge clk_sys)
     if(ebs_master_out.cyc & ebs_master_out.stb & ebs_master_out.we)
       $display("--> EBS-write addr %x data %x", ebs_master_out.adr ,ebs_master_out.dat);

   
   always@(posedge clk_sys)
     if(ebm_out.cyc & ebm_out.stb & !ebm_in.stall)
       if(ebm_out.we)
         $display("EBM-write addr %x data %x", ebm_out.adr, ebm_out.dat);
       else if(ebm_in.ack)
         $display("EBM-read addr %x data %x", ebm_out.adr, ebm_in.dat);

   
   
   initial begin
      uint32_t test_d[] = '{32'hffffffff,32'hebd0,32'h120000,4,5};
      uint32_t test_d2[] = '{32'hffffffff,32'hebd0,32'h140000,1,2,3,4,5};

      MQueueCB cpu0;
      CBusAccessor eb_cfg;

      eb_cfg = EbsCfg.get_accessor();
      
      cpu0 = new ( SI.get_accessor(), 0 );
      
      #1us;

      cpu0.send(0, test_d);
      #10us;
      
      cpu0.send(0, test_d2);
//      cpu0.send(0, '{10,11,12});

      
   end

   

   
endmodule

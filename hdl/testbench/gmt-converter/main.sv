`timescale 1ns/1ps

import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"
`include "gmt_converter_wb.vh"

// from ADC to raw_phase : 3262ns

   
module main;

   parameter g_clock_freq = 125000000;
   
  reg clk_wr = 0, clk_sys =0, clk_40m = 0;
  reg rst_n = 0;

   always
     #4ns clk_wr <= ~clk_wr;

   always
     #12.5ns clk_40m <= ~clk_40m;

   always@(posedge clk_wr)
     clk_sys <= ~clk_sys;

   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   IVHDWishboneMaster Host1 ( clk_sys, rst_n );

   reg [39:0]  tm_tai = 100;
   reg [31:0]  tm_nsec = 0;
   
   // 1GHz nsec counter
   always@(posedge clk_wr) begin
      if(tm_nsec == (g_clock_freq * 8 - 1)) begin
	 tm_tai <= tm_tai + 1;
	 tm_nsec <= 0;
      end      else
	tm_nsec <= tm_nsec + 8;
   end

   wire gmt_tx_done;
   reg 	gmt_tx_start = 0;
   reg [31:0] gmt_tx_data;
   wire       gmt_serial;
   
   int 	      bitrate_cnt = 0;
   reg 	      bitrate_tick = 0;
   

   always@(posedge clk_40m)
     begin
	if (bitrate_cnt == 39)
	  bitrate_cnt <= 0;
	else
	  bitrate_cnt <= bitrate_cnt + 1;

	bitrate_tick <= (bitrate_cnt == 0);
     end 
   

   me2 U_GMTEncoder 
     (
      .reset(~rst_n),
      .Clk40(clk_40m),
      .BitRate(bitrate_tick),
      .mesin_vec(gmt_tx_data),
      .start(gmt_tx_start),
      .mdo(gmt_serial),
      .done(gmt_tx_done)
      );
   
   
   // cores under test
   gmt_converter
      
   DUT (
	.rst_n_sys_i(rst_n),
	.clk_sys_i (clk_sys),
	.clk_wr_i (clk_wr),
	.clk_40m_i (clk_40m),

	.tm_valid_i(1'b1),
	.tm_cycles_i(tm_nsec[30:3]),
	
	.gmt_i({4'b0, gmt_serial}),
	
	.slave_i(Host1.master.out),
	.slave_o(Host1.master.in)
	);

   
    initial begin
       uint64_t rv;
      CBusAccessor acc_slave = Host1.get_accessor();

      $display ("Starting GMT Test");
      #5us;

      acc_slave.write(`ADDR_GMTC_CR, 1);
      acc_slave.write(`ADDR_GMTC_CR, 0);
       acc_slave.write(`ADDR_GMTC_DELAY, 10);
       
      
       @(posedge clk_40m);
       gmt_tx_data <= 'hdeadbeef;
       gmt_tx_start <= 1;
       @(posedge clk_40m);
       gmt_tx_start <= 0;
       
       @(posedge clk_40m);
       
       while(1)
	 begin
	    acc_slave.read(`ADDR_GMTC_RX_STATUS, rv);
	    if(rv & 1)
	      begin
		 acc_slave.read(`ADDR_GMTC_RX_DATA0,rv);
		 $display("RX %x", rv);
		 acc_slave.read(`ADDR_GMTC_RX_TSTAMP0,rv);
		 $display("Timestamp %x", rv);
		 acc_slave.write(`ADDR_GMTC_RX_STATUS, 1);
	      end
	 end
       
       

	
     end
   
   
   
endmodule

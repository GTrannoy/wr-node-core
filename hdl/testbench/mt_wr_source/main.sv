import wishbone_pkg::*;
import wr_node_pkg::*;
import wr_fabric_pkg::*;


`include "stream_utils.svh"
`include "wb_packet_source.svh"
`include "wb_packet_sink.svh"
`include "if_wb_master.svh"
`include "if_wb_slave.svh"


module main;

   reg rst_n = 0;
   reg clk_sys = 0;


   
   
   always #8ns clk_sys <= ~clk_sys;

   initial begin
      repeat(3) @(posedge clk_sys);
      rst_n <= 1;
   end
   

   t_mt_stream_source_out src_out;
   t_mt_stream_source_in src_in;

   t_wrf_source_out wr_out;
   t_wrf_source_in wr_in;
   
   stream_source SRC

     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .src_o(src_out),
      .src_i(src_in)
      );

   mt_wr_source DUT 
     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .src_o(wr_out),
      .src_i(wr_in),
      .snk_i(src_out),
      .snk_o(src_in)
      );


   IWishboneSlave #(2,16) WBS (clk_sys, rst_n);

   assign WBS.cyc = wr_out.cyc;
   assign WBS.stb = wr_out.stb;
   assign WBS.sel = wr_out.sel;
   assign WBS.we = wr_out.we;
   assign WBS.adr = wr_out.adr;
   assign WBS.dat_i = wr_out.dat;

   assign wr_in.stall = WBS.stall;
   assign wr_in.ack = WBS.ack;
   assign wr_in.err = WBS.err;
   assign wr_in.rty = WBS.rty;
   
		       

   
		   
		   

   
   initial begin
      uint32_t payload[$];
      vec64_t tx_payload;
      byte rx_payload[$];
      
      int i;
      WBPacketSink pkt_snk = new ( WBS.get_accessor() );


      #10us;

      while(1)
	begin
	   int len;

	   payload = '{};
	   len = 50 + $urandom()%100;
	   

	   $display("Len: %d", len);
	   
	   for ( i=0 ; i < len ; i++)
	     payload[i] = $random() & 'hffff;
      
	   SRC.send(payload);
	   
	   while(!pkt_snk.poll() ) #1us;

	   rx_payload='{};
	   
	   pkt_snk.recvRaw(rx_payload);
	   
	   
	   tx_payload = pack( payload, 2, 1 );

	   if(tx_payload.size() != rx_payload.size() )
	     $error("size mismatch: %d %d", tx_payload.size(), rx_payload.size() );
	   
	   for (int i = 0; i < rx_payload.size(); i++)
	     begin
//		$display("%-0x %-0x %s ", tx_payload[i], rx_payload[i], tx_payload[i] == rx_payload[i]?"OK" : "FAIL");

		if ( tx_payload[i] != rx_payload[i] ) begin
		  $display("%-0x %-0x ", tx_payload[i], rx_payload[i]);
		   $stop;
		end
		
	   
	     end

//	   $stop;
	   
	end // while (1)
      
      
  
   end // initial begin

   
         
   
endmodule

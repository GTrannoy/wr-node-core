import wishbone_pkg::*;
import wr_node_pkg::*;
import wr_fabric_pkg::*;


`include "stream_utils.svh"
`include "wb_packet_source.svh"
`include "wb_packet_sink.svh"
`include "if_wb_master.svh"


module main;

   reg rst_n = 0;
   reg clk_sys = 0;


   
   
   always #8ns clk_sys <= ~clk_sys;

   initial begin
      repeat(3) @(posedge clk_sys);
      rst_n <= 1;
   end
   

   t_mt_stream_sink_out snk_out;
   t_mt_stream_sink_in snk_in;

   t_wrf_source_out wr_out;
   t_wrf_source_in wr_in;
   
   stream_sink SNK

     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .snk_o(snk_out),
      .snk_i(snk_in)
      );

   mt_wr_sink DUT 
     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .src_o(snk_in),
      .src_i(snk_out),
      .snk_i(wr_out),
      .snk_o(wr_in)
      );


   IWishboneMaster #(2,16) WBM (clk_sys, rst_n);

   assign wr_out.cyc = WBM.cyc;
   assign wr_out.stb = WBM.stb;
   assign wr_out.we = WBM.we;
   assign wr_out.sel = WBM.sel;
   assign wr_out.adr = WBM.adr;
   assign wr_out.dat = WBM.dat_o;
   assign WBM.stall = wr_in.stall;
   assign WBM.ack = wr_in.ack;
   assign WBM.err = wr_in.err;
   assign WBM.rty = wr_in.rty;
   
		       

   
		   
		   

   
   initial begin
      byte payload[$];
      vec64_t rx_payload;
      
      int i;
      WBPacketSource pkt_src = new ( WBM.get_accessor() );


      #10us;

      while(1)
	begin
	   int len;

	   payload = '{};
	   len = 100 + ($urandom()%100)*2;

	   $display("Len: %d", len);
	   
	   for ( i=0 ; i < len ; i++)
	     payload[i] = $random();
      
	   pkt_src.sendRaw(payload);
	   
	   while(!SNK.poll() ) #1us;
      
	   rx_payload = pack( SNK.recv(), 2, 1 );

	   if(payload.size() != rx_payload.size() )
	     $error("size mismatch: %d %d", payload.size(), rx_payload.size() );
	   
	   for (int i = 0; i < rx_payload.size(); i++)
	     begin
		if ( payload[i] != rx_payload[i] ) begin
		  $error("%x %x ", payload[i], rx_payload[i]);
		   $stop;
		end
		
	   
	     end
	end // while (1)
      
      
      

   end // initial begin

   
         
   
endmodule

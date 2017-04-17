`include "simdrv_defs.svh"
`include "if_wb_master.svh"

import wishbone_pkg::*;
import etherbone_pkg::*;
import wr_fabric_pkg::*;
import wrn_mqueue_pkg::*;

typedef uint32_t vec32_t[$];



module stream_sink
(
 input clk_i,
 input rst_n_i,

 input t_mt_stream_sink_in snk_i,
 output t_mt_stream_sink_out snk_o
 );


   int 	idle = 1;
   vec32_t data;
   vec32_t packets[$];
   

   int 	f_out = 0;

   parameter int g_throttle = 50;

   
   
   always@(posedge clk_i)
     snk_o.ready <= $dist_uniform(seed, 0,100) < g_throttle ;
   

   
   
   task dump(uint32_t d[$]);
      int i;

      if(!f_out)
	f_out = $fopen("dump.txt","wb");
      
   
      for(i=0;i<d.size();i++)
	begin
//	   $display("Word %x: %x", i, d[i]);
	   $fwrite(f_out,$sformatf("%08x %02x %02x XX\n", i*2, d[i] >> 8, d[i]&'hff));
	end
      
      
      $fflush(f_out);
      
   endtask // dump
   
   
   
   always@(posedge clk_i)
     begin
	if(!rst_n_i)
	begin
	   idle <= 1;
	end else begin
	   if(snk_i.valid && snk_o.ready)
	     begin
		data.push_back(snk_i.data[15:0]);
		$display("got %x", snk_i.data[15:0]);
		if(snk_i.last)
		  begin
		     dump( data );
		     packets.push_back(data);
		     data={};
		  end
	     end
	end // else: !if(!rst_n_i)
     end // always@ (posedge clk_i)
   
   

   
   
endmodule // stream_sink


module stream_mon
(
 input clk_i,
 input rst_n_i,

 input t_mt_stream_sink_in snk_in_i,
 input t_mt_stream_sink_out snk_out_i
 );


   uint32_t data[$];


   
   
   task dump(uint32_t d[$]);
      int i;
      
   
      for(i=0;i<d.size();i++)
	begin
	   $display("Mon %x: %x", i, d[i]);
	 
	end
      
      
   endtask // dump
   
   
   
   always@(posedge clk_i)
     begin
	if(!rst_n_i)
	begin
	end else begin
	   if(snk_in_i.valid && snk_out_i.ready)
	     begin
		data.push_back(snk_in_i.data[15:0]);
		if(snk_in_i.last)
		  begin
		     dump( data );
		     data={};
		  end
	     end
	end // else: !if(!rst_n_i)
     end // always@ (posedge clk_i)
   
endmodule // stream_mon


module stream_source
(
 input clk_i,
 input rst_n_i,

 input t_mt_stream_source_in src_i,
 output t_mt_stream_source_out src_o
 );

   parameter int g_throttle = 50;

   initial begin
      src_o.valid = 0;
      src_o.last = 0;
   end
   
   reg valid_d = 0;
   
   int seed = 0;
   
   task automatic send( uint32_t data[$] );
      int i=0;
      int first=1;

      while( 1 )
	begin
	   bit gap;
	   
	   
	   

	   if(i == data.size())
	     break;

//	   $display("Send: i %d\n", i);
	   src_o.valid <= 1;
	   src_o.last <= (i == data.size() - 1);
	   src_o.data <= data[i];
           @(posedge clk_i);
	   while(!src_i.ready)
	     @(posedge clk_i);

	   i++;

	   gap = ($dist_uniform(seed, 0,100) < g_throttle );

	   if (gap)
	     begin
		src_o.valid <= 0;
		@(posedge clk_i);
	     end
	   
	end

      src_o.valid <= 0;
      src_o.last <= 0;
      @(posedge clk_i);
   endtask // send
   
endmodule // stream_source

   
  

module test_tx_path;

   reg rst_n = 0;
   
   reg clk_sys = 0;

   always #4ns clk_sys <= ~clk_sys;
   
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   
   
   function vec32_t make_vector(int length);
      vec32_t rv;
      int i;

      for(i=0;i<length;i++)
	rv.push_back(i);

      return rv;
   endfunction // make_vector
   

   t_mt_stream_source_out src_out;
   t_mt_stream_source_in src_in;
   t_mt_stream_sink_out snk_out;
   t_mt_stream_sink_in snk_in;

//   assign snk_out.ready = 1;

stream_mon mon(
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .snk_in_i(src_out),
      .snk_out_i(src_in)
);
   
   
   stream_source SRC
     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .src_o(src_out),
      .src_i(src_in)
      );

   stream_sink SNK
     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .snk_o(snk_out),
      .snk_i(snk_in)
      );
   

   initial begin
      repeat(100)@(posedge clk_sys);

      SRC.send(make_vector(16));
      
   end
  /*
     mt_udp_tx_framer
     DUT (
	  
	  .clk_i   (clk_sys),
	  .rst_n_i (rst_n),

	  .snk_i ( src_out ),
	  .snk_o ( src_in ),

	  .src_i(snk_out),
	  .src_o(snk_in),

	  .p_src_port_i      (16'h0000),
	  .p_dst_port_i      (16'hebd1),
	  .p_src_ip_i        (32'hffffffff),
	  .p_dst_ip_i        (32'hffffffff),
	  .p_payload_len_i (16'h10)
    );
*/
   
   mt_rmq_tx_path
     DUT (
	  
	  .clk_i   (clk_sys),
	  .rst_n_i (rst_n),

	  .snk_i ( src_out ),
	  .snk_o ( src_in ),

	  .src_i(snk_out),
	  .src_o(snk_in),

	  .p_use_udp_i       (1'b1),
	  .p_dst_mac_i       (48'hffffffffffff),
	  .p_ethertype_i     (16'h0800),
	  .p_src_port_i      (16'h0000),
	  .p_dst_port_i      (16'hebd1),
	  .p_src_ip_i        (32'hffffffff),
	  .p_dst_ip_i        (32'hffffffff),
	  .p_payload_words_i (16'h10)
    );

/* -----\/----- EXCLUDED -----\/-----
      mt_rmq_tx_packer
     DUT (
	  
	  .clk_i   (clk_sys),
	  .rst_n_i (rst_n),

	  .snk_i ( src_out ),
	  .snk_o ( src_in ),

	  .src_i(snk_out),
	  .src_o(snk_in)
    );
 -----/\----- EXCLUDED -----/\----- */


endmodule // test_tx_path

module test_rx_path;

   reg rst_n = 0;
   
   reg clk_sys = 0;

   always #4ns clk_sys <= ~clk_sys;
   
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   typedef uint32_t vec32_t[$];
   
   

   function vec32_t read_packet(string filename);
      int i,f ;
      vec32_t rv;
      
      f = $fopen(filename,"rb");

      while(!$feof(f))
	begin
	   string dummy;
	   int 	  offs, b1, b2, r;
	   
	   if( $fscanf(f, "%x %x %x %s", offs,b1,b2,dummy) == 4)
	     rv.push_back((b1 << 8) | b2);
	   else
	     break;
	end

      $fclose(f);
      return rv;
      
   endfunction // read_packet
   
   

   t_mt_stream_source_out src_out;
   t_mt_stream_source_in src_in;
   t_mt_stream_sink_out snk_out;
   t_mt_stream_sink_in snk_in;

//   assign snk_out.ready = 1;

/* -----\/----- EXCLUDED -----\/-----
stream_mon mon(
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .snk_in_i(src_out),
      .snk_out_i(src_in)
);
 -----/\----- EXCLUDED -----/\----- */
   
   
   stream_source SRC
     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .src_o(src_out),
      .src_i(src_in)
      );

   stream_sink SNK
     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .snk_o(snk_out),
      .snk_i(snk_in)
      );
   

   initial begin
      vec32_t pkt;
      
      repeat(100)@(posedge clk_sys);
      pkt = read_packet("packets.txt");
      SRC.send(pkt);
      
   end
   
   mt_rmq_rx_path
     DUT (
	  
	  .clk_i   (clk_sys),
	  .rst_n_i (rst_n),

	  .snk_i ( src_out ),
	  .snk_o ( src_in ),

	  .src_i(snk_out),
	  .src_o(snk_in),


	  .p_header_valid_o (),
	  .p_is_udp_o(),
	  .p_is_raw_o(),
	  .p_is_tlv_o(),
	  .p_src_mac_o(),
	  .p_dst_mac_o(),
	  .p_ethertype_o(),
	  .p_src_port_o      (),
	  .p_dst_port_o      (),
	  .p_src_ip_o        (),
	  .p_dst_ip_o        (),
	  .p_udp_length_o(),
	  .p_tlv_type_o(),
	  .p_tlv_size_o()
    );



endmodule // test_rx_path




`ifdef disabled
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

//   always@(posedge clk_sys)
  //   if(ebs_master_out.cyc & ebs_master_out.stb & ebs_master_out.we)
    //   $display("--> EBS-write addr %x data %x", ebs_master_out.adr ,ebs_master_out.dat);

   
/*   always@(posedge clk_sys)
     if(ebm_out.cyc & ebm_out.stb & !ebm_in.stall)
       if(ebm_out.we)
         $display("EBM-write addr %x data %x", ebm_out.adr, ebm_out.dat);
       else if(ebm_in.ack)
         $display("EBM-read addr %x data %x", ebm_out.adr, ebm_in.dat);*/

   
   
   initial begin
      int i;
      
uint32_t test_d[] = '{32'hffffffff,32'hebd0,32'h120000 , 'h10, 'h11, 'h12, 'h13, 'h14, 'h15, 'h16, 'h17, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0 };
      
      uint32_t test_d2[] = '{32'hffffffff,32'hebd0,32'h120000, 'h20, 'h21  };
      


      MQueueCB cpu0;
      CBusAccessor eb_cfg;

      eb_cfg = EbsCfg.get_accessor();
      
      cpu0 = new ( SI.get_accessor(), 0 );
      
      #1us;

      for(i=0;i<1000;)
	begin
	   int full;
	   cpu0.is_full(0, full);
	   if(full) begin
	      $display("temporarily full...");
	      continue;
	      #100ns;
	   end else begin
	      $display("send msg %d", i);
	      cpu0.send(0, test_d);
	      i++;
	   end
	end // for (i=0;i<100;i++)
      
	   
//      #10us;

//      cpu0.send(0, test_d2);
//      cpu0.send(0, '{10,11,12});

      
   end

   

   
endmodule
`endif //  `if 0

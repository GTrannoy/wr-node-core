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
		$display("'h%x,", snk_i.data[15:0]);
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
      src_o.error = 0;
      
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

   
  

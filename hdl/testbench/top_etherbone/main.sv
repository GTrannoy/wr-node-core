import wishbone_pkg::*;
import wr_node_pkg::*;
import wr_fabric_pkg::*;


`include "vhd_wishbone_master.svh"
`include "cpu_csr_driver.svh"
`include "mqueue_host.svh"
`include "stream_utils.svh"



module main;

   reg rst_n = 0;
   reg clk_sys = 0;

   reg clk_ref = 0;

   reg [31:0] tai = 0;
   reg [27:0] cycles = 0;
   
   
   
   always #4.1ns clk_ref <= ~clk_ref;
   
   always #8ns clk_sys <= ~clk_sys;


   always@(posedge clk_ref)
     if(cycles == 100) begin
	cycles <= 0;
	tai <= tai + 1;
     end else
       cycles <= cycles + 1;
   
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   IVHDWishboneMaster Host ( clk_sys, rst_n );

   t_wishbone_master_out host_wb_out;
   t_wishbone_master_in host_wb_in;


   wire t_wrn_timing_if timing;

   assign timing.tai = tai;
   assign timing.cycles = cycles;

   t_mt_stream_sink_out snk_out;
   t_mt_stream_sink_in snk_in;
   t_mt_stream_source_out src_out;
   t_mt_stream_source_in src_in;

   stream_sink SNK
     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .snk_o(snk_out),
      .snk_i(snk_in)
      ); 

   stream_source SRC
     (
      .clk_i(clk_sys),
      .rst_n_i(rst_n),
      .src_o(src_out),
      .src_i(src_in)
      );
  
   wr_node_core DUT (
				    .clk_i   (clk_sys),
				    .rst_n_i (rst_n),

				    .clk_ref_i(clk_ref),
				
				    .host_slave_i (Host.master.out),
				    .host_slave_o (Host.master.in),

				    .rmq_src_i(snk_out),
				    .rmq_src_o(snk_in),
				    .rmq_snk_i(src_out),
				    .rmq_snk_o(src_in),

				    .tm_i(timing)
				    );

 
   
   initial begin
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
   
      uint32_t payload[$]='{
			    'hffff,
			    'hffff,
			    'hffff,
			    'h0000,
			    'h0000,
			    'h0000,
			    'h0800,
			    'h4500,
			    'h002c,
			    'h0000,
			    'h4000,
			    'h3c11,
			    'h83c2,
			    'hffff,
			    'hffff,
			    'hffff,
			    'hffff,
			    'h1234,
			    'hebd1,
			    'h0018,
			    'h0000,
			    'hcafe,
			    'hbabe,
			    'h0000,
			    'h0001,
			    'h0000,
			    'h0002,
			    'h0000,
			    'h0003
			    };
      
      
      
      #10us;

      
      cpu_csr = new ( Host.get_accessor(), 'hc000 );
      hmq = new ( Host.get_accessor(), 0 );

      //eb.write('h30, 0);
      
      cpu_csr.init();

      $display("Load Firmware");
      
      cpu_csr.load_firmware (0, "../../sw/rmq-test/rmq-test.ram");
      cpu_csr.reset_core(0, 0);

      $display("CPU0 started");

      #10us;
      
      SRC.send(payload);
      
      payload[18] = 'hcafe; // change UDP port

      SRC.send(payload);

      payload[26] = 'h0005;
      SRC.send(payload);
      payload[26] = 'h0006;
      SRC.send(payload);
      payload[26] = 'h0007;
      SRC.send(payload);
      payload[26] = 'h0008;
      SRC.send(payload);
      
      forever begin
         cpu_csr.update();
         #1us;
      end
      
         

   end // initial begin
   
         
   
endmodule

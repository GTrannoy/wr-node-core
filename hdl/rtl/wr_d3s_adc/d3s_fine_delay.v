`timescale 1ns/1ps

module d3s_fine_delay
  (
   input 	 clk_i,
   input 	 rst_n_i,

//   input [22:0]  phase_i,
   input [13:0]  phase_divided_i[0:3],
   input 	 phase_valid_i,
   

   output [13:0]  phase_divided_o[0:3],
   output 	 phase_valid_o,

   input [16:0]  r_delay_i, // 8.8 fix pt
   input 	 r_enable_i

   );

   localparam c_size = 256;
   
   
   reg [7:0] rd_ptr, rd_ptr_prev, wr_ptr;
   reg [8:0] count;

   
   wire [14*4-1:0] s0_phases_prev_combined, s0_phases_cur_combined;
   wire [14*4-1:0] phases_in_combined;
   wire [8:0] sf0, sf1;


   wire [13:0] s0_phases_prev [0:3];
   wire [13:0] s0_phases_cur [0:3];
   
   assign sf0 = (256 - r_delay_i[7:0] );
   assign sf1 = (r_delay_i[7:0]);

   always@(posedge clk_i)
      if (!rst_n_i || !r_enable_i)
	begin
	   rd_ptr <= 0;
	   wr_ptr <= 0;
	   count <= 0;
	end else begin
	   if(phase_valid_i)
	     wr_ptr <= wr_ptr + 1;
	   if(count < c_size)
	     count <= count + 1;

	   rd_ptr_prev <= rd_ptr;
	   rd_ptr <= wr_ptr + r_delay_i[15:8];
	end

  generic_dpram  
     #(
       .g_size(c_size),
       .g_width(14 * 4),
       .g_dual_clock(0)
       )U_Ram0 (
	       .rst_n_i(rst_n_i),
	       .clka_i(clk_i),
	       .wea_i(r_enable_i & phase_valid_i),
	       .aa_i(wr_ptr),
	       .da_i(phases_in_combined),

	       .web_i(1'b0),
	       .aa_i(rd_ptr_prev),
	       .qa_o(s0_phases_prev_combined)
	       );
   
  generic_dpram  
     #(
       .g_size(c_size),
       .g_width(14 * 4),
       .g_dual_clock(0)
       )U_Ram1(
	       .rst_n_i(rst_n_i),
	       .clka_i(clk_i),
	       .wea_i(r_enable_i & phase_valid_i),
	       .aa_i(wr_ptr),
	       .da_i(phases_in_combined),

	       .web_i(1'b0),
	       .aa_i(rd_ptr),
	       .qa_o(s0_phases_cur_combined)
	       );
   
   genvar i;

   assign phases_in_combined [ 14*0 +: 14 ] = phase_divided_i[0];
   assign phases_in_combined [ 14*1 +: 14 ] = phase_divided_i[1];
   assign phases_in_combined [ 14*2 +: 14 ] = phase_divided_i[2];
   assign phases_in_combined [ 14*3 +: 14 ] = phase_divided_i[3];
;

   generate

      for(i=0;i<4;i=i+1)
	begin
	   assign s0_phases_dly[i] = s0_phases_prev_combined[ 14*i +: 14];
	   assign s0_phases_dly[3+i] = s0_phases_cur_combined[ 14*i +: 14];
	end
      endgenerate

   reg [13:0] s1_phases[0:6];
//   0-3 1-4 2-5 3-6

   generate
      
      always@(posedge clk_i)
	s1_phases[i] <= (s0_phases_dly[i] * sf0 + s0_phases_dly[i+1] * sf1) >> 8;
      	
   endgenerate


   reg [13:0] s2_pmuxed [0:3];
   
   always@(posedge clk_i)
     case (r_delay_i[9:8])
       2'b00: s2_pmuxed <= s1_phases[0:3];
       2'b01: s2_pmuxed <= s1_phases[1:4];
       2'b10: s2_pmuxed <= s1_phases[2:5];
       2'b11: s2_pmuxed <= s1_phases[3:6];
     endcase // case (r_delay_i[9:8])
   
   assign   phase_divided_o = s2_pmuxed;
   
   
	 
   


endmodule
   
   
   

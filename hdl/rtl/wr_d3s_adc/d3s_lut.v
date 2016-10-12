module d3s_lut (
		
  input 		clk_i,
  input 		rst_n_i,
		
  input [14*4-1:0] 	phase_divided_i,
  input 		phase_valid_i,
  
  output reg [4*14-1:0] dac_data_par_o

  );

   parameter integer g_lut_size_log2  = 10;

   reg [13:0] 	     y0, y1, y2, y3;

   parameter integer g_lut_sample_bits= 18;
   parameter integer g_lut_slope_bits = 18;
   
   reg [g_lut_sample_bits + g_lut_slope_bits-1:0]    lut01[0:2**g_lut_size_log2-1];
   reg [g_lut_sample_bits + g_lut_slope_bits-1:0]    lut23[0:2**g_lut_size_log2-1];

`include "lut_init.v"
   
   initial begin
      `INIT_LUT(01)
      `INIT_LUT(23)
   end

   // todo: phase interpolation & dithering
   
   always@(posedge clk_i)
     y0 <= integer'(1000 * $sin (2*3.14*real'(phase_divided_i[14*0+:14])/real'(1<<14))); // lut01[phase_divided_i[14*0+:14] >> 4][g_lut_sample_bits -1 : 0];
   always@(posedge clk_i)
     y1 <= integer'(1000 * $sin (2*3.14*real'(phase_divided_i[14*1+:14])/real'(1<<14)));//lut01[phase_divided_i[14*1+:14] >> 4][g_lut_sample_bits -1 : 0];
   always@(posedge clk_i)
     y2 <=integer'(1000 * $sin (2*3.14*real'(phase_divided_i[14*2+:14])/real'(1<<14))); //lut23[phase_divided_i[14*2+:14] >> 4][g_lut_sample_bits -1 : 0];
   always@(posedge clk_i)
     y3 <= integer'(1000 * $sin (2*3.14*real'(phase_divided_i[14*3+:14])/real'(1<<14)));//lut23[phase_divided_i[14*3+:14] >> 4][g_lut_sample_bits -1 : 0];


   always@(posedge clk_i)
     dac_data_par_o <= {y3, y2, y1, y0};

endmodule // d3s_lut


   

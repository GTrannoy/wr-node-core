`timescale 1ns/1ps

module d3s_upsample_divide
 (
  input 	clk_i, // clk_wr_ref
  input 	rst_n_i,

  input 	phase_valid_i,
  input [31:0] 	phase_ts_tai_i,
  input [27:0] 	phase_ts_cycles_i,
  input [13:0] 	phase_i,

  input [27:0] 	rec_delay_cycles_i,
  input [13:0] 	rec_delay_bias_i,
  
  
  output [13:0] phase_divided_p0_o,
  output [13:0] phase_divided_p1_o,
  output [13:0] phase_divided_p2_o,
  output [13:0] phase_divided_p3_o,

  input [31:0] 	frev_ts_tai_i,
  input [31:0] 	frev_ts_nsec_i,
  input 	frev_ts_valid_i,

  input 	tm_time_valid_i,
  input [31:0] 	tm_tai_i,
  input [27:0] 	tm_cycles_i
  
  
  );

   reg [31:0] 	t_alias;
   
   reg [13:0] 	interp0;
   reg [13:0] 	interp1;
   reg [13:0] 	interp2;
   reg [13:0] 	interp3;

   reg [13:0] 	phase_d;

   wire [13:0] 	phase_diff;

   assign phase_diff = ( phase_d > phase_i ?  phase_i - phase_d : 16384 + phase_i - phase_d) ;

   always@(posedge clk_i) begin
/* -----\/----- EXCLUDED -----\/-----
      if(phase_d > phase_i)
	$display("G %-10d %-10d %-10d", 16384+phase_d + phase_i, phase_i, phase_d);
      else
	$display("L %-10d %-10d %-10d", phase_i - phase_d,phase_i, phase_d);
 -----/\----- EXCLUDED -----/\----- */
	

      
   end
   
   
   reg [13:0] 	phase_diff_d;
   
   parameter integer c_acc_frac_bits = 8;
   parameter integer c_acc_int_bits = 18;

   reg [c_acc_int_bits + c_acc_frac_bits -1 :0 ] t_alias_acc;
   reg [c_acc_int_bits + c_acc_frac_bits -1 :0 ] dt_alias_acc;

   reg [c_acc_int_bits + c_acc_frac_bits -1 :0 ] t_alias_acc_p0;
   reg [c_acc_int_bits + c_acc_frac_bits -1 :0 ] t_alias_acc_p1;
   reg [c_acc_int_bits + c_acc_frac_bits -1 :0 ] t_alias_acc_p2;
   reg [c_acc_int_bits + c_acc_frac_bits -1 :0 ] t_alias_acc_p3;

   
   always@(posedge clk_i)
     begin
	if (!rst_n_i) begin
	   phase_d <= 0;
	   interp0 <= 0;
	   interp1 <= 0;
	   interp2 <= 0;
	   interp3 <= 0;
	   
	end else begin
	   phase_d <= phase_i;
	   phase_diff_d <= phase_diff;
	   
	   interp0 <= phase_d;
	   interp1 <= phase_d + (phase_diff >> 2);
	   interp2 <= phase_d + (phase_diff >> 1);
	   interp3 <= phase_d + (phase_diff >> 2) + (phase_diff >> 1);
	end
     end


   parameter real f_alias = 250e6;
   parameter real f_dds = 500e6;
   
   always@(posedge clk_i)
     if (!rst_n_i)  begin
	t_alias_acc <= 0;

	dt_alias_acc <= integer'(4.0 * 16384.0 * f_alias / f_dds) << c_acc_frac_bits;

     end else begin
	if(tm_cycles_i == 0)
	  t_alias_acc <= dt_alias_acc;
	else
	  t_alias_acc <= t_alias_acc + dt_alias_acc;
	t_alias_acc_p0 <= t_alias_acc;
	t_alias_acc_p1 <= t_alias_acc + (dt_alias_acc >> 2);
	t_alias_acc_p2 <= t_alias_acc + (dt_alias_acc >> 1);
	t_alias_acc_p3 <= t_alias_acc + (dt_alias_acc >> 1) + (dt_alias_acc >> 2);
     end

   reg [13:0] phase_up0, phase_up1, phase_up2, phase_up3, phase_up3_d;
   reg [3:0] zc;
   
   always@(posedge clk_i)
     begin
	phase_up3_d <= phase_up3;
	phase_up0 <= (t_alias_acc_p0 >> c_acc_frac_bits) - interp0;
	phase_up1 <= (t_alias_acc_p1 >> c_acc_frac_bits) - interp1;
	phase_up2 <= (t_alias_acc_p2 >> c_acc_frac_bits) - interp2;
	phase_up3 <= (t_alias_acc_p3 >> c_acc_frac_bits) - interp3;

	zc[0] <= phase_up3_d > phase_up0;
	zc[1] <= phase_up0 > phase_up1;
	zc[2] <= phase_up1 > phase_up2;
	zc[3] <= phase_up2 > phase_up3;
	
     end

   reg [13:0] div_start_phase;
   reg 	      div_start_phase_valid;

   reg [31:0] frev_ts_adjust_ns_i  = 5000;

   reg [31:0]	      frev_ts_tai;
   reg [31:0] 	      frev_ts_ns;
   reg 		      frev_ts_latched, frev_ts_match;

   wire [31:0] 	      frev_ts_ns_adjusted = frev_ts_nsec_i + frev_ts_adjust_ns_i;
   
   
   always@(posedge clk_i)
     if(!rst_n_i) begin
	frev_ts_latched <= 0;
	frev_ts_match <= 0;
     end else begin
	
	if(!frev_ts_latched)
	  begin
	     frev_ts_match <= 0;
	     
	     if(tm_time_valid_i && frev_ts_valid_i) 
	       begin
		  
		  frev_ts_tai <= (frev_ts_ns_adjusted >= 1000000000 ? frev_ts_tai_i + 1 : frev_ts_tai_i);
		  frev_ts_ns <=  (frev_ts_ns_adjusted >= 1000000000 ? frev_ts_ns_adjusted - 1000000000 : frev_ts_ns_adjusted );
		  frev_ts_latched <= 1;
		  
	       end
	     
	  end else begin // if (!frev_ts_latched)
	 //    $display("%d %d", frev_ts_ns[31:3], tm_cycles_i);
	     
	     if(frev_ts_tai == tm_tai_i && frev_ts_ns[31:3] == tm_cycles_i) begin
		frev_ts_latched <= 0;
		frev_ts_match <= 1;
	     end else begin
	       frev_ts_match <= 0;
	     end
	  end // else: !if(!frev_ts_latched)
     end // else: !if(!rst_n_i)
   
   

   reg [3:0] zc_masked;

   reg 	     match_pending;

   always@*
     if ( match_pending )
       zc_masked <= zc;
   
      else if (frev_ts_match)
       case ( frev_ts_ns[2:0] )
	 0, 1: zc_masked <=  zc & 'h7;
	 2, 3: zc_masked <=  zc & 'h3;
	 4, 5: zc_masked <=  zc & 'h1;
	 default: zc_masked <=  0;
       endcase // case ( frev_ts_ns[2:0] )
   
      else
	zc_masked <= 0;
   
   
   
   always@(posedge clk_i) begin
      if (!rst_n_i) begin
	 div_start_phase_valid <= 0;
      end else begin

	 if( frev_ts_match && !zc_masked)
	   match_pending <= 1;
	 
	 
	 else if(zc_masked)
	   begin
	      if(zc_masked[0])
		div_start_phase <= phase_up0;
	      else if (zc_masked[1]) div_start_phase <= phase_up1;
	      else if (zc_masked[2])  div_start_phase <= phase_up2;
	      else if (zc_masked[3]) div_start_phase <= phase_up3;
	      match_pending <= 0;
	      div_start_phase_valid <= 1;
	   end
	 
	 
	 if(frev_ts_match)
	   begin
		 
		 
		$display("GotFrevTs zcd %x ns %x!", zc, frev_ts_ns[2:0]);
	   end
	 
	 

      end
      
      
   end
   
   
   
   
// synthesis translate_off
   
   reg clk_dds = 0;
   integer phase_sel = 0;
   integer ph_int;
   real    y_test;
   
   always #1 clk_dds <= ~clk_dds;

   always@(posedge clk_i)
     phase_sel <= 0;
   
   
   always@(posedge clk_dds) begin
      phase_sel <= (phase_sel == 3 ? 0 : phase_sel + 1);
      case(phase_sel)
	0: ph_int = phase_up0;
	1: ph_int = phase_up1;
	2: ph_int = phase_up2;
	3: ph_int = phase_up3;
      endcase // case (phase_sel)

      y_test = $sin(2*3.1415926535 * real'(ph_int) / 16384.0);
      
      
	
   end
   
// synthesis translate_on

   

   function f_fast_div_by_5( input [13:0] x );
      reg [31:0] x_mul;      
      begin
	 x_mul = x * 3277;
	 f_fast_div_by_5 = (x_mul >> 14);
      end
   endfunction // f_fast_div_by_5
   
   

   reg[13:0] phase_divided0;
   reg[13:0] phase_divided1;
   reg[13:0] phase_divided2;
   reg[13:0] phase_divided3;

   reg[13:0] div_bias;
   
   

endmodule // d3s_upsample_divide


  

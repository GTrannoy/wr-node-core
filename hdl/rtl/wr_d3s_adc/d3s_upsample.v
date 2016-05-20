`timescale 1ps/1ps

module monitor_phase
  (
   input 	clk_i,
   input [13:0] ph0_i,
   input [13:0] ph1_i,
   input [13:0] ph2_i,
   input [13:0] ph3_i
   );

   parameter g_delay = 0;
   parameter g_oversample = 80;
   parameter g_step = 100;


   
   
   function integer f_interp(input integer k, input integer n, input integer y0, input integer y1);
      reg[13:0] y;
      
      begin
	 if(y1 < y0)
	   y = y0 + k*((y1+16384)-y0)/n;
	 else
	   y = y0 + k*(y1-y0)/n;
//	 $display("%d %d %d %d -> %d", k,n,y0,y1,y);
	 
	 f_interp = y;
	 
	 
	 
      end
      
   endfunction // f_interp
   

   reg [13:0] ph3_d;
   
   always@(posedge clk_i)
     ph3_d <= ph3_i;
	   
   
   reg [13:0 ] ph_recon_undiv;

   wire [13:0] ph_tab[0:4];

   assign ph_tab[0] = ph3_d;
   assign ph_tab[1] = ph0_i;
   assign ph_tab[2] = ph1_i;
   assign ph_tab[3] = ph2_i;
   assign ph_tab[4] = ph3_i;
   

   reg [13:0]  ph_over;
   
   
   initial forever begin : reconstruct_undiv
      integer i,p;

      
      @(posedge clk_i);

      for( p = 0; p < 4; p=p+1)
      begin
	for( i = 0; i < g_oversample/4; i=i+1)
	  begin
	     #(g_step/2);
//	     if(p==3)
//	       ph_over <= 'hx;
//	     else
	       ph_over <= f_interp(i, g_oversample/4  , ph_tab[p], ph_tab[p+1] );
	     #(g_step/2);
	  end
      end
      
   end
   

   reg [13:0] ph_out;

   always@(ph_over)
     ph_out <= #(g_delay) ph_over;
   

endmodule // monitor_phase

   

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
   wire [3:0] zc;
   
   always@(posedge clk_i)
     begin
	phase_up3_d <= phase_up3;
	phase_up0 <= (t_alias_acc_p0 >> c_acc_frac_bits) - interp0;
	phase_up1 <= (t_alias_acc_p1 >> c_acc_frac_bits) - interp1;
	phase_up2 <= (t_alias_acc_p2 >> c_acc_frac_bits) - interp2;
	phase_up3 <= (t_alias_acc_p3 >> c_acc_frac_bits) - interp3;

	
     end

   assign zc[0] = phase_up3_d > phase_up0;
   assign zc[1] = phase_up0 > phase_up1;
   assign zc[2] = phase_up1 > phase_up2;
   assign zc[3] = phase_up2 > phase_up3;

   
   reg [3:0] div_start_phase_sel;
   reg 	     div_start_phase_sel_valid;

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
	 div_start_phase_sel_valid <= 0;
	 match_pending <= 0;
      end else begin

	 div_start_phase_sel_valid <= 0;
	 
	 
	 if( frev_ts_match && !zc_masked)
	   match_pending <= 1;
	 
	 
	 else if(zc_masked)
	   begin
	      if(zc_masked[0])
		div_start_phase_sel <= 'b1111;
	      else if (zc_masked[1]) 
		div_start_phase_sel <= 'b1110;
	      else if (zc_masked[2])
		div_start_phase_sel <= 'b1100;
	      else 
		div_start_phase_sel <= 'b1000;
	      
	      match_pending <= 0;
	      div_start_phase_sel_valid <= 1;
	   end
	 
	 
	 if(frev_ts_match)
	   begin
	      
	      
	      $display("GotFrevTs zcd %x ns %x!", zc, frev_ts_ns[2:0]);
	   end
	 
	 

      end
      
      
   end
   
   
   
   
// synthesis translate_off
   

   monitor_phase #(.g_delay(8000)) MonUndiv( clk_i, phase_up0, phase_up1, phase_up2, phase_up3 );
   
   
   

// synthesis translate_on

   

   function integer f_fast_div_by_5( input [13:0] x );
      reg [31:0] x_mul;      
      begin
	 x_mul = x * 3277;
	 f_fast_div_by_5 = x/5;//(x_mul >> 14);
      end
   endfunction // f_fast_div_by_5
   
   

   reg[13:0] phase_divided0;
   reg[13:0] phase_divided1;
   reg[13:0] phase_divided2;
   reg[13:0] phase_divided3;

   reg[13:0] div_bias = 0;


   function integer f_count_ones(input [31:0] x, input integer n);
      integer c,i;
      begin
	 c = 0;
	 for(i=0;i<n;i=i+1)
	   if(x[i])
	     c=c+1;
	 f_count_ones = c;
      end
   endfunction // f_count_ones
   
	 
      
   
   always@(posedge clk_i)
     begin
	

	if(div_start_phase_sel_valid)
	  begin
	     phase_divided0 <= f_fast_div_by_5(phase_up0) + (f_count_ones(zc, 1) * div_start_phase_sel[0]) * (16384/5) ;
	     phase_divided1 <= f_fast_div_by_5(phase_up1) + (f_count_ones(zc, 2) * div_start_phase_sel[1]) * (16384/5) ;
	     phase_divided2 <= f_fast_div_by_5(phase_up2) + (f_count_ones(zc, 3) * div_start_phase_sel[2]) * (16384/5) ;
	     phase_divided3 <= f_fast_div_by_5(phase_up3) + (f_count_ones(zc, 4) * div_start_phase_sel[3]) * (16384/5) ;

	     div_bias <= f_count_ones(zc & div_start_phase_sel,4);
	     

	  end else begin

	     phase_divided0 <= f_fast_div_by_5(phase_up0) + (f_count_ones(zc, 1) + div_bias) * (16384/5) ;
	     phase_divided1 <= f_fast_div_by_5(phase_up1) + (f_count_ones(zc, 2) + div_bias) * (16384/5) ;
	     phase_divided2 <= f_fast_div_by_5(phase_up2) + (f_count_ones(zc, 3) + div_bias) * (16384/5) ;
	     phase_divided3 <= f_fast_div_by_5(phase_up3) + (f_count_ones(zc, 4) + div_bias) * (16384/5) ;

	     
	     if(div_bias + f_count_ones(zc,4) >= 5)
	       div_bias <= div_bias + f_count_ones(zc,4) - 5;
	     else
	       div_bias <= div_bias + f_count_ones(zc,4);

	  end
	

	  
	
     end

   monitor_phase #(.g_delay(0)) MonDiv( clk_i, phase_divided0, phase_divided1, phase_divided2, phase_divided3 );
   
   

endmodule // d3s_upsample_divide


  

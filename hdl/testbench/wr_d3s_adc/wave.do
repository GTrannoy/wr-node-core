onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/clk_i
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/rst_n_i
add wave -noupdate -group PhaseEncoder -format Analog-Step -height 84 -max 2000.0 -min -1999.0 /main/DUT/U_Phase_Enc/adc_data_i
add wave -noupdate -group PhaseEncoder -format Analog-Step -height 84 -max 8123.9999999999991 -min -8124.0 /main/DUT/U_Phase_Enc/raw_phase_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/raw_hp_data_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/r_max_run_len_i
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/r_max_error_i
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/r_min_error_i
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/r_record_count_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/fifo_en_i
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/fifo_full_i
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/fifo_lost_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/fifo_rl_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/fifo_phase_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/fifo_tstamp_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/fifo_is_rl_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/fifo_we_o
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/tm_cycles_i
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/adc_i
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/adc_i_pre
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/adc_q
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/adc_q_pre
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/adc_phase
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/dummy
add wave -noupdate -group PhaseEncoder -format Analog-Step -height 84 -max 16384.0 -min 1519.0 /main/DUT/U_Phase_Enc/adc_dphase
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/adc_phase_d0
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/flag
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/avg_lt
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/avg_lt_valid
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/avg_st_predelay
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/avg_st
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/avg_st_valid
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/avg_lt_trunc
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/avg_st_trunc
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/rl_phase
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/rl_integ
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/rl_phase_ext
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/rl_length
add wave -noupdate -group PhaseEncoder -height 16 /main/DUT/U_Phase_Enc/rl_state
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/err_st
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/err_lt
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/err_lt_bound
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/err_st_bound
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/adc_hp_out
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/adc_data_reg
add wave -noupdate -format Analog-Step -height 50 -max 1.0 -min -1.0 /main/sine_in
add wave -noupdate -format Analog-Step -max 1.0 -min -1.0 /main/y_under
add wave -noupdate /main/DUT/fake_data_i
add wave -noupdate /main/frev_in
add wave -noupdate -expand -group Upsampler /main/DUT2/clk_i
add wave -noupdate -expand -group Upsampler /main/DUT2/rst_n_i
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 8129.0000000000009 -min -8124.0 /main/DUT2/phase_i
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 8129.0000000000009 -min -8124.0 /main/DUT2/phase_d
add wave -noupdate -expand -group Upsampler /main/DUT2/phase_divided_p0_o
add wave -noupdate -expand -group Upsampler /main/DUT2/phase_divided_p1_o
add wave -noupdate -expand -group Upsampler /main/DUT2/phase_divided_p2_o
add wave -noupdate -expand -group Upsampler /main/DUT2/phase_divided_p3_o
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_tai_i
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_nsec_i
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_valid_i
add wave -noupdate -expand -group Upsampler /main/DUT2/tm_time_valid_i
add wave -noupdate -expand -group Upsampler /main/DUT2/tm_tai_i
add wave -noupdate -expand -group Upsampler /main/DUT2/tm_cycles_i
add wave -noupdate -expand -group Upsampler /main/DUT2/t_alias
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16253.000000000002 -radix unsigned /main/DUT2/interp0
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16286.0 -radix unsigned /main/DUT2/interp1
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16382.0 -radix unsigned /main/DUT2/interp2
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16347.0 -radix unsigned /main/DUT2/interp3
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 8273.0 -min -9488.0 /main/DUT2/phase_diff
add wave -noupdate -expand -group Upsampler /main/DUT2/t_alias_acc
add wave -noupdate -expand -group Upsampler /main/DUT2/dt_alias_acc
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16320.999999999998 -radix unsigned /main/DUT2/phase_up0
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16363.0 -min 49.0 -radix unsigned /main/DUT2/phase_up1
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16350.0 -min 29.0 -radix unsigned /main/DUT2/phase_up2
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16381.0 -min 1.0 -radix unsigned /main/DUT2/phase_up3
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 84 -max 16367.0 /main/DUT2/ph_int
add wave -noupdate -expand -group Upsampler /main/DUT2/phase_sel
add wave -noupdate -expand -group Upsampler -format Analog-Step -max 1.0 -min -1.0 /main/DUT2/y_test
add wave -noupdate -expand -group Upsampler /main/DUT2/zc
add wave -noupdate -expand -group Upsampler /main/DUT2/zc_masked
add wave -noupdate -expand -group Upsampler /main/DUT2/match_pending
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_adjust_ns_i
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_tai
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_ns
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_latched
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_match
add wave -noupdate -expand -group Upsampler /main/DUT2/frev_ts_ns_adjusted
add wave -noupdate -expand -group Upsampler /main/DUT2/div_start_phase
add wave -noupdate -expand -group Upsampler /main/DUT2/div_start_phase_valid
add wave -noupdate -expand -group Upsampler /main/DUT2/t_alias_acc_p0
add wave -noupdate -expand -group Upsampler /main/DUT2/t_alias_acc_p1
add wave -noupdate -expand -group Upsampler /main/DUT2/t_alias_acc_p2
add wave -noupdate -expand -group Upsampler /main/DUT2/t_alias_acc_p3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6479243 ps} 0}
configure wave -namecolwidth 406
configure wave -valuecolwidth 156
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {4367279 ps} {8614543 ps}

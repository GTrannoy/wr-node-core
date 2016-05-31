onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main/clk_rf
add wave -noupdate /main/a_rf
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
add wave -noupdate -group Slave /main/DUT_S/clk_sys_i
add wave -noupdate -group Slave /main/DUT_S/rst_n_sys_i
add wave -noupdate -group Slave /main/DUT_S/clk_125m_pllref_i
add wave -noupdate -group Slave /main/DUT_S/clk_wr_o
add wave -noupdate -group Slave /main/DUT_S/tm_tai_i
add wave -noupdate -group Slave /main/DUT_S/tm_cycles_i
add wave -noupdate -group Slave /main/DUT_S/tm_time_valid_i
add wave -noupdate -group Slave /main/DUT_S/tm_clk_aux_lock_en_o
add wave -noupdate -group Slave /main/DUT_S/tm_clk_aux_locked_i
add wave -noupdate -group Slave /main/DUT_S/wr_ref_clk_n_i
add wave -noupdate -group Slave /main/DUT_S/wr_ref_clk_p_i
add wave -noupdate -group Slave /main/DUT_S/slave_i
add wave -noupdate -group Slave /main/DUT_S/slave_o
add wave -noupdate -group Slave /main/DUT_S/dac_n_o
add wave -noupdate -group Slave /main/DUT_S/dac_p_o
add wave -noupdate -group Slave /main/DUT_S/debug_o
add wave -noupdate -group Slave /main/DUT_S/clk_wr_ref
add wave -noupdate -group Slave /main/DUT_S/clk_wr_ref_pllin
add wave -noupdate -group Slave /main/DUT_S/pllout_clk_fb_pllref
add wave -noupdate -group Slave /main/DUT_S/pllout_clk_wr_ref
add wave -noupdate -group Slave /main/DUT_S/clk_dds_phy
add wave -noupdate -group Slave /main/DUT_S/rst_n_wr
add wave -noupdate -group Slave /main/DUT_S/regs_in
add wave -noupdate -group Slave /main/DUT_S/regs_out
add wave -noupdate -group Slave /main/DUT_S/cnx_out
add wave -noupdate -group Slave /main/DUT_S/cnx_in
add wave -noupdate -group Slave /main/DUT_S/locked_out
add wave -noupdate -group Slave /main/DUT_S/clk_wr
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/clk_wr_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/rst_n_wr_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/r_enable_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/r_delay_coarse_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/tm_time_valid_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/tm_tai_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/tm_cycles_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/fifo_phase_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/fifo_rl_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/fifo_is_rl_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/fifo_tstamp_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/fifo_empty_i
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/fifo_rd_o
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/phase_o
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/phase_valid_o
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/phase_integ
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/dphase
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/rl_count
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/cyc_adjusted
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s2_valid_comb
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s2_valid
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s2_phase
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s2_is_rl
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s2_tstamp
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s2_rl
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s3_ts_match
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s3_valid
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s3_phase
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s3_dphase
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s3_count
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s3_state
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s1_phase
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s1_is_rl
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s1_valid
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s1_tstamp
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/s1_rl
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/fifo_rd
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/fifo_rd_d
add wave -noupdate -expand -group Phasedec /main/DUT_S/U_Phase_Dec/stall
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {97959634 ps} 0}
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
WaveRestoreZoom {0 ps} {204996608 ps}

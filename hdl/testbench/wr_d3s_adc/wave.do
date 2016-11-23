onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Input signals} /main/clk_rf
add wave -noupdate -expand -group {Input signals} -format Analog-Step -height 50 -max 1.0 -min -1.0 /main/sine_in
add wave -noupdate -expand -group {Input signals} -format Analog-Step -max 1.0 -min -1.0 /main/y_under
add wave -noupdate -expand -group {Input signals} /main/frev_in
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/clk_wr_i
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/rst_n_wr_i
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/r_enable_i
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ififo_payload_i
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ififo_empty_i
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ififo_rd_o
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ofifo_empty_o
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ofifo_rd_i
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ofifo_is_rl_o
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ofifo_rl_o
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ofifo_phase_o
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ofifo_tstamp_o
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/q_in_packed
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/q_out_packed
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/q_wr
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/q_almost_full
add wave -noupdate -expand -group PhaseDecoder -group Predecoder -expand /main/DUT_S/U_Phase_Dec/U_Predecode/q_in
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/q_out
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ififo_rd_d
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ififo_rd
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/got_ts
add wave -noupdate -expand -group PhaseDecoder -group Predecoder /main/DUT_S/U_Phase_Dec/U_Predecode/ts
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/clk_wr_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/rst_n_wr_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/r_enable_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/r_delay_coarse_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/tm_time_valid_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/tm_tai_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/tm_cycles_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/fifo_payload_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/fifo_empty_i
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/fifo_rd_o
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/phase_o
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/phase_valid_o
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/s3_ts_match
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/s3_ts_miss
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/s3_valid
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/s3_phase
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/s3_dphase
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/s3_count
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/s3_state
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/fifo_rd_d
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/stall
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/got_fixup
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/tm_cycles_adj0
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/tm_cycles_adj1
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/ofifo_phase
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/ofifo_rl
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/ofifo_is_rl
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/ofifo_tstamp
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/ofifo_empty
add wave -noupdate -expand -group PhaseDecoder /main/DUT_S/U_Phase_Dec/ofifo_rd
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/clk_i
add wave -noupdate -expand -group Upsampler -expand -group {Interpolated phase (200 MHz)} -format Analog-Step -height 100 -max 360.0 /main/DUT_S/U_Upsampler/MonUndiv/ph_o
add wave -noupdate -expand -group Upsampler -expand -group {Interpolated phase (undersampled)} -format Analog-Step -height 100 -max 360.0 /main/DUT_S/U_Upsampler/MonInterp/ph_o
add wave -noupdate -expand -group Upsampler -expand -group {Interpolated phase (40 MHz)} -format Analog-Step -height 100 -max 360.0 /main/DUT_S/U_Upsampler/MonDiv/ph_o
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/rst_n_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_valid_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_divided_o
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_divided_valid_o
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_tai_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_nsec_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_valid_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/tm_time_valid_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/tm_tai_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/tm_cycles_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/t_alias
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/interp0
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/interp1
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/interp2
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/interp3
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_d
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_diff
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_diff_d
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/t_alias_acc
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/dt_alias_acc
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/t_alias_acc_p0
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/t_alias_acc_p1
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/t_alias_acc_p2
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/t_alias_acc_p3
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up0
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up1
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up2
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up3
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up3_d
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/zc
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/div_start_phase_sel
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/div_start_phase_sel_valid
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/div_start_phase_sel_d
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/div_start_phase_sel_valid_d
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_adjust_ns_i
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_tai
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_ns
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_latched
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_match
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_ns_adjusted
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/zc_masked
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/match_pending
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/zc_masked_d
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/zc_d
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/zc_d2
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/frev_ts_match_d
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up0_s
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up1_s
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up2_s
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up3_s
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_divided0
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_divided1
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_divided2
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_divided3
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/div_bias
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 50 -max 16384.0 /main/DUT_S/U_Upsampler/phase_up0_div5
add wave -noupdate -expand -group Upsampler -format Analog-Step -height 50 -max 16384.0 /main/DUT_S/U_Upsampler/phase_up1_div5
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up2_div5
add wave -noupdate -expand -group Upsampler /main/DUT_S/U_Upsampler/phase_up3_div5
add wave -noupdate -group SlaveTop /main/DUT_S/rst_n_sys_i
add wave -noupdate -group SlaveTop /main/DUT_S/clk_sys_i
add wave -noupdate -group SlaveTop /main/DUT_S/clk_wr_o
add wave -noupdate -group SlaveTop /main/DUT_S/tm_link_up_i
add wave -noupdate -group SlaveTop /main/DUT_S/tm_time_valid_i
add wave -noupdate -group SlaveTop /main/DUT_S/tm_tai_i
add wave -noupdate -group SlaveTop /main/DUT_S/tm_cycles_i
add wave -noupdate -group SlaveTop /main/DUT_S/tm_clk_aux_lock_en_o
add wave -noupdate -group SlaveTop /main/DUT_S/tm_clk_aux_locked_i
add wave -noupdate -group SlaveTop /main/DUT_S/tm_dac_value_i
add wave -noupdate -group SlaveTop /main/DUT_S/tm_dac_wr_i
add wave -noupdate -group SlaveTop /main/DUT_S/wr_ref_clk_n_i
add wave -noupdate -group SlaveTop /main/DUT_S/wr_ref_clk_p_i
add wave -noupdate -group SlaveTop /main/DUT_S/pll_sys_cs_n_o
add wave -noupdate -group SlaveTop /main/DUT_S/pll_sys_ld_i
add wave -noupdate -group SlaveTop /main/DUT_S/pll_sys_reset_n_o
add wave -noupdate -group SlaveTop /main/DUT_S/pll_sys_sync_n_o
add wave -noupdate -group SlaveTop /main/DUT_S/pll_vcxo_cs_n_o
add wave -noupdate -group SlaveTop /main/DUT_S/pll_vcxo_sync_n_o
add wave -noupdate -group SlaveTop /main/DUT_S/pll_vcxo_status_i
add wave -noupdate -group SlaveTop /main/DUT_S/pll_sclk_o
add wave -noupdate -group SlaveTop /main/DUT_S/pll_sdio_b
add wave -noupdate -group SlaveTop /main/DUT_S/pll_sdo_i
add wave -noupdate -group SlaveTop /main/DUT_S/dac_n_o
add wave -noupdate -group SlaveTop /main/DUT_S/dac_p_o
add wave -noupdate -group SlaveTop /main/DUT_S/wr_dac_sclk_o
add wave -noupdate -group SlaveTop /main/DUT_S/wr_dac_din_o
add wave -noupdate -group SlaveTop /main/DUT_S/wr_dac_sync_n_o
add wave -noupdate -group SlaveTop -expand /main/DUT_S/slave_i
add wave -noupdate -group SlaveTop -expand /main/DUT_S/slave_o
add wave -noupdate -group SlaveTop /main/DUT_S/debug_o
add wave -noupdate -group SlaveTop /main/DUT_S/clk_wr_ref
add wave -noupdate -group SlaveTop /main/DUT_S/clk_wr_ref_pllin
add wave -noupdate -group SlaveTop /main/DUT_S/pllout_clk_fb_pllref
add wave -noupdate -group SlaveTop /main/DUT_S/pllout_clk_wr_ref
add wave -noupdate -group SlaveTop /main/DUT_S/clk_dds_phy
add wave -noupdate -group SlaveTop /main/DUT_S/regs_in
add wave -noupdate -group SlaveTop /main/DUT_S/regs_out
add wave -noupdate -group SlaveTop /main/DUT_S/clk_wr
add wave -noupdate -group SlaveTop /main/DUT_S/rst_n_wr
add wave -noupdate -group SlaveTop /main/DUT_S/rst_wr
add wave -noupdate -group SlaveTop /main/DUT_S/fpll_reset
add wave -noupdate -group SlaveTop /main/DUT_S/clk_dds_locked
add wave -noupdate -group SlaveTop /main/DUT_S/phase_divided
add wave -noupdate -group SlaveTop /main/DUT_S/phase_divided_valid
add wave -noupdate -group SlaveTop /main/DUT_S/phase_dec
add wave -noupdate -group SlaveTop /main/DUT_S/phase_dec_valid
add wave -noupdate -group SlaveTop /main/DUT_S/dac_data_par
add wave -noupdate -group SlaveTop /main/DUT_S/pll_sdio_val
add wave -noupdate -group Slave /main/DUT_S/rst_n_sys_i
add wave -noupdate -group Slave /main/DUT_S/clk_sys_i
add wave -noupdate -group Slave /main/DUT_S/clk_wr_o
add wave -noupdate -group Slave /main/DUT_S/tm_link_up_i
add wave -noupdate -group Slave /main/DUT_S/tm_time_valid_i
add wave -noupdate -group Slave /main/DUT_S/tm_tai_i
add wave -noupdate -group Slave /main/DUT_S/tm_cycles_i
add wave -noupdate -group Slave /main/DUT_S/tm_clk_aux_lock_en_o
add wave -noupdate -group Slave /main/DUT_S/tm_clk_aux_locked_i
add wave -noupdate -group Slave /main/DUT_S/tm_dac_value_i
add wave -noupdate -group Slave /main/DUT_S/tm_dac_wr_i
add wave -noupdate -group Slave /main/DUT_S/wr_ref_clk_n_i
add wave -noupdate -group Slave /main/DUT_S/wr_ref_clk_p_i
add wave -noupdate -group Slave /main/DUT_S/pll_sys_cs_n_o
add wave -noupdate -group Slave /main/DUT_S/pll_sys_ld_i
add wave -noupdate -group Slave /main/DUT_S/pll_sys_reset_n_o
add wave -noupdate -group Slave /main/DUT_S/pll_sys_sync_n_o
add wave -noupdate -group Slave /main/DUT_S/pll_vcxo_cs_n_o
add wave -noupdate -group Slave /main/DUT_S/pll_vcxo_sync_n_o
add wave -noupdate -group Slave /main/DUT_S/pll_vcxo_status_i
add wave -noupdate -group Slave /main/DUT_S/pll_sclk_o
add wave -noupdate -group Slave /main/DUT_S/pll_sdio_b
add wave -noupdate -group Slave /main/DUT_S/pll_sdo_i
add wave -noupdate -group Slave /main/DUT_S/dac_n_o
add wave -noupdate -group Slave /main/DUT_S/dac_p_o
add wave -noupdate -group Slave /main/DUT_S/wr_dac_sclk_o
add wave -noupdate -group Slave /main/DUT_S/wr_dac_din_o
add wave -noupdate -group Slave /main/DUT_S/wr_dac_sync_n_o
add wave -noupdate -group Slave /main/DUT_S/slave_i
add wave -noupdate -group Slave /main/DUT_S/slave_o
add wave -noupdate -group Slave /main/DUT_S/debug_o
add wave -noupdate -group Slave /main/DUT_S/clk_wr_ref
add wave -noupdate -group Slave /main/DUT_S/clk_wr_ref_pllin
add wave -noupdate -group Slave /main/DUT_S/pllout_clk_fb_pllref
add wave -noupdate -group Slave /main/DUT_S/pllout_clk_wr_ref
add wave -noupdate -group Slave /main/DUT_S/clk_dds_phy
add wave -noupdate -group Slave /main/DUT_S/regs_in
add wave -noupdate -group Slave /main/DUT_S/regs_out
add wave -noupdate -group Slave /main/DUT_S/clk_wr
add wave -noupdate -group Slave /main/DUT_S/rst_n_wr
add wave -noupdate -group Slave /main/DUT_S/rst_wr
add wave -noupdate -group Slave /main/DUT_S/fpll_reset
add wave -noupdate -group Slave /main/DUT_S/clk_dds_locked
add wave -noupdate -group Slave /main/DUT_S/phase_divided
add wave -noupdate -group Slave /main/DUT_S/phase_divided_valid
add wave -noupdate -group Slave /main/DUT_S/phase_dec
add wave -noupdate -group Slave /main/DUT_S/phase_dec_valid
add wave -noupdate -group Slave /main/DUT_S/dac_data_par
add wave -noupdate -group Slave /main/DUT_S/pll_sdio_val
add wave -noupdate -group LUT /main/DUT_S/U_LUT/clk_i
add wave -noupdate -group LUT /main/DUT_S/U_LUT/rst_n_i
add wave -noupdate -group LUT /main/DUT_S/U_LUT/phase_divided_i
add wave -noupdate -group LUT /main/DUT_S/U_LUT/phase_valid_i
add wave -noupdate -group LUT /main/DUT_S/U_LUT/dac_data_par_o
add wave -noupdate -group LUT /main/DUT_S/U_LUT/y0
add wave -noupdate -group LUT /main/DUT_S/U_LUT/y1
add wave -noupdate -group LUT /main/DUT_S/U_LUT/y2
add wave -noupdate -group LUT /main/DUT_S/U_LUT/y3
add wave -noupdate -group LUT -expand /main/DUT_S/U_LUT/st
add wave -noupdate -group LUT /main/DUT_S/U_LUT/phases_raw
add wave -noupdate -group LUT /main/DUT_S/U_LUT/phases
add wave -noupdate -group LUT /main/DUT_S/U_LUT/signs
add wave -noupdate -group DACModel /main/U_DAC/clk_i
add wave -noupdate -group DACModel -format Analog-Step -height 84 -max 8175.0 -min -8191.0 -radix decimal /main/U_DAC/data_i
add wave -noupdate -group DACModel /main/U_DAC/data_o
add wave -noupdate -group DACModel /main/U_DAC/y_over
add wave -noupdate -group DACModel /main/U_DAC/y_d
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/clk_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/rst_n_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_data_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/raw_phase_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/raw_hp_data_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/r_max_run_len_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/r_max_error_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/r_min_error_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/r_record_count_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/fifo_en_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/fifo_full_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/fifo_lost_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/fifo_payload_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/fifo_we_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/tm_cycles_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/cnt_fixed_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/cnt_rl_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/cnt_ts_o
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_i
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_i_pre
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_q
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_q_pre
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_phase
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/dummy
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_dphase
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_dphase_d0
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_ddphase
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_ddphase_abs
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_phase_d0
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/flag
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/avg_lt_predelay
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/avg_st_predelay
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/avg_lt_out
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/avg_st_out
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/avg_st
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/avg_lt
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/avg_st_d
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/avg_lt_d
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/rl_phase
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/transient_detect_phase
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/transient_theshold_hit
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/transient_found
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/transient_count
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_bound_st_lo
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_bound_st_hi
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_bound_lt_lo
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_bound_lt_hi
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/rl_integ
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/rl_integ_next
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/rl_phase_ext
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/transient_integ
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/rl_length
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/rl_state
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/rl_cycles_start
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_st
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_lt
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_lt_bound
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_st_bound
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_hp_out
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/adc_data_reg
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/c1
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/c2
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/c1_d
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/c2_d
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/c_out
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/c2_pending
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/ts_report_cnt
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_st_lo
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_st_hi
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_lt_lo
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/err_lt_hi
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/cnt_fix
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/cnt_rl
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/cnt_ts
add wave -noupdate -expand -group PhaseEncoder /main/DUT_M/U_Phase_Enc/ddphase_threshold_hit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {127111050 ps} 0}
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
WaveRestoreZoom {127046730 ps} {127175370 ps}

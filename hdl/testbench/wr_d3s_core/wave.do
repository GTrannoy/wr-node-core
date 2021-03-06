onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DAC /main/DAC/clk_i
add wave -noupdate -expand -group DAC -format Analog-Step -height 84 -max 16128.0 -radix unsigned /main/DAC/data_i
add wave -noupdate -expand -group DAC /main/DAC/dds_clk_o
add wave -noupdate -expand -group DAC2 -format Analog-Step -height 84 -max 16128.0 -radix unsigned /main/DAC2/data_i
add wave -noupdate -expand -group DAC2 -radix unsigned /main/DAC2/dds_clk_o
add wave -noupdate -expand -group Sample1 /main/DUT1/sample_p
add wave -noupdate -expand -group Sample1 /main/DUT1/sampling_div
add wave -noupdate -expand -group Sample2 /main/DUT2/sample_p
add wave -noupdate -expand -group Sample2 /main/DUT2/sampling_div
add wave -noupdate /main/DUT2/synth_acc_load
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/clk_i
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/rst_n_i
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/acc_load_i
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/tune_load_i
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/acc_i
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/acc_o
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/tune_i
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/dreq_i
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/y0_o
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/y1_o
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/y2_o
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/y3_o
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/lut_addr
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/acc
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/acc_d0
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/tune
add wave -noupdate /main/DUT2/U_DDS_Synthesizer/y
add wave -noupdate -group DDSCore1 /main/DUT1/clk_sys_i
add wave -noupdate -group DDSCore1 /main/DUT1/rst_n_i
add wave -noupdate -group DDSCore1 /main/DUT1/clk_ref_i
add wave -noupdate -group DDSCore1 /main/DUT1/clk_wr_o
add wave -noupdate -group DDSCore1 /main/DUT1/tm_link_up_i
add wave -noupdate -group DDSCore1 /main/DUT1/tm_time_valid_i
add wave -noupdate -group DDSCore1 /main/DUT1/tm_tai_i
add wave -noupdate -group DDSCore1 /main/DUT1/tm_cycles_i
add wave -noupdate -group DDSCore1 /main/DUT1/tm_clk_aux_lock_en_o
add wave -noupdate -group DDSCore1 /main/DUT1/tm_clk_aux_locked_i
add wave -noupdate -group DDSCore1 /main/DUT1/tm_dac_value_i
add wave -noupdate -group DDSCore1 /main/DUT1/tm_dac_wr_i
add wave -noupdate -group DDSCore1 /main/DUT1/dac_n_o
add wave -noupdate -group DDSCore1 /main/DUT1/dac_p_o
add wave -noupdate -group DDSCore1 /main/DUT1/wr_ref_clk_n_i
add wave -noupdate -group DDSCore1 /main/DUT1/wr_ref_clk_p_i
add wave -noupdate -group DDSCore1 /main/DUT1/synth_clk_n_i
add wave -noupdate -group DDSCore1 /main/DUT1/synth_clk_p_i
add wave -noupdate -group DDSCore1 /main/DUT1/rf_clk_n_i
add wave -noupdate -group DDSCore1 /main/DUT1/rf_clk_p_i
add wave -noupdate -group DDSCore1 /main/DUT1/pll_sys_cs_n_o
add wave -noupdate -group DDSCore1 /main/DUT1/pll_sys_ld_i
add wave -noupdate -group DDSCore1 /main/DUT1/pll_sys_reset_n_o
add wave -noupdate -group DDSCore1 /main/DUT1/pll_sys_sync_n_o
add wave -noupdate -group DDSCore1 /main/DUT1/pll_vcxo_cs_n_o
add wave -noupdate -group DDSCore1 /main/DUT1/pll_vcxo_sync_n_o
add wave -noupdate -group DDSCore1 /main/DUT1/pll_vcxo_status_i
add wave -noupdate -group DDSCore1 /main/DUT1/pll_sclk_o
add wave -noupdate -group DDSCore1 /main/DUT1/pll_sdio_b
add wave -noupdate -group DDSCore1 /main/DUT1/pll_sdo_i
add wave -noupdate -group DDSCore1 /main/DUT1/pd_lockdet_i
add wave -noupdate -group DDSCore1 /main/DUT1/pd_clk_o
add wave -noupdate -group DDSCore1 /main/DUT1/pd_data_b
add wave -noupdate -group DDSCore1 /main/DUT1/pd_le_o
add wave -noupdate -group DDSCore1 /main/DUT1/adc_sdo_i
add wave -noupdate -group DDSCore1 /main/DUT1/adc_sck_o
add wave -noupdate -group DDSCore1 /main/DUT1/adc_cnv_o
add wave -noupdate -group DDSCore1 /main/DUT1/adc_sdi_o
add wave -noupdate -group DDSCore1 /main/DUT1/delay_d_o
add wave -noupdate -group DDSCore1 /main/DUT1/delay_fb_i
add wave -noupdate -group DDSCore1 /main/DUT1/delay_len_o
add wave -noupdate -group DDSCore1 /main/DUT1/delay_pulse_o
add wave -noupdate -group DDSCore1 /main/DUT1/trig_p_i
add wave -noupdate -group DDSCore1 /main/DUT1/trig_n_i
add wave -noupdate -group DDSCore1 /main/DUT1/onewire_b
add wave -noupdate -group DDSCore1 /main/DUT1/wr_dac_sclk_o
add wave -noupdate -group DDSCore1 /main/DUT1/wr_dac_din_o
add wave -noupdate -group DDSCore1 /main/DUT1/wr_dac_sync_n_o
add wave -noupdate -group DDSCore1 /main/DUT1/slave_i
add wave -noupdate -group DDSCore1 /main/DUT1/slave_o
add wave -noupdate -group DDSCore1 /main/DUT1/dac_data_par
add wave -noupdate -group DDSCore1 /main/DUT1/synth_tune
add wave -noupdate -group DDSCore1 /main/DUT1/synth_tune_d0
add wave -noupdate -group DDSCore1 /main/DUT1/synth_tune_d1
add wave -noupdate -group DDSCore1 /main/DUT1/synth_tune_bias
add wave -noupdate -group DDSCore1 /main/DUT1/synth_acc_in
add wave -noupdate -group DDSCore1 /main/DUT1/synth_acc_out
add wave -noupdate -group DDSCore1 /main/DUT1/synth_tune_load
add wave -noupdate -group DDSCore1 /main/DUT1/synth_acc_load
add wave -noupdate -group DDSCore1 /main/DUT1/synth_y0
add wave -noupdate -group DDSCore1 /main/DUT1/synth_y1
add wave -noupdate -group DDSCore1 /main/DUT1/synth_y2
add wave -noupdate -group DDSCore1 /main/DUT1/synth_y3
add wave -noupdate -group DDSCore1 /main/DUT1/regs_in
add wave -noupdate -group DDSCore1 /main/DUT1/regs_out
add wave -noupdate -group DDSCore1 /main/DUT1/swrst
add wave -noupdate -group DDSCore1 /main/DUT1/swrst_n
add wave -noupdate -group DDSCore1 /main/DUT1/rst_n_ref
add wave -noupdate -group DDSCore1 /main/DUT1/rst_ref
add wave -noupdate -group DDSCore1 /main/DUT1/synth_acc_out_msb
add wave -noupdate -group DDSCore1 /main/DUT1/tune_empty_d0
add wave -noupdate -group DDSCore1 /main/DUT1/adc_data
add wave -noupdate -group DDSCore1 /main/DUT1/adc_dvalid
add wave -noupdate -group DDSCore1 /main/DUT1/clk_wr_ref
add wave -noupdate -group DDSCore1 /main/DUT1/clk_wr_ref_pllin
add wave -noupdate -group DDSCore1 /main/DUT1/clk_dds_synth
add wave -noupdate -group DDSCore1 /main/DUT1/clk_rf_in
add wave -noupdate -group DDSCore1 /main/DUT1/pllout_clk_fb_pllref
add wave -noupdate -group DDSCore1 /main/DUT1/pllout_clk_wr_ref
add wave -noupdate -group DDSCore1 /main/DUT1/clk_dds_phy
add wave -noupdate -group DDSCore1 /main/DUT1/presc_counter
add wave -noupdate -group DDSCore1 /main/DUT1/presc_tick
add wave -noupdate -group DDSCore1 /main/DUT1/wr_tai
add wave -noupdate -group DDSCore1 /main/DUT1/wr_cycles
add wave -noupdate -group DDSCore1 /main/DUT1/wr_pps_prepulse
add wave -noupdate -group DDSCore1 /main/DUT1/clk_dds_locked
add wave -noupdate -group DDSCore1 /main/DUT1/fpll_reset
add wave -noupdate -group DDSCore1 /main/DUT1/trig_p_a
add wave -noupdate -group DDSCore1 /main/DUT1/pll_sdio_val
add wave -noupdate -group DDSCore1 /main/DUT1/cic_out_clamp
add wave -noupdate -group DDSCore1 /main/DUT1/CONTROL
add wave -noupdate -group DDSCore1 /main/DUT1/CLK
add wave -noupdate -group DDSCore1 /main/DUT1/TRIG0
add wave -noupdate -group DDSCore1 /main/DUT1/TRIG1
add wave -noupdate -group DDSCore1 /main/DUT1/TRIG2
add wave -noupdate -group DDSCore1 /main/DUT1/TRIG3
add wave -noupdate -group DDSCore1 /main/DUT1/freq_gate_cntr
add wave -noupdate -group DDSCore1 /main/DUT1/freq_gate
add wave -noupdate -group DDSCore1 /main/DUT1/sample_idx
add wave -noupdate -group DDSCore1 /main/DUT1/load_acc_scheduled
add wave -noupdate -group DDSCore1 /main/DUT1/rf_counter
add wave -noupdate -group DDSCore1 /main/DUT1/rf_counter_load_dds
add wave -noupdate -group DDSCore1 /main/DUT1/rf_counter_load_dds_d0
add wave -noupdate -group DDSCore1 /main/DUT1/rf_counter_load_ref
add wave -noupdate -group DDSCore1 /main/DUT1/rf_counter_load_ref_fb
add wave -noupdate -group DDSCore1 /main/DUT1/rf_cnt_trigger_cycles
add wave -noupdate -group DDSCore1 /main/DUT1/cnt_phase_safe
add wave -noupdate -group DDSCore1 -height 16 /main/DUT1/rf_counter_load_state
add wave -noupdate -group DDSCore1 /main/DUT1/trig_armed
add wave -noupdate -group DDSCore1 /main/DUT1/trig_p
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_sys_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rst_n_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_ref_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_wr_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tm_link_up_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tm_time_valid_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tm_tai_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tm_cycles_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tm_clk_aux_lock_en_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tm_clk_aux_locked_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tm_dac_value_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tm_dac_wr_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/dac_n_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/dac_p_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/wr_ref_clk_n_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/wr_ref_clk_p_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_clk_n_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_clk_p_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rf_clk_n_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rf_clk_p_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_sys_cs_n_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_sys_ld_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_sys_reset_n_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_sys_sync_n_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_vcxo_cs_n_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_vcxo_sync_n_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_vcxo_status_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_sclk_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_sdio_b
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_sdo_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pd_lockdet_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pd_clk_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pd_data_b
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pd_le_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/adc_sdo_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/adc_sck_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/adc_cnv_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/adc_sdi_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/delay_d_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/delay_fb_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/delay_len_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/delay_pulse_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/trig_p_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/trig_n_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/onewire_b
add wave -noupdate -expand -group DDSCore2 /main/DUT2/wr_dac_sclk_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/wr_dac_din_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/wr_dac_sync_n_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/slave_i
add wave -noupdate -expand -group DDSCore2 /main/DUT2/slave_o
add wave -noupdate -expand -group DDSCore2 /main/DUT2/dac_data_par
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_tune
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_tune_d0
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_tune_d1
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_tune_bias
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_acc_in
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_acc_out
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_tune_load
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_y0
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_y1
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_y2
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_y3
add wave -noupdate -expand -group DDSCore2 /main/DUT2/regs_in
add wave -noupdate -expand -group DDSCore2 /main/DUT2/regs_out
add wave -noupdate -expand -group DDSCore2 /main/DUT2/swrst
add wave -noupdate -expand -group DDSCore2 /main/DUT2/swrst_n
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rst_n_ref
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rst_ref
add wave -noupdate -expand -group DDSCore2 /main/DUT2/synth_acc_out_msb
add wave -noupdate -expand -group DDSCore2 /main/DUT2/tune_empty_d0
add wave -noupdate -expand -group DDSCore2 /main/DUT2/adc_data
add wave -noupdate -expand -group DDSCore2 /main/DUT2/adc_dvalid
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_wr_ref
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_wr_ref_pllin
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_dds_synth
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_rf_in
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pllout_clk_fb_pllref
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pllout_clk_wr_ref
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_dds_phy
add wave -noupdate -expand -group DDSCore2 /main/DUT2/presc_counter
add wave -noupdate -expand -group DDSCore2 /main/DUT2/presc_tick
add wave -noupdate -expand -group DDSCore2 /main/DUT2/wr_tai
add wave -noupdate -expand -group DDSCore2 /main/DUT2/wr_cycles
add wave -noupdate -expand -group DDSCore2 /main/DUT2/wr_pps_prepulse
add wave -noupdate -expand -group DDSCore2 /main/DUT2/clk_dds_locked
add wave -noupdate -expand -group DDSCore2 /main/DUT2/fpll_reset
add wave -noupdate -expand -group DDSCore2 /main/DUT2/trig_p_a
add wave -noupdate -expand -group DDSCore2 /main/DUT2/pll_sdio_val
add wave -noupdate -expand -group DDSCore2 /main/DUT2/cic_out_clamp
add wave -noupdate -expand -group DDSCore2 /main/DUT2/CONTROL
add wave -noupdate -expand -group DDSCore2 /main/DUT2/CLK
add wave -noupdate -expand -group DDSCore2 /main/DUT2/TRIG0
add wave -noupdate -expand -group DDSCore2 /main/DUT2/TRIG1
add wave -noupdate -expand -group DDSCore2 /main/DUT2/TRIG2
add wave -noupdate -expand -group DDSCore2 /main/DUT2/TRIG3
add wave -noupdate -expand -group DDSCore2 /main/DUT2/freq_gate_cntr
add wave -noupdate -expand -group DDSCore2 /main/DUT2/freq_gate
add wave -noupdate -expand -group DDSCore2 /main/DUT2/sample_idx
add wave -noupdate -expand -group DDSCore2 /main/DUT2/load_acc_scheduled
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rf_counter
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rf_counter_load_dds
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rf_counter_load_dds_d0
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rf_counter_load_ref
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rf_counter_load_ref_fb
add wave -noupdate -expand -group DDSCore2 /main/DUT2/rf_cnt_trigger_cycles
add wave -noupdate -expand -group DDSCore2 /main/DUT2/cnt_phase_safe
add wave -noupdate -expand -group DDSCore2 -height 16 /main/DUT2/rf_counter_load_state
add wave -noupdate -expand -group DDSCore2 /main/DUT2/trig_armed
add wave -noupdate -expand -group DDSCore2 /main/DUT2/trig_p
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {424009000 ps} 0}
configure wave -namecolwidth 406
configure wave -valuecolwidth 40
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
configure wave -timelineunits ps
update
WaveRestoreZoom {423955 ns} {424435 ns}

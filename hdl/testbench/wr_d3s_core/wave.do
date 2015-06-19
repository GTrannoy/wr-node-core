onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DAC /main/DAC/clk_i
add wave -noupdate -expand -group DAC -format Analog-Step -height 84 -max 16128.0 -radix unsigned /main/DAC/data_i
add wave -noupdate -expand -group DAC /main/DAC/dds_clk_o
add wave -noupdate -expand -group DDSCore /main/DUT/clk_sys_i
add wave -noupdate -expand -group DDSCore /main/DUT/rst_n_i
add wave -noupdate -expand -group DDSCore /main/DUT/clk_ref_i
add wave -noupdate -expand -group DDSCore /main/DUT/clk_wr_o
add wave -noupdate -expand -group DDSCore /main/DUT/tm_link_up_i
add wave -noupdate -expand -group DDSCore /main/DUT/tm_time_valid_i
add wave -noupdate -expand -group DDSCore /main/DUT/tm_tai_i
add wave -noupdate -expand -group DDSCore /main/DUT/tm_cycles_i
add wave -noupdate -expand -group DDSCore /main/DUT/tm_clk_aux_lock_en_o
add wave -noupdate -expand -group DDSCore /main/DUT/tm_clk_aux_locked_i
add wave -noupdate -expand -group DDSCore /main/DUT/tm_dac_value_i
add wave -noupdate -expand -group DDSCore /main/DUT/tm_dac_wr_i
add wave -noupdate -expand -group DDSCore /main/DUT/dac_n_o
add wave -noupdate -expand -group DDSCore /main/DUT/dac_p_o
add wave -noupdate -expand -group DDSCore /main/DUT/wr_ref_clk_n_i
add wave -noupdate -expand -group DDSCore /main/DUT/wr_ref_clk_p_i
add wave -noupdate -expand -group DDSCore /main/DUT/synth_clk_n_i
add wave -noupdate -expand -group DDSCore /main/DUT/synth_clk_p_i
add wave -noupdate -expand -group DDSCore /main/DUT/rf_clk_n_i
add wave -noupdate -expand -group DDSCore /main/DUT/rf_clk_p_i
add wave -noupdate -expand -group DDSCore /main/DUT/pll_sys_cs_n_o
add wave -noupdate -expand -group DDSCore /main/DUT/pll_sys_ld_i
add wave -noupdate -expand -group DDSCore /main/DUT/pll_sys_reset_n_o
add wave -noupdate -expand -group DDSCore /main/DUT/pll_sys_sync_n_o
add wave -noupdate -expand -group DDSCore /main/DUT/pll_vcxo_cs_n_o
add wave -noupdate -expand -group DDSCore /main/DUT/pll_vcxo_sync_n_o
add wave -noupdate -expand -group DDSCore /main/DUT/pll_vcxo_status_i
add wave -noupdate -expand -group DDSCore /main/DUT/pll_sclk_o
add wave -noupdate -expand -group DDSCore /main/DUT/pll_sdio_b
add wave -noupdate -expand -group DDSCore /main/DUT/pll_sdo_i
add wave -noupdate -expand -group DDSCore /main/DUT/pd_lockdet_i
add wave -noupdate -expand -group DDSCore /main/DUT/pd_clk_o
add wave -noupdate -expand -group DDSCore /main/DUT/pd_data_b
add wave -noupdate -expand -group DDSCore /main/DUT/pd_le_o
add wave -noupdate -expand -group DDSCore /main/DUT/adc_sdo_i
add wave -noupdate -expand -group DDSCore /main/DUT/adc_sck_o
add wave -noupdate -expand -group DDSCore /main/DUT/adc_cnv_o
add wave -noupdate -expand -group DDSCore /main/DUT/adc_sdi_o
add wave -noupdate -expand -group DDSCore /main/DUT/delay_d_o
add wave -noupdate -expand -group DDSCore /main/DUT/delay_fb_i
add wave -noupdate -expand -group DDSCore /main/DUT/delay_len_o
add wave -noupdate -expand -group DDSCore /main/DUT/delay_pulse_o
add wave -noupdate -expand -group DDSCore /main/DUT/trig_p_i
add wave -noupdate -expand -group DDSCore /main/DUT/trig_n_i
add wave -noupdate -expand -group DDSCore /main/DUT/onewire_b
add wave -noupdate -expand -group DDSCore /main/DUT/wr_dac_sclk_o
add wave -noupdate -expand -group DDSCore /main/DUT/wr_dac_din_o
add wave -noupdate -expand -group DDSCore /main/DUT/wr_dac_sync_n_o
add wave -noupdate -expand -group DDSCore /main/DUT/slave_i
add wave -noupdate -expand -group DDSCore /main/DUT/slave_o
add wave -noupdate -expand -group DDSCore /main/DUT/dac_data_par
add wave -noupdate -expand -group DDSCore /main/DUT/synth_tune
add wave -noupdate -expand -group DDSCore /main/DUT/synth_tune_d0
add wave -noupdate -expand -group DDSCore /main/DUT/synth_tune_d1
add wave -noupdate -expand -group DDSCore /main/DUT/synth_tune_bias
add wave -noupdate -expand -group DDSCore /main/DUT/synth_acc_in
add wave -noupdate -expand -group DDSCore /main/DUT/synth_acc_out
add wave -noupdate -expand -group DDSCore /main/DUT/synth_tune_load
add wave -noupdate -expand -group DDSCore /main/DUT/synth_acc_load
add wave -noupdate -expand -group DDSCore /main/DUT/synth_y0
add wave -noupdate -expand -group DDSCore /main/DUT/synth_y1
add wave -noupdate -expand -group DDSCore /main/DUT/synth_y2
add wave -noupdate -expand -group DDSCore /main/DUT/synth_y3
add wave -noupdate -expand -group DDSCore /main/DUT/regs_in
add wave -noupdate -expand -group DDSCore -expand /main/DUT/regs_out
add wave -noupdate -expand -group DDSCore /main/DUT/swrst
add wave -noupdate -expand -group DDSCore /main/DUT/swrst_n
add wave -noupdate -expand -group DDSCore /main/DUT/rst_n_ref
add wave -noupdate -expand -group DDSCore /main/DUT/rst_ref
add wave -noupdate -expand -group DDSCore /main/DUT/synth_acc_out_msb
add wave -noupdate -expand -group DDSCore /main/DUT/tune_empty_d0
add wave -noupdate -expand -group DDSCore /main/DUT/adc_data
add wave -noupdate -expand -group DDSCore /main/DUT/adc_dvalid
add wave -noupdate -expand -group DDSCore /main/DUT/clk_wr_ref
add wave -noupdate -expand -group DDSCore /main/DUT/clk_wr_ref_pllin
add wave -noupdate -expand -group DDSCore /main/DUT/clk_dds_synth
add wave -noupdate -expand -group DDSCore /main/DUT/clk_rf_in
add wave -noupdate -expand -group DDSCore /main/DUT/pllout_clk_fb_pllref
add wave -noupdate -expand -group DDSCore /main/DUT/pllout_clk_wr_ref
add wave -noupdate -expand -group DDSCore /main/DUT/clk_dds_phy
add wave -noupdate -expand -group DDSCore /main/DUT/sample_p
add wave -noupdate -expand -group DDSCore /main/DUT/sample_idx
add wave -noupdate -expand -group DDSCore -expand /main/DUT/wr_pps_prepulse
add wave -noupdate -expand -group DDSCore /main/DUT/presc_tick
add wave -noupdate -expand -group DDSCore /main/DUT/presc_counter
add wave -noupdate -expand -group DDSCore /main/DUT/sampling_div
add wave -noupdate -expand -group DDSCore /main/DUT/wr_tai
add wave -noupdate -expand -group DDSCore /main/DUT/wr_cycles
add wave -noupdate -expand -group DDSCore /main/DUT/clk_dds_locked
add wave -noupdate -expand -group DDSCore /main/DUT/fpll_reset
add wave -noupdate -expand -group DDSCore /main/DUT/trig_p_a
add wave -noupdate -expand -group DDSCore /main/DUT/pll_sdio_val
add wave -noupdate -expand -group DDSCore /main/DUT/cic_out_clamp
add wave -noupdate -expand -group DDSCore /main/DUT/freq_gate_cntr
add wave -noupdate -expand -group DDSCore /main/DUT/freq_gate
add wave -noupdate -expand -group DDSCore /main/DUT/load_acc_scheduled
add wave -noupdate -expand -group DDSCore /main/DUT/rf_counter
add wave -noupdate -expand -group DDSCore /main/DUT/rf_counter_load_dds
add wave -noupdate -expand -group DDSCore /main/DUT/rf_counter_load_dds_d0
add wave -noupdate -expand -group DDSCore /main/DUT/rf_counter_load_ref
add wave -noupdate -expand -group DDSCore /main/DUT/rf_counter_load_ref_fb
add wave -noupdate -expand -group DDSCore /main/DUT/rf_cnt_trigger_cycles
add wave -noupdate -expand -group DDSCore /main/DUT/cnt_phase_safe
add wave -noupdate -expand -group DDSCore -height 16 /main/DUT/rf_counter_load_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1814017000 ps} 0}
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
WaveRestoreZoom {1733056 ns} {2224576 ns}

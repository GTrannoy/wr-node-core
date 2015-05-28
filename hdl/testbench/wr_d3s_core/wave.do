onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/clk_i
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/rst_n_i
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/acc_load_i
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/tune_load_i
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/acc_i
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/acc_o
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/tune_i
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/dreq_i
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/y0_o
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/y1_o
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/y2_o
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/y3_o
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/lut_addr
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/acc
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/acc_d0
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/tune
add wave -noupdate -expand -group Synthesizer /main/DUT/U_DDS_Synthesizer/y
add wave -noupdate /main/DUT/clk_sys_i
add wave -noupdate /main/DUT/rst_n_i
add wave -noupdate /main/DUT/clk_ref_i
add wave -noupdate /main/DUT/tm_link_up_i
add wave -noupdate /main/DUT/tm_time_valid_i
add wave -noupdate /main/DUT/tm_tai_i
add wave -noupdate /main/DUT/tm_cycles_i
add wave -noupdate /main/DUT/tm_clk_aux_lock_en_o
add wave -noupdate /main/DUT/tm_clk_aux_locked_i
add wave -noupdate /main/DUT/dac_n_o
add wave -noupdate /main/DUT/dac_p_o
add wave -noupdate /main/DUT/wr_ref_clk_n_i
add wave -noupdate /main/DUT/wr_ref_clk_p_i
add wave -noupdate /main/DUT/pll_vcxo_clk_n_i
add wave -noupdate /main/DUT/pll_vcxo_clk_p_i
add wave -noupdate /main/DUT/pll_sys_cs_n_o
add wave -noupdate /main/DUT/pll_sys_ld_i
add wave -noupdate /main/DUT/pll_sys_reset_n_o
add wave -noupdate /main/DUT/pll_sys_sync_n_o
add wave -noupdate /main/DUT/pll_vcxo_cs_n_o
add wave -noupdate /main/DUT/pll_vcxo_sync_n_o
add wave -noupdate /main/DUT/pll_vcxo_status_i
add wave -noupdate /main/DUT/pll_sclk_o
add wave -noupdate /main/DUT/pll_sdio_b
add wave -noupdate /main/DUT/pll_sdo_i
add wave -noupdate /main/DUT/pd_lockdet_i
add wave -noupdate /main/DUT/pd_clk_o
add wave -noupdate /main/DUT/pd_data_b
add wave -noupdate /main/DUT/pd_le_o
add wave -noupdate /main/DUT/adc_sdo_i
add wave -noupdate /main/DUT/adc_sck_o
add wave -noupdate /main/DUT/adc_cnv_o
add wave -noupdate /main/DUT/adc_sdi_o
add wave -noupdate /main/DUT/delay_d_o
add wave -noupdate /main/DUT/delay_fb_i
add wave -noupdate /main/DUT/delay_len_o
add wave -noupdate /main/DUT/delay_pulse_o
add wave -noupdate /main/DUT/trig_p_i
add wave -noupdate /main/DUT/trig_n_i
add wave -noupdate /main/DUT/onewire_b
add wave -noupdate /main/DUT/slave_i
add wave -noupdate /main/DUT/slave_o
add wave -noupdate /main/DUT/dac_data_par
add wave -noupdate /main/DUT/synth_tune
add wave -noupdate /main/DUT/synth_tune_d0
add wave -noupdate /main/DUT/synth_tune_d1
add wave -noupdate /main/DUT/synth_tune_bias
add wave -noupdate /main/DUT/synth_acc_in
add wave -noupdate /main/DUT/synth_acc_out
add wave -noupdate /main/DUT/synth_tune_load
add wave -noupdate /main/DUT/synth_acc_load
add wave -noupdate /main/DUT/synth_y0
add wave -noupdate /main/DUT/synth_y1
add wave -noupdate /main/DUT/synth_y2
add wave -noupdate /main/DUT/synth_y3
add wave -noupdate /main/DUT/regs_in
add wave -noupdate /main/DUT/regs_out
add wave -noupdate /main/DUT/swrst
add wave -noupdate /main/DUT/swrst_n
add wave -noupdate /main/DUT/rst_n_ref
add wave -noupdate /main/DUT/rst_ref
add wave -noupdate /main/DUT/slave_cic_rst
add wave -noupdate /main/DUT/cic_out
add wave -noupdate /main/DUT/slave_tune
add wave -noupdate /main/DUT/cic_in
add wave -noupdate /main/DUT/cic_out_clamp
add wave -noupdate /main/DUT/cic_ce
add wave -noupdate /main/DUT/tune_empty_d0
add wave -noupdate /main/DUT/adc_data
add wave -noupdate /main/DUT/adc_dvalid
add wave -noupdate /main/DUT/mdsp_out
add wave -noupdate /main/DUT/pi_out
add wave -noupdate /main/DUT/mdsp_in
add wave -noupdate /main/DUT/clk_wr_ref
add wave -noupdate /main/DUT/clk_wr_ref_pllin
add wave -noupdate /main/DUT/clk_dds_vcxo
add wave -noupdate /main/DUT/pllout_clk_fb_pllref
add wave -noupdate /main/DUT/pllout_clk_wr_ref
add wave -noupdate /main/DUT/clk_dds_phy
add wave -noupdate /main/DUT/sample_p
add wave -noupdate /main/DUT/presc_counter
add wave -noupdate /main/DUT/presc_tick
add wave -noupdate /main/DUT/sampling_div
add wave -noupdate /main/DUT/wr_tai
add wave -noupdate /main/DUT/wr_cycles
add wave -noupdate /main/DUT/wr_pps_prepulse
add wave -noupdate /main/DUT/clk_dds_locked
add wave -noupdate /main/DUT/fpll_reset
add wave -noupdate /main/DUT/freq_gate
add wave -noupdate /main/DUT/sample_idx
add wave -noupdate /main/DUT/freq_gate_cntr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30001739 ps} 0}
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
WaveRestoreZoom {29788 ns} {30268 ns}

onerror {resume}
quietly virtual signal -install /main/DUT1/cmp_TrevGen { /main/DUT1/cmp_TrevGen/s_regs_o.trevgen_rm_next_tick_o(30 downto 3)} regs_o_WRcycTarget
quietly virtual signal -install /main/DUT1/cmp_TrevGen { /main/DUT1/cmp_TrevGen/s_regs_o.trevgen_rm_next_tick_o(2 downto 0)} regs_o_phase
quietly WaveActivateNextPane {} 0
add wave -noupdate /main/clk_wr
add wave -noupdate -expand -group HOST /main/Host1/out.adr
add wave -noupdate -expand -group HOST /main/Host1/in.dat
add wave -noupdate -expand -group HOST /main/Host1/out.dat
add wave -noupdate /main/DUT1/tm_cycles_i
add wave -noupdate -group DAC /main/DAC/clk_i
add wave -noupdate -group DAC -format Analog-Step -height 84 -max 16128.0 -radix unsigned -childformat {{{/main/DAC/data_i[13]} -radix unsigned} {{/main/DAC/data_i[12]} -radix unsigned} {{/main/DAC/data_i[11]} -radix unsigned} {{/main/DAC/data_i[10]} -radix unsigned} {{/main/DAC/data_i[9]} -radix unsigned} {{/main/DAC/data_i[8]} -radix unsigned} {{/main/DAC/data_i[7]} -radix unsigned} {{/main/DAC/data_i[6]} -radix unsigned} {{/main/DAC/data_i[5]} -radix unsigned} {{/main/DAC/data_i[4]} -radix unsigned} {{/main/DAC/data_i[3]} -radix unsigned} {{/main/DAC/data_i[2]} -radix unsigned} {{/main/DAC/data_i[1]} -radix unsigned} {{/main/DAC/data_i[0]} -radix unsigned}} -subitemconfig {{/main/DAC/data_i[13]} {-height 17 -radix unsigned} {/main/DAC/data_i[12]} {-height 17 -radix unsigned} {/main/DAC/data_i[11]} {-height 17 -radix unsigned} {/main/DAC/data_i[10]} {-height 17 -radix unsigned} {/main/DAC/data_i[9]} {-height 17 -radix unsigned} {/main/DAC/data_i[8]} {-height 17 -radix unsigned} {/main/DAC/data_i[7]} {-height 17 -radix unsigned} {/main/DAC/data_i[6]} {-height 17 -radix unsigned} {/main/DAC/data_i[5]} {-height 17 -radix unsigned} {/main/DAC/data_i[4]} {-height 17 -radix unsigned} {/main/DAC/data_i[3]} {-height 17 -radix unsigned} {/main/DAC/data_i[2]} {-height 17 -radix unsigned} {/main/DAC/data_i[1]} {-height 17 -radix unsigned} {/main/DAC/data_i[0]} {-height 17 -radix unsigned}} /main/DAC/data_i
add wave -noupdate -group DAC /main/DAC/dds_clk_o
add wave -noupdate -group Sample1 /main/DUT1/sample_p
add wave -noupdate -group Sample1 /main/DUT1/sampling_div
add wave -noupdate -group DDSCore1 /main/DUT1/clk_sys_i
add wave -noupdate -group DDSCore1 /main/DUT1/rst_n_i
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
add wave -noupdate -group DDSCore1 /main/DUT1/clk_wr_ref_pllin
add wave -noupdate -group DDSCore1 /main/DUT1/clk_dds_synth
add wave -noupdate -group DDSCore1 /main/DUT1/clk_rf_in
add wave -noupdate -group DDSCore1 /main/DUT1/pllout_clk_fb_pllref
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
add wave -noupdate -group DDSCore1 /main/DUT1/rf_counter_load_state
add wave -noupdate -group DDSCore1 /main/DUT1/trig_armed
add wave -noupdate -group DDSCore1 /main/DUT1/trig_p
add wave -noupdate -radix unsigned /main/count
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/rst_n_i
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/clk_sys_i
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/clk_125m_i
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/wb_adr_i
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/wb_data_i
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/wb_data_o
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/s_state
add wave -noupdate -expand -group TrevGen -radix unsigned /main/DUT1/cmp_TrevGen/WRcyc_i
add wave -noupdate -expand -group TrevGen -radix unsigned /main/DUT1/cmp_TrevGen/s_WRcycTarget
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/s_phase
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/s_BclkGate
add wave -noupdate -expand -group TrevGen -expand /main/DUT1/cmp_TrevGen/s_regs_i
add wave -noupdate -expand -group TrevGen -radix unsigned /main/DUT1/cmp_TrevGen/regs_o_WRcycTarget
add wave -noupdate -expand -group TrevGen /main/DUT1/cmp_TrevGen/regs_o_phase
add wave -noupdate -expand -group TrevGen -expand /main/DUT1/cmp_TrevGen/s_regs_o
add wave -noupdate /main/DUT1/cmp_TrevGen/s_BclkGate
add wave -noupdate /main/DUT1/cmp_TrevGen/B_clk_i
add wave -noupdate /main/DUT1/cmp_TrevGen/Rev_clk_o
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/sys_rst_n_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/clk_sys_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/clk_125m_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/serdes_clk_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/serdes_strobe_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_addr_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_data_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_data_o
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_cyc_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_sel_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_stb_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_we_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_ack_o
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/wb_stall_o
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/stdc_input_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/cycles_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/strobe_o
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/stdc_data_o
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/TRIG_O
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/detect
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/polarity
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/timestamp_8th
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/timestamp_resync
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/fifo_clear
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/fifo_full
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/fifo_we
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/fifo_di
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/fifo_empty
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/fifo_re
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/fifo_do
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/regs_i
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/regs_o
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/cycles_reg
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/signal_reg
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/signal_reg2
add wave -noupdate -group STDC /main/DUT1/cmp_stdc/en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 6} {9787017 ps} 0} {{Cursor 7} {27232533 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 334
configure wave -valuecolwidth 95
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {9537511 ps} {10907969 ps}

onerror {resume}
quietly virtual signal -install /main/DUT/cmp_stdc { /main/DUT/cmp_stdc/fifo_di(30 downto 3)} fifo_in_cycles_reg
quietly virtual signal -install /main/DUT/cmp_stdc {/main/DUT/cmp_stdc/fifo_di(31)  } fifo_di_polarity
quietly virtual signal -install /main/DUT/cmp_stdc { /main/DUT/cmp_stdc/fifo_di(30 downto 3)} fifo_di_cycles
quietly virtual signal -install /main/DUT/cmp_stdc { /main/DUT/cmp_stdc/fifo_di(2 downto 0)} fifo_di_resync_timestamp
quietly WaveActivateNextPane {} 0
add wave -noupdate -group D3S_ADC /main/DUT/clk_sys_i
add wave -noupdate -group D3S_ADC /main/DUT/rst_n_sys_i
add wave -noupdate -group D3S_ADC /main/DUT/clk_125m_pllref_i
add wave -noupdate -group D3S_ADC /main/DUT/clk_wr_o
add wave -noupdate -group D3S_ADC /main/DUT/tm_cycles_i
add wave -noupdate -group D3S_ADC /main/DUT/tm_time_valid_i
add wave -noupdate -group D3S_ADC /main/DUT/tm_clk_aux_lock_en_o
add wave -noupdate -group D3S_ADC /main/DUT/tm_clk_aux_locked_i
add wave -noupdate -group D3S_ADC /main/DUT/fake_data_i
add wave -noupdate -group D3S_ADC /main/DUT/spi_din_i
add wave -noupdate -group D3S_ADC /main/DUT/spi_dout_o
add wave -noupdate -group D3S_ADC /main/DUT/spi_sck_o
add wave -noupdate -group D3S_ADC /main/DUT/spi_cs_adc_n_o
add wave -noupdate -group D3S_ADC /main/DUT/spi_cs_dac1_n_o
add wave -noupdate -group D3S_ADC /main/DUT/spi_cs_dac2_n_o
add wave -noupdate -group D3S_ADC /main/DUT/spi_cs_dac3_n_o
add wave -noupdate -group D3S_ADC /main/DUT/spi_cs_dac4_n_o
add wave -noupdate -group D3S_ADC /main/DUT/si570_scl_b
add wave -noupdate -group D3S_ADC /main/DUT/si570_sda_b
add wave -noupdate -group D3S_ADC /main/DUT/adc_dco_p_i
add wave -noupdate -group D3S_ADC /main/DUT/adc_dco_n_i
add wave -noupdate -group D3S_ADC /main/DUT/adc_fr_p_i
add wave -noupdate -group D3S_ADC /main/DUT/adc_fr_n_i
add wave -noupdate -group D3S_ADC /main/DUT/adc_outa_p_i
add wave -noupdate -group D3S_ADC /main/DUT/adc_outa_n_i
add wave -noupdate -group D3S_ADC /main/DUT/adc_outb_p_i
add wave -noupdate -group D3S_ADC /main/DUT/adc_outb_n_i
add wave -noupdate -group D3S_ADC /main/DUT/adc0_ext_trigger_p_i
add wave -noupdate -group D3S_ADC /main/DUT/adc0_ext_trigger_n_i
add wave -noupdate -group D3S_ADC /main/DUT/ext_trigger
add wave -noupdate -group D3S_ADC /main/DUT/gpio_dac_clr_n_o
add wave -noupdate -group D3S_ADC /main/DUT/gpio_si570_oe_o
add wave -noupdate -group D3S_ADC /main/DUT/slave_i
add wave -noupdate -group D3S_ADC /main/DUT/slave_o
add wave -noupdate -group D3S_ADC /main/DUT/debug_o
add wave -noupdate -group D3S_ADC /main/DUT/rst_n_wr
add wave -noupdate -group D3S_ADC /main/DUT/regs_in
add wave -noupdate -group D3S_ADC /main/DUT/regs_out
add wave -noupdate -group D3S_ADC /main/DUT/adc_data
add wave -noupdate -group D3S_ADC /main/DUT/adc_data2
add wave -noupdate -group D3S_ADC /main/DUT/serdes_in_p
add wave -noupdate -group D3S_ADC /main/DUT/serdes_in_n
add wave -noupdate -group D3S_ADC /main/DUT/serdes_out_raw
add wave -noupdate -group D3S_ADC /main/DUT/serdes_out_data
add wave -noupdate -group D3S_ADC /main/DUT/serdes_out_fr
add wave -noupdate -group D3S_ADC /main/DUT/serdes_auto_bitslip
add wave -noupdate -group D3S_ADC /main/DUT/serdes_man_bitslip
add wave -noupdate -group D3S_ADC /main/DUT/serdes_bitslip
add wave -noupdate -group D3S_ADC /main/DUT/serdes_synced
add wave -noupdate -group D3S_ADC /main/DUT/bitslip_sreg
add wave -noupdate -group D3S_ADC /main/DUT/pllout_stdc_clk
add wave -noupdate -group D3S_ADC /main/DUT/pllout_stdc_clkdiv8
add wave -noupdate -group D3S_ADC /main/DUT/pllout_stdc_locked
add wave -noupdate -group D3S_ADC /main/DUT/pllout_stdc_fb
add wave -noupdate -group D3S_ADC /main/DUT/stdc_clkdiv8
add wave -noupdate -group D3S_ADC /main/DUT/stdc_serdes_strobe
add wave -noupdate -group D3S_ADC /main/DUT/stdc_serdes_clk
add wave -noupdate -group D3S_ADC /main/DUT/stdc_strobe
add wave -noupdate -group D3S_ADC /main/DUT/stdc_data
add wave -noupdate -group D3S_ADC /main/DUT/dco_clk
add wave -noupdate -group D3S_ADC /main/DUT/dco_clk_buf
add wave -noupdate -group D3S_ADC /main/DUT/clk_wr
add wave -noupdate -group D3S_ADC /main/DUT/clk_fb
add wave -noupdate -group D3S_ADC /main/DUT/clk_fb_buf
add wave -noupdate -group D3S_ADC /main/DUT/locked_in
add wave -noupdate -group D3S_ADC /main/DUT/locked_out
add wave -noupdate -group D3S_ADC /main/DUT/serdes_clk
add wave -noupdate -group D3S_ADC /main/DUT/fs_clk_buf
add wave -noupdate -group D3S_ADC /main/DUT/sys_rst
add wave -noupdate -group D3S_ADC /main/DUT/clk_wr_div2
add wave -noupdate -group D3S_ADC /main/DUT/scl_out
add wave -noupdate -group D3S_ADC /main/DUT/sda_out
add wave -noupdate -group D3S_ADC /main/DUT/raw_hp_data
add wave -noupdate -group D3S_ADC /main/DUT/raw_phase
add wave -noupdate -group D3S_ADC /main/DUT/cnx_out
add wave -noupdate -group D3S_ADC /main/DUT/cnx_in
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/sys_rst_n_i
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/clk_sys_i
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/clk_125m_i
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/serdes_clk_i
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/serdes_strobe_i
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/signal_i
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/signal_reg
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/signal_reg2
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/en
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/cycles_i
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/cycles_reg
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/timestamp_8th
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/timestamp_resync
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/stdc_data_o
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/strobe_o
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/polarity
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/detect
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_clear
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_full
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_we
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_di_polarity
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_di_cycles
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_di_resync_timestamp
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_di
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_empty
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_re
add wave -noupdate -expand -group STDC /main/DUT/cmp_stdc/fifo_do
add wave -noupdate -expand -group STDC -expand /main/DUT/cmp_stdc/regs_i
add wave -noupdate -expand -group STDC -expand /main/DUT/cmp_stdc/regs_o
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
add wave -noupdate -group PhaseEncoder /main/DUT/U_Phase_Enc/rl_state
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 5} {900955 ps} 0} {{Cursor 6} {1203100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 185
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
WaveRestoreZoom {803756 ps} {1602444 ps}

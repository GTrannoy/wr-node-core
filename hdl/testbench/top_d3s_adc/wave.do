onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Top /main/DUT/rst_n_a_i
add wave -noupdate -group Top /main/DUT/clk_20m_vcxo_i
add wave -noupdate -group Top /main/DUT/clk_125m_pllref_p_i
add wave -noupdate -group Top /main/DUT/clk_125m_pllref_n_i
add wave -noupdate -group Top /main/DUT/clk_125m_gtp_p_i
add wave -noupdate -group Top /main/DUT/clk_125m_gtp_n_i
add wave -noupdate -group Top /main/DUT/fp_led_line_oen_o
add wave -noupdate -group Top /main/DUT/fp_led_line_o
add wave -noupdate -group Top /main/DUT/fp_led_column_o
add wave -noupdate -group Top /main/DUT/dbg_led0_o
add wave -noupdate -group Top /main/DUT/dbg_led1_o
add wave -noupdate -group Top /main/DUT/dbg_led2_o
add wave -noupdate -group Top /main/DUT/dbg_led3_o
add wave -noupdate -group Top /main/DUT/fp_gpio1_a2b_o
add wave -noupdate -group Top /main/DUT/fp_gpio2_a2b_o
add wave -noupdate -group Top /main/DUT/fp_gpio34_a2b_o
add wave -noupdate -group Top /main/DUT/fp_gpio1_b
add wave -noupdate -group Top /main/DUT/fp_gpio2_b
add wave -noupdate -group Top /main/DUT/fp_gpio3_b
add wave -noupdate -group Top /main/DUT/fp_gpio4_b
add wave -noupdate -group Top /main/DUT/VME_AS_n_i
add wave -noupdate -group Top /main/DUT/VME_RST_n_i
add wave -noupdate -group Top /main/DUT/VME_WRITE_n_i
add wave -noupdate -group Top /main/DUT/VME_AM_i
add wave -noupdate -group Top /main/DUT/VME_DS_n_i
add wave -noupdate -group Top /main/DUT/VME_GA_i
add wave -noupdate -group Top /main/DUT/VME_BERR_o
add wave -noupdate -group Top /main/DUT/VME_DTACK_n_o
add wave -noupdate -group Top /main/DUT/VME_RETRY_n_o
add wave -noupdate -group Top /main/DUT/VME_RETRY_OE_o
add wave -noupdate -group Top /main/DUT/VME_LWORD_n_b
add wave -noupdate -group Top /main/DUT/VME_ADDR_b
add wave -noupdate -group Top /main/DUT/VME_DATA_b
add wave -noupdate -group Top /main/DUT/VME_BBSY_n_i
add wave -noupdate -group Top /main/DUT/VME_IRQ_n_o
add wave -noupdate -group Top /main/DUT/VME_IACK_n_i
add wave -noupdate -group Top /main/DUT/VME_IACKIN_n_i
add wave -noupdate -group Top /main/DUT/VME_IACKOUT_n_o
add wave -noupdate -group Top /main/DUT/VME_DTACK_OE_o
add wave -noupdate -group Top /main/DUT/VME_DATA_DIR_o
add wave -noupdate -group Top /main/DUT/VME_DATA_OE_N_o
add wave -noupdate -group Top /main/DUT/VME_ADDR_DIR_o
add wave -noupdate -group Top /main/DUT/VME_ADDR_OE_N_o
add wave -noupdate -group Top /main/DUT/sfp_txp_o
add wave -noupdate -group Top /main/DUT/sfp_txn_o
add wave -noupdate -group Top /main/DUT/sfp_rxp_i
add wave -noupdate -group Top /main/DUT/sfp_rxn_i
add wave -noupdate -group Top /main/DUT/sfp_mod_def0_b
add wave -noupdate -group Top /main/DUT/sfp_mod_def1_b
add wave -noupdate -group Top /main/DUT/sfp_mod_def2_b
add wave -noupdate -group Top /main/DUT/sfp_rate_select_b
add wave -noupdate -group Top /main/DUT/sfp_tx_fault_i
add wave -noupdate -group Top /main/DUT/sfp_tx_disable_o
add wave -noupdate -group Top /main/DUT/sfp_los_i
add wave -noupdate -group Top /main/DUT/pll20dac_din_o
add wave -noupdate -group Top /main/DUT/pll20dac_sclk_o
add wave -noupdate -group Top /main/DUT/pll20dac_sync_n_o
add wave -noupdate -group Top /main/DUT/pll25dac_din_o
add wave -noupdate -group Top /main/DUT/pll25dac_sclk_o
add wave -noupdate -group Top /main/DUT/pll25dac_sync_n_o
add wave -noupdate -group Top /main/DUT/tempid_dq_b
add wave -noupdate -group Top /main/DUT/uart_rxd_i
add wave -noupdate -group Top /main/DUT/uart_txd_o
add wave -noupdate -group Top /main/DUT/scl_afpga_b
add wave -noupdate -group Top /main/DUT/sda_afpga_b
add wave -noupdate -group Top /main/DUT/fmc0_prsntm2c_n_i
add wave -noupdate -group Top /main/DUT/fmc1_prsntm2c_n_i
add wave -noupdate -group Top /main/DUT/adc0_ext_trigger_p_i
add wave -noupdate -group Top /main/DUT/adc0_ext_trigger_n_i
add wave -noupdate -group Top /main/DUT/adc0_dco_p_i
add wave -noupdate -group Top /main/DUT/adc0_dco_n_i
add wave -noupdate -group Top /main/DUT/adc0_fr_p_i
add wave -noupdate -group Top /main/DUT/adc0_fr_n_i
add wave -noupdate -group Top /main/DUT/adc0_outa_p_i
add wave -noupdate -group Top /main/DUT/adc0_outa_n_i
add wave -noupdate -group Top /main/DUT/adc0_outb_p_i
add wave -noupdate -group Top /main/DUT/adc0_outb_n_i
add wave -noupdate -group Top /main/DUT/adc0_spi_din_i
add wave -noupdate -group Top /main/DUT/adc0_spi_dout_o
add wave -noupdate -group Top /main/DUT/adc0_spi_sck_o
add wave -noupdate -group Top /main/DUT/adc0_spi_cs_adc_n_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_led_acq_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_led_trig_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_si570_oe_o
add wave -noupdate -group Top /main/DUT/adc0_si570_scl_b
add wave -noupdate -group Top /main/DUT/adc0_si570_sda_b
add wave -noupdate -group Top /main/DUT/fmc1_dac_p_o
add wave -noupdate -group Top /main/DUT/fmc1_dac_n_o
add wave -noupdate -group Top /main/DUT/fmc1_pll_sclk_o
add wave -noupdate -group Top /main/DUT/fmc1_pll_sdio_b
add wave -noupdate -group Top /main/DUT/fmc1_pll_sdo_i
add wave -noupdate -group Top /main/DUT/fmc1_pll_sys_ld_i
add wave -noupdate -group Top /main/DUT/fmc1_pll_sys_reset_n_o
add wave -noupdate -group Top /main/DUT/fmc1_pll_sys_cs_n_o
add wave -noupdate -group Top /main/DUT/fmc1_pll_sys_sync_n_o
add wave -noupdate -group Top /main/DUT/fmc1_pll_vcxo_cs_n_o
add wave -noupdate -group Top /main/DUT/fmc1_pll_vcxo_sync_n_o
add wave -noupdate -group Top /main/DUT/fmc1_pll_vcxo_status_i
add wave -noupdate -group Top /main/DUT/fmc1_wr_ref_clk_n_i
add wave -noupdate -group Top /main/DUT/fmc1_wr_ref_clk_p_i
add wave -noupdate -group Top /main/DUT/fmc1_wr_dac_sclk_o
add wave -noupdate -group Top /main/DUT/fmc1_wr_dac_din_o
add wave -noupdate -group Top /main/DUT/fmc1_wr_dac_sync_n_o
add wave -noupdate -group Top /main/DUT/clk_sys
add wave -noupdate -group Top /main/DUT/rst_n
add wave -noupdate -group Top /main/DUT/fmc_host_wb_out
add wave -noupdate -group Top /main/DUT/fmc_dp_wb_out
add wave -noupdate -group Top /main/DUT/fmc_host_wb_in
add wave -noupdate -group Top /main/DUT/fmc_dp_wb_in
add wave -noupdate -group Top /main/DUT/fmc_host_irq
add wave -noupdate -group Top /main/DUT/tm_link_up
add wave -noupdate -group Top /main/DUT/tm_dac_value
add wave -noupdate -group Top /main/DUT/tm_dac_wr
add wave -noupdate -group Top /main/DUT/tm_clk_aux_lock_en
add wave -noupdate -group Top /main/DUT/tm_clk_aux_locked
add wave -noupdate -group Top /main/DUT/tm_time_valid
add wave -noupdate -group Top /main/DUT/tm_tai
add wave -noupdate -group Top /main/DUT/tm_cycles
add wave -noupdate -group Top /main/DUT/fmc0_clk_wr
add wave -noupdate -group Top /main/DUT/fmc1_clk_wr
add wave -noupdate -group Top /main/DUT/debug
add wave -noupdate -group Top /main/DUT/fmc_wb_muxed_out
add wave -noupdate -group Top /main/DUT/fmc_wb_muxed_in
add wave -noupdate -group Top /main/DUT/scl_pad_oen
add wave -noupdate -group Top /main/DUT/sda_pad_oen
add wave -noupdate -group Top /main/DUT/clk_125m_pllref
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/rst_n_sys_i
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/clk_sys_i
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/clk_acq_i
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/data_i
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/slave_i
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/slave_o
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/wr_addr
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/done
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/regs_in
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/regs_out
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/acq_in_progress
add wave -noupdate -group Acq0 /main/DUT/U_D3S_ADC_Core/U_Acq/rst_n_acq
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/rst_n_sys_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/clk_sys_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/clk_125m_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/enable_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/tm_time_valid_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/tm_tai_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/tm_cycles_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/bunch_tick_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/Trev_tick_o
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_adr_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_dat_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_dat_o
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_cyc_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_sel_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_stb_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_we_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_ack_o
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/wb_stall_o
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/s_state
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/s_BclkGate
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/s_Trev_tick
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/s_phase
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/s_WRcycTarget
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/s_regs_i
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/s_regs_o
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/CONTROL
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/CLK
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/TRIG0
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/TRIG1
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/TRIG2
add wave -noupdate -expand -group TrevGen /main/DUT/U_D3S_ADC_slave_core/cmp_TrevGen/TRIG3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {32716409 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 249
configure wave -valuecolwidth 44
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
WaveRestoreZoom {0 ps} {268435456 ps}

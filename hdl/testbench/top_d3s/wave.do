onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TopLevel /main/DUT/rst_n_a_i
add wave -noupdate -group TopLevel /main/DUT/clk_20m_vcxo_i
add wave -noupdate -group TopLevel /main/DUT/clk_125m_pllref_p_i
add wave -noupdate -group TopLevel /main/DUT/clk_125m_pllref_n_i
add wave -noupdate -group TopLevel /main/DUT/clk_125m_gtp_p_i
add wave -noupdate -group TopLevel /main/DUT/clk_125m_gtp_n_i
add wave -noupdate -group TopLevel /main/DUT/fp_led_line_oen_o
add wave -noupdate -group TopLevel /main/DUT/fp_led_line_o
add wave -noupdate -group TopLevel /main/DUT/fp_led_column_o
add wave -noupdate -group TopLevel /main/DUT/fp_gpio1_a2b_o
add wave -noupdate -group TopLevel /main/DUT/fp_gpio2_a2b_o
add wave -noupdate -group TopLevel /main/DUT/fp_gpio34_a2b_o
add wave -noupdate -group TopLevel /main/DUT/fp_gpio1_b
add wave -noupdate -group TopLevel /main/DUT/fp_gpio2_b
add wave -noupdate -group TopLevel /main/DUT/fp_gpio3_b
add wave -noupdate -group TopLevel /main/DUT/fp_gpio4_b
add wave -noupdate -group TopLevel /main/DUT/dbg_led0_o
add wave -noupdate -group TopLevel /main/DUT/dbg_led1_o
add wave -noupdate -group TopLevel /main/DUT/dbg_led2_o
add wave -noupdate -group TopLevel /main/DUT/dbg_led3_o
add wave -noupdate -group TopLevel /main/DUT/carrier_scl_b
add wave -noupdate -group TopLevel /main/DUT/carrier_sda_b
add wave -noupdate -group TopLevel /main/DUT/VME_AS_n_i
add wave -noupdate -group TopLevel /main/DUT/VME_RST_n_i
add wave -noupdate -group TopLevel /main/DUT/VME_WRITE_n_i
add wave -noupdate -group TopLevel /main/DUT/VME_AM_i
add wave -noupdate -group TopLevel /main/DUT/VME_DS_n_i
add wave -noupdate -group TopLevel /main/DUT/VME_GA_i
add wave -noupdate -group TopLevel /main/DUT/VME_BERR_o
add wave -noupdate -group TopLevel /main/DUT/VME_DTACK_n_o
add wave -noupdate -group TopLevel /main/DUT/VME_RETRY_n_o
add wave -noupdate -group TopLevel /main/DUT/VME_RETRY_OE_o
add wave -noupdate -group TopLevel /main/DUT/VME_LWORD_n_b
add wave -noupdate -group TopLevel /main/DUT/VME_ADDR_b
add wave -noupdate -group TopLevel /main/DUT/VME_DATA_b
add wave -noupdate -group TopLevel /main/DUT/VME_BBSY_n_i
add wave -noupdate -group TopLevel /main/DUT/VME_IRQ_n_o
add wave -noupdate -group TopLevel /main/DUT/VME_IACK_n_i
add wave -noupdate -group TopLevel /main/DUT/VME_IACKIN_n_i
add wave -noupdate -group TopLevel /main/DUT/VME_IACKOUT_n_o
add wave -noupdate -group TopLevel /main/DUT/VME_DTACK_OE_o
add wave -noupdate -group TopLevel /main/DUT/VME_DATA_DIR_o
add wave -noupdate -group TopLevel /main/DUT/VME_DATA_OE_N_o
add wave -noupdate -group TopLevel /main/DUT/VME_ADDR_DIR_o
add wave -noupdate -group TopLevel /main/DUT/VME_ADDR_OE_N_o
add wave -noupdate -group TopLevel /main/DUT/sfp_txp_o
add wave -noupdate -group TopLevel /main/DUT/sfp_txn_o
add wave -noupdate -group TopLevel /main/DUT/sfp_rxp_i
add wave -noupdate -group TopLevel /main/DUT/sfp_rxn_i
add wave -noupdate -group TopLevel /main/DUT/sfp_mod_def0_b
add wave -noupdate -group TopLevel /main/DUT/sfp_mod_def1_b
add wave -noupdate -group TopLevel /main/DUT/sfp_mod_def2_b
add wave -noupdate -group TopLevel /main/DUT/sfp_rate_select_b
add wave -noupdate -group TopLevel /main/DUT/sfp_tx_fault_i
add wave -noupdate -group TopLevel /main/DUT/sfp_tx_disable_o
add wave -noupdate -group TopLevel /main/DUT/sfp_los_i
add wave -noupdate -group TopLevel /main/DUT/pll20dac_din_o
add wave -noupdate -group TopLevel /main/DUT/pll20dac_sclk_o
add wave -noupdate -group TopLevel /main/DUT/pll20dac_sync_n_o
add wave -noupdate -group TopLevel /main/DUT/pll25dac_din_o
add wave -noupdate -group TopLevel /main/DUT/pll25dac_sclk_o
add wave -noupdate -group TopLevel /main/DUT/pll25dac_sync_n_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_dac_n_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_dac_p_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_sclk_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_sdio_b
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_sdo_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_sys_ld_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_sys_reset_n_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_sys_cs_n_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_sys_sync_n_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_vcxo_cs_n_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_vcxo_sync_n_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pll_vcxo_status_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_adc_sdo_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_adc_sck_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_adc_cnv_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_adc_sdi_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pd_lockdet_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_pd_clk_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_pd_data_b
add wave -noupdate -group TopLevel /main/DUT/fmc0_pd_le_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_wr_ref_clk_n_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_wr_ref_clk_p_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_synth_clk_n_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_synth_clk_p_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_rf_clk_n_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_rf_clk_p_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_delay_d_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_delay_fb_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_delay_len_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_delay_pulse_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_trig_p_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_trig_n_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_onewire_b
add wave -noupdate -group TopLevel /main/DUT/fmc0_wr_dac_sclk_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_wr_dac_din_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_wr_dac_sync_n_o
add wave -noupdate -group TopLevel /main/DUT/fmc0_prsntm2c_n_i
add wave -noupdate -group TopLevel /main/DUT/fmc0_scl_b
add wave -noupdate -group TopLevel /main/DUT/fmc0_sda_b
add wave -noupdate -group TopLevel /main/DUT/fmc1_prsntm2c_n_i
add wave -noupdate -group TopLevel /main/DUT/fmc1_scl_b
add wave -noupdate -group TopLevel /main/DUT/fmc1_sda_b
add wave -noupdate -group TopLevel /main/DUT/tempid_dq_b
add wave -noupdate -group TopLevel /main/DUT/uart_rxd_i
add wave -noupdate -group TopLevel /main/DUT/uart_txd_o
add wave -noupdate -group TopLevel /main/DUT/clk_sys
add wave -noupdate -group TopLevel /main/DUT/rst_n
add wave -noupdate -group TopLevel -expand -subitemconfig {/main/DUT/fmc_host_wb_out(0) -expand} /main/DUT/fmc_host_wb_out
add wave -noupdate -group TopLevel /main/DUT/fmc_dp_wb_out
add wave -noupdate -group TopLevel -expand -subitemconfig {/main/DUT/fmc_host_wb_in(0) -expand} /main/DUT/fmc_host_wb_in
add wave -noupdate -group TopLevel /main/DUT/fmc_dp_wb_in
add wave -noupdate -group TopLevel /main/DUT/fmc_host_irq
add wave -noupdate -group TopLevel /main/DUT/tm_link_up
add wave -noupdate -group TopLevel /main/DUT/tm_dac_value
add wave -noupdate -group TopLevel /main/DUT/tm_dac_wr
add wave -noupdate -group TopLevel /main/DUT/tm_clk_aux_lock_en
add wave -noupdate -group TopLevel /main/DUT/tm_clk_aux_locked
add wave -noupdate -group TopLevel /main/DUT/tm_time_valid
add wave -noupdate -group TopLevel /main/DUT/tm_tai
add wave -noupdate -group TopLevel /main/DUT/tm_cycles
add wave -noupdate -group TopLevel /main/DUT/CONTROL
add wave -noupdate -group TopLevel /main/DUT/TRIG
add wave -noupdate -group TopLevel /main/DUT/fmc0_clk_wr
add wave -noupdate -group TopLevel /main/DUT/debug
add wave -noupdate -group TopLevel /main/DUT/fmc_wb_muxed_out
add wave -noupdate -group TopLevel /main/DUT/fmc_wb_muxed_in
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/sys_clk_i
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/sys_rst_n_i
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/serdes_clk_i
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/serdes_strobe_i
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/signal_i
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/detect_o
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/polarity_o
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/timestamp_8th_o
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/samples
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/serdes_cascade
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/looking_for
add wave -noupdate -group cmp_stdc /main/DUT/U_DDS_Core0/cmp_stdc/cmp_stdc/iserdes2_rst
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/sys_clk_i
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/clear_i
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/full_o
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/we_i
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/data_i
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/empty_o
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/re_i
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/data_o
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/level
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/produce
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/consume
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/do_write
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/do_read
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/full
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/empty
add wave -noupdate -group cmp_stdc_fifo /main/DUT/U_DDS_Core0/cmp_stdc/cmp_fifo/storage_rda
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/rst_n_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/clk_sys_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_adr_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_dat_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_dat_o
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_cyc_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_sel_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_stb_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_we_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_ack_o
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wb_stall_o
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/regs_i
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/regs_o
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/stdc_ctrl_clr_dly0
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/stdc_ctrl_clr_int
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/stdc_ctrl_clr_ovf_dly0
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/stdc_ctrl_clr_ovf_int
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/stdc_ctrl_next_dly0
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/stdc_ctrl_next_int
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/stdc_ctrl_filter_int
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/ack_sreg
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/rddata_reg
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wrdata_reg
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/bwsel_reg
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/rwaddr_reg
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/ack_in_progress
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/wr_int
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/rd_int
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/allones
add wave -noupdate -group cmp_stdc_wb_slave /main/DUT/U_DDS_Core0/cmp_stdc/comp_stdc_wb_slave/allzeros
add wave -noupdate /main/DUT/U_DDS_Core0/clk_wr_ref
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/sys_rst_n_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/clk_sys_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/clk_125m_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/serdes_clk_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/serdes_strobe_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/signal_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/cycles_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/cycles_reg
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/dbg_cycles_slv
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/strobe_o
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/stdc_data_o
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_addr_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_data_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_data_o
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_cyc_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_sel_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_stb_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_we_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_ack_o
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/wb_stall_o
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/detect
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/polarity
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/timestamp_8th
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/fifo_clear
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/fifo_full
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/fifo_we
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/fifo_di
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/fifo_empty
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/fifo_re
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/fifo_do
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/regs_i
add wave -noupdate -expand -group STDC /main/DUT/U_DDS_Core0/cmp_stdc/regs_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/rst_n_a_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/rst_n_sys_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_sys_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_20m_vcxo_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_125m_pllref_p_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_125m_pllref_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_125m_gtp_p_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_125m_gtp_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_led_line_oen_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_led_line_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_led_column_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_gpio1_a2b_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_gpio2_a2b_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_gpio34_a2b_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_gpio1_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_gpio2_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_gpio3_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fp_gpio4_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_AS_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_RST_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_WRITE_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_AM_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_DS_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_GA_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_BERR_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_DTACK_n_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_RETRY_n_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_RETRY_OE_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_LWORD_n_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_ADDR_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_DATA_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_BBSY_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_IRQ_n_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_IACK_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_IACKIN_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_IACKOUT_n_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_DTACK_OE_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_DATA_DIR_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_DATA_OE_N_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_ADDR_DIR_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_ADDR_OE_N_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_txp_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_txn_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_rxp_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_rxn_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_mod_def0_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_mod_def1_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_mod_def2_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_rate_select_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_tx_fault_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_tx_disable_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_los_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pll20dac_din_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pll20dac_sclk_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pll20dac_sync_n_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pll25dac_din_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pll25dac_sclk_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pll25dac_sync_n_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc0_prsntm2c_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc1_prsntm2c_n_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tempid_dq_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/uart_rxd_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/uart_txd_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc0_clk_aux_i
add wave -noupdate -group NodeTemplate -expand /main/DUT/U_Node_Template/fmc0_host_wb_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc0_host_wb_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc0_dp_wb_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc0_dp_wb_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc0_host_irq_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc1_clk_aux_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc1_host_wb_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc1_host_wb_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc1_dp_wb_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc1_dp_wb_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/fmc1_host_irq_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sp_master_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sp_master_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_link_up_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_dac_value_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_dac_wr_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_clk_aux_lock_en_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_clk_aux_locked_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_time_valid_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_tai_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_cycles_o
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/carrier_scl_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/carrier_sda_b
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/led_state_i
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_DATA_b_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_ADDR_b_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_LWORD_n_b_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_DATA_DIR_int
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/VME_ADDR_DIR_int
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/dac_hpll_load_p1
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/dac_dpll_load_p1
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/dac_hpll_data
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/dac_dpll_data
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_tx_data
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_tx_k
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_tx_disparity
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_tx_enc_err
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_rx_data
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_rx_rbclk
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_rx_k
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_rx_enc_err
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_rx_bitslide
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_rst
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/phy_loopen
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/cnx_master_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/cnx_master_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/cnx_slave_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/cnx_slave_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrn_fmc0_wb_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrn_fmc1_wb_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrc_aux_master_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrn_fmc0_wb_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrn_fmc1_wb_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrc_aux_master_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_link_up
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_tai
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_cycles
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_time_valid
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_clk_aux_lock_en
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_clk_aux_locked
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_dac_value
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm_dac_wr
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrc_scl_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrc_scl_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrc_sda_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrc_sda_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_scl_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_scl_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_sda_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sfp_sda_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrc_owr_en
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrc_owr_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pllout_clk_sys
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pllout_clk_cpu
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pllout_clk_dmtd
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pllout_clk_fb_pllref
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pllout_clk_fb_dmtd
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_20m_vcxo_buf
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_125m_pllref
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_125m_gtp
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_sys
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_cpu
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/clk_dmtd
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/local_reset_n
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrn_irq
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pins
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pps
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/vic_master_irq
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/ebm_src_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/ebm_src_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/ebs_snk_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/ebs_snk_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/powerup_reset_cnt
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/powerup_rst_n
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/sys_locked
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/led_state
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pps_led
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/pps_ext
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/led_link
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/led_act
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/vme_access
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/tm
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrn_gpio_out
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrn_gpio_in
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/rst_net_n
add wave -noupdate -group NodeTemplate /main/DUT/U_Node_Template/wrn_debug_msg_irq
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_sys_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rst_n_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_ref_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_wr_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tm_link_up_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tm_time_valid_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tm_tai_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tm_cycles_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tm_clk_aux_lock_en_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tm_clk_aux_locked_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tm_dac_value_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tm_dac_wr_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/dac_n_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/dac_p_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_ref_clk_n_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_ref_clk_p_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_clk_n_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_clk_p_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_clk_n_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_clk_p_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_sys_cs_n_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_sys_ld_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_sys_reset_n_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_sys_sync_n_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_vcxo_cs_n_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_vcxo_sync_n_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_vcxo_status_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_sclk_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_sdio_b
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_sdo_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pd_lockdet_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pd_clk_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pd_data_b
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pd_le_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/adc_sdo_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/adc_sck_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/adc_cnv_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/adc_sdi_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/delay_d_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/delay_fb_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/delay_len_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/delay_pulse_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/trig_p_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/trig_n_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/onewire_b
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_dac_sclk_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_dac_din_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_dac_sync_n_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_valid_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_overflow_p_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/slave_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/slave_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/debug_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/dac_data_par
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_tune
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_tune_d0
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_tune_d1
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_tune_bias
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_acc_in
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_acc_out
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_tune_load
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_acc_load
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_y0
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_y1
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_y2
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_y3
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/regs_in
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/regs_out
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/swrst
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/swrst_n
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rst_n_ref
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rst_ref
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/synth_acc_out_msb
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/tune_empty_d0
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/adc_data
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/adc_dvalid
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_wr_ref
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_wr_ref_pllin
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_wr_ref_io2in
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pllout_serdes_clk
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/serdes_clk
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/serdes_strobe
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/Trev
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_dds_synth
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_rf_in
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pllout_clk_fb_pllref
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pllout_clk_wr_ref
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_dds_phy
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/sample_p
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/presc_counter
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/presc_tick
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/sampling_div
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_tai
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_cycles
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_cycles_slv
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wr_pps_prepulse
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/clk_dds_locked
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/fpll_reset
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pll_sdio_val
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/cic_out_clamp
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/CONTROL
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/CLK
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/TRIG0
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/TRIG1
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/TRIG2
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/TRIG3
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/freq_gate_cntr
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/freq_gate
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/sample_idx
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/load_acc_scheduled
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_load_dds
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_load_dds_d0
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_load_ref
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_load_ref_fb
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_cnt_trigger_cycles
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/cnt_phase_safe
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_load_state
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/rf_counter_snap_state
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/trig_armed
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/trig_p
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/dds_tmp
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/pulse_armed
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wb_dds_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wb_dds_o
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wb_stdc_i
add wave -noupdate -group DDSCore /main/DUT/U_DDS_Core0/wb_stdc_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {350339226060 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 249
configure wave -valuecolwidth 85
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
WaveRestoreZoom {350322899980 fs} {350352873930 fs}

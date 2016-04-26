onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Template /main/DUT/U_Node_Template/rst_n_a_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/rst_n_sys_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_sys_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_20m_vcxo_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_125m_pllref_p_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_125m_pllref_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_125m_gtp_p_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_125m_gtp_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_led_line_oen_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_led_line_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_led_column_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_gpio1_a2b_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_gpio2_a2b_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_gpio34_a2b_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_gpio1_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_gpio2_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_gpio3_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/fp_gpio4_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_AS_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_RST_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_WRITE_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_AM_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_DS_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_GA_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_BERR_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_DTACK_n_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_RETRY_n_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_RETRY_OE_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_LWORD_n_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_ADDR_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_DATA_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_BBSY_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_IRQ_n_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_IACK_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_IACKIN_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_IACKOUT_n_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_DTACK_OE_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_DATA_DIR_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_DATA_OE_N_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_ADDR_DIR_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_ADDR_OE_N_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_txp_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_txn_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_rxp_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_rxn_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_mod_def0_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_mod_def1_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_mod_def2_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_rate_select_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_tx_fault_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_tx_disable_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_los_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/pll20dac_din_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/pll20dac_sclk_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/pll20dac_sync_n_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/pll25dac_din_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/pll25dac_sclk_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/pll25dac_sync_n_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc0_prsntm2c_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc1_prsntm2c_n_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/tempid_dq_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/uart_rxd_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/uart_txd_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc0_clk_aux_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc0_host_wb_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc0_host_wb_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc0_dp_wb_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc0_dp_wb_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc0_host_irq_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc1_clk_aux_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc1_host_wb_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc1_host_wb_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc1_dp_wb_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc1_dp_wb_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/fmc1_host_irq_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/sp_master_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/sp_master_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_link_up_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_dac_value_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_dac_wr_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_clk_aux_lock_en_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_clk_aux_locked_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_time_valid_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_tai_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_cycles_o
add wave -noupdate -group Template /main/DUT/U_Node_Template/carrier_scl_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/carrier_sda_b
add wave -noupdate -group Template /main/DUT/U_Node_Template/led_state_i
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_DATA_b_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_ADDR_b_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_LWORD_n_b_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_DATA_DIR_int
add wave -noupdate -group Template /main/DUT/U_Node_Template/VME_ADDR_DIR_int
add wave -noupdate -group Template /main/DUT/U_Node_Template/dac_hpll_load_p1
add wave -noupdate -group Template /main/DUT/U_Node_Template/dac_dpll_load_p1
add wave -noupdate -group Template /main/DUT/U_Node_Template/dac_hpll_data
add wave -noupdate -group Template /main/DUT/U_Node_Template/dac_dpll_data
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_tx_data
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_tx_k
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_tx_disparity
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_tx_enc_err
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_rx_data
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_rx_rbclk
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_rx_k
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_rx_enc_err
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_rx_bitslide
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_rst
add wave -noupdate -group Template /main/DUT/U_Node_Template/phy_loopen
add wave -noupdate -group Template -expand /main/DUT/U_Node_Template/cnx_master_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/cnx_master_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/cnx_slave_out
add wave -noupdate -group Template -expand -subitemconfig {/main/DUT/U_Node_Template/cnx_slave_in(0) -expand} /main/DUT/U_Node_Template/cnx_slave_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrn_fmc0_wb_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrn_fmc1_wb_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrc_aux_master_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrn_fmc0_wb_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrn_fmc1_wb_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrc_aux_master_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_link_up
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_tai
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_cycles
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_time_valid
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_clk_aux_lock_en
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_clk_aux_locked
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_dac_value
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm_dac_wr
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrc_scl_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrc_scl_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrc_sda_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrc_sda_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_scl_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_scl_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_sda_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/sfp_sda_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrc_owr_en
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrc_owr_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/pllout_clk_sys
add wave -noupdate -group Template /main/DUT/U_Node_Template/pllout_clk_cpu
add wave -noupdate -group Template /main/DUT/U_Node_Template/pllout_clk_dmtd
add wave -noupdate -group Template /main/DUT/U_Node_Template/pllout_clk_fb_pllref
add wave -noupdate -group Template /main/DUT/U_Node_Template/pllout_clk_fb_dmtd
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_20m_vcxo_buf
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_125m_pllref
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_125m_gtp
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_sys
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_cpu
add wave -noupdate -group Template /main/DUT/U_Node_Template/clk_dmtd
add wave -noupdate -group Template /main/DUT/U_Node_Template/local_reset_n
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrn_irq
add wave -noupdate -group Template /main/DUT/U_Node_Template/pins
add wave -noupdate -group Template /main/DUT/U_Node_Template/pps
add wave -noupdate -group Template /main/DUT/U_Node_Template/vic_master_irq
add wave -noupdate -group Template /main/DUT/U_Node_Template/ebm_src_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/ebm_src_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/ebs_snk_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/ebs_snk_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/powerup_reset_cnt
add wave -noupdate -group Template /main/DUT/U_Node_Template/powerup_rst_n
add wave -noupdate -group Template /main/DUT/U_Node_Template/sys_locked
add wave -noupdate -group Template /main/DUT/U_Node_Template/led_state
add wave -noupdate -group Template /main/DUT/U_Node_Template/pps_led
add wave -noupdate -group Template /main/DUT/U_Node_Template/pps_ext
add wave -noupdate -group Template /main/DUT/U_Node_Template/led_link
add wave -noupdate -group Template /main/DUT/U_Node_Template/led_act
add wave -noupdate -group Template /main/DUT/U_Node_Template/vme_access
add wave -noupdate -group Template /main/DUT/U_Node_Template/tm
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrn_gpio_out
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrn_gpio_in
add wave -noupdate -group Template /main/DUT/U_Node_Template/rst_net_n
add wave -noupdate -group Template /main/DUT/U_Node_Template/wrn_debug_msg_irq
add wave -noupdate -group Top /main/DUT/rst_n_a_i
add wave -noupdate -group Top /main/DUT/clk_20m_vcxo_i
add wave -noupdate -group Top /main/DUT/clk_125m_pllref_p_i
add wave -noupdate -group Top /main/DUT/clk_125m_pllref_n_i
add wave -noupdate -group Top /main/DUT/clk_125m_gtp_p_i
add wave -noupdate -group Top /main/DUT/clk_125m_gtp_n_i
add wave -noupdate -group Top /main/DUT/fp_led_line_oen_o
add wave -noupdate -group Top /main/DUT/fp_led_line_o
add wave -noupdate -group Top /main/DUT/fp_led_column_o
add wave -noupdate -group Top /main/DUT/fp_gpio1_a2b_o
add wave -noupdate -group Top /main/DUT/fp_gpio2_a2b_o
add wave -noupdate -group Top /main/DUT/fp_gpio34_a2b_o
add wave -noupdate -group Top /main/DUT/fp_gpio1_b
add wave -noupdate -group Top /main/DUT/fp_gpio2_b
add wave -noupdate -group Top /main/DUT/fp_gpio3_b
add wave -noupdate -group Top /main/DUT/fp_gpio4_b
add wave -noupdate -group Top /main/DUT/dbg_led0_o
add wave -noupdate -group Top /main/DUT/dbg_led1_o
add wave -noupdate -group Top /main/DUT/dbg_led2_o
add wave -noupdate -group Top /main/DUT/dbg_led3_o
add wave -noupdate -group Top /main/DUT/carrier_scl_b
add wave -noupdate -group Top /main/DUT/carrier_sda_b
add wave -noupdate -group Top /main/DUT/fmc0_prsntm2c_n_i
add wave -noupdate -group Top /main/DUT/fmc1_prsntm2c_n_i
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
add wave -noupdate -group Top /main/DUT/adc0_spi_cs_dac1_n_o
add wave -noupdate -group Top /main/DUT/adc0_spi_cs_dac2_n_o
add wave -noupdate -group Top /main/DUT/adc0_spi_cs_dac3_n_o
add wave -noupdate -group Top /main/DUT/adc0_spi_cs_dac4_n_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_dac_clr_n_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_led_acq_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_led_trig_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_ssr_ch1_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_ssr_ch2_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_ssr_ch3_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_ssr_ch4_o
add wave -noupdate -group Top /main/DUT/adc0_gpio_si570_oe_o
add wave -noupdate -group Top /main/DUT/adc0_si570_scl_b
add wave -noupdate -group Top /main/DUT/adc0_si570_sda_b
add wave -noupdate -group Top /main/DUT/adc0_one_wire_b
add wave -noupdate -group Top /main/DUT/tempid_dq_b
add wave -noupdate -group Top /main/DUT/uart_rxd_i
add wave -noupdate -group Top /main/DUT/uart_txd_o
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
add wave -noupdate -group Top /main/DUT/CONTROL
add wave -noupdate -group Top /main/DUT/TRIG
add wave -noupdate -group Top /main/DUT/fmc0_clk_wr
add wave -noupdate -group Top /main/DUT/debug
add wave -noupdate -group Top /main/DUT/fmc_wb_muxed_out
add wave -noupdate -group Top /main/DUT/fmc_wb_muxed_in
add wave -noupdate -group Top /main/DUT/scl_pad_oen
add wave -noupdate -group Top /main/DUT/sda_pad_oen
add wave -noupdate -expand -group Si57x /main/DUT/U_Silabs_IF/clk_sys_i
add wave -noupdate -expand -group Si57x /main/DUT/U_Silabs_IF/rst_n_i
add wave -noupdate -expand -group Si57x /main/DUT/U_Silabs_IF/tm_dac_value_i
add wave -noupdate -expand -group Si57x /main/DUT/U_Silabs_IF/tm_dac_value_wr_i
add wave -noupdate -expand -group Si57x /main/DUT/U_Silabs_IF/scl_pad_oen_o
add wave -noupdate -expand -group Si57x /main/DUT/U_Silabs_IF/sda_pad_oen_o
add wave -noupdate -expand -group Si57x /main/DUT/U_Silabs_IF/scl_pad_i
add wave -noupdate -expand -group Si57x /main/DUT/U_Silabs_IF/sda_pad_i
add wave -noupdate -expand -group Si57x -expand /main/DUT/U_Silabs_IF/slave_i
add wave -noupdate -expand -group Si57x -expand /main/DUT/U_Silabs_IF/slave_o
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/clk_sys_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/rst_n_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/tm_dac_value_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/tm_dac_value_wr_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/scl_pad_oen_o
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/sda_pad_oen_o
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/scl_pad_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/sda_pad_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_adr_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_dat_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_dat_o
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_sel_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_we_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_cyc_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_stb_i
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_ack_o
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_err_o
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/wb_stall_o
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/regs_in
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/regs_out
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/new_rfreq
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/rfreq_base
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/rfreq_adj
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/rfreq_current
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/i2c_tick
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/i2c_divider
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/scl_int
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/sda_int
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/seq_count
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/state
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/scl_out_host
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/scl_out_fsm
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/sda_out_host
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/sda_out_fsm
add wave -noupdate -expand -group Si67x_int /main/DUT/U_Silabs_IF/U_Wrapped_si57x/n1
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/clk_sys_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/clk_dmtd_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/clk_ref_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/clk_aux_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/clk_ext_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/pps_ext_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/rst_n_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/dac_hpll_load_p1_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/dac_hpll_data_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/dac_dpll_load_p1_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/dac_dpll_data_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_ref_clk_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_tx_data_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_tx_k_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_tx_disparity_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_tx_enc_err_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_rx_data_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_rx_rbclk_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_rx_k_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_rx_enc_err_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_rx_bitslide_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_rst_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/phy_loopen_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/led_act_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/led_link_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/scl_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/scl_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/sda_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/sda_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/sfp_scl_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/sfp_scl_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/sfp_sda_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/sfp_sda_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/sfp_det_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/btn1_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/btn2_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/uart_rxd_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/uart_txd_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/owr_pwren_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/owr_en_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/owr_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/slave_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/slave_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/aux_master_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/aux_master_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/wrf_src_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/wrf_src_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/wrf_snk_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/wrf_snk_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/timestamps_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/timestamps_ack_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/tm_link_up_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/tm_dac_value_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/tm_dac_wr_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/tm_clk_aux_lock_en_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/tm_clk_aux_locked_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/tm_time_valid_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/tm_tai_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/tm_cycles_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/pps_p_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/pps_led_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/dio_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/rst_aux_n_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/link_ok_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/clk_sys_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/clk_dmtd_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/clk_ref_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/clk_aux_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/clk_ext_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/pps_ext_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/rst_n_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dac_hpll_load_p1_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dac_hpll_data_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dac_dpll_load_p1_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dac_dpll_data_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_ref_clk_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_tx_data_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_tx_k_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_tx_disparity_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_tx_enc_err_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_rx_data_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_rx_rbclk_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_rx_k_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_rx_enc_err_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_rx_bitslide_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_rst_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/phy_loopen_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/led_act_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/led_link_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/scl_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/scl_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sda_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sda_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sfp_scl_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sfp_scl_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sfp_sda_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sfp_sda_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sfp_det_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/btn1_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/btn2_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/uart_rxd_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/uart_txd_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/owr_pwren_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/owr_en_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/owr_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_adr_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_dat_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_dat_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_sel_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_we_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_cyc_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_stb_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_ack_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_err_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_rty_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/wb_stall_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_adr_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_dat_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_dat_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_sel_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_we_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_cyc_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_stb_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_ack_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/aux_stall_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_adr_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_dat_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_sel_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_cyc_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_we_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_stb_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_ack_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_err_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_snk_stall_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_adr_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_dat_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_sel_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_cyc_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_stb_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_we_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_ack_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_err_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_src_stall_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/txtsu_port_id_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/txtsu_frame_id_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/txtsu_ts_value_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/txtsu_ts_incorrect_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/txtsu_stb_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/txtsu_ack_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/tm_link_up_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/tm_dac_value_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/tm_dac_wr_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/tm_clk_aux_lock_en_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/tm_clk_aux_locked_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/tm_time_valid_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/tm_tai_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/tm_cycles_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/pps_p_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/pps_led_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dio_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/rst_aux_n_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/link_ok_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/rst_wrc_n
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/rst_net_n
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/s_pps_csync
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/pps_valid
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ppsg_wb_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ppsg_wb_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/spll_wb_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/spll_wb_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_txtsu_port_id
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_txtsu_frame_id
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_txtsu_ts_value
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_txtsu_ts_incorrect
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_txtsu_stb
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_txtsu_ack
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_led_link
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mnic_mem_data_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mnic_mem_addr_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mnic_mem_data_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mnic_mem_wr_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mnic_txtsu_ack
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dpram_wbb_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dpram_wbb_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/periph_slave_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/periph_slave_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sysc_in_regs
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/sysc_out_regs
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/secbar_master_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/secbar_master_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/cbar_slave_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/cbar_slave_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/cbar_master_i
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/cbar_master_o
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_wb_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ext_wb_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/hpll_auxout
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dmpll_auxout
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/clk_ref_slv
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/clk_rx_slv
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/s_dummy_addr
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/softpll_irq
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/lm32_irq_slv
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_wb_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_wb_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/minic_wb_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/minic_wb_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_src_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_src_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_snk_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/ep_snk_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mux_src_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mux_src_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mux_snk_out
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mux_snk_in
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/mux_class
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dummy
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/spll_out_locked
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dac_dpll_data
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dac_dpll_sel
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/dac_dpll_load_p1
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/clk_fb
add wave -noupdate -group WRC-in /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/out_enable
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/clk_sys_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/rst_n_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/clk_ref_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/clk_fb_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/clk_dmtd_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/clk_ext_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/sync_p_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/dac_dmtd_data_o
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/dac_dmtd_load_o
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/dac_out_data_o
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/dac_out_sel_o
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/dac_out_load_o
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/out_enable_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/out_locked_o
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/slave_i
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/slave_o
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/debug_o
add wave -noupdate -expand -group SoftPLL /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_SOFTPLL/dbg_fifo_irq_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {309941998760 fs} 0}
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
WaveRestoreZoom {230834632570 fs} {499270088570 fs}

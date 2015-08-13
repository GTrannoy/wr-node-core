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
add wave -noupdate -group Top /main/DUT/fmc0_tdc_pll_sclk_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_pll_sdi_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_pll_cs_n_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_pll_dac_sync_n_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_pll_sdo_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_pll_status_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_125m_clk_p_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_125m_clk_n_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_acam_refclk_p_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_acam_refclk_n_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_start_from_fpga_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_err_flag_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_int_flag_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_start_dis_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_stop_dis_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_data_bus_io
add wave -noupdate -group Top /main/DUT/fmc0_tdc_address_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_cs_n_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_oe_n_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_rd_n_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_wr_n_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_ef1_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_ef2_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_enable_inputs_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_term_en_1_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_term_en_2_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_term_en_3_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_term_en_4_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_term_en_5_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_one_wire_b
add wave -noupdate -group Top /main/DUT/fmc0_tdc_scl_b
add wave -noupdate -group Top /main/DUT/fmc0_tdc_sda_b
add wave -noupdate -group Top /main/DUT/fmc0_tdc_led_status_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_led_trig1_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_led_trig2_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_led_trig3_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_led_trig4_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_led_trig5_o
add wave -noupdate -group Top /main/DUT/fmc0_tdc_in_fpga_1_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_in_fpga_2_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_in_fpga_3_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_in_fpga_4_i
add wave -noupdate -group Top /main/DUT/fmc0_tdc_in_fpga_5_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_start_p_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_start_n_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_clk_ref_p_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_clk_ref_n_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_trig_a_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_cal_pulse_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_d_b
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_emptyf_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_alutrigger_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_wr_n_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_rd_n_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_oe_n_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_led_trig_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_start_dis_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_stop_dis_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_spi_cs_dac_n_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_spi_cs_pll_n_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_spi_cs_gpio_n_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_spi_sclk_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_spi_mosi_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_spi_miso_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_delay_len_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_delay_val_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_delay_pulse_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_dmtd_clk_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_dmtd_fb_in_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_dmtd_fb_out_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_pll_status_i
add wave -noupdate -group Top /main/DUT/fmc1_fd_ext_rst_n_o
add wave -noupdate -group Top /main/DUT/fmc1_fd_onewire_b
add wave -noupdate -group Top /main/DUT/fmc0_prsntm2c_n_i
add wave -noupdate -group Top /main/DUT/fmc0_scl_b
add wave -noupdate -group Top /main/DUT/fmc0_sda_b
add wave -noupdate -group Top /main/DUT/fmc1_prsntm2c_n_i
add wave -noupdate -group Top /main/DUT/fmc1_scl_b
add wave -noupdate -group Top /main/DUT/fmc1_sda_b
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
add wave -noupdate -group Top /main/DUT/tdc_clk_125m
add wave -noupdate -group Top /main/DUT/dcm1_clk_ref_0
add wave -noupdate -group Top /main/DUT/dcm1_clk_ref_180
add wave -noupdate -group Top /main/DUT/tm_link_up
add wave -noupdate -group Top /main/DUT/tm_dac_value
add wave -noupdate -group Top /main/DUT/tm_dac_wr
add wave -noupdate -group Top /main/DUT/tm_clk_aux_lock_en
add wave -noupdate -group Top /main/DUT/tm_clk_aux_locked
add wave -noupdate -group Top /main/DUT/tm_time_valid
add wave -noupdate -group Top /main/DUT/tm_tai
add wave -noupdate -group Top /main/DUT/tm_cycles
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_start
add wave -noupdate -group Top /main/DUT/ddr1_pll_reset
add wave -noupdate -group Top /main/DUT/ddr1_pll_locked
add wave -noupdate -group Top /main/DUT/fmc1_fd_pll_status
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_data_out
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_data_in
add wave -noupdate -group Top /main/DUT/fmc1_fd_tdc_data_oe
add wave -noupdate -group Top /main/DUT/fmc1_fd_owr_en
add wave -noupdate -group Top /main/DUT/fmc1_fd_owr_in
add wave -noupdate -group Top /main/DUT/fmc1_fd_scl_out
add wave -noupdate -group Top /main/DUT/fmc1_fd_scl_in
add wave -noupdate -group Top /main/DUT/fmc1_fd_sda_out
add wave -noupdate -group Top /main/DUT/fmc1_fd_sda_in
add wave -noupdate -group Top /main/DUT/fmc0_scl_out
add wave -noupdate -group Top /main/DUT/fmc0_sda_out
add wave -noupdate -group Top /main/DUT/fmc1_wb_out
add wave -noupdate -group Top /main/DUT/fmc1_wb_in
add wave -noupdate -group Top /main/DUT/CONTROL
add wave -noupdate -group Top /main/DUT/TRIG
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_cpu_i
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset_n
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/core_sel_match
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_wr
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_wr
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en_cpu
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_en
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_cpu
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_addr
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_host
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_q
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_d
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_d
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_q
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out_sys
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in_sys
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bwe
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wr_d
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_d0
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_load_d0
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_wr
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_out
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_in
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2_d0
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_dat_d0
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync_ext
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_ack_d0
add wave -noupdate -group CPU0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_cyc_d0
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/clk_cpu_i
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_reset_n
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/core_sel_match
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_i_wr
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_d_wr
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_i_en_cpu
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_d_en
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_cpu
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/udata_addr
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_host
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_q
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_d
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_d
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_q
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out_sys
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in_sys
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/bwe
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/wr_d
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/data_d0
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/udata_load_d0
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/udata_wr
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/udata_out
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/udata_in
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/clk_div2
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/clk_div2_d0
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/wb_io_sync
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/wb_dat_d0
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/wb_io_sync_ext
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/wb_ack_d0
add wave -noupdate -expand -group CPU1 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_WR_Node/U_WRNode_Core/gen_cpus(1)/U_CPU_Block/U_TheCoreCPU/wb_cyc_d0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1169076000000 fs} 0}
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
WaveRestoreZoom {0 fs} {2012068249600 fs}

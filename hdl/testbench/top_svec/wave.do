onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_cpu_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset_n
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/core_sel_match
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_wr
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_wr
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en_cpu
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_en
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_cpu
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_addr
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_host
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_q
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_d
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_d
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_q
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -group WRC -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out_sys
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in_sys
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bwe
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wr_d
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_d0
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_load_d0
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_wr
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_out
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_in
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2_d0
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_dat_d0
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync_ext
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_ack_d0
add wave -noupdate -group WRC /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_cyc_d0
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/rst_n_a_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rst_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slots_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slots_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/stat_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/discard_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/ebm_o
add wave -noupdate -group TmpL -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/ebm_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/host_slave_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/host_slave_o
add wave -noupdate -group TmpL -height 16 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/arb_state
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_ready
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_sel
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_done
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_req
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_stat
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_discard
add wave -noupdate -group TmpL -height 16 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/eb_state
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/eb_write_addr
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/eb_write_start
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/msg_size
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/msg_remaining
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/ack_count
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_addr
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rq_adr
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rq_dat_wr
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rq_wr
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rq_rd
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rq_done
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rq_dat_rd
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rq_ready
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/rst_n_sys_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_sys_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_20m_vcxo_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_125m_pllref_p_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_125m_pllref_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_125m_gtp_p_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_125m_gtp_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_led_line_oen_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_led_line_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_led_column_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_gpio1_a2b_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_gpio2_a2b_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_gpio34_a2b_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_gpio1_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_gpio2_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_gpio3_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fp_gpio4_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_AS_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_RST_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_WRITE_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_AM_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_DS_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_GA_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_BERR_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_DTACK_n_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_RETRY_n_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_RETRY_OE_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_LWORD_n_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_ADDR_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_DATA_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_BBSY_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_IRQ_n_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_IACK_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_IACKIN_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_IACKOUT_n_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_DTACK_OE_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_DATA_DIR_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_DATA_OE_N_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_ADDR_DIR_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_ADDR_OE_N_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_txp_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_txn_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_rxp_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_rxn_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_mod_def0_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_mod_def1_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_mod_def2_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_rate_select_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_tx_fault_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_tx_disable_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_los_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pll20dac_din_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pll20dac_sclk_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pll20dac_sync_n_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pll25dac_din_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pll25dac_sclk_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pll25dac_sync_n_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc0_prsntm2c_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc1_prsntm2c_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tempid_dq_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/uart_rxd_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/uart_txd_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc0_clk_aux_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc0_host_wb_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc0_host_wb_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc0_dp_wb_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc0_dp_wb_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc0_host_irq_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc1_clk_aux_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc1_host_wb_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc1_host_wb_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc1_dp_wb_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc1_dp_wb_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/fmc1_host_irq_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_link_up_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_dac_value_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_dac_wr_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_clk_aux_lock_en_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_clk_aux_locked_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_time_valid_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_tai_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_cycles_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/carrier_scl_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/carrier_sda_b
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/led_state_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_DATA_b_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_ADDR_b_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_LWORD_n_b_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_DATA_DIR_int
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/VME_ADDR_DIR_int
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/dac_hpll_load_p1
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/dac_dpll_load_p1
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/dac_hpll_data
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/dac_dpll_data
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_tx_data
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_tx_k
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_tx_disparity
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_tx_enc_err
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_rx_data
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_rx_rbclk
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_rx_k
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_rx_enc_err
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_rx_bitslide
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_rst
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/phy_loopen
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/cnx_master_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/cnx_master_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/cnx_slave_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/cnx_slave_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrn_fmc0_wb_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrn_fmc1_wb_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrc_aux_master_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrn_fmc0_wb_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrn_fmc1_wb_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrc_aux_master_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_link_up
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_tai
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_cycles
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_time_valid
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_clk_aux_lock_en
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_clk_aux_locked
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_dac_value
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm_dac_wr
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrc_scl_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrc_scl_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrc_sda_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrc_sda_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_scl_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_scl_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_sda_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sfp_sda_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrc_owr_en
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrc_owr_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pllout_clk_sys
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pllout_clk_cpu
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pllout_clk_dmtd
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pllout_clk_fb_pllref
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pllout_clk_fb_dmtd
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_20m_vcxo_buf
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_125m_pllref
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_125m_gtp
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_sys
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_cpu
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/clk_dmtd
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/local_reset_n
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrn_irq
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pins
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pps
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/vic_master_irq
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/ebm_src_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/ebm_src_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/ebs_snk_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/ebs_snk_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/powerup_reset_cnt
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/powerup_rst_n
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/sys_locked
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/led_state
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pps_led
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/pps_ext
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/led_link
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/led_act
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/vme_access
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/tm
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrn_gpio_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrn_gpio_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/rst_net_n
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/wrn_debug_msg_irq
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/clk_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/rst_n_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/slave_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/slave_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/src_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/src_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_adr_hi
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_cfg_rec_hdr
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/r_drain
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_rst_n
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/wb_rst_n
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_tx_send_now
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_byte_cnt
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_ovf
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_his_mac
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_my_mac
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_his_ip
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_my_ip
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_his_port
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_my_port
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_tx_stb
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_clear
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_test
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_tx_flush
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/r_udp_raw
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_skip_stb
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_length
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_max_ops
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp_raw_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp_we_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp_valid_i
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp_data_o
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_framer_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_framer_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_ctrl_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_ctrl_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_narrow_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_narrow_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_framer2narrow
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_narrow2framer
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_narrow2tx
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_tx2narrow
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/cbar_slaveport_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/cbar_slaveport_out
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/cbar_masterport_in
add wave -noupdate -group TmpL /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/cbar_masterport_out
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/clk_i
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/rst_n_i
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/slave_i
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/slave_stall_o
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/slave_ack_o
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/rec_valid_o
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/rec_hdr_o
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/rec_adr_rd_o
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/rec_adr_wr_o
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/rec_ack_i
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/byte_cnt_o
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/cfg_rec_hdr_i
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/wb_fifo_q
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/wb_fifo_d
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/wb_fifo_push
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/wb_fifo_pop
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/wb_fifo_full
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/wb_fifo_empty
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/dat
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/adr
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/we
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/stb
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/cyc
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/sel
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/s_drop
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/s_cmd
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/s_push
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_drain
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/s_stall
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_stall_out
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_ack
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_wb_pop
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_start
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_sel
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_drop
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_cyc
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_cyc_in
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_stb
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_stb_in
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_we_in
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_adr
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_adr_in
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_dat
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_dat_in
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_sel_in
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_adr_wr
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_adr_rd
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_rec_hdr
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_push_hdr
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_rec_valid
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/s_word_cnt
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_hdr_state
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_mode
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_wait_return
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/r_cnt_wait
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/a_adr
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/a_dat
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/a_sel
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/a_we
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/a_cmd
add wave -noupdate -expand -group Framer -expand -group Rgen /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rgen/a_drop
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rst_n_i
add wave -noupdate -expand -group Framer -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/slave_i
add wave -noupdate -expand -group Framer -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/slave_o
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/master_o
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/master_i
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/byte_cnt_o
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/ovf_o
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/tx_send_now_i
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/tx_flush_o
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/max_ops_i
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/length_i
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/cfg_rec_hdr_i
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/ctrl_fifo_q
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/ctrl_fifo_d
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/ctrl_fifo_empty
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/s_slave_stall
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/s_tx_send_now
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_tx_send_now
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/send_now
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/tx_stb
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_pop_req
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_pop_cmd
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_abort
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/s_space_sufficient
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/s_rec_byte_cnt
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_rec_byte_cnt
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/s_word_cnt
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/op_fifo_q
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/op_fifo_d
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/op_fifo_push
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/op_fifo_pop
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/op_fifo_full
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/op_fifo_empty
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/dat
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/adr
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/we
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/stb
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/cyc
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_ack
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_err
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_ovf
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/tx_cyc
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_rec_ack
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/s_recgen_slave_stall
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/s_recgen_slave_ack
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/adr_wr
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/adr_rd
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rec_hdr
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/rec_valid
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_first_rec
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_eb_hdr
add wave -noupdate -expand -group Framer -height 16 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_mux_state
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_cnt_ops
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_cnt_pad
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/r_byte_cnt
add wave -noupdate -expand -group Framer /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer/s_recgen_slave_i
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/clk_i
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/rst_n_i
add wave -noupdate -expand -group ebm -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/slave_i
add wave -noupdate -expand -group ebm -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/slave_o
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer_in
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/framer_out
add wave -noupdate -expand -group ebm -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/src_i
add wave -noupdate -expand -group ebm -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/src_o
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_adr_hi
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_cfg_rec_hdr
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/r_drain
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_rst_n
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/wb_rst_n
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_tx_send_now
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_byte_cnt
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_ovf
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_his_mac
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_my_mac
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_his_ip
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_my_ip
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_his_port
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_my_port
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_tx_stb
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_clear
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_test
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_tx_flush
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/r_udp_raw
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_skip_stb
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_length
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_max_ops
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp_raw_o
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp_we_o
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp_valid_i
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_udp_data_o
add wave -noupdate -expand -group ebm -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_framer_in
add wave -noupdate -expand -group ebm -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_framer_out
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_ctrl_in
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_ctrl_out
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_narrow_in
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_narrow_out
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_framer2narrow
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_narrow2framer
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_narrow2tx
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/s_tx2narrow
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/cbar_slaveport_in
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/cbar_slaveport_out
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/cbar_masterport_in
add wave -noupdate -expand -group ebm /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Etherbone_Master/cbar_masterport_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1352614276330 fs} 0}
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
WaveRestoreZoom {1340984720330 fs} {1372423286730 fs}

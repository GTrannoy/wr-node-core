onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/clk_sys_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/rst_sys_n_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/rst_n_a_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_sclk_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_sdi_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_cs_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_dac_sync_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_sdo_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_status_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_clk_125m_p_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_clk_125m_n_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/acam_refclk_p_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/acam_refclk_n_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/start_from_fpga_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/err_flag_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/int_flag_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/start_dis_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/stop_dis_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/data_bus_io
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/address_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/cs_n_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/oe_n_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/rd_n_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/wr_n_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/ef1_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/ef2_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/enable_inputs_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/term_en_1_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/term_en_2_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/term_en_3_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/term_en_4_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/term_en_5_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_led_status_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_led_trig1_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_led_trig2_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_led_trig3_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_led_trig4_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_led_trig5_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_in_fpga_1_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_in_fpga_2_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_in_fpga_3_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_in_fpga_4_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_in_fpga_5_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/mezz_scl_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/mezz_sda_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/mezz_scl_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/mezz_sda_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/mezz_one_wire_b
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_link_up_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_time_valid_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_cycles_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_tai_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_clk_aux_lock_en_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_clk_aux_locked_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_clk_dmtd_locked_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_dac_value_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tm_dac_wr_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/slave_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/slave_o
add wave -noupdate -group TDCCore -expand /main/DUT/U_TDC_Core/direct_slave_i
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/direct_slave_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/irq_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/clk_125m_tdc_o
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/clk_125m_mezz
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/rst_125m_mezz_n
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/rst_125m_mezz
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/acam_refclk_r_edge_p
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/send_dac_word_p
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/dac_word
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_sclk
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_sdi
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/pll_dac_sync
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/fmc_eic_irq
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/fmc_eic_irq_synch
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_scl_out
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_scl_oen
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_sda_out
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/tdc_sda_oen
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/direct_timestamp
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/direct_timestamp_wr
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/cnx_master_in
add wave -noupdate -group TDCCore /main/DUT/U_TDC_Core/cnx_master_out
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/clk_sys_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/rst_sys_n_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/clk_tdc_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/rst_tdc_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/acam_refclk_r_edge_p_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/send_dac_word_p_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/dac_word_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/start_from_fpga_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/err_flag_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/int_flag_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/start_dis_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/stop_dis_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/data_bus_io
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/address_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/cs_n_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/oe_n_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/rd_n_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wr_n_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/ef1_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/ef2_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/enable_inputs_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/term_en_1_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/term_en_2_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/term_en_3_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/term_en_4_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/term_en_5_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_led_status_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_led_trig1_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_led_trig2_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_led_trig3_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_led_trig4_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_led_trig5_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_in_fpga_1_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_in_fpga_2_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_in_fpga_3_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_in_fpga_4_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_in_fpga_5_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_link_up_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_time_valid_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_cycles_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_utc_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_clk_aux_lock_en_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_clk_aux_locked_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_clk_dmtd_locked_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_dac_value_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_dac_wr_p_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/slave_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/slave_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wb_irq_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/i2c_scl_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/i2c_scl_oen_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/i2c_scl_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/i2c_sda_oen_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/i2c_sda_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/i2c_sda_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/onewire_b
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/direct_timestamp_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/direct_timestamp_stb_o
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/general_rst_n
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/rst_ref_0_n
add wave -noupdate -group TDCMezz -expand -subitemconfig {/main/DUT/U_TDC_Core/cmp_tdc_mezz/cnx_master_out(1) -expand} /main/DUT/U_TDC_Core/cmp_tdc_mezz/cnx_master_out
add wave -noupdate -group TDCMezz -expand -subitemconfig {/main/DUT/U_TDC_Core/cmp_tdc_mezz/cnx_master_in(1) -expand} /main/DUT/U_TDC_Core/cmp_tdc_mezz/cnx_master_in
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_core_wb_adr
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/tdc_mem_wb_adr
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/mezz_owr_en
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/mezz_owr_i
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/sys_scl_in
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/sys_scl_out
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/sys_scl_oe_n
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/sys_sda_in
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/sys_sda_out
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/sys_sda_oe_n
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/irq_tstamp_p
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/irq_time_p
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/irq_acam_err_p
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/irq_tstamp_p_sys
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/irq_time_p_sys
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/irq_acam_err_p_sys
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/reg_to_wr
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/reg_from_wr
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_utc_p
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/wrabbit_synched
add wave -noupdate -group TDCMezz /main/DUT/U_TDC_Core/cmp_tdc_mezz/irq_tstamp_sreg
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/clk_sys_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/rst_n_sys_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/clk_tdc_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/rst_tdc_i
add wave -noupdate -group TDCRegs -expand /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/slave_i
add wave -noupdate -group TDCRegs -expand /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/slave_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_config_rdbk_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_ififo1_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_ififo2_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_start01_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/wr_index_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/local_utc_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/core_status_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/irq_code_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/wrabbit_status_reg_i
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_config_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/activate_acq_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/deactivate_acq_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_wr_config_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_rdbk_config_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_rst_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_rdbk_status_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_rdbk_ififo1_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_rdbk_ififo2_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_rdbk_start01_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dacapo_c_rst_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/deactivate_chan_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/send_dac_word_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dac_word_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/load_utc_p_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/starting_utc_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/irq_tstamp_threshold_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/irq_time_threshold_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/one_hz_phase_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_inputs_en_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/wrabbit_ctrl_reg_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/start_phase_o
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_config
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/reg_adr
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/reg_adr_pipe0
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/starting_utc
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/acam_inputs_en
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/start_phase
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/ctrl_reg
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/one_hz_phase
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/irq_tstamp_threshold
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/irq_time_threshold
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/clear_ctrl_reg
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/send_dac_word_p
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dac_word
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/pulse_extender_en
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/pulse_extender_c
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/wrabbit_ctrl_reg
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/deactivate_chan
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/ack_out_pipe0
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/ack_out_pipe1
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out_comb0
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out_comb1
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out_comb2
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out_comb3
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out_pipe0
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out_pipe1
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out_pipe2
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/dat_out_pipe3
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cyc_in_progress
add wave -noupdate -group TDCRegs -expand /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/wb_in
add wave -noupdate -group TDCRegs -expand /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/wb_out
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/rst_n_tdc
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cc_rst_n
add wave -noupdate -group TDCRegs /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cc_rst_n_or_sys
add wave -noupdate -group VME /main/VME/sys_rst_n_i
add wave -noupdate -group VME /main/VME/as_n
add wave -noupdate -group VME /main/VME/rst_n
add wave -noupdate -group VME /main/VME/write_n
add wave -noupdate -group VME /main/VME/am
add wave -noupdate -group VME -expand /main/VME/ds_n
add wave -noupdate -group VME /main/VME/ga
add wave -noupdate -group VME /main/VME/berr_n
add wave -noupdate -group VME /main/VME/dtack_n
add wave -noupdate -group VME /main/VME/retry_n
add wave -noupdate -group VME /main/VME/lword_n
add wave -noupdate -group VME /main/VME/addr
add wave -noupdate -group VME /main/VME/data
add wave -noupdate -group VME /main/VME/bbsy_n
add wave -noupdate -group VME -expand /main/VME/irq_n
add wave -noupdate -group VME /main/VME/iackin_n
add wave -noupdate -group VME /main/VME/iackout_n
add wave -noupdate -group VME /main/VME/iack_n
add wave -noupdate -group VME /main/VME/q_as_n
add wave -noupdate -group VME /main/VME/q_rst_n
add wave -noupdate -group VME /main/VME/q_write_n
add wave -noupdate -group VME /main/VME/q_am
add wave -noupdate -group VME /main/VME/q_ds_n
add wave -noupdate -group VME /main/VME/q_ga
add wave -noupdate -group VME /main/VME/q_berr_n
add wave -noupdate -group VME /main/VME/q_dtack_n
add wave -noupdate -group VME /main/VME/q_retry_n
add wave -noupdate -group VME /main/VME/q_lword_n
add wave -noupdate -group VME /main/VME/q_addr
add wave -noupdate -group VME /main/VME/q_data
add wave -noupdate -group VME /main/VME/q_bbsy_n
add wave -noupdate -group VME /main/VME/q_irq_n
add wave -noupdate -group VME /main/VME/q_iackin_n
add wave -noupdate -group VME /main/VME/q_iackout_n
add wave -noupdate -group VME /main/VME/q_iack_n
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out_sys
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in_sys
add wave -noupdate -expand -group CPU0 -subitemconfig {/main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i.reset_o -expand} /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset_n
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/core_sel_match
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_wr
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_wr
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en_cpu
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_cpu
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_host
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_q
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_d
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_d
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_q
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -expand -group CPU0 -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bwe
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wr_d
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_d0
add wave -noupdate -expand -group CPU0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/clk_sys_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rst_n_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/clk_ref_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rst_n_ref_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/sh_master_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/sh_master_o
add wave -noupdate -group CB0 -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dp_master_i
add wave -noupdate -group CB0 -expand /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dp_master_o
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_csr_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_csr_o
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rmq_ready_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/hmq_ready_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/gpio_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/gpio_o
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dbg_drdy_o
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dbg_dack_i
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dbg_data_o
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_in
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_out
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tai_sec_rd_ack
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/local_regs_in
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/local_regs_out
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_dwb_out
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_dwb_in
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tai_sys
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cycles_sys
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cycles_sys_d0
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cycles_sys_d1
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tai_ref
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cycles_ref
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_p_ref
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_ready_ref
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_p_sys
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_p_ref_d0
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dbg_fifo_empty
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dbg_fifo_full
add wave -noupdate -group CB0 /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dbg_fifo_wr
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/slave_clk_i
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/slave_rst_n_i
add wave -noupdate -group ClkX -expand /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/slave_i
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/slave_o
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/master_clk_i
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/master_rst_n_i
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/master_i
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/master_o
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/msend
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/mrecv
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/msend_vect
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/mrecv_vect
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/mw_en
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/mr_empty
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/mr_en
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/ssend
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/srecv
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/ssend_vect
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/srecv_vect
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/sw_en
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/sr_empty
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/sr_en
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/slave_CYC
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/master_o_STB
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/slave_o_PUSH
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/mpushed
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/mpopped
add wave -noupdate -group ClkX /main/DUT/U_TDC_Core/cmp_tdc_mezz/cmp_tdc_core/reg_control_block/cmp_clks_crossing/full
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/clk_i
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/rst_i
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/interrupt
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_DAT_I
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_ACK_I
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_ERR_I
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_RTY_I
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_DAT_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_ADR_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_CYC_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_SEL_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_STB_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_WE_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_CTI_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_LOCK_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/D_BTE_O
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_i_adr_o
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_d_adr_o
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_d_dat_o
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_i_dat_i
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_d_dat_i
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_d_sel_o
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_d_en_o
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_i_en_o
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_d_we_o
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/valid_f
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/valid_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/valid_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/valid_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/valid_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/q_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/immediate_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_q_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/store_q_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/q_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_q_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/store_q_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/store_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/store_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/store_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/size_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/size_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_predict_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_predict_taken_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_predict_address_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_target_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/bi_unconditional
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/bi_conditional
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_predict_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_predict_taken_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_predict_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_predict_taken_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_mispredict_taken_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_flushX_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_reg_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_offset_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_target_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_target_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/d_result_sel_0_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/d_result_sel_1_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_csr_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_csr_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/q_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_mc_arith_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_mc_arith_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_sext_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_sext_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_logic_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_add_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result_sel_add_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_result_sel_compare_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_result_sel_compare_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_result_sel_compare_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_result_sel_shift_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_result_sel_shift_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_result_sel_shift_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_sel_load_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_sel_load_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_sel_load_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_sel_load_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_sel_mul_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_sel_mul_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_sel_mul_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_sel_mul_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_bypass_enable_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_bypass_enable_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_bypass_enable_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_bypass_enable_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_bypass_enable_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/sign_extend_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/sign_extend_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_enable_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_enable_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_enable_q_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_enable_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_enable_q_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_enable_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_enable_q_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/read_enable_0_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/read_idx_0_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/read_enable_1_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/read_idx_1_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_idx_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_idx_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_idx_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/write_idx_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/csr_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/csr_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/condition_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/condition_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/scall_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/scall_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/eret_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/eret_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/eret_q_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/csr_write_enable_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/csr_write_enable_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/csr_write_enable_q_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/d_result_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/d_result_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/x_result
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/m_result
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/operand_0_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/operand_1_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/store_operand_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/operand_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/operand_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/reg_data_live_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/reg_data_live_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/use_buf
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/reg_data_buf_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/reg_data_buf_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/reg_data_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/reg_data_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/bypass_data_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/bypass_data_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/reg_write_enable_q_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/interlock
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/stall_a
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/stall_f
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/stall_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/stall_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/stall_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/adder_op_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/adder_op_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/adder_op_x_n
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/adder_result_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/adder_overflow_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/adder_carry_n_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/logic_op_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/logic_op_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/logic_result_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/sextb_result_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/sexth_result_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/sext_result_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/direction_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/direction_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/shifter_result_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/multiplier_result_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/divide_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/divide_q_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/modulus_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/modulus_q_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/divide_by_zero_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/mc_stall_request_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/mc_result_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/interrupt_csr_read_data_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/cfg
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/cfg2
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/csr_read_data_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/pc_f
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/pc_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/pc_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/pc_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/pc_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_f
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_data_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/stall_wb_load
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/raw_x_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/raw_x_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/raw_m_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/raw_m_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/raw_w_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/raw_w_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/cmp_zero
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/cmp_negative
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/cmp_overflow
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/cmp_carry_n
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/condition_met_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/condition_met_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/branch_taken_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/kill_f
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/kill_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/kill_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/kill_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/kill_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/eba
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/eid_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/exception_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/exception_m
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/exception_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/exception_q_w
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/interrupt_exception
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/divide_by_zero_exception
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/system_call_exception
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/iram_stall_request_x
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/regfile_data_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/regfile_data_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/w_result_d
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/regfile_raw_0
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/regfile_raw_0_nxt
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/regfile_raw_1
add wave -noupdate -group cpu-top /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/regfile_raw_1_nxt
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/iram_i_adr_o
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/iram_i_dat_i
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/clk_i
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/rst_i
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/stall_a
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/stall_f
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/stall_d
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/stall_x
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/stall_m
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/valid_f
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/valid_d
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/kill_f
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/branch_predict_taken_d
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/branch_predict_address_d
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/exception_m
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/branch_taken_m
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/branch_mispredict_taken_m
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/branch_target_m
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/pc_f
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/pc_d
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/pc_x
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/pc_m
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/pc_w
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/instruction_f
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/instruction_d
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/pc_a
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/iram_select_a
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/iram_select_f
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/prev_instruction_f
add wave -noupdate -group insn-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/instruction_unit/iram_i_en_d0
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/clk_i
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/clk_div2
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/clk_div2_d0
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/wb_io_sync
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_dat_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_adr_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_cyc_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_sel_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_stb_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_we_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_dat_i
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_ack_i
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_err_i
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/d_rty_i
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/rst_i
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/stall_a
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/stall_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/stall_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/kill_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/kill_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/exception_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/store_operand_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/load_store_address_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/load_store_address_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/load_store_address_w
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/load_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/store_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/load_q_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/store_q_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/load_q_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/store_q_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/sign_extend_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/size_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_d_adr_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_d_dat_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_d_dat_i
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_d_sel_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_d_en_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_d_we_o
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_stall_request_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/load_data_w
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/stall_wb_load
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/size_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/size_w
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/sign_extend_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/sign_extend_w
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/store_data_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/store_data_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/byte_enable_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/byte_enable_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/data_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/data_w
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/wb_select_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_select_x
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_enable_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/iram_select_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/wb_select_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/wb_data_m
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/wb_load_complete
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/clk_div2
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/clk_div2_d0
add wave -noupdate -expand -group lst-unit /main/DUT/U_Node_Template/U_WR_Node/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_CPU/load_store_unit/wb_io_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {261260000000 fs} 0}
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
WaveRestoreZoom {261197650520 fs} {261320457420 fs}

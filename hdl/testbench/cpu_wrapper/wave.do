onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group CPU /main/DUT/clk_sys_i
add wave -noupdate -expand -group CPU /main/DUT/rst_n_i
add wave -noupdate -expand -group CPU /main/DUT/irq_i
add wave -noupdate -expand -group CPU /main/DUT/dwb_o
add wave -noupdate -expand -group CPU /main/DUT/dwb_i
add wave -noupdate -expand -group CPU /main/DUT/cpu_csr_i
add wave -noupdate -expand -group CPU /main/DUT/cpu_csr_o
add wave -noupdate -expand -group CPU /main/DUT/jtag_clk
add wave -noupdate -expand -group CPU /main/DUT/jtag_update
add wave -noupdate -expand -group CPU /main/DUT/jtag_reg_q
add wave -noupdate -expand -group CPU /main/DUT/jtag_reg_addr_q
add wave -noupdate -expand -group CPU /main/DUT/jtag_reg_d
add wave -noupdate -expand -group CPU /main/DUT/jtag_reg_addr_d
add wave -noupdate -expand -group CPU /main/DUT/iram_i_adr
add wave -noupdate -expand -group CPU /main/DUT/iram_i_dat
add wave -noupdate -expand -group CPU /main/DUT/iram_i_en
add wave -noupdate -expand -group CPU /main/DUT/iram_d_adr
add wave -noupdate -expand -group CPU /main/DUT/iram_d_dat_out
add wave -noupdate -expand -group CPU /main/DUT/iram_d_dat_in
add wave -noupdate -expand -group CPU /main/DUT/iram_d_sel
add wave -noupdate -expand -group CPU /main/DUT/iram_d_we
add wave -noupdate -expand -group CPU /main/DUT/iram_d_en
add wave -noupdate -expand -group CPU /main/DUT/cm_out
add wave -noupdate -expand -group CPU /main/DUT/cm_in
add wave -noupdate -expand -group CPU /main/DUT/data_addr_reg
add wave -noupdate -expand -group CPU /main/DUT/cpu_enable
add wave -noupdate -expand -group CPU /main/DUT/host_rdata
add wave -noupdate -expand -group CPU /main/DUT/host_write
add wave -noupdate -expand -group CPU /main/DUT/data_was_busy
add wave -noupdate -expand -group CPU /main/DUT/rst
add wave -noupdate -expand -group CPU /main/DUT/d_adr
add wave -noupdate -expand -group CPU /main/DUT/iram_ena
add wave -noupdate -expand -group CPU /main/DUT/iram_aa
add wave -noupdate -group IRAM /main/DUT/U_IRAM/clk_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/rst_n_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/aa_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/ab_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/da_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/db_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/qa_o
add wave -noupdate -group IRAM /main/DUT/U_IRAM/qb_o
add wave -noupdate -group IRAM /main/DUT/U_IRAM/ena_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/enb_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/bwea_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/bweb_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/wea_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/web_i
add wave -noupdate -group IRAM /main/DUT/U_IRAM/wea_rep
add wave -noupdate -group IRAM /main/DUT/U_IRAM/web_rep
add wave -noupdate -group IRAM /main/DUT/U_IRAM/s_we_a
add wave -noupdate -group IRAM /main/DUT/U_IRAM/s_we_b
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/clk_i
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/rst_i
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/interrupt
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_DAT_I
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_ACK_I
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_ERR_I
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_RTY_I
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_DAT_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_ADR_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_CYC_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_SEL_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_STB_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_WE_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_CTI_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_LOCK_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/D_BTE_O
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/iram_i_adr_o
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/iram_d_adr_o
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/iram_d_dat_o
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/iram_i_dat_i
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/iram_d_dat_i
add wave -noupdate -group CPU-top -expand /main/DUT/U_Wrapped_CPU/iram_d_sel_o
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/iram_d_en_o
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/iram_i_en_o
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/iram_d_we_o
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/valid_f
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/valid_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/valid_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/valid_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/valid_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/q_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/immediate_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/load_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/load_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/load_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/load_q_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/store_q_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/q_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/load_q_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/store_q_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/store_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/store_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/store_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/size_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/size_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_predict_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_predict_taken_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_predict_address_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_target_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/bi_unconditional
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/bi_conditional
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_predict_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_predict_taken_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_predict_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_predict_taken_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_mispredict_taken_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_flushX_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_reg_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_offset_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_target_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_target_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/d_result_sel_0_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/d_result_sel_1_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_csr_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_csr_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/q_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_mc_arith_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_mc_arith_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_sext_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_sext_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_logic_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_add_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result_sel_add_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_result_sel_compare_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_result_sel_compare_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_result_sel_compare_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_result_sel_shift_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_result_sel_shift_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_result_sel_shift_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_sel_load_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_sel_load_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_sel_load_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_sel_load_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_sel_mul_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_sel_mul_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_sel_mul_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_sel_mul_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_bypass_enable_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_bypass_enable_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_bypass_enable_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_bypass_enable_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_bypass_enable_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/sign_extend_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/sign_extend_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_enable_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_enable_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_enable_q_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_enable_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_enable_q_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_enable_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_enable_q_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/read_enable_0_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/read_idx_0_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/read_enable_1_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/read_idx_1_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_idx_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_idx_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_idx_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/write_idx_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/csr_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/csr_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/condition_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/condition_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/scall_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/scall_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/eret_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/eret_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/eret_q_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/csr_write_enable_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/csr_write_enable_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/csr_write_enable_q_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/d_result_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/d_result_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/x_result
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/m_result
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/operand_0_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/operand_1_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/store_operand_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/operand_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/operand_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/reg_data_live_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/reg_data_live_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/use_buf
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/reg_data_buf_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/reg_data_buf_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/reg_data_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/reg_data_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/bypass_data_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/bypass_data_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/reg_write_enable_q_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/interlock
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/stall_a
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/stall_f
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/stall_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/stall_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/stall_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/adder_op_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/adder_op_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/adder_op_x_n
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/adder_result_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/adder_overflow_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/adder_carry_n_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/logic_op_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/logic_op_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/logic_result_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/sextb_result_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/sexth_result_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/sext_result_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/direction_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/direction_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/shifter_result_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/multiplier_result_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/divide_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/divide_q_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/modulus_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/modulus_q_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/divide_by_zero_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/mc_stall_request_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/mc_result_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/interrupt_csr_read_data_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/cfg
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/cfg2
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/csr_read_data_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/pc_f
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/pc_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/pc_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/pc_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/pc_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/instruction_f
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/instruction_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/irom_store_data_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/irom_address_xm
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/irom_data_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/irom_we_xm
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/irom_stall_request_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/load_data_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/stall_wb_load
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/raw_x_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/raw_x_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/raw_m_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/raw_m_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/raw_w_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/raw_w_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/cmp_zero
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/cmp_negative
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/cmp_overflow
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/cmp_carry_n
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/condition_met_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/condition_met_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/branch_taken_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/kill_f
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/kill_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/kill_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/kill_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/kill_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/eba
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/eid_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/exception_x
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/exception_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/exception_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/exception_q_w
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/interrupt_exception
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/divide_by_zero_exception
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/system_call_exception
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/irom_byte_enable_m
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/regfile_data_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/regfile_data_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/w_result_d
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/regfile_raw_0
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/regfile_raw_0_nxt
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/regfile_raw_1
add wave -noupdate -group CPU-top /main/DUT/U_Wrapped_CPU/regfile_raw_1_nxt
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_i_adr_o
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_d_adr_o
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_d_dat_o
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_i_dat_i
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_d_dat_i
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_d_sel_o
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_d_en_o
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_i_en_o
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/iram_d_we_o
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/clk_i
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/rst_i
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/stall_a
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/stall_f
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/stall_d
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/stall_x
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/stall_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/valid_f
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/valid_d
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/kill_f
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/branch_predict_taken_d
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/branch_predict_address_d
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/exception_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/branch_taken_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/branch_mispredict_taken_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/branch_target_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/irom_store_data_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/irom_address_xm
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/irom_byte_enable_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/irom_we_xm
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/pc_f
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/pc_d
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/pc_x
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/pc_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/pc_w
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/irom_data_m
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/instruction_f
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/instruction_d
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/pc_a
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/irom_select_a
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/irom_select_f
add wave -noupdate -group IUnit /main/DUT/U_Wrapped_CPU/instruction_unit/irom_data_f
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/clk_i
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/rst_i
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/stall_a
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/stall_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/stall_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/kill_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/kill_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/exception_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/store_operand_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/load_store_address_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/load_store_address_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/load_store_address_w
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/load_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/store_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/load_q_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/store_q_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/load_q_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/store_q_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/sign_extend_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/size_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/irom_data_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_dat_i
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_ack_i
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_err_i
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_rty_i
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/irom_store_data_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/irom_address_xm
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/irom_we_xm
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/irom_stall_request_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/irom_byte_enable_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/load_data_w
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/stall_wb_load
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_dat_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_adr_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_cyc_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_sel_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_stb_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_we_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_cti_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_lock_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/d_bte_o
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/size_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/size_w
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/sign_extend_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/sign_extend_w
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/store_data_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/store_data_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/byte_enable_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/byte_enable_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/data_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/data_w
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/wb_select_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/irom_select_x
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/irom_select_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/wb_select_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/wb_data_m
add wave -noupdate -group LStore /main/DUT/U_Wrapped_CPU/load_store_unit/wb_load_complete
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_0/clk_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_0/rst_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_0/we_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_0/waddr_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_0/wdata_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_0/raddr_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_0/rdata_o
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_1/clk_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_1/rst_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_1/we_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_1/waddr_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_1/wdata_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_1/raddr_i
add wave -noupdate -expand -group Regfile /main/DUT/U_Wrapped_CPU/reg_1/rdata_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65813 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {10507 ns} {10647 ns}

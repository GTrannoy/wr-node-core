onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_cpu_i
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -group LM32-0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -group LM32-0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset_n
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/core_sel_match
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_wr
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_wr
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en_cpu
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_en
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_cpu
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_addr
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_host
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_q
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_d
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_d
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_q
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out_sys
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in_sys
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bwe
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wr_d
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_d0
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_load_d0
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_wr
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_out
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_in
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2_d0
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_dat_d0
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync_ext
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_ack_d0
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_cyc_d0
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_bwe
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_out
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/CONTROL
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/CLK
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG0
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG1
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG2
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG3
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bus_timeout
add wave -noupdate -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bus_timeout_hit
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/clk_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/rst_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/interrupt
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_DAT_I
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_ACK_I
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_ERR_I
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_RTY_I
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/enable_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/trace_pc
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/trace_pc_valid
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/trace_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/trace_eid
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/trace_eret
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/trace_bret
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_DAT_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_ADR_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_CYC_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_SEL_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_STB_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_WE_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_CTI_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_LOCK_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/D_BTE_O
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_i_adr_o
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_d_adr_o
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_d_dat_o
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_i_dat_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_d_dat_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_d_sel_o
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_d_en_o
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_i_en_o
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_d_we_o
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/valid_f
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/valid_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/valid_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/valid_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/valid_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/q_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/immediate_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/load_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/load_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/load_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/load_q_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/store_q_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/q_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/load_q_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/store_q_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/store_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/store_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/store_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/size_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/size_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_predict_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_predict_taken_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_predict_address_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_target_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bi_unconditional
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bi_conditional
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_predict_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_predict_taken_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_predict_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_predict_taken_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_mispredict_taken_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_flushX_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_reg_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_offset_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_target_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_target_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/d_result_sel_0_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/d_result_sel_1_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_csr_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_csr_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/q_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_mc_arith_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_mc_arith_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_sext_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_sext_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_logic_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_add_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result_sel_add_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_result_sel_compare_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_result_sel_compare_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_result_sel_compare_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_result_sel_shift_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_result_sel_shift_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_result_sel_shift_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_sel_load_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_sel_load_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_sel_load_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_sel_load_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_sel_mul_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_sel_mul_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_sel_mul_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_sel_mul_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_bypass_enable_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_bypass_enable_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_bypass_enable_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_bypass_enable_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_bypass_enable_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/sign_extend_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/sign_extend_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_enable_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_enable_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_enable_q_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_enable_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_enable_q_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_enable_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_enable_q_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/read_enable_0_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/read_idx_0_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/read_enable_1_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/read_idx_1_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_idx_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_idx_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_idx_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/write_idx_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/csr_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/csr_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/condition_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/condition_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/break_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/break_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/scall_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/scall_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eret_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eret_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eret_q_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eret_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eret_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bret_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bret_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bret_q_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bret_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bret_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/csr_write_enable_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/csr_write_enable_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/csr_write_enable_q_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bus_error_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bus_error_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/data_bus_error_exception_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/memop_pc_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/d_result_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/d_result_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/x_result
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/m_result
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/operand_0_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/operand_1_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/store_operand_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/operand_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/operand_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/reg_data_live_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/reg_data_live_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/use_buf
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/reg_data_buf_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/reg_data_buf_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/reg_data_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/reg_data_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bypass_data_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bypass_data_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/reg_write_enable_q_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/interlock
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/stall_a
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/stall_f
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/stall_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/stall_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/stall_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/adder_op_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/adder_op_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/adder_op_x_n
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/adder_result_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/adder_overflow_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/adder_carry_n_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/logic_op_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/logic_op_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/logic_result_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/sextb_result_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/sexth_result_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/sext_result_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/direction_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/direction_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/shifter_result_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/multiplier_result_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/divide_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/divide_q_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/modulus_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/modulus_q_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/divide_by_zero_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/mc_stall_request_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/mc_result_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/interrupt_csr_read_data_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/cfg
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/cfg2
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/csr_read_data_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/pc_f
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/pc_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/pc_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/pc_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/pc_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/pc_c
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_f
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/load_data_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/stall_wb_load
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/raw_x_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/raw_x_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/raw_m_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/raw_m_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/raw_w_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/raw_w_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/cmp_zero
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/cmp_negative
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/cmp_overflow
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/cmp_carry_n
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/condition_met_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/condition_met_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/branch_taken_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/kill_f
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/kill_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/kill_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/kill_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/kill_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eba
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/deba
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eid_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eid_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/eid_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/dc_ss
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/dc_re
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/bp_match
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/wp_match
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/exception_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/exception_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/debug_exception_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/debug_exception_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/debug_exception_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/debug_exception_q_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/non_debug_exception_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/non_debug_exception_m
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/non_debug_exception_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/non_debug_exception_q_w
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/reset_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/interrupt_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/breakpoint_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/watchpoint_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_bus_error_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/data_bus_error_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/divide_by_zero_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/system_call_exception
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/data_bus_error_seen
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/iram_stall_request_x
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/dbg_csr_write_enable_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/dbg_csr_write_data_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/dbg_csr_addr_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/dbg_exception_o
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/dbg_reset_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/dbg_break_i
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/jtag_read_enable
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/jtag_write_enable
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/jtag_write_data
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/jtag_address
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/jtag_read_data
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/jtag_access_complete
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/jtag_break
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/regfile_data_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/regfile_data_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/w_result_d
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/regfile_raw_0
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/regfile_raw_0_nxt
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/regfile_raw_1
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/regfile_raw_1_nxt
add wave -noupdate -group TopLM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/user_stall
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/clk_sys_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/rst_n_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/clk_ref_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/rst_n_ref_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/clk_cpu_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/sh_master_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/sh_master_o
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/dp_master_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/dp_master_o
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_csr_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_csr_o
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/rmq_ready_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/hmq_ready_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/gpio_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/gpio_o
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_drdy_o
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_dack_i
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_data_o
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cnx_master_in
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cnx_master_out
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/tai_sec_rd_ack
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/local_regs_in
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/local_regs_out
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_dwb_out
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_dwb_in
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/tai_sys
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/delay_cnt
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cycles_sys
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cycles_sys_d0
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cycles_sys_d1
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/tai_ref
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/cycles_ref
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_p_ref
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_ready_ref
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_p_sys
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_p_ref_d0
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_fifo_empty
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_fifo_full
add wave -noupdate -group cpucb0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_fifo_wr
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/iram_i_adr_o
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/iram_i_dat_i
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/iram_i_en_o
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/clk_i
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/rst_i
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/stall_a
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/stall_f
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/stall_d
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/stall_x
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/stall_m
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/valid_f
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/valid_d
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/kill_f
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/branch_predict_taken_d
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/branch_predict_address_d
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/exception_m
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/branch_taken_m
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/branch_mispredict_taken_m
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/branch_target_m
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/jtag_read_enable
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/jtag_write_enable
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/jtag_write_data
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/jtag_address
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/pc_f
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/pc_d
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/pc_x
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/pc_m
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/pc_w
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/jtag_read_data
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/jtag_access_complete
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/bus_error_d
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/instruction_f
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/instruction_d
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/pc_a
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/iram_select_a
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/iram_select_f
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/bus_error_f
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/jtag_access
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/prev_instruction_f
add wave -noupdate -expand -group IU /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/gen_without_double_core_clock/U_CPU/instruction_unit/iram_i_en_d0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {160708 ns} 0}
configure wave -namecolwidth 282
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
WaveRestoreZoom {160388 ns} {161028 ns}

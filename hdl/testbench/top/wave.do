onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/clk_sys_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/rst_n_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_i
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/sh_master_i
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/sh_master_o
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/dp_master_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/dp_master_o
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_csr_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_csr_o
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/rmq_ready_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/hmq_ready_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/cnx_master_in
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/cnx_master_out
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/tai_cycles_rd_ack
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/local_regs_in
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/local_regs_out
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_dwb_out
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_dwb_in
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_in
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_we
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_en
add wave -noupdate -group CPU0 -expand -group LM32-0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cm_out
add wave -noupdate -group CPU0 -expand -group LM32-0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cm_in
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_addr_reg
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_was_busy
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_ena
add wave -noupdate -group CPU0 -expand -group LM32-0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_aa
add wave -noupdate -group Top /main/DUT/clk_i
add wave -noupdate -group Top /main/DUT/rst_n_i
add wave -noupdate -group Top /main/DUT/sp_master_o
add wave -noupdate -group Top /main/DUT/sp_master_i
add wave -noupdate -group Top /main/DUT/dp_master_o
add wave -noupdate -group Top /main/DUT/dp_master_i
add wave -noupdate -group Top /main/DUT/ebm_master_o
add wave -noupdate -group Top /main/DUT/ebm_master_i
add wave -noupdate -group Top /main/DUT/ebs_slave_o
add wave -noupdate -group Top /main/DUT/ebs_slave_i
add wave -noupdate -group Top /main/DUT/host_slave_i
add wave -noupdate -group Top /main/DUT/host_slave_o
add wave -noupdate -group Top /main/DUT/host_irq_o
add wave -noupdate -group Top /main/DUT/hac_master_out
add wave -noupdate -group Top /main/DUT/hac_master_in
add wave -noupdate -group Top /main/DUT/si_slave_in
add wave -noupdate -group Top /main/DUT/si_slave_out
add wave -noupdate -group Top /main/DUT/si_master_in
add wave -noupdate -group Top /main/DUT/si_master_out
add wave -noupdate -group Top /main/DUT/cpu_csr_fromwb
add wave -noupdate -group Top /main/DUT/cpu_csr_towb
add wave -noupdate -group Top /main/DUT/timing
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/clk_i
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/rst_n_i
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/si_slave_i
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/si_slave_o
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/host_slave_i
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/host_slave_o
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/host_irq_o
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/hmq_status_o
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/si_incoming_in
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/host_incoming_in
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/si_incoming_out
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/host_incoming_out
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/si_outgoing_in
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/host_outgoing_in
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/si_outgoing_out
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/host_outgoing_out
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/incoming_stat
add wave -noupdate -group HMQ /main/DUT/U_Host_MQ/outgoing_stat
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/clk_i
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/rst_i
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/stall_a
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/stall_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/stall_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/kill_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/kill_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/exception_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/store_operand_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/load_store_address_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/load_store_address_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/load_store_address_w
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/load_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/store_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/load_q_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/store_q_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/load_q_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/store_q_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/sign_extend_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/size_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/irom_data_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_dat_i
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_ack_i
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_err_i
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_rty_i
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/irom_store_data_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/irom_address_xm
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/irom_we_xm
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/irom_stall_request_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/irom_byte_enable_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/load_data_w
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/stall_wb_load
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_dat_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_adr_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_cyc_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_sel_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_stb_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_we_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_cti_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_lock_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/d_bte_o
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/size_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/size_w
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/sign_extend_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/sign_extend_w
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/store_data_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/store_data_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/byte_enable_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/byte_enable_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/data_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/data_w
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/wb_select_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/irom_select_x
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/irom_select_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/wb_select_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/wb_data_m
add wave -noupdate -expand -group LSU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/load_store_unit/wb_load_complete
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_i_adr_o
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_d_adr_o
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_d_dat_o
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_i_dat_i
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_d_dat_i
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_d_sel_o
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_d_en_o
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_i_en_o
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/iram_d_we_o
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/clk_i
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/rst_i
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/stall_a
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/stall_f
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/stall_d
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/stall_x
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/stall_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/valid_f
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/valid_d
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/kill_f
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/branch_predict_taken_d
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/branch_predict_address_d
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/exception_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/branch_taken_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/branch_mispredict_taken_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/branch_target_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/irom_store_data_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/irom_address_xm
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/irom_byte_enable_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/irom_we_xm
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/pc_f
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/pc_d
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/pc_x
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/pc_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/pc_w
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/irom_data_m
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/instruction_f
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/instruction_d
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/pc_a
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/irom_select_a
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/irom_select_f
add wave -noupdate -expand -group IU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/U_Wrapped_CPU/instruction_unit/irom_data_f
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22772 ns} 0}
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
WaveRestoreZoom {22688 ns} {22856 ns}

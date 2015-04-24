onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Core /main/DUT/clk_i
add wave -noupdate -group Core /main/DUT/rst_n_i
add wave -noupdate -group Core /main/DUT/sp_master_o
add wave -noupdate -group Core /main/DUT/sp_master_i
add wave -noupdate -group Core /main/DUT/dp_master_o
add wave -noupdate -group Core /main/DUT/dp_master_i
add wave -noupdate -group Core /main/DUT/ebm_master_o
add wave -noupdate -group Core /main/DUT/ebm_master_i
add wave -noupdate -group Core /main/DUT/ebs_slave_o
add wave -noupdate -group Core /main/DUT/ebs_slave_i
add wave -noupdate -group Core /main/DUT/host_slave_i
add wave -noupdate -group Core /main/DUT/host_slave_o
add wave -noupdate -group Core /main/DUT/clk_ref_i
add wave -noupdate -group Core /main/DUT/tm_i
add wave -noupdate -group Core /main/DUT/gpio_o
add wave -noupdate -group Core /main/DUT/gpio_i
add wave -noupdate -group Core /main/DUT/host_irq_o
add wave -noupdate -group Core /main/DUT/debug_msg_irq_o
add wave -noupdate -group Core /main/DUT/hac_master_out
add wave -noupdate -group Core /main/DUT/hac_master_in
add wave -noupdate -group Core /main/DUT/si_slave_in
add wave -noupdate -group Core /main/DUT/si_slave_out
add wave -noupdate -group Core /main/DUT/si_master_in
add wave -noupdate -group Core /main/DUT/si_master_out
add wave -noupdate -group Core /main/DUT/cpu_csr_fromwb
add wave -noupdate -group Core /main/DUT/cpu_csr_towb
add wave -noupdate -group Core /main/DUT/hmq_status
add wave -noupdate -group Core /main/DUT/rmq_status
add wave -noupdate -group Core /main/DUT/cpu_index
add wave -noupdate -group Core /main/DUT/cpu_dbg_drdy
add wave -noupdate -group Core /main/DUT/cpu_dbg_dack
add wave -noupdate -group Core /main/DUT/cpu_dbg_msg_data
add wave -noupdate -group Core /main/DUT/dbg_msg_data_read_ack
add wave -noupdate -group Core /main/DUT/cpu_csr_towb_cb
add wave -noupdate -group Core /main/DUT/cpu_gpio_out
add wave -noupdate -group Core /main/DUT/rst_n_ref
add wave -noupdate -group Core /main/DUT/host_remapped_in
add wave -noupdate -group Core /main/DUT/host_remapped_out
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/clk_sys_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/rst_n_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/clk_ref_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/rst_n_ref_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/sh_master_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/sh_master_o
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dp_master_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dp_master_o
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_csr_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_csr_o
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/rmq_ready_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/hmq_ready_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/gpio_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/gpio_o
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_drdy_o
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_dack_i
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_data_o
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cnx_master_in
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cnx_master_out
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tai_sec_rd_ack
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/local_regs_in
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/local_regs_out
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_dwb_out
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_dwb_in
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tai_sys
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cycles_sys
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cycles_sys_d0
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cycles_sys_d1
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tai_ref
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cycles_ref
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_p_ref
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_ready_ref
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_p_sys
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_p_ref_d0
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_fifo_empty
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_fifo_full
add wave -noupdate -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dbg_fifo_wr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_cpu_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -expand -group Core0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset_n
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/core_sel_match
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_wr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_wr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en_cpu
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_en
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_cpu
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_addr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_host
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_q
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_d
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_d
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_q
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out_sys
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in_sys
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bwe
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wr_d
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_d0
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_load_d0
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_wr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_out
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_in
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2_d0
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_dat_d0
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync_ext
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_ack_d0
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_cyc_d0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {54462 ns} 0}
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
WaveRestoreZoom {0 ns} {327680 ns}

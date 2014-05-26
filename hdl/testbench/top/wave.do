onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cm_out
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cm_in
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_addr_reg
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset_n
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_was_busy
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_remaining
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/CONTROL
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/CLK
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG1
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG2
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG3
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/core_sel_match
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_iwb_out
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_iwb_in
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_access
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_access_d0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_wr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_wr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_d
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_q
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/clk_sys_i
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/rst_n_i
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tm_i
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/sh_master_i
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/sh_master_o
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dp_master_i
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/dp_master_o
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_csr_i
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_csr_o
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/rmq_ready_i
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/hmq_ready_i
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cnx_master_in
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cnx_master_out
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/tai_cycles_rd_ack
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/local_regs_in
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/local_regs_out
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_dwb_out
add wave -noupdate -expand -group CB0 /main/DUT/gen_cpus(0)/U_CPU_Block/cpu_dwb_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {284042 ns} 0}
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
WaveRestoreZoom {283903 ns} {284187 ns}

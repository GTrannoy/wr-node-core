onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group DUT /main/DUT/clk_i
add wave -noupdate -group DUT /main/DUT/rst_n_i
add wave -noupdate -group DUT /main/DUT/sp_master_o
add wave -noupdate -group DUT /main/DUT/sp_master_i
add wave -noupdate -group DUT /main/DUT/dp_master_o
add wave -noupdate -group DUT /main/DUT/dp_master_i
add wave -noupdate -group DUT /main/DUT/wr_src_o
add wave -noupdate -group DUT /main/DUT/wr_src_i
add wave -noupdate -group DUT /main/DUT/wr_snk_o
add wave -noupdate -group DUT /main/DUT/wr_snk_i
add wave -noupdate -group DUT /main/DUT/eb_config_i
add wave -noupdate -group DUT /main/DUT/eb_config_o
add wave -noupdate -group DUT /main/DUT/host_slave_i
add wave -noupdate -group DUT /main/DUT/host_slave_o
add wave -noupdate -group DUT /main/DUT/host_irq_o
add wave -noupdate -group DUT /main/DUT/tm_i
add wave -noupdate -group DUT /main/DUT/eb_config_out
add wave -noupdate -group DUT /main/DUT/eb_config_in
add wave -noupdate -group DUT /main/DUT/wrn_ebs_out
add wave -noupdate -group DUT /main/DUT/ebm_mux_out
add wave -noupdate -group DUT /main/DUT/wrn_ebm_out
add wave -noupdate -group DUT /main/DUT/wrn_ebs_in
add wave -noupdate -group DUT /main/DUT/ebm_mux_in
add wave -noupdate -group DUT /main/DUT/wrn_ebm_in
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/clk_i
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/rst_n_i
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/sp_master_o
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/sp_master_i
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/dp_master_o
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/dp_master_i
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/ebm_master_o
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/ebm_master_i
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/ebs_slave_o
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/ebs_slave_i
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/host_slave_i
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/host_slave_o
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/host_irq_o
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/tm_i
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/hac_master_out
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/hac_master_in
add wave -noupdate -group WRN -expand -subitemconfig {/main/DUT/U_WRNode_Core/si_slave_in(3) -expand} /main/DUT/U_WRNode_Core/si_slave_in
add wave -noupdate -group WRN -expand -subitemconfig {/main/DUT/U_WRNode_Core/si_slave_out(3) -expand} /main/DUT/U_WRNode_Core/si_slave_out
add wave -noupdate -group WRN -expand /main/DUT/U_WRNode_Core/si_master_in
add wave -noupdate -group WRN -expand /main/DUT/U_WRNode_Core/si_master_out
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/cpu_csr_fromwb
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/cpu_csr_towb
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/hmq_status
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/rmq_status
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/timing
add wave -noupdate -group WRN /main/DUT/U_WRNode_Core/cpu_index
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/clk_sys_i
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cm_out
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cm_in
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_addr_reg
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_was_busy
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_remaining
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rst_n_i
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_i
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/sh_master_i
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/sh_master_o
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dp_master_i
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dp_master_o
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_csr_i
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_csr_o
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rmq_ready_i
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/hmq_ready_i
add wave -noupdate -group CPU0 -expand /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_in
add wave -noupdate -group CPU0 -expand -subitemconfig {/main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_out(2) -expand} /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_out
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tai_cycles_rd_ack
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/local_regs_in
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/local_regs_out
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_dwb_out
add wave -noupdate -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_dwb_in
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/clk_i
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/rst_n_i
add wave -noupdate -group RMQ -expand /main/DUT/U_WRNode_Core/U_Remote_MQ/si_slave_i
add wave -noupdate -group RMQ -expand /main/DUT/U_WRNode_Core/U_Remote_MQ/si_slave_o
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/ebm_master_o
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/ebm_master_i
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/ebs_slave_o
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/ebs_slave_i
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/rmq_status_o
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/si_incoming_in
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_incoming_in
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/si_incoming_out
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_incoming_out
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/si_outgoing_in
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_in
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/si_outgoing_out
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_out
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/incoming_stat
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/outgoing_stat
add wave -noupdate -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_discard
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/clk_i
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/rst_n_i
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_slave_i
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_slave_o
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_slave_i
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_slave_o
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_irq_o
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/hmq_status_o
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_incoming_in
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_incoming_in
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_incoming_out
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_incoming_out
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_outgoing_in
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_outgoing_in
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_outgoing_out
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_outgoing_out
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/incoming_stat
add wave -noupdate -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/outgoing_stat
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/clk_i
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/rst_n_i
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/slave_i
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/slave_o
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/src_i
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/src_o
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_adr_hi
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_cfg_rec_hdr
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/r_drain
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_dat
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_ack
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_err
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_stall
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_rst_n
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/wb_rst_n
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_tx_send_now
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_his_mac
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_my_mac
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_his_ip
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_my_ip
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_his_port
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_my_port
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_tx_stb
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_clear
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_tx_flush
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_skip_stb
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_length
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_max_ops
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_slave_framer_i
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_slave_ctrl_i
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_master_o
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_master_i
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_framer2narrow
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_narrow2framer
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_narrow2tx
add wave -noupdate -expand -group EBM /main/DUT/U_WRNode_Etherbone_Master/s_tx2narrow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {142861 ns} 0}
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
WaveRestoreZoom {118285 ns} {204301 ns}

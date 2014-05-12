onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT /main/DUT/clk_i
add wave -noupdate -expand -group DUT /main/DUT/rst_n_i
add wave -noupdate -expand -group DUT /main/DUT/sp_master_o
add wave -noupdate -expand -group DUT /main/DUT/sp_master_i
add wave -noupdate -expand -group DUT /main/DUT/dp_master_o
add wave -noupdate -expand -group DUT /main/DUT/dp_master_i
add wave -noupdate -expand -group DUT /main/DUT/wr_src_o
add wave -noupdate -expand -group DUT /main/DUT/wr_src_i
add wave -noupdate -expand -group DUT /main/DUT/wr_snk_o
add wave -noupdate -expand -group DUT /main/DUT/wr_snk_i
add wave -noupdate -expand -group DUT /main/DUT/eb_config_i
add wave -noupdate -expand -group DUT /main/DUT/eb_config_o
add wave -noupdate -expand -group DUT /main/DUT/host_slave_i
add wave -noupdate -expand -group DUT /main/DUT/host_slave_o
add wave -noupdate -expand -group DUT /main/DUT/host_irq_o
add wave -noupdate -expand -group DUT /main/DUT/tm_i
add wave -noupdate -expand -group DUT /main/DUT/eb_config_out
add wave -noupdate -expand -group DUT /main/DUT/eb_config_in
add wave -noupdate -expand -group DUT /main/DUT/wrn_ebs_out
add wave -noupdate -expand -group DUT /main/DUT/ebm_mux_out
add wave -noupdate -expand -group DUT /main/DUT/wrn_ebm_out
add wave -noupdate -expand -group DUT /main/DUT/wrn_ebs_in
add wave -noupdate -expand -group DUT /main/DUT/ebm_mux_in
add wave -noupdate -expand -group DUT /main/DUT/wrn_ebm_in
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/clk_i
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/rst_n_i
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/sp_master_o
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/sp_master_i
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/dp_master_o
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/dp_master_i
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/ebm_master_o
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/ebm_master_i
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/ebs_slave_o
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/ebs_slave_i
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/host_slave_i
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/host_slave_o
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/host_irq_o
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/tm_i
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/hac_master_out
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/hac_master_in
add wave -noupdate -expand -group WRN -expand -subitemconfig {/main/DUT/U_WRNode_Core/si_slave_in(3) -expand} /main/DUT/U_WRNode_Core/si_slave_in
add wave -noupdate -expand -group WRN -expand -subitemconfig {/main/DUT/U_WRNode_Core/si_slave_out(3) -expand} /main/DUT/U_WRNode_Core/si_slave_out
add wave -noupdate -expand -group WRN -expand /main/DUT/U_WRNode_Core/si_master_in
add wave -noupdate -expand -group WRN -expand /main/DUT/U_WRNode_Core/si_master_out
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/cpu_csr_fromwb
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/cpu_csr_towb
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/hmq_status
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/rmq_status
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/timing
add wave -noupdate -expand -group WRN /main/DUT/U_WRNode_Core/cpu_index
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/clk_sys_i
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_in
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_we
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_en
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cm_out
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cm_in
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_addr_reg
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_was_busy
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_remaining
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_ena
add wave -noupdate -expand -group CPU0 -group LM32 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_aa
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rst_n_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/sh_master_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/sh_master_o
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dp_master_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dp_master_o
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_csr_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_csr_o
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rmq_ready_i
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/hmq_ready_i
add wave -noupdate -expand -group CPU0 -expand /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_in
add wave -noupdate -expand -group CPU0 -expand -subitemconfig {/main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_out(2) -expand} /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_out
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tai_cycles_rd_ack
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/local_regs_in
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/local_regs_out
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_dwb_out
add wave -noupdate -expand -group CPU0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_dwb_in
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/clk_i
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/rst_n_i
add wave -noupdate -expand -group RMQ -expand /main/DUT/U_WRNode_Core/U_Remote_MQ/si_slave_i
add wave -noupdate -expand -group RMQ -expand /main/DUT/U_WRNode_Core/U_Remote_MQ/si_slave_o
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/ebm_master_o
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/ebm_master_i
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/ebs_slave_o
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/ebs_slave_i
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/rmq_status_o
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/si_incoming_in
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_incoming_in
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/si_incoming_out
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_incoming_out
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/si_outgoing_in
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_in
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/si_outgoing_out
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_out
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/incoming_stat
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/outgoing_stat
add wave -noupdate -expand -group RMQ /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_discard
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/clk_i
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/rst_n_i
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/incoming_status_i
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/outgoing_status_i
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/incoming_o
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/incoming_i
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/outgoing_o
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/outgoing_i
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/slave_i
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/slave_o
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/irq_config_o
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/slot_num
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/slot_num_d0
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/gcr_sel
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/gcr_sel_d0
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/in_area_sel
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/in_area_sel_d0
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/out_area_sel
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/out_area_sel_d0
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/wb_write
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/wb_read
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/gcr_rd_data
add wave -noupdate /main/DUT/U_WRNode_Core/U_Remote_MQ/U_SI_Wishbone_Slave/irq_config
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/clk_i
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/rst_n_i
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_slave_i
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_slave_o
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_slave_i
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_slave_o
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_irq_o
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/hmq_status_o
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_incoming_in
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_incoming_in
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_incoming_out
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_incoming_out
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_outgoing_in
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_outgoing_in
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/si_outgoing_out
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/host_outgoing_out
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/incoming_stat
add wave -noupdate -expand -group HMQ /main/DUT/U_WRNode_Core/U_Host_MQ/outgoing_stat
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {33994 ns} 0}
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
WaveRestoreZoom {28285 ns} {114301 ns}

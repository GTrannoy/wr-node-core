onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Top /main/DUT/clk_i
add wave -noupdate -group Top /main/DUT/clk_cpu_i
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
add wave -noupdate -group Top /main/DUT/clk_ref_i
add wave -noupdate -group Top /main/DUT/tm_i
add wave -noupdate -group Top /main/DUT/gpio_o
add wave -noupdate -group Top /main/DUT/gpio_i
add wave -noupdate -group Top /main/DUT/host_irq_o
add wave -noupdate -group Top /main/DUT/debug_msg_irq_o
add wave -noupdate -group Top /main/DUT/hac_master_out
add wave -noupdate -group Top /main/DUT/hac_master_in
add wave -noupdate -group Top /main/DUT/si_slave_in
add wave -noupdate -group Top /main/DUT/si_slave_out
add wave -noupdate -group Top /main/DUT/si_master_in
add wave -noupdate -group Top /main/DUT/si_master_out
add wave -noupdate -group Top /main/DUT/cpu_csr_fromwb
add wave -noupdate -group Top /main/DUT/cpu_csr_towb
add wave -noupdate -group Top /main/DUT/hmq_status
add wave -noupdate -group Top /main/DUT/rmq_status
add wave -noupdate -group Top /main/DUT/cpu_index
add wave -noupdate -group Top /main/DUT/cpu_dbg_drdy
add wave -noupdate -group Top /main/DUT/cpu_dbg_dack
add wave -noupdate -group Top /main/DUT/cpu_dbg_msg_data
add wave -noupdate -group Top /main/DUT/dbg_msg_data_read_ack
add wave -noupdate -group Top /main/DUT/cpu_csr_towb_cb
add wave -noupdate -group Top /main/DUT/cpu_gpio_out
add wave -noupdate -group Top /main/DUT/rst_n_ref
add wave -noupdate -group Top /main/DUT/host_remapped_in
add wave -noupdate -group Top /main/DUT/host_remapped_out
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/clk_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/ena_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/wea_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/aa_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/bwea_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/da_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/qa_o
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/enb_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/web_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/ab_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/bweb_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/db_i
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/qb_o
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/qa_int
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/qb_int
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/f
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/addr
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/data
add wave -noupdate -group IRAM /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/U_iram/cmd
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/clk_cpu_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/clk_sys_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/rst_n_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/irq_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dwb_o
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dwb_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/cpu_rst
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/cpu_rst_d
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/core_sel_match
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/im_addr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/im_data
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/im_valid
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/ha_im_addr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/ha_im_wdata
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/ha_im_rdata
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/ha_im_access
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/ha_im_access_d
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/ha_im_write
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/im_addr_muxed
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_addr
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_data_s
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_data_l
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_data_select
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_load
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_store
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_load_done
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_store_done
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_ready
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_cycle_in_progress
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_is_wishbone
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_mem_rdata
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_wb_rdata
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_wb_write
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_select_wb
add wave -noupdate -expand -group Core0 /main/DUT/gen_cpus(0)/U_CPU_Block/gen_with_urv/U_TheCoreCPU/dm_data_write
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {733422271 ps} 0}
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
WaveRestoreZoom {0 ps} {2621440 ns}

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/clk_i
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/rst_n_i
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slots_i
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slots_o
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/stat_i
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/discard_o
add wave -noupdate -group RMQ_ebout -expand /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/ebm_o
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/ebm_i
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/host_slave_i
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/host_slave_o
add wave -noupdate -group RMQ_ebout -height 16 /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/arb_state
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_ready
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_sel
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_done
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_req
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_in
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_stat
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_out
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_discard
add wave -noupdate -group RMQ_ebout -height 16 /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/eb_state
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/eb_write_addr
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/eb_write_start
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/msg_size
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/msg_remaining
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/ack_count
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/ebm_out
add wave -noupdate -group RMQ_ebout /main/DUT/U_WRNode_Core/U_Remote_MQ/U_EB_Output/slot_addr
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/clk_i
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/rst_n_i
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/slave_i
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/slave_stall_o
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/tx_send_now_i
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/master_o
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/master_i
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/tx_flush_o
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/max_ops_i
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/length_i
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/cfg_rec_hdr_i
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/ctrl_fifo_q
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/ctrl_fifo_d
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/ctrl_fifo_empty
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/send_now
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/tx_stb
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/pop_state
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_fifo_q
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_fifo_d
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_fifo_push
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_fifo_pop
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_fifo_full
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_fifo_empty
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/dat
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/adr
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/we
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/stb
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/cyc
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/tx_cyc
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_rec_ack
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_stall
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/adr_wr
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/adr_rd
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/rec_hdr
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/rec_valid
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_aux1
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_aux2
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/op_pop
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_first_rec
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_eb_hdr
add wave -noupdate -group Framer -height 16 /main/DUT/U_WRNode_Etherbone_Master/framer/r_mux_state
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_cnt_ops
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_cnt_pad
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_max_ops_left
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_byte_cnt
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/r_length
add wave -noupdate -group Framer /main/DUT/U_WRNode_Etherbone_Master/framer/s_recgen_slave_i
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/clk_i
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/rst_n_i
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/slave_i
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/slave_o
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/src_i
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/src_o
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_adr_hi
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_cfg_rec_hdr
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/r_drain
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_dat
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_ack
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_err
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_stall
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_rst_n
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/wb_rst_n
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_tx_send_now
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_his_mac
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_my_mac
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_his_ip
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_my_ip
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_his_port
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_my_port
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_tx_stb
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_clear
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_tx_flush
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_skip_stb
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_length
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_max_ops
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_slave_framer_i
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_slave_ctrl_i
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_master_o
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_master_i
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_framer2narrow
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_narrow2framer
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_narrow2tx
add wave -noupdate -group EBM_top /main/DUT/U_WRNode_Etherbone_Master/s_tx2narrow
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/clk_sys_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rst_n_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/clk_ref_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rst_n_ref_i
add wave -noupdate -expand -group CB0 -expand /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/sh_master_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/sh_master_o
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dp_master_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/dp_master_o
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_csr_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_csr_o
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/rmq_ready_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/hmq_ready_i
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_in
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cnx_master_out
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tai_cycles_rd_ack
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/local_regs_in
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/local_regs_out
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_dwb_out
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cpu_dwb_in
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tai_sys
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cycles_sys
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cycles_sys_latched
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tai_ref
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/cycles_ref
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_p_ref
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_ready_ref
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_p_sys
add wave -noupdate -expand -group CB0 /main/DUT/U_WRNode_Core/gen_cpus(0)/U_CPU_Block/tm_p_ref_d0
add wave -noupdate /main/tai
add wave -noupdate /main/cycles
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65444 ns} 0}
configure wave -namecolwidth 485
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
WaveRestoreZoom {40892 ns} {124860 ns}

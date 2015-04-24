onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/clk_i
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/nRst_i
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/snk_i
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/snk_o
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/src_o
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/src_i
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/cfg_slave_o
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/cfg_slave_i
add wave -noupdate -group ebs -expand -subitemconfig {/main/DUT/U_WRNode_Etherbone_Slave/master_o.adr -expand} /main/DUT/U_WRNode_Etherbone_Slave/master_o
add wave -noupdate -group ebs /main/DUT/U_WRNode_Etherbone_Slave/master_i
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/clk_i
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/rst_n_i
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/si_slave_i
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/si_slave_o
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/ebm_master_o
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/ebm_master_i
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/ebs_slave_o
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/ebs_slave_i
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/rmq_status_o
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/si_incoming_in
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_incoming_in
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/si_incoming_out
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_incoming_out
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/si_outgoing_in
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_in
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/si_outgoing_out
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_out
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/incoming_stat
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/outgoing_stat
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/eb_outgoing_discard
add wave -noupdate -expand -group rmq /main/DUT/U_WRNode_Core/U_Remote_MQ/rmq_status
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/clk_i
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/rst_n_i
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/slave_i
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/slave_o
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/src_i
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/src_o
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_adr_hi
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_cfg_rec_hdr
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/r_drain
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_dat
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_ack
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_err
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_stall
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_rst_n
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/wb_rst_n
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_tx_send_now
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_his_mac
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_my_mac
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_his_ip
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_my_ip
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_his_port
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_my_port
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_tx_stb
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_clear
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_tx_flush
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_skip_stb
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_length
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_max_ops
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_slave_framer_i
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_slave_ctrl_i
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_master_o
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_master_i
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_framer2narrow
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_narrow2framer
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_narrow2tx
add wave -noupdate -expand -group ebm /main/DUT/U_WRNode_Etherbone_Master/s_tx2narrow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {188923 ns} 0}
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
WaveRestoreZoom {20231 ns} {104199 ns}

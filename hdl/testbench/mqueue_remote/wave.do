onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Top /main/DUT/clk_i
add wave -noupdate -group Top /main/DUT/rst_n_i
add wave -noupdate -group Top /main/DUT/si_slave_i
add wave -noupdate -group Top /main/DUT/si_slave_o
add wave -noupdate -group Top -expand /main/DUT/ebm_master_o
add wave -noupdate -group Top -expand /main/DUT/ebm_master_i
add wave -noupdate -group Top /main/DUT/ebs_slave_o
add wave -noupdate -group Top /main/DUT/ebs_slave_i
add wave -noupdate -group Top /main/DUT/rmq_status_o
add wave -noupdate -group Top /main/DUT/si_incoming_in
add wave -noupdate -group Top /main/DUT/eb_incoming_in
add wave -noupdate -group Top /main/DUT/si_incoming_out
add wave -noupdate -group Top /main/DUT/eb_incoming_out
add wave -noupdate -group Top /main/DUT/si_outgoing_in
add wave -noupdate -group Top /main/DUT/eb_outgoing_in
add wave -noupdate -group Top /main/DUT/si_outgoing_out
add wave -noupdate -group Top /main/DUT/eb_outgoing_out
add wave -noupdate -group Top /main/DUT/incoming_stat
add wave -noupdate -group Top /main/DUT/outgoing_stat
add wave -noupdate -group Top /main/DUT/eb_outgoing_discard
add wave -noupdate -group EBS /main/U_Slave/clk_i
add wave -noupdate -group EBS /main/U_Slave/nRst_i
add wave -noupdate -group EBS /main/U_Slave/snk_i
add wave -noupdate -group EBS /main/U_Slave/snk_o
add wave -noupdate -group EBS /main/U_Slave/src_o
add wave -noupdate -group EBS /main/U_Slave/src_i
add wave -noupdate -group EBS /main/U_Slave/cfg_slave_o
add wave -noupdate -group EBS /main/U_Slave/cfg_slave_i
add wave -noupdate -group EBS /main/U_Slave/master_o
add wave -noupdate -group EBS /main/U_Slave/master_i
add wave -noupdate -group EBS /main/U_Slave/s_his_mac
add wave -noupdate -group EBS /main/U_Slave/s_my_mac
add wave -noupdate -group EBS /main/U_Slave/s_his_ip
add wave -noupdate -group EBS /main/U_Slave/s_my_ip
add wave -noupdate -group EBS /main/U_Slave/s_his_port
add wave -noupdate -group EBS /main/U_Slave/s_my_port
add wave -noupdate -group EBS /main/U_Slave/s_tx_stb
add wave -noupdate -group EBS /main/U_Slave/s_tx_stall
add wave -noupdate -group EBS /main/U_Slave/s_skip_stb
add wave -noupdate -group EBS /main/U_Slave/s_skip_stall
add wave -noupdate -group EBS /main/U_Slave/s_length
add wave -noupdate -group EBS /main/U_Slave/s_rx2widen
add wave -noupdate -group EBS /main/U_Slave/s_widen2rx
add wave -noupdate -group EBS /main/U_Slave/s_widen2fsm
add wave -noupdate -group EBS /main/U_Slave/s_fsm2widen
add wave -noupdate -group EBS /main/U_Slave/s_fsm2narrow
add wave -noupdate -group EBS /main/U_Slave/s_narrow2fsm
add wave -noupdate -group EBS /main/U_Slave/s_narrow2tx
add wave -noupdate -group EBS /main/U_Slave/s_tx2narrow
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/clk_i
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/rst_n_i
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slots_i
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slots_o
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/stat_i
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/discard_o
add wave -noupdate -expand -group RMQ_EB_Out -expand /main/DUT/U_EB_Output/ebm_o
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/ebm_i
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/host_slave_i
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/host_slave_o
add wave -noupdate -expand -group RMQ_EB_Out -height 16 /main/DUT/U_EB_Output/arb_state
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_ready
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_sel
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_done
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_req
add wave -noupdate -expand -group RMQ_EB_Out -expand /main/DUT/U_EB_Output/slot_in
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_stat
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_out
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_discard
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/ack_count
add wave -noupdate -expand -group RMQ_EB_Out -height 16 /main/DUT/U_EB_Output/eb_state
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/eb_write_addr
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/msg_size
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_addr
add wave -noupdate -expand -group EBM /main/EBM/clk_i
add wave -noupdate -expand -group EBM /main/EBM/rst_n_i
add wave -noupdate -expand -group EBM /main/EBM/slave_i
add wave -noupdate -expand -group EBM /main/EBM/slave_o
add wave -noupdate -expand -group EBM /main/EBM/src_i
add wave -noupdate -expand -group EBM /main/EBM/src_o
add wave -noupdate -expand -group EBM /main/EBM/s_adr_hi
add wave -noupdate -expand -group EBM /main/EBM/s_cfg_rec_hdr
add wave -noupdate -expand -group EBM /main/EBM/r_drain
add wave -noupdate -expand -group EBM /main/EBM/s_dat
add wave -noupdate -expand -group EBM /main/EBM/s_ack
add wave -noupdate -expand -group EBM /main/EBM/s_err
add wave -noupdate -expand -group EBM /main/EBM/s_stall
add wave -noupdate -expand -group EBM /main/EBM/s_rst_n
add wave -noupdate -expand -group EBM /main/EBM/wb_rst_n
add wave -noupdate -expand -group EBM /main/EBM/s_tx_send_now
add wave -noupdate -expand -group EBM /main/EBM/s_his_mac
add wave -noupdate -expand -group EBM /main/EBM/s_my_mac
add wave -noupdate -expand -group EBM /main/EBM/s_his_ip
add wave -noupdate -expand -group EBM /main/EBM/s_my_ip
add wave -noupdate -expand -group EBM /main/EBM/s_his_port
add wave -noupdate -expand -group EBM /main/EBM/s_my_port
add wave -noupdate -expand -group EBM /main/EBM/s_tx_stb
add wave -noupdate -expand -group EBM /main/EBM/s_clear
add wave -noupdate -expand -group EBM /main/EBM/s_tx_flush
add wave -noupdate -expand -group EBM /main/EBM/s_skip_stb
add wave -noupdate -expand -group EBM /main/EBM/s_length
add wave -noupdate -expand -group EBM /main/EBM/s_max_ops
add wave -noupdate -expand -group EBM /main/EBM/s_slave_framer_i
add wave -noupdate -expand -group EBM /main/EBM/s_slave_ctrl_i
add wave -noupdate -expand -group EBM /main/EBM/s_master_o
add wave -noupdate -expand -group EBM /main/EBM/s_master_i
add wave -noupdate -expand -group EBM /main/EBM/s_framer2narrow
add wave -noupdate -expand -group EBM /main/EBM/s_narrow2framer
add wave -noupdate -expand -group EBM /main/EBM/s_narrow2tx
add wave -noupdate -expand -group EBM /main/EBM/s_tx2narrow
add wave -noupdate -expand -group Framer /main/EBM/framer/clk_i
add wave -noupdate -expand -group Framer /main/EBM/framer/rst_n_i
add wave -noupdate -expand -group Framer /main/EBM/framer/slave_i
add wave -noupdate -expand -group Framer /main/EBM/framer/slave_stall_o
add wave -noupdate -expand -group Framer /main/EBM/framer/tx_send_now_i
add wave -noupdate -expand -group Framer /main/EBM/framer/master_o
add wave -noupdate -expand -group Framer /main/EBM/framer/master_i
add wave -noupdate -expand -group Framer /main/EBM/framer/tx_flush_o
add wave -noupdate -expand -group Framer /main/EBM/framer/max_ops_i
add wave -noupdate -expand -group Framer /main/EBM/framer/length_i
add wave -noupdate -expand -group Framer /main/EBM/framer/cfg_rec_hdr_i
add wave -noupdate -expand -group Framer /main/EBM/framer/ctrl_fifo_q
add wave -noupdate -expand -group Framer /main/EBM/framer/ctrl_fifo_d
add wave -noupdate -expand -group Framer /main/EBM/framer/ctrl_fifo_empty
add wave -noupdate -expand -group Framer /main/EBM/framer/send_now
add wave -noupdate -expand -group Framer /main/EBM/framer/tx_stb
add wave -noupdate -expand -group Framer /main/EBM/framer/pop_state
add wave -noupdate -expand -group Framer /main/EBM/framer/op_fifo_q
add wave -noupdate -expand -group Framer /main/EBM/framer/op_fifo_d
add wave -noupdate -expand -group Framer /main/EBM/framer/op_fifo_push
add wave -noupdate -expand -group Framer /main/EBM/framer/op_fifo_pop
add wave -noupdate -expand -group Framer /main/EBM/framer/op_fifo_full
add wave -noupdate -expand -group Framer /main/EBM/framer/op_fifo_empty
add wave -noupdate -expand -group Framer /main/EBM/framer/dat
add wave -noupdate -expand -group Framer /main/EBM/framer/adr
add wave -noupdate -expand -group Framer /main/EBM/framer/we
add wave -noupdate -expand -group Framer /main/EBM/framer/stb
add wave -noupdate -expand -group Framer /main/EBM/framer/cyc
add wave -noupdate -expand -group Framer /main/EBM/framer/tx_cyc
add wave -noupdate -expand -group Framer /main/EBM/framer/r_rec_ack
add wave -noupdate -expand -group Framer /main/EBM/framer/r_stall
add wave -noupdate -expand -group Framer /main/EBM/framer/adr_wr
add wave -noupdate -expand -group Framer /main/EBM/framer/adr_rd
add wave -noupdate -expand -group Framer /main/EBM/framer/rec_hdr
add wave -noupdate -expand -group Framer /main/EBM/framer/rec_valid
add wave -noupdate -expand -group Framer /main/EBM/framer/op_aux1
add wave -noupdate -expand -group Framer /main/EBM/framer/op_aux2
add wave -noupdate -expand -group Framer /main/EBM/framer/op_pop
add wave -noupdate -expand -group Framer /main/EBM/framer/r_first_rec
add wave -noupdate -expand -group Framer /main/EBM/framer/r_eb_hdr
add wave -noupdate -expand -group Framer /main/EBM/framer/r_mux_state
add wave -noupdate -expand -group Framer /main/EBM/framer/r_cnt_ops
add wave -noupdate -expand -group Framer /main/EBM/framer/r_cnt_pad
add wave -noupdate -expand -group Framer /main/EBM/framer/r_max_ops_left
add wave -noupdate -expand -group Framer /main/EBM/framer/r_byte_cnt
add wave -noupdate -expand -group Framer /main/EBM/framer/r_length
add wave -noupdate -expand -group Framer /main/EBM/framer/s_recgen_slave_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12112 ns} 0}
configure wave -namecolwidth 289
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
WaveRestoreZoom {9655 ns} {15671 ns}

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
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_stat
add wave -noupdate -expand -group RMQ_EB_Out -expand /main/DUT/U_EB_Output/slot_in
add wave -noupdate -expand -group RMQ_EB_Out -expand /main/DUT/U_EB_Output/slot_out
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_discard
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/ack_count
add wave -noupdate -expand -group RMQ_EB_Out -height 16 /main/DUT/U_EB_Output/eb_state
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/eb_write_addr
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/msg_size
add wave -noupdate -expand -group RMQ_EB_Out /main/DUT/U_EB_Output/slot_addr
add wave -noupdate -group EBM /main/EBM/clk_i
add wave -noupdate -group EBM /main/EBM/rst_n_i
add wave -noupdate -group EBM -expand /main/EBM/slave_i
add wave -noupdate -group EBM -expand /main/EBM/slave_o
add wave -noupdate -group EBM /main/EBM/framer_in
add wave -noupdate -group EBM /main/EBM/framer_out
add wave -noupdate -group EBM /main/EBM/src_i
add wave -noupdate -group EBM /main/EBM/src_o
add wave -noupdate -group EBM /main/EBM/s_adr_hi
add wave -noupdate -group EBM /main/EBM/s_cfg_rec_hdr
add wave -noupdate -group EBM /main/EBM/s_rst_n
add wave -noupdate -group EBM /main/EBM/s_tx_send_now
add wave -noupdate -group EBM /main/EBM/s_byte_cnt
add wave -noupdate -group EBM /main/EBM/s_ovf
add wave -noupdate -group EBM /main/EBM/s_his_mac
add wave -noupdate -group EBM /main/EBM/s_my_mac
add wave -noupdate -group EBM /main/EBM/s_his_ip
add wave -noupdate -group EBM /main/EBM/s_my_ip
add wave -noupdate -group EBM /main/EBM/s_his_port
add wave -noupdate -group EBM /main/EBM/s_my_port
add wave -noupdate -group EBM /main/EBM/s_tx_stb
add wave -noupdate -group EBM /main/EBM/s_clear
add wave -noupdate -group EBM /main/EBM/s_test
add wave -noupdate -group EBM /main/EBM/s_tx_flush
add wave -noupdate -group EBM /main/EBM/s_udp
add wave -noupdate -group EBM /main/EBM/r_udp_raw
add wave -noupdate -group EBM /main/EBM/s_skip_stb
add wave -noupdate -group EBM /main/EBM/s_length
add wave -noupdate -group EBM /main/EBM/s_max_ops
add wave -noupdate -group EBM /main/EBM/s_udp_raw_o
add wave -noupdate -group EBM /main/EBM/s_udp_we_o
add wave -noupdate -group EBM /main/EBM/s_udp_valid_i
add wave -noupdate -group EBM /main/EBM/s_udp_data_o
add wave -noupdate -group EBM /main/EBM/s_framer_in
add wave -noupdate -group EBM /main/EBM/s_framer_out
add wave -noupdate -group EBM -expand /main/EBM/s_ctrl_in
add wave -noupdate -group EBM -expand /main/EBM/s_ctrl_out
add wave -noupdate -group EBM /main/EBM/s_narrow_in
add wave -noupdate -group EBM /main/EBM/s_narrow_out
add wave -noupdate -group EBM /main/EBM/s_framer2narrow
add wave -noupdate -group EBM /main/EBM/s_narrow2framer
add wave -noupdate -group EBM /main/EBM/s_narrow2tx
add wave -noupdate -group EBM /main/EBM/s_tx2narrow
add wave -noupdate -group EBM /main/EBM/cbar_slaveport_in
add wave -noupdate -group EBM /main/EBM/cbar_slaveport_out
add wave -noupdate -group EBM -expand -subitemconfig {/main/EBM/cbar_masterport_in(1) -expand} /main/EBM/cbar_masterport_in
add wave -noupdate -group EBM /main/EBM/cbar_masterport_out
add wave -noupdate -expand -group Framer /main/EBM/framer/clk_i
add wave -noupdate -expand -group Framer /main/EBM/framer/rst_n_i
add wave -noupdate -expand -group Framer -expand /main/EBM/framer/slave_i
add wave -noupdate -expand -group Framer -expand /main/EBM/framer/slave_o
add wave -noupdate -expand -group Framer /main/EBM/framer/master_o
add wave -noupdate -expand -group Framer /main/EBM/framer/master_i
add wave -noupdate -expand -group Framer /main/EBM/framer/byte_cnt_o
add wave -noupdate -expand -group Framer /main/EBM/framer/ovf_o
add wave -noupdate -expand -group Framer /main/EBM/framer/tx_send_now_i
add wave -noupdate -expand -group Framer /main/EBM/framer/tx_flush_o
add wave -noupdate -expand -group Framer /main/EBM/framer/max_ops_i
add wave -noupdate -expand -group Framer /main/EBM/framer/length_i
add wave -noupdate -expand -group Framer /main/EBM/framer/cfg_rec_hdr_i
add wave -noupdate -expand -group Framer /main/EBM/framer/ctrl_fifo_q
add wave -noupdate -expand -group Framer /main/EBM/framer/ctrl_fifo_d
add wave -noupdate -expand -group Framer /main/EBM/framer/ctrl_fifo_empty
add wave -noupdate -expand -group Framer /main/EBM/framer/s_slave_stall
add wave -noupdate -expand -group Framer /main/EBM/framer/s_tx_send_now
add wave -noupdate -expand -group Framer /main/EBM/framer/r_tx_send_now
add wave -noupdate -expand -group Framer /main/EBM/framer/send_now
add wave -noupdate -expand -group Framer /main/EBM/framer/tx_stb
add wave -noupdate -expand -group Framer /main/EBM/framer/r_pop_req
add wave -noupdate -expand -group Framer /main/EBM/framer/r_pop_cmd
add wave -noupdate -expand -group Framer /main/EBM/framer/r_abort
add wave -noupdate -expand -group Framer /main/EBM/framer/s_space_sufficient
add wave -noupdate -expand -group Framer /main/EBM/framer/s_rec_byte_cnt
add wave -noupdate -expand -group Framer /main/EBM/framer/r_rec_byte_cnt
add wave -noupdate -expand -group Framer /main/EBM/framer/s_word_cnt
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
add wave -noupdate -expand -group Framer /main/EBM/framer/r_ack
add wave -noupdate -expand -group Framer /main/EBM/framer/r_err
add wave -noupdate -expand -group Framer /main/EBM/framer/r_ovf
add wave -noupdate -expand -group Framer /main/EBM/framer/tx_cyc
add wave -noupdate -expand -group Framer /main/EBM/framer/r_rec_ack
add wave -noupdate -expand -group Framer /main/EBM/framer/s_recgen_slave_stall
add wave -noupdate -expand -group Framer /main/EBM/framer/s_recgen_slave_ack
add wave -noupdate -expand -group Framer /main/EBM/framer/adr_wr
add wave -noupdate -expand -group Framer /main/EBM/framer/adr_rd
add wave -noupdate -expand -group Framer /main/EBM/framer/rec_hdr
add wave -noupdate -expand -group Framer /main/EBM/framer/rec_valid
add wave -noupdate -expand -group Framer /main/EBM/framer/r_first_rec
add wave -noupdate -expand -group Framer /main/EBM/framer/r_eb_hdr
add wave -noupdate -expand -group Framer /main/EBM/framer/r_mux_state
add wave -noupdate -expand -group Framer /main/EBM/framer/r_cnt_ops
add wave -noupdate -expand -group Framer /main/EBM/framer/r_cnt_pad
add wave -noupdate -expand -group Framer /main/EBM/framer/r_byte_cnt
add wave -noupdate -expand -group Framer /main/EBM/framer/s_recgen_slave_i
add wave -noupdate -expand -group WbIF /main/EBM/wbif/clk_i
add wave -noupdate -expand -group WbIF /main/EBM/wbif/rst_n_i
add wave -noupdate -expand -group WbIF -expand /main/EBM/wbif/slave_i
add wave -noupdate -expand -group WbIF -expand /main/EBM/wbif/slave_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/byte_cnt_i
add wave -noupdate -expand -group WbIF /main/EBM/wbif/error_i
add wave -noupdate -expand -group WbIF /main/EBM/wbif/clear_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/flush_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/my_mac_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/my_ip_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/my_port_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/his_mac_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/his_ip_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/his_port_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/length_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/max_ops_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/adr_hi_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/eb_opt_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/udp_raw_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/udp_we_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/udp_valid_i
add wave -noupdate -expand -group WbIF /main/EBM/wbif/udp_data_o
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_slave_out_ack
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_slave_out_err
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_stall
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_slave_out_dat
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_stat
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_clr
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_flush
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_his_mac
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_my_mac
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_his_ip
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_my_ip
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_his_port
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_my_port
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_ops_max
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_length
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_adr_hi
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_eb_opt
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_sema
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_udp_raw
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_udp_data
add wave -noupdate -expand -group WbIF /main/EBM/wbif/r_udp_we
add wave -noupdate -expand -group WbIF /main/EBM/wbif/a_my_mac_lo
add wave -noupdate -expand -group WbIF /main/EBM/wbif/a_my_mac_hi
add wave -noupdate -expand -group WbIF /main/EBM/wbif/a_his_mac_lo
add wave -noupdate -expand -group WbIF /main/EBM/wbif/a_his_mac_hi
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1680 ns} 0}
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
WaveRestoreZoom {1606 ns} {1798 ns}

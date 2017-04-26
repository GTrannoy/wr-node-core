onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/clk_i
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/rst_n_i
add wave -noupdate -group RMQ -expand /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/si_slave_i
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/si_slave_o
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/src_o
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/src_i
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/snk_o
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/snk_i
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/wr_snk_i
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/wr_snk_o
add wave -noupdate -group RMQ -expand /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/wr_src_i
add wave -noupdate -group RMQ -expand /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/wr_src_o
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/rmq_swrst_o
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/rmq_status_o
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/debug_o
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/si_incoming_in
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/si_incoming_out
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/si_outgoing_in
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/si_outgoing_out
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/incoming_stat
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/outgoing_stat
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/rmq_status
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/rmq_swrst_vec
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/out_req
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/out_grant
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/out_snks_ins
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/out_snks_outs
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/out_cfgs
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/snk_in
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/snk_out
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/p_header
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/p_header_valid
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/mt_snk_in
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/mt_snk_out
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/mt_src_in
add wave -noupdate -group RMQ /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/mt_src_out
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/clk_i
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rst_n_i
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/stat_o
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/inb_i
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/inb_o
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/config_o
add wave -noupdate -group slot0 -expand /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/src_o
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/src_i
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/tx_req_o
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/tx_grant_i
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rmq_swrst_o
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/out_discard_i
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_raddr
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_waddr
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_wdata
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_rdata_in
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_rdata_out
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_ptr
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/wr_ptr
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/occupied
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/words_written
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_we
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/full
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/empty
add wave -noupdate -group slot0 -height 16 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/wr_state
add wave -noupdate -group slot0 -height 16 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_state
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_claim
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_purge
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_ready
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_enqueue
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_commit
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_cmd_wr
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_stat_rd
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/status
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/q_read
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/q_write
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/n_words_last
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/config
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_count
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_count_next
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/wr_mem_offset
add wave -noupdate -group slot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/wr_mem_valid
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/clk_i
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/rst_n_i
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/snk_i
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/snk_o
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/src_i
add wave -noupdate -group WrSource -expand /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/src_o
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/q_valid
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/full
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/we
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/rd
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/rd_d0
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/fin
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/fout
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/pre_dvalid
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/pre_eof
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/pre_data
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/pre_addr
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/post_dvalid
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/post_eof
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/post_bytesel
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/post_sof
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/err_status
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/cyc_int
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/cyc_next
add wave -noupdate -group WrSource /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Source/status_sent
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/clk_i
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/rst_n_i
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/rmq_swrst_i
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/snks_i
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/snks_o
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/cfgs_i
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/tx_req_i
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/tx_grant_o
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/src_o
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/src_i
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/debug_o
add wave -noupdate -group PktOut -height 16 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/arb_state
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_ready
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_sel
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_done
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_req
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_in
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_stat
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_out
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_discard
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/rst_n_int
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/src_out
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/src_in
add wave -noupdate -group PktOut /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/U_Packet_Output/config
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/clk_ref_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/clk_sys_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/clk_dmtd_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rst_sys_n_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rst_ref_n_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rst_dmtd_n_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rst_txclk_n_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rst_rxclk_n_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pps_csync_p1_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pps_valid_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_rst_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_loopen_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_loopen_vec_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_tx_prbs_sel_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_sfp_tx_fault_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_sfp_los_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_sfp_tx_disable_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_rdy_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_ref_clk_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_tx_data_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_tx_k_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_tx_disparity_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_tx_enc_err_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_rx_data_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_rx_clk_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_rx_k_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_rx_enc_err_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phy_rx_bitslide_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/gmii_tx_clk_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/gmii_txd_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/gmii_tx_en_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/gmii_tx_er_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/gmii_rx_clk_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/gmii_rxd_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/gmii_rx_er_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/gmii_rx_dv_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_dat_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_adr_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_sel_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_cyc_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_stb_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_we_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_stall_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_ack_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_err_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_dat_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_adr_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_sel_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_cyc_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_stb_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_we_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_stall_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_ack_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_err_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/snk_rty_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txtsu_port_id_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txtsu_frame_id_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txtsu_ts_value_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txtsu_ts_incorrect_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txtsu_stb_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txtsu_ack_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_full_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_almost_full_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq_strobe_p1_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq_abort_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq_smac_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq_dmac_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq_vid_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq_has_vid_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq_prio_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq_has_prio_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_cyc_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_stb_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_we_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_sel_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_adr_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_dat_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_dat_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_ack_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_stall_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pfilter_pclass_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pfilter_drop_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pfilter_done_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/fc_tx_pause_req_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/fc_tx_pause_delay_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/fc_tx_pause_ready_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/fc_rx_pause_start_p_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/fc_rx_pause_quanta_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/fc_rx_pause_prio_mask_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/fc_rx_buffer_occupation_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/inject_req_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/inject_ready_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/inject_packet_sel_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/inject_user_value_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rmon_events_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/led_link_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/led_act_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/link_kill_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/link_up_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/stop_traffic_i
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/dbg_tx_pcs_wr_count_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/dbg_tx_pcs_rd_count_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/nice_dbg_o
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txpcs_fab
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txpcs_dreq
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txpcs_error
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txpcs_busy
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txoob_fid_value
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txoob_fid_stb
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txpcs_timestamp_trigger_p_a
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txts_timestamp_stb
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txts_timestamp_valid
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txts_timestamp_value
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxpcs_timestamp_stb
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxpcs_timestamp_trigger_p_a
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxpcs_timestamp_valid
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxpcs_timestamp_value
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxpcs_fab
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxpath_fab
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxpcs_busy
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxpcs_fifo_almostfull
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_fromwb
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_towb
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_towb_ep
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_towb_tsu
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_towb_rpath
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_towb_tpath
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/regs_towb_dmtd
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txfra_flow_enable
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxfra_pause_p
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rxfra_pause_delay
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txfra_pause_req
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txfra_pause_ready
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txfra_pause_delay
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/link_ok
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/txfra_enable
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/mdio_addr
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/sink_in
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/sink_out
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_in
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/src_out
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rst_n_rx
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_in
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/wb_out
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/extended_ADDR
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phase_meas
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/phase_meas_p
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/validity_cntr
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/r_dmcr_en
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/r_dmcr_n_avg
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rtu_rq
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/dvalid_tx
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/dvalid_rx
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/ep_ctrl
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pfilter_pclass
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pfilter_drop
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pfilter_done
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/tx_pclass
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/pcs_rmon
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rx_path_rmon
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/rmon
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/CONTROL0
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/TRIG0
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/TRIG1
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/TRIG2
add wave -noupdate -group EP /main/DUT/U_Node_Template/gen_with_wr/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/TRIG3
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/clk_i
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/rst_n_i
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/snk_i
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/snk_o
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/src_o
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/src_i
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/q_valid
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/full
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/we
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/rd
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/fin
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/fout
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/fout_reg
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/cyc_d0
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/rd_d0
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/pre_sof
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/pre_eof
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/pre_bytesel
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/pre_dvalid
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/post_sof
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/post_dvalid
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/post_addr
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/post_data
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/snk_out
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/data_present
add wave -noupdate -group WrSink /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_with_wr_fabric/U_WR_Sink/is_data
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/clk_i
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/rst_n_i
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/stat_o
add wave -noupdate -expand -group InSlot0 -expand /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/outb_i
add wave -noupdate -expand -group InSlot0 -expand /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/outb_o
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/snk_i
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/snk_o
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/p_header_valid_i
add wave -noupdate -expand -group InSlot0 -expand /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/p_header_i
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_discard_i
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_raddr
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_waddr_hdr
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_waddr_payload
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_waddr
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_wdata
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_rdata_in
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_rdata_out
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/rd_ptr
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/wr_ptr
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/occupied
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/words_written
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_we
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/full
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/empty
add wave -noupdate -expand -group InSlot0 -height 16 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/wr_state
add wave -noupdate -expand -group InSlot0 -height 16 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/rd_state
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_cmd_wr
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_stat_rd
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_cmd_wr
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_stat_rd
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/status
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/current_size
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_discard
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_purge
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/q_read
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/q_write
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/n_words_last
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/config
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_type0
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_type1
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_type2
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_type3
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_dst_mac
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_dst_ip
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_udp
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_ethertype
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_dst_port
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_raw
add wave -noupdate -expand -group InSlot0 /main/DUT/U_Node_Template/gen_wr_node_with_white_rabbit/U_Mock_Turtle/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {603140000000 fs} 0}
configure wave -namecolwidth 249
configure wave -valuecolwidth 44
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
WaveRestoreZoom {587364689860 fs} {618803256260 fs}

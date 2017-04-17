onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_cpu_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_sys_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/rst_n_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/irq_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_o
add wave -noupdate -group CPU0 -expand /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_i
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_csr_o
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_clk
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_update
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_q
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_q
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_d
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/jtag_reg_addr_d
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_enable
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_reset_n
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_rdata
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/host_write
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/d_adr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/core_sel_match
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_wr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_wr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_en_cpu
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_en
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_cpu
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_adr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_addr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_adr_host
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_q
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_i_dat_d
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_d
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_q
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_sel
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_out_sys
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/cpu_dwb_in_sys
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bwe
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wr_d
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/data_d0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_d_dat_out
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_load_d0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_wr
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_out
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/udata_in
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/clk_div2_d0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_dat_d0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_io_sync_ext
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_ack_d0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/wb_cyc_d0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/iram_bwe
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/dwb_out
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/CONTROL
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/CLK
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG0
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG1
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG2
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/TRIG3
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bus_timeout
add wave -noupdate -group CPU0 /main/DUT/gen_cpus(0)/U_CPU_Block/U_TheCoreCPU/bus_timeout_hit
add wave -noupdate -group Top /main/DUT/clk_i
add wave -noupdate -group Top /main/DUT/clk_cpu_i
add wave -noupdate -group Top /main/DUT/rst_n_i
add wave -noupdate -group Top /main/DUT/sp_master_o
add wave -noupdate -group Top /main/DUT/sp_master_i
add wave -noupdate -group Top /main/DUT/dp_master_o
add wave -noupdate -group Top /main/DUT/dp_master_i
add wave -noupdate -group Top /main/DUT/rmq_src_o
add wave -noupdate -group Top /main/DUT/rmq_src_i
add wave -noupdate -group Top /main/DUT/host_slave_i
add wave -noupdate -group Top /main/DUT/host_slave_o
add wave -noupdate -group Top /main/DUT/clk_ref_i
add wave -noupdate -group Top /main/DUT/tm_i
add wave -noupdate -group Top /main/DUT/gpio_o
add wave -noupdate -group Top /main/DUT/gpio_i
add wave -noupdate -group Top /main/DUT/rmq_swrst_o
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
add wave -noupdate -group Top /main/DUT/ebm_master
add wave -noupdate -group Top /main/DUT/CONTROL
add wave -noupdate -group Top /main/DUT/CLK
add wave -noupdate -group Top /main/DUT/TRIG0
add wave -noupdate -group Top /main/DUT/TRIG1
add wave -noupdate -group Top /main/DUT/TRIG2
add wave -noupdate -group Top /main/DUT/TRIG3
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/clk_i
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/rst_n_i
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/si_slave_i
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/si_slave_o
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/src_o
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/src_i
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/rmq_swrst_o
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/rmq_status_o
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/debug_o
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/si_incoming_in
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/si_incoming_out
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/si_outgoing_in
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/si_outgoing_out
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/incoming_stat
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/outgoing_stat
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/rmq_status
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/rmq_swrst_vec
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/out_req
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/out_grant
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/out_snks_ins
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/out_snks_outs
add wave -noupdate -group RMQ /main/DUT/gen_with_rmq/U_Remote_MQ/out_cfgs
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/clk_i
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rst_n_i
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/stat_o
add wave -noupdate -group OutSlot0 -expand /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/inb_i
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/inb_o
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/config_o
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/src_o
add wave -noupdate -group OutSlot0 -expand /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/src_i
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/tx_req_o
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/tx_grant_i
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rmq_swrst_o
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/out_discard_i
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_raddr
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_waddr
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_wdata
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_rdata_in
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_rdata_out
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_ptr
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/wr_ptr
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/occupied
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/words_written
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_we
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/full
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/empty
add wave -noupdate -group OutSlot0 -height 16 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/wr_state
add wave -noupdate -group OutSlot0 -height 16 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_state
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_claim
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_purge
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_ready
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_enqueue
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_commit
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_cmd_wr
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_stat_rd
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/status
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/q_read
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/q_write
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/n_words_last
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/config
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_count
add wave -noupdate -group OutSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_count_next
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/clk_i
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/rst_n_i
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/rmq_swrst_i
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/snks_i
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/snks_o
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/cfgs_i
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/tx_req_i
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/tx_grant_o
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/src_o
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/src_i
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/debug_o
add wave -noupdate -group PacketOutput -height 16 /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/arb_state
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_ready
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_sel
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_done
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_req
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_in
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_stat
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_out
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/slot_discard
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/rst_n_int
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/src_out
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/src_in
add wave -noupdate -group PacketOutput /main/DUT/gen_with_rmq/U_Remote_MQ/U_Packet_Output/config
add wave -noupdate -group SRC /main/SRC/clk_i
add wave -noupdate -group SRC /main/SRC/rst_n_i
add wave -noupdate -group SRC /main/SRC/src_i
add wave -noupdate -group SRC -expand /main/SRC/src_o
add wave -noupdate -group SRC /main/SRC/valid_d
add wave -noupdate -group SRC /main/SRC/seed
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/clk_i
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/rst_n_i
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/snk_i
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/snk_o
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/src_i
add wave -noupdate -group RXPath -expand /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/src_o
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/p_header_valid_o
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/p_header_o
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/fwd_pipe
add wave -noupdate -group RXPath /main/DUT/gen_with_rmq/U_Remote_MQ/U_RX_Path/rev_pipe
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/clk_i
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/rst_n_i
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/stat_o
add wave -noupdate -expand -group InSlot0 -expand /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/outb_i
add wave -noupdate -expand -group InSlot0 -expand /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/outb_o
add wave -noupdate -expand -group InSlot0 -expand /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/snk_i
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/snk_o
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/p_header_valid_i
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/p_header_i
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_discard_i
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_raddr
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_waddr
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_wdata
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_rdata_in
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_rdata_out
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_waddr_hdr
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_waddr_payload
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/rd_ptr
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/wr_ptr
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/occupied
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/words_written
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/mem_we
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/full
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/empty
add wave -noupdate -expand -group InSlot0 -height 16 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/wr_state
add wave -noupdate -expand -group InSlot0 -height 16 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/rd_state
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_claim
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_purge
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_ready
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_enqueue
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_commit
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_cmd_wr
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/in_stat_rd
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_cmd_wr
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_stat_rd
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/status
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_discard
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/out_purge
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/q_read
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/q_write
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/n_words_last
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/config
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_type0
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_type1
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_type2
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_type3
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_dst_mac
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_dst_ip
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_udp
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_ethertype
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match_dst_port
add wave -noupdate -expand -group InSlot0 /main/DUT/gen_with_rmq/U_Remote_MQ/gen_incoming_slots(0)/U_In_SlotX/match
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {290457 ns} 0}
configure wave -namecolwidth 267
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
WaveRestoreZoom {290286 ns} {290752 ns}

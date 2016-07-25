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
add wave -noupdate -group Top -expand /main/DUT/cpu_csr_towb
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
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/clk_i
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rst_n_i
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/stat_o
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/inb_i
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/inb_o
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/outb_i
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/outb_o
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/out_discard_i
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_raddr
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_waddr
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_wdata
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_rdata_in
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_rdata_out
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_ptr
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/wr_ptr
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/occupied
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/words_written
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/mem_we
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/full
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/empty
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/wr_state
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/rd_state
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_claim
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_purge
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_ready
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_enqueue
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_commit
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_cmd_wr
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/in_stat_rd
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/out_cmd_wr
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/out_stat_rd
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/status
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/out_discard
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/out_purge
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/q_read
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/q_write
add wave -noupdate -expand -group OutSlot0 /main/DUT/U_Host_MQ/gen_outgoing_slots(0)/U_Out_SlotX/n_words_last
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/clk_i
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/rst_n_i
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/si_slave_i
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/si_slave_o
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/host_slave_i
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/host_slave_o
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/host_irq_o
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/hmq_status_o
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/si_incoming_in
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/host_incoming_in
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/si_incoming_out
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/host_incoming_out
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/si_outgoing_in
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/host_outgoing_in
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/si_outgoing_out
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/host_outgoing_out
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/incoming_stat
add wave -noupdate -expand -group HMQ -expand -subitemconfig {/main/DUT/U_Host_MQ/outgoing_stat(0) -expand} /main/DUT/U_Host_MQ/outgoing_stat
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/hmq_status
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/irq_config
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/tmr_div
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/tmr_tick
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/tmr_timeout
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/irq_vec_in
add wave -noupdate -expand -group HMQ /main/DUT/U_Host_MQ/irq_vec_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {175218 ns} 0}
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
WaveRestoreZoom {173892 ns} {176452 ns}

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Top /main/DUT/clk_i
add wave -noupdate -group Top /main/DUT/rst_n_i
add wave -noupdate -group Top /main/DUT/si_slave_i
add wave -noupdate -group Top /main/DUT/si_slave_o
add wave -noupdate -group Top -expand /main/DUT/host_slave_i
add wave -noupdate -group Top -expand /main/DUT/host_slave_o
add wave -noupdate -group Top /main/DUT/host_irq_o
add wave -noupdate -group Top /main/DUT/hmq_status_o
add wave -noupdate -group Top /main/DUT/si_incoming_in
add wave -noupdate -group Top /main/DUT/host_incoming_in
add wave -noupdate -group Top /main/DUT/si_incoming_out
add wave -noupdate -group Top /main/DUT/host_incoming_out
add wave -noupdate -group Top /main/DUT/si_outgoing_in
add wave -noupdate -group Top /main/DUT/host_outgoing_in
add wave -noupdate -group Top /main/DUT/si_outgoing_out
add wave -noupdate -group Top /main/DUT/host_outgoing_out
add wave -noupdate -group Top -expand -subitemconfig {/main/DUT/incoming_stat(0) -expand} /main/DUT/incoming_stat
add wave -noupdate -group Top /main/DUT/outgoing_stat
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/clk_i
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/rst_n_i
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/stat_o
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/inb_i
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/inb_o
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/outb_i
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/outb_o
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/out_discard_i
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/mem_raddr
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/mem_waddr
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/mem_wdata
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/mem_rdata_in
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/mem_rdata_out
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/rd_ptr
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/wr_ptr
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/occupied
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/words_written
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/mem_we
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/full
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/empty
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/wr_state
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/rd_state
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/in_claim
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/in_purge
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/in_ready
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/in_cmd_wr
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/in_stat_rd
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/out_cmd_wr
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/out_stat_rd
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/status
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/out_discard
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/q_read
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/q_write
add wave -noupdate -group InSlot0 /main/DUT/gen_incoming_slots(0)/U_Incoming_SlotX/n_words_last
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/clk_i
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/rst_n_i
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/incoming_status_i
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/outgoing_status_i
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/incoming_o
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/incoming_i
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/outgoing_o
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/outgoing_i
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/slave_i
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/slave_o
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/irq_config_o
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/slot_num
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/slot_num_d0
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/gcr_sel
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/gcr_sel_d0
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/in_area_sel
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/in_area_sel_d0
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/out_area_sel
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/out_area_sel_d0
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/wb_write
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/wb_write_d0
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/wb_read
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/wb_read_d0
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/gcr_rd_data
add wave -noupdate -expand -group HostWBIf /main/DUT/U_Host_Wishbone_Slave/irq_config
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1025 ns} 0}
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
WaveRestoreZoom {883 ns} {1163 ns}

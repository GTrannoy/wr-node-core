onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Top /main/DUT/clk_i
add wave -noupdate -expand -group Top /main/DUT/clk_cpu_i
add wave -noupdate -expand -group Top /main/DUT/rst_n_i
add wave -noupdate -expand -group Top /main/DUT/sp_master_o
add wave -noupdate -expand -group Top /main/DUT/sp_master_i
add wave -noupdate -expand -group Top /main/DUT/dp_master_o
add wave -noupdate -expand -group Top /main/DUT/dp_master_i
add wave -noupdate -expand -group Top /main/DUT/ebm_master_o
add wave -noupdate -expand -group Top /main/DUT/ebm_master_i
add wave -noupdate -expand -group Top /main/DUT/ebs_slave_o
add wave -noupdate -expand -group Top /main/DUT/ebs_slave_i
add wave -noupdate -expand -group Top /main/DUT/host_slave_i
add wave -noupdate -expand -group Top /main/DUT/host_slave_o
add wave -noupdate -expand -group Top /main/DUT/clk_ref_i
add wave -noupdate -expand -group Top /main/DUT/tm_i
add wave -noupdate -expand -group Top /main/DUT/gpio_o
add wave -noupdate -expand -group Top /main/DUT/gpio_i
add wave -noupdate -expand -group Top /main/DUT/host_irq_o
add wave -noupdate -expand -group Top /main/DUT/debug_msg_irq_o
add wave -noupdate -expand -group Top /main/DUT/hac_master_out
add wave -noupdate -expand -group Top /main/DUT/hac_master_in
add wave -noupdate -expand -group Top /main/DUT/si_slave_in
add wave -noupdate -expand -group Top /main/DUT/si_slave_out
add wave -noupdate -expand -group Top /main/DUT/si_master_in
add wave -noupdate -expand -group Top /main/DUT/si_master_out
add wave -noupdate -expand -group Top /main/DUT/cpu_csr_fromwb
add wave -noupdate -expand -group Top /main/DUT/cpu_csr_towb
add wave -noupdate -expand -group Top /main/DUT/hmq_status
add wave -noupdate -expand -group Top /main/DUT/rmq_status
add wave -noupdate -expand -group Top /main/DUT/cpu_index
add wave -noupdate -expand -group Top /main/DUT/cpu_dbg_drdy
add wave -noupdate -expand -group Top /main/DUT/cpu_dbg_dack
add wave -noupdate -expand -group Top /main/DUT/cpu_dbg_msg_data
add wave -noupdate -expand -group Top /main/DUT/dbg_msg_data_read_ack
add wave -noupdate -expand -group Top /main/DUT/cpu_csr_towb_cb
add wave -noupdate -expand -group Top /main/DUT/cpu_gpio_out
add wave -noupdate -expand -group Top /main/DUT/rst_n_ref
add wave -noupdate -expand -group Top /main/DUT/host_remapped_in
add wave -noupdate -expand -group Top /main/DUT/host_remapped_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {54462 ns} 0}
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
WaveRestoreZoom {0 ns} {327680 ns}

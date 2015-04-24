onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group cb /main/DUT/clk_sys_i
add wave -noupdate -expand -group cb /main/DUT/rst_n_i
add wave -noupdate -expand -group cb /main/DUT/clk_ref_i
add wave -noupdate -expand -group cb /main/DUT/rst_n_ref_i
add wave -noupdate -expand -group cb /main/DUT/tm_i
add wave -noupdate -expand -group cb /main/DUT/sh_master_i
add wave -noupdate -expand -group cb /main/DUT/sh_master_o
add wave -noupdate -expand -group cb /main/DUT/dp_master_i
add wave -noupdate -expand -group cb /main/DUT/dp_master_o
add wave -noupdate -expand -group cb /main/DUT/cpu_csr_i
add wave -noupdate -expand -group cb /main/DUT/cpu_csr_o
add wave -noupdate -expand -group cb /main/DUT/rmq_ready_i
add wave -noupdate -expand -group cb /main/DUT/hmq_ready_i
add wave -noupdate -expand -group cb /main/DUT/gpio_i
add wave -noupdate -expand -group cb /main/DUT/gpio_o
add wave -noupdate -expand -group cb /main/DUT/cnx_master_in
add wave -noupdate -expand -group cb /main/DUT/cnx_master_out
add wave -noupdate -expand -group cb /main/DUT/local_regs_in
add wave -noupdate -expand -group cb /main/DUT/local_regs_out
add wave -noupdate -expand -group cb /main/DUT/cpu_dwb_out
add wave -noupdate -expand -group cb /main/DUT/cpu_dwb_in
add wave -noupdate -expand -group cb /main/DUT/tai_sys
add wave -noupdate -expand -group cb /main/DUT/cycles_sys
add wave -noupdate -expand -group cb /main/DUT/tai_ref
add wave -noupdate -expand -group cb /main/DUT/cycles_ref
add wave -noupdate -expand -group cb /main/DUT/tm_p_ref
add wave -noupdate -expand -group cb /main/DUT/tm_ready_ref
add wave -noupdate -expand -group cb /main/DUT/tm_p_sys
add wave -noupdate -expand -group cb /main/DUT/tm_p_ref_d0
add wave -noupdate /main/DUT/tai_sec_rd_ack
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {71154801 ps} 0}
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
WaveRestoreZoom {0 ps} {143360 ns}

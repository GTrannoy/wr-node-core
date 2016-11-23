onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/clk_i
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/rst_n_i
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/slave_i
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/slave_o
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/mem0
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/mem1
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/mem2
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/mem3
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/op_addr
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/op_sel
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/fetch_data
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/result
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/state
add wave -noupdate -expand -group SMEM /main/DUT/U_Shared_Mem/wr_mask
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {160708 ns} 0}
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
WaveRestoreZoom {399392 ns} {400032 ns}

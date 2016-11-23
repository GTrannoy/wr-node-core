onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main/DUT/U_GMT_Converter/clk_sys_i
add wave -noupdate /main/DUT/U_GMT_Converter/clk_wr_i
add wave -noupdate /main/DUT/U_GMT_Converter/clk_40m_i
add wave -noupdate /main/DUT/U_GMT_Converter/rst_n_sys_i
add wave -noupdate /main/DUT/U_GMT_Converter/tm_cycles_i
add wave -noupdate /main/DUT/U_GMT_Converter/tm_tai_i
add wave -noupdate /main/DUT/U_GMT_Converter/tm_valid_i
add wave -noupdate /main/DUT/U_GMT_Converter/gmt_i
add wave -noupdate /main/DUT/U_GMT_Converter/gmt_o
add wave -noupdate /main/DUT/U_GMT_Converter/pps_gmt_a_i
add wave -noupdate /main/DUT/U_GMT_Converter/slave_i
add wave -noupdate /main/DUT/U_GMT_Converter/slave_o
add wave -noupdate /main/DUT/U_GMT_Converter/regs_in
add wave -noupdate /main/DUT/U_GMT_Converter/regs_out
add wave -noupdate /main/DUT/U_GMT_Converter/rx_channels
add wave -noupdate /main/DUT/U_GMT_Converter/rst_n_40m
add wave -noupdate /main/DUT/U_GMT_Converter/rst_n_wr
add wave -noupdate /main/DUT/U_GMT_Converter/pps_gmt_p
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24824487 ps} 0}
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
WaveRestoreZoom {0 ps} {268435456 ps}

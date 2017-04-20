onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main/DUT/clk_i
add wave -noupdate /main/DUT/rst_n_i
add wave -noupdate /main/DUT/snk_i
add wave -noupdate /main/DUT/snk_o
add wave -noupdate /main/DUT/src_i
add wave -noupdate /main/DUT/src_o
add wave -noupdate /main/DUT/q_valid
add wave -noupdate /main/DUT/full
add wave -noupdate /main/DUT/we
add wave -noupdate /main/DUT/rd
add wave -noupdate /main/DUT/rd_d0
add wave -noupdate /main/DUT/fin
add wave -noupdate /main/DUT/fout
add wave -noupdate /main/DUT/pre_dvalid
add wave -noupdate /main/DUT/pre_eof
add wave -noupdate /main/DUT/pre_data
add wave -noupdate /main/DUT/pre_addr
add wave -noupdate /main/DUT/post_dvalid
add wave -noupdate /main/DUT/post_eof
add wave -noupdate /main/DUT/post_bytesel
add wave -noupdate /main/DUT/post_sof
add wave -noupdate /main/DUT/err_status
add wave -noupdate /main/DUT/cyc_int
add wave -noupdate /main/DUT/cyc_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {290457000 ps} 0}
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
WaveRestoreZoom {0 ps} {466 ns}

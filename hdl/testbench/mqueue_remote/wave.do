onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group RX /test_rx_path/DUT/clk_i
add wave -noupdate -expand -group RX /test_rx_path/DUT/rst_n_i
add wave -noupdate -expand -group RX /test_rx_path/DUT/snk_i
add wave -noupdate -expand -group RX /test_rx_path/DUT/snk_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/src_i
add wave -noupdate -expand -group RX /test_rx_path/DUT/src_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_header_valid_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_is_udp_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_is_raw_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_is_tlv_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_src_mac_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_dst_mac_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_ethertype_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_src_port_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_dst_port_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_src_ip_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_dst_ip_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_udp_length_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_tlv_type_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/p_tlv_size_o
add wave -noupdate -expand -group RX /test_rx_path/DUT/dummy
add wave -noupdate -expand -group RX /test_rx_path/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {808 ns} 0}
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
WaveRestoreZoom {0 ns} {3072 ns}

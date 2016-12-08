onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Path /test_tx_path/DUT/clk_i
add wave -noupdate -group Path /test_tx_path/DUT/rst_n_i
add wave -noupdate -group Path -expand /test_tx_path/DUT/snk_i
add wave -noupdate -group Path -expand /test_tx_path/DUT/snk_o
add wave -noupdate -group Path /test_tx_path/DUT/src_i
add wave -noupdate -group Path /test_tx_path/DUT/src_o
add wave -noupdate -group Path /test_tx_path/DUT/p_use_udp_i
add wave -noupdate -group Path /test_tx_path/DUT/p_dst_mac_i
add wave -noupdate -group Path /test_tx_path/DUT/p_ethertype_i
add wave -noupdate -group Path /test_tx_path/DUT/p_src_port_i
add wave -noupdate -group Path /test_tx_path/DUT/p_dst_port_i
add wave -noupdate -group Path /test_tx_path/DUT/p_src_ip_i
add wave -noupdate -group Path /test_tx_path/DUT/p_dst_ip_i
add wave -noupdate -group Path /test_tx_path/DUT/p_payload_words_i
add wave -noupdate -group Path -expand -subitemconfig {/test_tx_path/DUT/fwd_pipe(0) -expand} /test_tx_path/DUT/fwd_pipe
add wave -noupdate -group Path -expand /test_tx_path/DUT/rev_pipe
add wave -noupdate -group EFramer /test_tx_path/DUT/U_EthernetFramer/clk_i
add wave -noupdate -group EFramer /test_tx_path/DUT/U_EthernetFramer/rst_n_i
add wave -noupdate -group EFramer -expand /test_tx_path/DUT/U_EthernetFramer/snk_i
add wave -noupdate -group EFramer -expand /test_tx_path/DUT/U_EthernetFramer/snk_o
add wave -noupdate -group EFramer /test_tx_path/DUT/U_EthernetFramer/src_i
add wave -noupdate -group EFramer /test_tx_path/DUT/U_EthernetFramer/src_o
add wave -noupdate -group EFramer /test_tx_path/DUT/U_EthernetFramer/p_dst_mac_i
add wave -noupdate -group EFramer /test_tx_path/DUT/U_EthernetFramer/p_ethertype_i
add wave -noupdate -group EFramer -height 16 /test_tx_path/DUT/U_EthernetFramer/state
add wave -noupdate -group EFramer /test_tx_path/DUT/U_EthernetFramer/d_prev
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/clk_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/rst_n_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/snk_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/snk_o
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/src_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/src_o
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/p_src_port_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/p_dst_port_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/p_src_ip_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/p_dst_ip_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/p_payload_len_i
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/state
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/checksum
add wave -noupdate -expand -group UFramer /test_tx_path/DUT/U_UDPFramer/d_prev
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

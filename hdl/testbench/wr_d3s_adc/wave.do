onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -childformat {{/main/RFGen.Ns -radix unsigned} {/main/RFGen.fRF1_Ns -radix unsigned} {/main/RFGen.fRF2_Ns -radix unsigned} {/main/RFGen.frev_Nsamples -radix unsigned} {/main/RFGen.fRF1 -radix unsigned} {/main/RFGen.fRF2 -radix unsigned} {/main/RFGen.frev -radix unsigned} {/main/RFGen.favg -radix unsigned} {/main/RFGen.Nper1 -radix unsigned} {/main/RFGen.Nper2 -radix unsigned} {/main/RFGen.phi -radix unsigned}} -expand -subitemconfig {/main/RFGen.Ns {-height 16 -radix unsigned} /main/RFGen.fRF1_Ns {-height 16 -radix unsigned} /main/RFGen.fRF2_Ns {-height 16 -radix unsigned} /main/RFGen.frev_Nsamples {-height 16 -radix unsigned} /main/RFGen.fRF1 {-height 16 -radix unsigned} /main/RFGen.fRF2 {-height 16 -radix unsigned} /main/RFGen.frev {-height 16 -radix unsigned} /main/RFGen.favg {-height 16 -radix unsigned} /main/RFGen.Nper1 {-height 16 -radix unsigned} /main/RFGen.Nper2 {-height 16 -radix unsigned} /main/RFGen.phi {-height 16 -radix unsigned}} /main/RFGen
add wave -noupdate -format Analog-Step -height 25 -max 1.0 -min -1.0 /main/sine_in
add wave -noupdate -format Analog-Step -height 25 -max 1.0 -min -1.0 /main/sine_in_d0
add wave -noupdate /main/a_rf
add wave -noupdate /main/frev_in
add wave -noupdate /main/clk_rf
add wave -noupdate /main/fbunch_in
add wave -noupdate -radix unsigned /main/fbunch_count
add wave -noupdate /main/clk_rf
add wave -noupdate /main/DUT_S/cmp_TrevGen/bunch_tick_i
add wave -noupdate /main/frev_in
add wave -noupdate /main/tm_tai
add wave -noupdate /main/tm_cyc
add wave -noupdate /main/tm_nsec
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/sys_rst_n_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/clk_sys_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/clk_125m_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/serdes_clk_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/serdes_strobe_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/stdc_input_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/timestamp_8th
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/timestamp_8th_reg
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/detect
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/got_a_pulse
add wave -noupdate -group STDC -radix hexadecimal /main/DUT_M/cmp_stdc/cycles_i
add wave -noupdate -group STDC -radix hexadecimal /main/DUT_M/cmp_stdc/cycles_reg
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/tai_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/tai_reg
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/strobe_o
add wave -noupdate -group STDC -radix hexadecimal /main/DUT_M/cmp_stdc/ts_nsec_o
add wave -noupdate -group STDC -radix hexadecimal /main/DUT_M/cmp_stdc/ts_tai_o
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/polarity
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/fifo_clear
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/fifo_full
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/fifo_we
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/fifo_di
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/fifo_empty
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/fifo_re
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/fifo_do
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/regs_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/regs_o
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/wb_addr_i
add wave -noupdate -group STDC -radix hexadecimal /main/DUT_M/cmp_stdc/wb_data_i
add wave -noupdate -group STDC -radix hexadecimal /main/DUT_M/cmp_stdc/wb_data_o
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/wb_cyc_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/wb_sel_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/wb_stb_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/wb_we_i
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/wb_ack_o
add wave -noupdate -group STDC /main/DUT_M/cmp_stdc/wb_stall_o
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/rst_n_sys_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/clk_sys_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/clk_125m_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/enable_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/tm_time_valid_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/tm_tai_i
add wave -noupdate -expand -group TrevGen -radix hexadecimal /main/DUT_S/cmp_TrevGen/tm_cycles_i
add wave -noupdate -expand -group TrevGen /main/DUT_M/cmp_stdc/stdc_input_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/bunch_tick_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/Trev_tick_o
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_adr_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_dat_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_dat_o
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_cyc_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_sel_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_stb_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_we_i
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_ack_o
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/wb_stall_o
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/s_state
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/s_BclkGate
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/s_Trev_tick
add wave -noupdate -expand -group TrevGen /main/DUT_S/cmp_TrevGen/s_phase
add wave -noupdate -expand -group TrevGen -radix unsigned -childformat {{/main/DUT_S/cmp_TrevGen/s_WRcycTarget(27) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(26) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(25) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(24) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(23) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(22) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(21) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(20) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(19) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(18) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(17) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(16) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(15) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(14) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(13) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(12) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(11) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(10) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(9) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(8) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(7) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(6) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(5) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(4) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(3) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(2) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(1) -radix hexadecimal} {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(0) -radix hexadecimal}} -subitemconfig {/main/DUT_S/cmp_TrevGen/s_WRcycTarget(27) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(26) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(25) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(24) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(23) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(22) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(21) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(20) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(19) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(18) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(17) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(16) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(15) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(14) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(13) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(12) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(11) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(10) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(9) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(8) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(7) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(6) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(5) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(4) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(3) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(2) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(1) {-height 16 -radix hexadecimal} /main/DUT_S/cmp_TrevGen/s_WRcycTarget(0) {-height 16 -radix hexadecimal}} /main/DUT_S/cmp_TrevGen/s_WRcycTarget
add wave -noupdate -expand -group TrevGen -expand /main/DUT_S/cmp_TrevGen/s_regs_i
add wave -noupdate -expand -group TrevGen -childformat {{/main/DUT_S/cmp_TrevGen/s_regs_o.trevgen_rm_next_tick_o -radix hexadecimal}} -expand -subitemconfig {/main/DUT_S/cmp_TrevGen/s_regs_o.trevgen_rm_next_tick_o {-height 16 -radix hexadecimal}} /main/DUT_S/cmp_TrevGen/s_regs_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 16} {116371100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 273
configure wave -valuecolwidth 156
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
WaveRestoreZoom {112530913 ps} {120977981 ps}

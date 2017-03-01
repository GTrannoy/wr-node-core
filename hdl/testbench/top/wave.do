onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/clk_i
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/rst_n_i
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/cpu_pc_i
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/cpu_pc_valid_i
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/slave_i
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/slave_o
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/ts_counter
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/ch
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/state
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/chan_sel
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/start_rec_v
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/stop_rec_v
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/start_rec
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/stop_rec
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/arb_input_data
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/arb_input_req
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/arb_input_valid
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/arb_out_data
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/arb_out_valid
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/mem_addr
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/mem_rdata
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/channel_id
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/regs_out
add wave -noupdate /main/DUT/gen_with_tpu/U_TPU/regs_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {172681 ns} 0}
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
WaveRestoreZoom {143748 ns} {184708 ns}

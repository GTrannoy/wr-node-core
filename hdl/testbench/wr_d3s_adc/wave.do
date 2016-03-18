onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group DUT /main/DUT/clk_sys_i
add wave -noupdate -group DUT /main/DUT/rst_n_sys_i
add wave -noupdate -group DUT /main/DUT/tm_cycles_i
add wave -noupdate -group DUT /main/DUT/spi_din_i
add wave -noupdate -group DUT /main/DUT/spi_dout_o
add wave -noupdate -group DUT /main/DUT/spi_sck_o
add wave -noupdate -group DUT /main/DUT/spi_cs_adc_n_o
add wave -noupdate -group DUT /main/DUT/spi_cs_dac1_n_o
add wave -noupdate -group DUT /main/DUT/spi_cs_dac2_n_o
add wave -noupdate -group DUT /main/DUT/spi_cs_dac3_n_o
add wave -noupdate -group DUT /main/DUT/spi_cs_dac4_n_o
add wave -noupdate -group DUT /main/DUT/si570_scl_b
add wave -noupdate -group DUT /main/DUT/si570_sda_b
add wave -noupdate -group DUT /main/DUT/adc_dco_p_i
add wave -noupdate -group DUT /main/DUT/adc_dco_n_i
add wave -noupdate -group DUT /main/DUT/adc_fr_p_i
add wave -noupdate -group DUT /main/DUT/adc_fr_n_i
add wave -noupdate -group DUT /main/DUT/adc_outa_p_i
add wave -noupdate -group DUT /main/DUT/adc_outa_n_i
add wave -noupdate -group DUT /main/DUT/adc_outb_p_i
add wave -noupdate -group DUT /main/DUT/adc_outb_n_i
add wave -noupdate -group DUT /main/DUT/gpio_dac_clr_n_o
add wave -noupdate -group DUT /main/DUT/gpio_si570_oe_o
add wave -noupdate -group DUT /main/DUT/slave_i
add wave -noupdate -group DUT /main/DUT/slave_o
add wave -noupdate -group DUT /main/DUT/rst_n_wr
add wave -noupdate -group DUT /main/DUT/regs_in
add wave -noupdate -group DUT /main/DUT/regs_out
add wave -noupdate -group DUT /main/DUT/adc_data
add wave -noupdate -group DUT /main/DUT/serdes_in_p
add wave -noupdate -group DUT /main/DUT/serdes_in_n
add wave -noupdate -group DUT /main/DUT/serdes_out_raw
add wave -noupdate -group DUT /main/DUT/serdes_out_data
add wave -noupdate -group DUT /main/DUT/serdes_out_fr
add wave -noupdate -group DUT /main/DUT/serdes_auto_bitslip
add wave -noupdate -group DUT /main/DUT/serdes_man_bitslip
add wave -noupdate -group DUT /main/DUT/serdes_bitslip
add wave -noupdate -group DUT /main/DUT/serdes_synced
add wave -noupdate -group DUT /main/DUT/bitslip_sreg
add wave -noupdate -group DUT /main/DUT/dco_clk
add wave -noupdate -group DUT /main/DUT/dco_clk_buf
add wave -noupdate -group DUT /main/DUT/clk_wr
add wave -noupdate -group DUT /main/DUT/clk_fb
add wave -noupdate -group DUT /main/DUT/clk_fb_buf
add wave -noupdate -group DUT /main/DUT/locked_in
add wave -noupdate -group DUT /main/DUT/locked_out
add wave -noupdate -group DUT /main/DUT/serdes_clk
add wave -noupdate -group DUT /main/DUT/fs_clk_buf
add wave -noupdate -group DUT /main/DUT/sys_rst
add wave -noupdate -group DUT /main/DUT/scl_out
add wave -noupdate -group DUT /main/DUT/sda_out
add wave -noupdate -group DUT /main/DUT/cnx_out
add wave -noupdate -group DUT /main/DUT/cnx_in
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/rst_n_sys_i
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/clk_sys_i
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/clk_acq_i
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/data_i
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/slave_i
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/slave_o
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/wr_addr
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/done
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/regs_in
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/regs_out
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/acq_in_progress
add wave -noupdate -expand -group Acq /main/DUT/U_Acq/rst_n_acq
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/clk_i
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/rst_n_i
add wave -noupdate -group PhEnc -format Analog-Step -height 84 -max 8000.0 -min -6000.0 -radix decimal /main/DUT/U_Phase_Enc/adc_data_i
add wave -noupdate -group PhEnc -format Analog-Step -height 84 -max 7851.0 -min -7887.0 -radix decimal /main/DUT/U_Phase_Enc/raw_phase_o
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/r_max_run_len_i
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/r_max_error_i
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/r_min_error_i
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/r_record_count_o
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/fifo_en_i
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/fifo_full_i
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/fifo_lost_o
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/fifo_rl_o
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/fifo_phase_o
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/fifo_tstamp_o
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/fifo_is_rl_o
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/fifo_we_o
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/tm_cycles_i
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/adc_i
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/adc_i_pre
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/adc_q
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/adc_q_pre
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/adc_phase
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/dummy
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/adc_dphase
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/adc_phase_d0
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/flag
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/avg_lt
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/avg_lt_valid
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/avg_st_predelay
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/avg_st
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/avg_st_valid
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/avg_lt_trunc
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/avg_st_trunc
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/rl_phase
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/rl_integ
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/rl_phase_ext
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/rl_length
add wave -noupdate -group PhEnc -height 16 /main/DUT/U_Phase_Enc/rl_state
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/err_st
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/err_lt
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/err_lt_bound
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/err_st_bound
add wave -noupdate -group PhEnc /main/DUT/U_Phase_Enc/adc_hp_out
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/clk_i
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/rst_n_i
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/x_valid_i
add wave -noupdate -expand -group DCBlock -format Analog-Step -height 84 -max 15507.0 -radix decimal /main/DUT/U_Phase_Enc/DcBlock_1/x_i
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/y_valid_o
add wave -noupdate -expand -group DCBlock -format Analog-Step -height 84 -max 11199.0 -min -7862.0 -radix decimal /main/DUT/U_Phase_Enc/DcBlock_1/y_o
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/x_del_Dm1
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/x_del_2Dm2
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/x_reg
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/MA1_y_o
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/MA2_y_o
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/x_valid_reg
add wave -noupdate -expand -group DCBlock /main/DUT/U_Phase_Enc/DcBlock_1/MA1_valid_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4308850 ps} 0}
configure wave -namecolwidth 406
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
WaveRestoreZoom {3913586 ps} {4704114 ps}

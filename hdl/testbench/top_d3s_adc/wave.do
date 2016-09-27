onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/rst_n_sys_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/clk_sys_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/clk_125m_pllref_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/clk_wr_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/tm_link_up_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/tm_time_valid_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/tm_cycles_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/tm_clk_aux_lock_en_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/tm_clk_aux_locked_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/fake_data_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/spi_din_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/spi_dout_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/spi_sck_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/spi_cs_adc_n_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/spi_cs_dac1_n_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/spi_cs_dac2_n_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/spi_cs_dac3_n_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/spi_cs_dac4_n_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/si570_scl_b
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/si570_sda_b
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_dco_p_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_dco_n_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_fr_p_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_fr_n_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_outa_p_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_outa_n_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_outb_p_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_outb_n_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc0_ext_trigger_p_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc0_ext_trigger_n_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/slave_i
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/slave_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/debug_o
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/TRIG_O
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/rst_n_wr
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/regs_in
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/regs_out
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_data
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/adc_data2
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_in_p
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_in_n
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_out_raw
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_out_data
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_out_fr
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_auto_bitslip
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_man_bitslip
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_bitslip
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_synced
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/bitslip_sreg
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/stdc_data
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/ext_trigger
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/dco_clk
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/dco_clk_buf
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/clk_wr
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/clk_fb
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/clk_fb_buf
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/locked_in
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/locked_out
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_clk
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/serdes_strobe
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/fs_clk_buf
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/sys_rst
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/pllout_serdes_clk
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/clk_wr_div2
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/scl_out
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/sda_out
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/raw_hp_data
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/raw_phase
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/cnx_out
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/cnx_in
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/pllout_clk2
add wave -noupdate -group ADC /main/DUT/U_D3S_ADC_Core/clk2
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKFBOUT
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKOUT0
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKOUT1
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKOUT2
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKOUT3
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKOUT4
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKOUT5
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/LOCKED
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKFBIN
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/CLKIN
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/RST
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/h1
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/z1
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/z5
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/z16
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN0
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN1
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN2
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN3
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN4
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN5
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN6
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN7
add wave -noupdate -group PLL /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/OPEN16
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKFBDCM
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKFBOUT
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT0
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT3
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT4
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT5
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUTDCM0
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUTDCM1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUTDCM2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUTDCM3
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUTDCM4
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUTDCM5
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DO
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DRDY
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/LOCKED
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKFBIN
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKIN1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKIN2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKINSEL
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DADDR
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DCLK
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DEN
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DI
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DWE
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/REL
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/RST
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKIN1_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKIN2_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKFBIN_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/RST_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/REL_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKINSEL_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DADDR_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DI_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DWE_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DEN_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DCLK_ipd
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT0_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT1_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT2_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT3_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT4_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKOUT5_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKFBOUT_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/LOCKED_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/do_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DRDY_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKIN1_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKIN2_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKFBIN_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/RST_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/REL_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKINSEL_dly1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/CLKINSEL_dly2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DADDR_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DI_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DWE_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DEN_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/DCLK_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/sim_d
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/di_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/dwe_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/den_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/dclk_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rst_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rst_input
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rel_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin1_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin1_in_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin2_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkinsel_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkinsel_tmp
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/daddr_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/daddr_in_lat
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/drp_lock
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/drp_lock1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/dr_sram
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk_osc
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_p
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_p
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_lost_val
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_lost_val
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_stopped
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_stopped
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_lost_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_lost_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout_en
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout_en1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout_en0
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout_en0_tmp
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_lock_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout_en_time
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/locked_en_time
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/lock_cnt_max
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkvco_lk
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkvco_lk_rst
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkvco_free
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkvco
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_mult_tl
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/fbclk_tmp
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_src
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rst_in1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rst_unlock
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rst_on_loss
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rst_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rst_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/fb_delay_found
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/fb_delay_found_tmp
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_tst
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/fb_delay
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkvco_delay
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/val_tmp
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/delay_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_period
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco_rm
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco_cmp_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkvco_tm_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco_cmp_flag
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco3
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco4
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco5
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco6
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco7
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco_half
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco_half1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco_half_rm
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco_half_rm1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_vco_half_rm2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_fb
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/period_avg
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkvco_freq_init_chk
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/md_product
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/m_product
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/m_product2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/drp_init_done
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/pll_locked_delay
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_dly_t
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_dly_t
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkpll
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkpll_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfb_in_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/pll_unlock
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/pll_locked_tm
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/pll_locked_tmp1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/pll_locked_tmp2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/lock_period
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/pll_lock_tm
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/unlock_recover
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkpll_jitter_unlock
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkin_jit
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clka1_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkb1_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clka1d2_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clka1d4_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clka1d8_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkdiv_rel_rst
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/qrel_o_reg1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/qrel_o_reg2
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/qrel_o_reg3
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rel_o_mux_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/pmcd_mode
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rel_rst_o
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rel_o_mux_clk
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/rel_o_mux_clk_tmp
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clka1_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkb1_in
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout0_out_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout1_out_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout2_out_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout3_out_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout4_out_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout5_out_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbout_out_out
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0ps_en
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1ps_en
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2ps_en
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3ps_en
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4ps_en
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5ps_en
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1ps_en
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout_mux
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0pm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1pm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2pm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3pm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4pm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5pm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1pm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbmpm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2pm_sel
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1pm_rl
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2pm_rl
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkind_edge
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkind_nocnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_dly_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_dly_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_dly_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_dly_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_dly_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_dly_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_dly_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_dly_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_dlyi
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_dlyi
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_dlyi
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_dlyi
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_dlyi
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_dlyi
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_dlyi
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_dlyi
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout0_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout1_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout2_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout3_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout4_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkout5_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm_dly
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkind_ht
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkind_lt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_ht1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_ht1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_ht1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_ht1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_ht1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_ht1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_ht1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_ht1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_cnt
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk0_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk1_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk2_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk3_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk4_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clk5_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm1_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm2_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm_div1
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkfbm_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/clkind_div
add wave -noupdate -expand -group PLL_ADV /main/DUT/U_D3S_ADC_Core/cmp_serdes_clk_pll/PLL_ADV_inst/init_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4468000000 fs} 0}
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
WaveRestoreZoom {1334061644800 fs} {1350838860800 fs}

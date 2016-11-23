---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for WR D3S WB (master)
---------------------------------------------------------------------------------------
-- File           : wr_d3s_adc_wb.vhd
-- Author         : auto-generated by wbgen2 from wr_d3s_adc.wb
-- Created        : Thu Nov 17 16:49:28 2016
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE wr_d3s_adc.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wbgen2_pkg.all;

use work.d3s_wbgen2_pkg.all;


entity d3s_adc_wb is
  port (
    rst_n_i                                  : in     std_logic;
    clk_sys_i                                : in     std_logic;
    wb_adr_i                                 : in     std_logic_vector(4 downto 0);
    wb_dat_i                                 : in     std_logic_vector(31 downto 0);
    wb_dat_o                                 : out    std_logic_vector(31 downto 0);
    wb_cyc_i                                 : in     std_logic;
    wb_sel_i                                 : in     std_logic_vector(3 downto 0);
    wb_stb_i                                 : in     std_logic;
    wb_we_i                                  : in     std_logic;
    wb_ack_o                                 : out    std_logic;
    wb_stall_o                               : out    std_logic;
    clk_wr_i                                 : in     std_logic;
    regs_i                                   : in     t_d3s_in_registers;
    regs_o                                   : out    t_d3s_out_registers
  );
end d3s_adc_wb;

architecture syn of d3s_adc_wb is

signal d3s_rstr_pll_rst_int                     : std_logic      ;
signal d3s_tcr_wr_lock_en_int                   : std_logic      ;
signal d3s_gpior_spi_cs_adc_int                 : std_logic      ;
signal d3s_gpior_spi_sck_int                    : std_logic      ;
signal d3s_gpior_spi_mosi_int                   : std_logic      ;
signal d3s_adc_rst_n                            : std_logic      ;
signal d3s_adc_in_int                           : std_logic_vector(31 downto 0);
signal d3s_adc_out_int                          : std_logic_vector(31 downto 0);
signal d3s_adc_rdreq_int                        : std_logic      ;
signal d3s_adc_rdreq_int_d0                     : std_logic      ;
signal d3s_ssr_int                              : std_logic_vector(31 downto 0);
signal d3s_ssr_swb                              : std_logic      ;
signal d3s_ssr_swb_delay                        : std_logic      ;
signal d3s_ssr_swb_s0                           : std_logic      ;
signal d3s_ssr_swb_s1                           : std_logic      ;
signal d3s_ssr_swb_s2                           : std_logic      ;
signal d3s_cr_enable_int                        : std_logic      ;
signal d3s_lt_rl_err_min_int                    : std_logic_vector(31 downto 0);
signal d3s_lt_rl_err_min_swb                    : std_logic      ;
signal d3s_lt_rl_err_min_swb_delay              : std_logic      ;
signal d3s_lt_rl_err_min_swb_s0                 : std_logic      ;
signal d3s_lt_rl_err_min_swb_s1                 : std_logic      ;
signal d3s_lt_rl_err_min_swb_s2                 : std_logic      ;
signal d3s_lt_rl_err_max_int                    : std_logic_vector(31 downto 0);
signal d3s_lt_rl_err_max_swb                    : std_logic      ;
signal d3s_lt_rl_err_max_swb_delay              : std_logic      ;
signal d3s_lt_rl_err_max_swb_s0                 : std_logic      ;
signal d3s_lt_rl_err_max_swb_s1                 : std_logic      ;
signal d3s_lt_rl_err_max_swb_s2                 : std_logic      ;
signal d3s_st_rl_err_min_int                    : std_logic_vector(31 downto 0);
signal d3s_st_rl_err_min_swb                    : std_logic      ;
signal d3s_st_rl_err_min_swb_delay              : std_logic      ;
signal d3s_st_rl_err_min_swb_s0                 : std_logic      ;
signal d3s_st_rl_err_min_swb_s1                 : std_logic      ;
signal d3s_st_rl_err_min_swb_s2                 : std_logic      ;
signal d3s_st_rl_err_max_int                    : std_logic_vector(31 downto 0);
signal d3s_st_rl_err_max_swb                    : std_logic      ;
signal d3s_st_rl_err_max_swb_delay              : std_logic      ;
signal d3s_st_rl_err_max_swb_s0                 : std_logic      ;
signal d3s_st_rl_err_max_swb_s1                 : std_logic      ;
signal d3s_st_rl_err_max_swb_s2                 : std_logic      ;
signal d3s_rl_length_max_int                    : std_logic_vector(15 downto 0);
signal d3s_rl_length_max_swb                    : std_logic      ;
signal d3s_rl_length_max_swb_delay              : std_logic      ;
signal d3s_rl_length_max_swb_s0                 : std_logic      ;
signal d3s_rl_length_max_swb_s1                 : std_logic      ;
signal d3s_rl_length_max_swb_s2                 : std_logic      ;
signal d3s_cnt_fixed_int                        : std_logic_vector(31 downto 0);
signal d3s_cnt_fixed_lwb                        : std_logic      ;
signal d3s_cnt_fixed_lwb_delay                  : std_logic      ;
signal d3s_cnt_fixed_lwb_in_progress            : std_logic      ;
signal d3s_cnt_fixed_lwb_s0                     : std_logic      ;
signal d3s_cnt_fixed_lwb_s1                     : std_logic      ;
signal d3s_cnt_fixed_lwb_s2                     : std_logic      ;
signal d3s_lt_cnt_rl_int                        : std_logic_vector(31 downto 0);
signal d3s_lt_cnt_rl_lwb                        : std_logic      ;
signal d3s_lt_cnt_rl_lwb_delay                  : std_logic      ;
signal d3s_lt_cnt_rl_lwb_in_progress            : std_logic      ;
signal d3s_lt_cnt_rl_lwb_s0                     : std_logic      ;
signal d3s_lt_cnt_rl_lwb_s1                     : std_logic      ;
signal d3s_lt_cnt_rl_lwb_s2                     : std_logic      ;
signal d3s_st_cnt_rl_int                        : std_logic_vector(31 downto 0);
signal d3s_st_cnt_rl_lwb                        : std_logic      ;
signal d3s_st_cnt_rl_lwb_delay                  : std_logic      ;
signal d3s_st_cnt_rl_lwb_in_progress            : std_logic      ;
signal d3s_st_cnt_rl_lwb_s0                     : std_logic      ;
signal d3s_st_cnt_rl_lwb_s1                     : std_logic      ;
signal d3s_st_cnt_rl_lwb_s2                     : std_logic      ;
signal d3s_cnt_tstamp_int                       : std_logic_vector(31 downto 0);
signal d3s_cnt_tstamp_lwb                       : std_logic      ;
signal d3s_cnt_tstamp_lwb_delay                 : std_logic      ;
signal d3s_cnt_tstamp_lwb_in_progress           : std_logic      ;
signal d3s_cnt_tstamp_lwb_s0                    : std_logic      ;
signal d3s_cnt_tstamp_lwb_s1                    : std_logic      ;
signal d3s_cnt_tstamp_lwb_s2                    : std_logic      ;
signal d3s_adc_full_int                         : std_logic      ;
signal d3s_adc_empty_int                        : std_logic      ;
signal d3s_adc_clear_bus_int                    : std_logic      ;
signal d3s_adc_usedw_int                        : std_logic_vector(13 downto 0);
signal ack_sreg                                 : std_logic_vector(9 downto 0);
signal rddata_reg                               : std_logic_vector(31 downto 0);
signal wrdata_reg                               : std_logic_vector(31 downto 0);
signal bwsel_reg                                : std_logic_vector(3 downto 0);
signal rwaddr_reg                               : std_logic_vector(4 downto 0);
signal ack_in_progress                          : std_logic      ;
signal wr_int                                   : std_logic      ;
signal rd_int                                   : std_logic      ;
signal allones                                  : std_logic_vector(31 downto 0);
signal allzeros                                 : std_logic_vector(31 downto 0);

begin
-- Some internal signals assignments. For (foreseen) compatibility with other bus standards.
  wrdata_reg <= wb_dat_i;
  bwsel_reg <= wb_sel_i;
  rd_int <= wb_cyc_i and (wb_stb_i and (not wb_we_i));
  wr_int <= wb_cyc_i and (wb_stb_i and wb_we_i);
  allones <= (others => '1');
  allzeros <= (others => '0');
-- 
-- Main register bank access process.
  process (clk_sys_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      ack_sreg <= "0000000000";
      ack_in_progress <= '0';
      rddata_reg <= "00000000000000000000000000000000";
      d3s_rstr_pll_rst_int <= '0';
      d3s_tcr_wr_lock_en_int <= '0';
      regs_o.gpior_si57x_scl_load_o <= '0';
      regs_o.gpior_si57x_sda_load_o <= '0';
      d3s_gpior_spi_cs_adc_int <= '0';
      d3s_gpior_spi_sck_int <= '0';
      d3s_gpior_spi_mosi_int <= '0';
      d3s_ssr_int <= "00000000000000000000000000000000";
      d3s_ssr_swb <= '0';
      d3s_ssr_swb_delay <= '0';
      d3s_cr_enable_int <= '0';
      d3s_lt_rl_err_min_int <= "00000000000000000000000000000000";
      d3s_lt_rl_err_min_swb <= '0';
      d3s_lt_rl_err_min_swb_delay <= '0';
      d3s_lt_rl_err_max_int <= "00000000000000000000000000000000";
      d3s_lt_rl_err_max_swb <= '0';
      d3s_lt_rl_err_max_swb_delay <= '0';
      d3s_st_rl_err_min_int <= "00000000000000000000000000000000";
      d3s_st_rl_err_min_swb <= '0';
      d3s_st_rl_err_min_swb_delay <= '0';
      d3s_st_rl_err_max_int <= "00000000000000000000000000000000";
      d3s_st_rl_err_max_swb <= '0';
      d3s_st_rl_err_max_swb_delay <= '0';
      d3s_rl_length_max_int <= "0000000000000000";
      d3s_rl_length_max_swb <= '0';
      d3s_rl_length_max_swb_delay <= '0';
      d3s_cnt_fixed_lwb <= '0';
      d3s_cnt_fixed_lwb_delay <= '0';
      d3s_cnt_fixed_lwb_in_progress <= '0';
      d3s_lt_cnt_rl_lwb <= '0';
      d3s_lt_cnt_rl_lwb_delay <= '0';
      d3s_lt_cnt_rl_lwb_in_progress <= '0';
      d3s_st_cnt_rl_lwb <= '0';
      d3s_st_cnt_rl_lwb_delay <= '0';
      d3s_st_cnt_rl_lwb_in_progress <= '0';
      d3s_cnt_tstamp_lwb <= '0';
      d3s_cnt_tstamp_lwb_delay <= '0';
      d3s_cnt_tstamp_lwb_in_progress <= '0';
      d3s_adc_clear_bus_int <= '0';
      d3s_adc_rdreq_int <= '0';
    elsif rising_edge(clk_sys_i) then
-- advance the ACK generator shift register
      ack_sreg(8 downto 0) <= ack_sreg(9 downto 1);
      ack_sreg(9) <= '0';
      if (ack_in_progress = '1') then
        if (ack_sreg(0) = '1') then
          regs_o.gpior_si57x_scl_load_o <= '0';
          regs_o.gpior_si57x_sda_load_o <= '0';
          d3s_adc_clear_bus_int <= '0';
          ack_in_progress <= '0';
        else
          regs_o.gpior_si57x_scl_load_o <= '0';
          regs_o.gpior_si57x_sda_load_o <= '0';
          d3s_ssr_swb <= d3s_ssr_swb_delay;
          d3s_ssr_swb_delay <= '0';
          d3s_lt_rl_err_min_swb <= d3s_lt_rl_err_min_swb_delay;
          d3s_lt_rl_err_min_swb_delay <= '0';
          d3s_lt_rl_err_max_swb <= d3s_lt_rl_err_max_swb_delay;
          d3s_lt_rl_err_max_swb_delay <= '0';
          d3s_st_rl_err_min_swb <= d3s_st_rl_err_min_swb_delay;
          d3s_st_rl_err_min_swb_delay <= '0';
          d3s_st_rl_err_max_swb <= d3s_st_rl_err_max_swb_delay;
          d3s_st_rl_err_max_swb_delay <= '0';
          d3s_rl_length_max_swb <= d3s_rl_length_max_swb_delay;
          d3s_rl_length_max_swb_delay <= '0';
          d3s_cnt_fixed_lwb <= d3s_cnt_fixed_lwb_delay;
          d3s_cnt_fixed_lwb_delay <= '0';
          if ((ack_sreg(1) = '1') and (d3s_cnt_fixed_lwb_in_progress = '1')) then
            rddata_reg(31 downto 0) <= d3s_cnt_fixed_int;
            d3s_cnt_fixed_lwb_in_progress <= '0';
          end if;
          d3s_lt_cnt_rl_lwb <= d3s_lt_cnt_rl_lwb_delay;
          d3s_lt_cnt_rl_lwb_delay <= '0';
          if ((ack_sreg(1) = '1') and (d3s_lt_cnt_rl_lwb_in_progress = '1')) then
            rddata_reg(31 downto 0) <= d3s_lt_cnt_rl_int;
            d3s_lt_cnt_rl_lwb_in_progress <= '0';
          end if;
          d3s_st_cnt_rl_lwb <= d3s_st_cnt_rl_lwb_delay;
          d3s_st_cnt_rl_lwb_delay <= '0';
          if ((ack_sreg(1) = '1') and (d3s_st_cnt_rl_lwb_in_progress = '1')) then
            rddata_reg(31 downto 0) <= d3s_st_cnt_rl_int;
            d3s_st_cnt_rl_lwb_in_progress <= '0';
          end if;
          d3s_cnt_tstamp_lwb <= d3s_cnt_tstamp_lwb_delay;
          d3s_cnt_tstamp_lwb_delay <= '0';
          if ((ack_sreg(1) = '1') and (d3s_cnt_tstamp_lwb_in_progress = '1')) then
            rddata_reg(31 downto 0) <= d3s_cnt_tstamp_int;
            d3s_cnt_tstamp_lwb_in_progress <= '0';
          end if;
        end if;
      else
        if ((wb_cyc_i = '1') and (wb_stb_i = '1')) then
          case rwaddr_reg(4 downto 0) is
          when "00000" => 
            if (wb_we_i = '1') then
              d3s_rstr_pll_rst_int <= wrdata_reg(0);
            end if;
            rddata_reg(0) <= d3s_rstr_pll_rst_int;
            rddata_reg(1) <= 'X';
            rddata_reg(2) <= 'X';
            rddata_reg(3) <= 'X';
            rddata_reg(4) <= 'X';
            rddata_reg(5) <= 'X';
            rddata_reg(6) <= 'X';
            rddata_reg(7) <= 'X';
            rddata_reg(8) <= 'X';
            rddata_reg(9) <= 'X';
            rddata_reg(10) <= 'X';
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(16) <= 'X';
            rddata_reg(17) <= 'X';
            rddata_reg(18) <= 'X';
            rddata_reg(19) <= 'X';
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "00001" => 
            if (wb_we_i = '1') then
              d3s_tcr_wr_lock_en_int <= wrdata_reg(0);
            end if;
            rddata_reg(0) <= d3s_tcr_wr_lock_en_int;
            rddata_reg(1) <= regs_i.tcr_wr_locked_i;
            rddata_reg(2) <= regs_i.tcr_wr_time_valid_i;
            rddata_reg(3) <= regs_i.tcr_wr_link_i;
            rddata_reg(4) <= 'X';
            rddata_reg(5) <= 'X';
            rddata_reg(6) <= 'X';
            rddata_reg(7) <= 'X';
            rddata_reg(8) <= 'X';
            rddata_reg(9) <= 'X';
            rddata_reg(10) <= 'X';
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(16) <= 'X';
            rddata_reg(17) <= 'X';
            rddata_reg(18) <= 'X';
            rddata_reg(19) <= 'X';
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "00010" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(31 downto 0) <= regs_i.wr_freq_meter_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "00011" => 
            if (wb_we_i = '1') then
              regs_o.gpior_si57x_scl_load_o <= '1';
              regs_o.gpior_si57x_sda_load_o <= '1';
              d3s_gpior_spi_cs_adc_int <= wrdata_reg(2);
              d3s_gpior_spi_sck_int <= wrdata_reg(3);
              d3s_gpior_spi_mosi_int <= wrdata_reg(4);
            end if;
            rddata_reg(0) <= regs_i.gpior_si57x_scl_i;
            rddata_reg(1) <= regs_i.gpior_si57x_sda_i;
            rddata_reg(2) <= d3s_gpior_spi_cs_adc_int;
            rddata_reg(3) <= d3s_gpior_spi_sck_int;
            rddata_reg(4) <= d3s_gpior_spi_mosi_int;
            rddata_reg(5) <= regs_i.gpior_spi_miso_i;
            rddata_reg(6) <= regs_i.gpior_serdes_pll_locked_i;
            rddata_reg(7) <= 'X';
            rddata_reg(8) <= 'X';
            rddata_reg(9) <= 'X';
            rddata_reg(10) <= 'X';
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(16) <= 'X';
            rddata_reg(17) <= 'X';
            rddata_reg(18) <= 'X';
            rddata_reg(19) <= 'X';
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "00100" => 
            if (wb_we_i = '1') then
              d3s_ssr_int <= wrdata_reg(31 downto 0);
              d3s_ssr_swb <= '1';
              d3s_ssr_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= d3s_ssr_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "00101" => 
            if (wb_we_i = '1') then
              d3s_cr_enable_int <= wrdata_reg(0);
            end if;
            rddata_reg(0) <= d3s_cr_enable_int;
            rddata_reg(1) <= 'X';
            rddata_reg(2) <= 'X';
            rddata_reg(3) <= 'X';
            rddata_reg(4) <= 'X';
            rddata_reg(5) <= 'X';
            rddata_reg(6) <= 'X';
            rddata_reg(7) <= 'X';
            rddata_reg(8) <= 'X';
            rddata_reg(9) <= 'X';
            rddata_reg(10) <= 'X';
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(16) <= 'X';
            rddata_reg(17) <= 'X';
            rddata_reg(18) <= 'X';
            rddata_reg(19) <= 'X';
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "00110" => 
            if (wb_we_i = '1') then
              d3s_lt_rl_err_min_int <= wrdata_reg(31 downto 0);
              d3s_lt_rl_err_min_swb <= '1';
              d3s_lt_rl_err_min_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= d3s_lt_rl_err_min_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "00111" => 
            if (wb_we_i = '1') then
              d3s_lt_rl_err_max_int <= wrdata_reg(31 downto 0);
              d3s_lt_rl_err_max_swb <= '1';
              d3s_lt_rl_err_max_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= d3s_lt_rl_err_max_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "01000" => 
            if (wb_we_i = '1') then
              d3s_st_rl_err_min_int <= wrdata_reg(31 downto 0);
              d3s_st_rl_err_min_swb <= '1';
              d3s_st_rl_err_min_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= d3s_st_rl_err_min_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "01001" => 
            if (wb_we_i = '1') then
              d3s_st_rl_err_max_int <= wrdata_reg(31 downto 0);
              d3s_st_rl_err_max_swb <= '1';
              d3s_st_rl_err_max_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= d3s_st_rl_err_max_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "01010" => 
            if (wb_we_i = '1') then
              d3s_rl_length_max_int <= wrdata_reg(15 downto 0);
              d3s_rl_length_max_swb <= '1';
              d3s_rl_length_max_swb_delay <= '1';
            end if;
            rddata_reg(15 downto 0) <= d3s_rl_length_max_int;
            rddata_reg(16) <= 'X';
            rddata_reg(17) <= 'X';
            rddata_reg(18) <= 'X';
            rddata_reg(19) <= 'X';
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "01011" => 
            if (wb_we_i = '1') then
            end if;
            if (wb_we_i = '0') then
              d3s_cnt_fixed_lwb <= '1';
              d3s_cnt_fixed_lwb_delay <= '1';
              d3s_cnt_fixed_lwb_in_progress <= '1';
            end if;
            ack_sreg(5) <= '1';
            ack_in_progress <= '1';
          when "01100" => 
            if (wb_we_i = '1') then
            end if;
            if (wb_we_i = '0') then
              d3s_lt_cnt_rl_lwb <= '1';
              d3s_lt_cnt_rl_lwb_delay <= '1';
              d3s_lt_cnt_rl_lwb_in_progress <= '1';
            end if;
            ack_sreg(5) <= '1';
            ack_in_progress <= '1';
          when "01101" => 
            if (wb_we_i = '1') then
            end if;
            if (wb_we_i = '0') then
              d3s_st_cnt_rl_lwb <= '1';
              d3s_st_cnt_rl_lwb_delay <= '1';
              d3s_st_cnt_rl_lwb_in_progress <= '1';
            end if;
            ack_sreg(5) <= '1';
            ack_in_progress <= '1';
          when "01110" => 
            if (wb_we_i = '1') then
            end if;
            if (wb_we_i = '0') then
              d3s_cnt_tstamp_lwb <= '1';
              d3s_cnt_tstamp_lwb_delay <= '1';
              d3s_cnt_tstamp_lwb_in_progress <= '1';
            end if;
            ack_sreg(5) <= '1';
            ack_in_progress <= '1';
          when "01111" => 
            if (wb_we_i = '1') then
            end if;
            if (d3s_adc_rdreq_int_d0 = '0') then
              d3s_adc_rdreq_int <= not d3s_adc_rdreq_int;
            else
              rddata_reg(31 downto 0) <= d3s_adc_out_int(31 downto 0);
              ack_in_progress <= '1';
              ack_sreg(0) <= '1';
            end if;
          when "10000" => 
            if (wb_we_i = '1') then
              if (wrdata_reg(18) = '1') then
                d3s_adc_clear_bus_int <= '1';
              end if;
            end if;
            rddata_reg(16) <= d3s_adc_full_int;
            rddata_reg(17) <= d3s_adc_empty_int;
            rddata_reg(18) <= '0';
            rddata_reg(13 downto 0) <= d3s_adc_usedw_int;
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(19) <= 'X';
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when others =>
-- prevent the slave from hanging the bus on invalid address
            ack_in_progress <= '1';
            ack_sreg(0) <= '1';
          end case;
        end if;
      end if;
    end if;
  end process;
  
  
-- Drive the data output bus
  wb_dat_o <= rddata_reg;
-- FPGA REF/Serdes PLL Reset
  regs_o.rstr_pll_rst_o <= d3s_rstr_pll_rst_int;
-- WR Lock Enable
  regs_o.tcr_wr_lock_en_o <= d3s_tcr_wr_lock_en_int;
-- WR Locked
-- WR Time Valid
-- WR Link
-- WR frequency
-- SI57X_SCL
  regs_o.gpior_si57x_scl_o <= wrdata_reg(0);
-- SI57X_SDA
  regs_o.gpior_si57x_sda_o <= wrdata_reg(1);
-- SPI_CS_ADC
  regs_o.gpior_spi_cs_adc_o <= d3s_gpior_spi_cs_adc_int;
-- SPI_SCK
  regs_o.gpior_spi_sck_o <= d3s_gpior_spi_sck_int;
-- SPI_MOSI
  regs_o.gpior_spi_mosi_o <= d3s_gpior_spi_mosi_int;
-- SPI_MISO
-- Serdes PLL locked
-- extra code for reg/fifo/mem: ADC Data FIFO
  d3s_adc_in_int(31 downto 0) <= regs_i.adc_payload_i;
  d3s_adc_rst_n <= rst_n_i and (not d3s_adc_clear_bus_int);
  d3s_adc_INST : wbgen2_fifo_async
    generic map (
      g_size               => 16384,
      g_width              => 32,
      g_usedw_size         => 14
    )
    port map (
      wr_req_i             => regs_i.adc_wr_req_i,
      wr_full_o            => regs_o.adc_wr_full_o,
      wr_empty_o           => regs_o.adc_wr_empty_o,
      rd_full_o            => d3s_adc_full_int,
      rd_empty_o           => d3s_adc_empty_int,
      rd_usedw_o           => d3s_adc_usedw_int,
      rd_req_i             => d3s_adc_rdreq_int,
      rst_n_i              => d3s_adc_rst_n,
      wr_clk_i             => clk_wr_i,
      rd_clk_i             => clk_sys_i,
      wr_data_i            => d3s_adc_in_int,
      rd_data_o            => d3s_adc_out_int
    );
  
-- SSR Outputs
-- asynchronous std_logic_vector register : SSR Outputs (type RW/RO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_ssr_swb_s0 <= '0';
      d3s_ssr_swb_s1 <= '0';
      d3s_ssr_swb_s2 <= '0';
      regs_o.ssr_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_ssr_swb_s0 <= d3s_ssr_swb;
      d3s_ssr_swb_s1 <= d3s_ssr_swb_s0;
      d3s_ssr_swb_s2 <= d3s_ssr_swb_s1;
      if ((d3s_ssr_swb_s2 = '0') and (d3s_ssr_swb_s1 = '1')) then
        regs_o.ssr_o <= d3s_ssr_int;
      end if;
    end if;
  end process;
  
  
-- ENABLE
  regs_o.cr_enable_o <= d3s_cr_enable_int;
-- MinError
-- asynchronous std_logic_vector register : MinError (type RW/RO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_lt_rl_err_min_swb_s0 <= '0';
      d3s_lt_rl_err_min_swb_s1 <= '0';
      d3s_lt_rl_err_min_swb_s2 <= '0';
      regs_o.lt_rl_err_min_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_lt_rl_err_min_swb_s0 <= d3s_lt_rl_err_min_swb;
      d3s_lt_rl_err_min_swb_s1 <= d3s_lt_rl_err_min_swb_s0;
      d3s_lt_rl_err_min_swb_s2 <= d3s_lt_rl_err_min_swb_s1;
      if ((d3s_lt_rl_err_min_swb_s2 = '0') and (d3s_lt_rl_err_min_swb_s1 = '1')) then
        regs_o.lt_rl_err_min_o <= d3s_lt_rl_err_min_int;
      end if;
    end if;
  end process;
  
  
-- MaxError
-- asynchronous std_logic_vector register : MaxError (type RW/RO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_lt_rl_err_max_swb_s0 <= '0';
      d3s_lt_rl_err_max_swb_s1 <= '0';
      d3s_lt_rl_err_max_swb_s2 <= '0';
      regs_o.lt_rl_err_max_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_lt_rl_err_max_swb_s0 <= d3s_lt_rl_err_max_swb;
      d3s_lt_rl_err_max_swb_s1 <= d3s_lt_rl_err_max_swb_s0;
      d3s_lt_rl_err_max_swb_s2 <= d3s_lt_rl_err_max_swb_s1;
      if ((d3s_lt_rl_err_max_swb_s2 = '0') and (d3s_lt_rl_err_max_swb_s1 = '1')) then
        regs_o.lt_rl_err_max_o <= d3s_lt_rl_err_max_int;
      end if;
    end if;
  end process;
  
  
-- MinError
-- asynchronous std_logic_vector register : MinError (type RW/RO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_st_rl_err_min_swb_s0 <= '0';
      d3s_st_rl_err_min_swb_s1 <= '0';
      d3s_st_rl_err_min_swb_s2 <= '0';
      regs_o.st_rl_err_min_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_st_rl_err_min_swb_s0 <= d3s_st_rl_err_min_swb;
      d3s_st_rl_err_min_swb_s1 <= d3s_st_rl_err_min_swb_s0;
      d3s_st_rl_err_min_swb_s2 <= d3s_st_rl_err_min_swb_s1;
      if ((d3s_st_rl_err_min_swb_s2 = '0') and (d3s_st_rl_err_min_swb_s1 = '1')) then
        regs_o.st_rl_err_min_o <= d3s_st_rl_err_min_int;
      end if;
    end if;
  end process;
  
  
-- MaxError
-- asynchronous std_logic_vector register : MaxError (type RW/RO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_st_rl_err_max_swb_s0 <= '0';
      d3s_st_rl_err_max_swb_s1 <= '0';
      d3s_st_rl_err_max_swb_s2 <= '0';
      regs_o.st_rl_err_max_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_st_rl_err_max_swb_s0 <= d3s_st_rl_err_max_swb;
      d3s_st_rl_err_max_swb_s1 <= d3s_st_rl_err_max_swb_s0;
      d3s_st_rl_err_max_swb_s2 <= d3s_st_rl_err_max_swb_s1;
      if ((d3s_st_rl_err_max_swb_s2 = '0') and (d3s_st_rl_err_max_swb_s1 = '1')) then
        regs_o.st_rl_err_max_o <= d3s_st_rl_err_max_int;
      end if;
    end if;
  end process;
  
  
-- RLMax
-- asynchronous std_logic_vector register : RLMax (type RW/RO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_rl_length_max_swb_s0 <= '0';
      d3s_rl_length_max_swb_s1 <= '0';
      d3s_rl_length_max_swb_s2 <= '0';
      regs_o.rl_length_max_o <= "0000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_rl_length_max_swb_s0 <= d3s_rl_length_max_swb;
      d3s_rl_length_max_swb_s1 <= d3s_rl_length_max_swb_s0;
      d3s_rl_length_max_swb_s2 <= d3s_rl_length_max_swb_s1;
      if ((d3s_rl_length_max_swb_s2 = '0') and (d3s_rl_length_max_swb_s1 = '1')) then
        regs_o.rl_length_max_o <= d3s_rl_length_max_int;
      end if;
    end if;
  end process;
  
  
-- Count
-- asynchronous std_logic_vector register : Count (type RO/WO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_cnt_fixed_lwb_s0 <= '0';
      d3s_cnt_fixed_lwb_s1 <= '0';
      d3s_cnt_fixed_lwb_s2 <= '0';
      d3s_cnt_fixed_int <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_cnt_fixed_lwb_s0 <= d3s_cnt_fixed_lwb;
      d3s_cnt_fixed_lwb_s1 <= d3s_cnt_fixed_lwb_s0;
      d3s_cnt_fixed_lwb_s2 <= d3s_cnt_fixed_lwb_s1;
      if ((d3s_cnt_fixed_lwb_s1 = '1') and (d3s_cnt_fixed_lwb_s2 = '0')) then
        d3s_cnt_fixed_int <= regs_i.cnt_fixed_i;
      end if;
    end if;
  end process;
  
  
-- Count
-- asynchronous std_logic_vector register : Count (type RO/WO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_lt_cnt_rl_lwb_s0 <= '0';
      d3s_lt_cnt_rl_lwb_s1 <= '0';
      d3s_lt_cnt_rl_lwb_s2 <= '0';
      d3s_lt_cnt_rl_int <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_lt_cnt_rl_lwb_s0 <= d3s_lt_cnt_rl_lwb;
      d3s_lt_cnt_rl_lwb_s1 <= d3s_lt_cnt_rl_lwb_s0;
      d3s_lt_cnt_rl_lwb_s2 <= d3s_lt_cnt_rl_lwb_s1;
      if ((d3s_lt_cnt_rl_lwb_s1 = '1') and (d3s_lt_cnt_rl_lwb_s2 = '0')) then
        d3s_lt_cnt_rl_int <= regs_i.lt_cnt_rl_i;
      end if;
    end if;
  end process;
  
  
-- Count
-- asynchronous std_logic_vector register : Count (type RO/WO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_st_cnt_rl_lwb_s0 <= '0';
      d3s_st_cnt_rl_lwb_s1 <= '0';
      d3s_st_cnt_rl_lwb_s2 <= '0';
      d3s_st_cnt_rl_int <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_st_cnt_rl_lwb_s0 <= d3s_st_cnt_rl_lwb;
      d3s_st_cnt_rl_lwb_s1 <= d3s_st_cnt_rl_lwb_s0;
      d3s_st_cnt_rl_lwb_s2 <= d3s_st_cnt_rl_lwb_s1;
      if ((d3s_st_cnt_rl_lwb_s1 = '1') and (d3s_st_cnt_rl_lwb_s2 = '0')) then
        d3s_st_cnt_rl_int <= regs_i.st_cnt_rl_i;
      end if;
    end if;
  end process;
  
  
-- Count
-- asynchronous std_logic_vector register : Count (type RO/WO, clk_wr_i <-> clk_sys_i)
  process (clk_wr_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_cnt_tstamp_lwb_s0 <= '0';
      d3s_cnt_tstamp_lwb_s1 <= '0';
      d3s_cnt_tstamp_lwb_s2 <= '0';
      d3s_cnt_tstamp_int <= "00000000000000000000000000000000";
    elsif rising_edge(clk_wr_i) then
      d3s_cnt_tstamp_lwb_s0 <= d3s_cnt_tstamp_lwb;
      d3s_cnt_tstamp_lwb_s1 <= d3s_cnt_tstamp_lwb_s0;
      d3s_cnt_tstamp_lwb_s2 <= d3s_cnt_tstamp_lwb_s1;
      if ((d3s_cnt_tstamp_lwb_s1 = '1') and (d3s_cnt_tstamp_lwb_s2 = '0')) then
        d3s_cnt_tstamp_int <= regs_i.cnt_tstamp_i;
      end if;
    end if;
  end process;
  
  
-- extra code for reg/fifo/mem: FIFO 'ADC Data FIFO' data output register 0
  process (clk_sys_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      d3s_adc_rdreq_int_d0 <= '0';
    elsif rising_edge(clk_sys_i) then
      d3s_adc_rdreq_int_d0 <= d3s_adc_rdreq_int;
    end if;
  end process;
  
  
  rwaddr_reg <= wb_adr_i;
  wb_stall_o <= (not ack_sreg(0)) and (wb_stb_i and wb_cyc_i);
-- ACK signal generation. Just pass the LSB of ACK counter.
  wb_ack_o <= ack_sreg(0);
end syn;

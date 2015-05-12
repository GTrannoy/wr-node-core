---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for DDS RF distribution WB Slave
---------------------------------------------------------------------------------------
-- File           : dds_wb_slave.vhd
-- Author         : auto-generated by wbgen2 from dds_wb_slave.wb
-- Created        : Tue May 12 17:33:15 2015
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE dds_wb_slave.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.dds_wbgen2_pkg.all;


entity dds_wb_slave is
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
    clk_ref_i                                : in     std_logic;
    regs_i                                   : in     t_dds_in_registers;
    regs_o                                   : out    t_dds_out_registers
  );
end dds_wb_slave;

architecture syn of dds_wb_slave is

signal dds_cr_samp_en_int                       : std_logic      ;
signal dds_cr_samp_en_sync0                     : std_logic      ;
signal dds_cr_samp_en_sync1                     : std_logic      ;
signal dds_cr_samp_div_int                      : std_logic_vector(15 downto 0);
signal dds_cr_samp_div_swb                      : std_logic      ;
signal dds_cr_samp_div_swb_delay                : std_logic      ;
signal dds_cr_samp_div_swb_s0                   : std_logic      ;
signal dds_cr_samp_div_swb_s1                   : std_logic      ;
signal dds_cr_samp_div_swb_s2                   : std_logic      ;
signal dds_tcr_wr_lock_en_int                   : std_logic      ;
signal dds_gpior_pll_sys_cs_n_int               : std_logic      ;
signal dds_gpior_pll_sys_reset_n_int            : std_logic      ;
signal dds_gpior_pll_sclk_int                   : std_logic      ;
signal dds_gpior_pll_sdio_dir_int               : std_logic      ;
signal dds_gpior_pll_vcxo_reset_n_int           : std_logic      ;
signal dds_gpior_pll_vcxo_cs_n_int              : std_logic      ;
signal dds_gpior_adf_ce_int                     : std_logic      ;
signal dds_gpior_adf_clk_int                    : std_logic      ;
signal dds_gpior_adf_le_int                     : std_logic      ;
signal dds_gpior_adf_data_int                   : std_logic      ;
signal dds_tune_val_tune_int                    : std_logic_vector(27 downto 0);
signal dds_tune_val_tune_swb                    : std_logic      ;
signal dds_tune_val_tune_swb_delay              : std_logic      ;
signal dds_tune_val_tune_swb_s0                 : std_logic      ;
signal dds_tune_val_tune_swb_s1                 : std_logic      ;
signal dds_tune_val_tune_swb_s2                 : std_logic      ;
signal dds_tune_val_load_acc_int_read           : std_logic      ;
signal dds_tune_val_load_acc_int_write          : std_logic      ;
signal dds_tune_val_load_acc_lw                 : std_logic      ;
signal dds_tune_val_load_acc_lw_delay           : std_logic      ;
signal dds_tune_val_load_acc_lw_read_in_progress : std_logic      ;
signal dds_tune_val_load_acc_lw_s0              : std_logic      ;
signal dds_tune_val_load_acc_lw_s1              : std_logic      ;
signal dds_tune_val_load_acc_lw_s2              : std_logic      ;
signal dds_tune_val_load_acc_rwsel              : std_logic      ;
signal dds_freq_hi_int                          : std_logic_vector(31 downto 0);
signal dds_freq_hi_swb                          : std_logic      ;
signal dds_freq_hi_swb_delay                    : std_logic      ;
signal dds_freq_hi_swb_s0                       : std_logic      ;
signal dds_freq_hi_swb_s1                       : std_logic      ;
signal dds_freq_hi_swb_s2                       : std_logic      ;
signal dds_freq_lo_int                          : std_logic_vector(31 downto 0);
signal dds_freq_lo_swb                          : std_logic      ;
signal dds_freq_lo_swb_delay                    : std_logic      ;
signal dds_freq_lo_swb_s0                       : std_logic      ;
signal dds_freq_lo_swb_s1                       : std_logic      ;
signal dds_freq_lo_swb_s2                       : std_logic      ;
signal dds_acc_snap_hi_int                      : std_logic_vector(31 downto 0);
signal dds_acc_snap_hi_lwb                      : std_logic      ;
signal dds_acc_snap_hi_lwb_delay                : std_logic      ;
signal dds_acc_snap_hi_lwb_in_progress          : std_logic      ;
signal dds_acc_snap_hi_lwb_s0                   : std_logic      ;
signal dds_acc_snap_hi_lwb_s1                   : std_logic      ;
signal dds_acc_snap_hi_lwb_s2                   : std_logic      ;
signal dds_acc_snap_lo_int                      : std_logic_vector(31 downto 0);
signal dds_acc_snap_lo_lwb                      : std_logic      ;
signal dds_acc_snap_lo_lwb_delay                : std_logic      ;
signal dds_acc_snap_lo_lwb_in_progress          : std_logic      ;
signal dds_acc_snap_lo_lwb_s0                   : std_logic      ;
signal dds_acc_snap_lo_lwb_s1                   : std_logic      ;
signal dds_acc_snap_lo_lwb_s2                   : std_logic      ;
signal dds_acc_load_hi_int                      : std_logic_vector(31 downto 0);
signal dds_acc_load_hi_swb                      : std_logic      ;
signal dds_acc_load_hi_swb_delay                : std_logic      ;
signal dds_acc_load_hi_swb_s0                   : std_logic      ;
signal dds_acc_load_hi_swb_s1                   : std_logic      ;
signal dds_acc_load_hi_swb_s2                   : std_logic      ;
signal dds_acc_load_lo_int                      : std_logic_vector(31 downto 0);
signal dds_acc_load_lo_swb                      : std_logic      ;
signal dds_acc_load_lo_swb_delay                : std_logic      ;
signal dds_acc_load_lo_swb_s0                   : std_logic      ;
signal dds_acc_load_lo_swb_s1                   : std_logic      ;
signal dds_acc_load_lo_swb_s2                   : std_logic      ;
signal dds_gain_int                             : std_logic_vector(15 downto 0);
signal dds_gain_swb                             : std_logic      ;
signal dds_gain_swb_delay                       : std_logic      ;
signal dds_gain_swb_s0                          : std_logic      ;
signal dds_gain_swb_s1                          : std_logic      ;
signal dds_gain_swb_s2                          : std_logic      ;
signal dds_rstr_pll_rst_int                     : std_logic      ;
signal dds_rstr_sw_rst_int                      : std_logic      ;
signal dds_i2cr_scl_out_int                     : std_logic      ;
signal dds_i2cr_sda_out_int                     : std_logic      ;
signal dds_freq_meas_gate_int                   : std_logic_vector(31 downto 0);
signal dds_sample_idx_int                       : std_logic_vector(23 downto 0);
signal dds_sample_idx_lwb                       : std_logic      ;
signal dds_sample_idx_lwb_delay                 : std_logic      ;
signal dds_sample_idx_lwb_in_progress           : std_logic      ;
signal dds_sample_idx_lwb_s0                    : std_logic      ;
signal dds_sample_idx_lwb_s1                    : std_logic      ;
signal dds_sample_idx_lwb_s2                    : std_logic      ;
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
      dds_cr_samp_en_int <= '0';
      dds_cr_samp_div_int <= "0000000000000000";
      dds_cr_samp_div_swb <= '0';
      dds_cr_samp_div_swb_delay <= '0';
      dds_tcr_wr_lock_en_int <= '0';
      dds_gpior_pll_sys_cs_n_int <= '0';
      dds_gpior_pll_sys_reset_n_int <= '0';
      dds_gpior_pll_sclk_int <= '0';
      regs_o.gpior_pll_sdio_load_o <= '0';
      dds_gpior_pll_sdio_dir_int <= '0';
      dds_gpior_pll_vcxo_reset_n_int <= '0';
      dds_gpior_pll_vcxo_cs_n_int <= '0';
      dds_gpior_adf_ce_int <= '0';
      dds_gpior_adf_clk_int <= '0';
      dds_gpior_adf_le_int <= '0';
      dds_gpior_adf_data_int <= '0';
      regs_o.pd_data_valid_load_o <= '0';
      dds_tune_val_tune_int <= "0000000000000000000000000000";
      dds_tune_val_tune_swb <= '0';
      dds_tune_val_tune_swb_delay <= '0';
      dds_tune_val_load_acc_lw <= '0';
      dds_tune_val_load_acc_lw_delay <= '0';
      dds_tune_val_load_acc_lw_read_in_progress <= '0';
      dds_tune_val_load_acc_rwsel <= '0';
      dds_tune_val_load_acc_int_write <= '0';
      dds_freq_hi_int <= "00000000000000000000000000000000";
      dds_freq_hi_swb <= '0';
      dds_freq_hi_swb_delay <= '0';
      dds_freq_lo_int <= "00000000000000000000000000000000";
      dds_freq_lo_swb <= '0';
      dds_freq_lo_swb_delay <= '0';
      dds_acc_snap_hi_lwb <= '0';
      dds_acc_snap_hi_lwb_delay <= '0';
      dds_acc_snap_hi_lwb_in_progress <= '0';
      dds_acc_snap_lo_lwb <= '0';
      dds_acc_snap_lo_lwb_delay <= '0';
      dds_acc_snap_lo_lwb_in_progress <= '0';
      dds_acc_load_hi_int <= "00000000000000000000000000000000";
      dds_acc_load_hi_swb <= '0';
      dds_acc_load_hi_swb_delay <= '0';
      dds_acc_load_lo_int <= "00000000000000000000000000000000";
      dds_acc_load_lo_swb <= '0';
      dds_acc_load_lo_swb_delay <= '0';
      dds_gain_int <= "0000000000000000";
      dds_gain_swb <= '0';
      dds_gain_swb_delay <= '0';
      dds_rstr_pll_rst_int <= '0';
      dds_rstr_sw_rst_int <= '1';
      dds_i2cr_scl_out_int <= '1';
      dds_i2cr_sda_out_int <= '1';
      dds_freq_meas_gate_int <= "00000011101110011010110010100000";
      dds_sample_idx_lwb <= '0';
      dds_sample_idx_lwb_delay <= '0';
      dds_sample_idx_lwb_in_progress <= '0';
    elsif rising_edge(clk_sys_i) then
-- advance the ACK generator shift register
      ack_sreg(8 downto 0) <= ack_sreg(9 downto 1);
      ack_sreg(9) <= '0';
      if (ack_in_progress = '1') then
        if (ack_sreg(0) = '1') then
          regs_o.gpior_pll_sdio_load_o <= '0';
          regs_o.pd_data_valid_load_o <= '0';
          ack_in_progress <= '0';
        else
          dds_cr_samp_div_swb <= dds_cr_samp_div_swb_delay;
          dds_cr_samp_div_swb_delay <= '0';
          regs_o.gpior_pll_sdio_load_o <= '0';
          regs_o.pd_data_valid_load_o <= '0';
          dds_tune_val_tune_swb <= dds_tune_val_tune_swb_delay;
          dds_tune_val_tune_swb_delay <= '0';
          dds_tune_val_load_acc_lw <= dds_tune_val_load_acc_lw_delay;
          dds_tune_val_load_acc_lw_delay <= '0';
          if ((ack_sreg(1) = '1') and (dds_tune_val_load_acc_lw_read_in_progress = '1')) then
            rddata_reg(28) <= dds_tune_val_load_acc_int_read;
            dds_tune_val_load_acc_lw_read_in_progress <= '0';
          end if;
          dds_freq_hi_swb <= dds_freq_hi_swb_delay;
          dds_freq_hi_swb_delay <= '0';
          dds_freq_lo_swb <= dds_freq_lo_swb_delay;
          dds_freq_lo_swb_delay <= '0';
          dds_acc_snap_hi_lwb <= dds_acc_snap_hi_lwb_delay;
          dds_acc_snap_hi_lwb_delay <= '0';
          if ((ack_sreg(1) = '1') and (dds_acc_snap_hi_lwb_in_progress = '1')) then
            rddata_reg(31 downto 0) <= dds_acc_snap_hi_int;
            dds_acc_snap_hi_lwb_in_progress <= '0';
          end if;
          dds_acc_snap_lo_lwb <= dds_acc_snap_lo_lwb_delay;
          dds_acc_snap_lo_lwb_delay <= '0';
          if ((ack_sreg(1) = '1') and (dds_acc_snap_lo_lwb_in_progress = '1')) then
            rddata_reg(31 downto 0) <= dds_acc_snap_lo_int;
            dds_acc_snap_lo_lwb_in_progress <= '0';
          end if;
          dds_acc_load_hi_swb <= dds_acc_load_hi_swb_delay;
          dds_acc_load_hi_swb_delay <= '0';
          dds_acc_load_lo_swb <= dds_acc_load_lo_swb_delay;
          dds_acc_load_lo_swb_delay <= '0';
          dds_gain_swb <= dds_gain_swb_delay;
          dds_gain_swb_delay <= '0';
          dds_sample_idx_lwb <= dds_sample_idx_lwb_delay;
          dds_sample_idx_lwb_delay <= '0';
          if ((ack_sreg(1) = '1') and (dds_sample_idx_lwb_in_progress = '1')) then
            rddata_reg(23 downto 0) <= dds_sample_idx_int;
            dds_sample_idx_lwb_in_progress <= '0';
          end if;
        end if;
      else
        if ((wb_cyc_i = '1') and (wb_stb_i = '1')) then
          case rwaddr_reg(4 downto 0) is
          when "00000" => 
            if (wb_we_i = '1') then
              dds_cr_samp_en_int <= wrdata_reg(0);
              dds_cr_samp_div_int <= wrdata_reg(16 downto 1);
              dds_cr_samp_div_swb <= '1';
              dds_cr_samp_div_swb_delay <= '1';
            end if;
            rddata_reg(0) <= dds_cr_samp_en_int;
            rddata_reg(16 downto 1) <= dds_cr_samp_div_int;
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
          when "00001" => 
            if (wb_we_i = '1') then
              dds_tcr_wr_lock_en_int <= wrdata_reg(0);
            end if;
            rddata_reg(0) <= dds_tcr_wr_lock_en_int;
            rddata_reg(1) <= regs_i.tcr_wr_locked_i;
            rddata_reg(2) <= regs_i.tcr_wr_link_i;
            rddata_reg(3) <= regs_i.tcr_wr_time_valid_i;
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
              dds_gpior_pll_sys_cs_n_int <= wrdata_reg(0);
              dds_gpior_pll_sys_reset_n_int <= wrdata_reg(1);
              dds_gpior_pll_sclk_int <= wrdata_reg(2);
              regs_o.gpior_pll_sdio_load_o <= '1';
              dds_gpior_pll_sdio_dir_int <= wrdata_reg(4);
              dds_gpior_pll_vcxo_reset_n_int <= wrdata_reg(5);
              dds_gpior_pll_vcxo_cs_n_int <= wrdata_reg(6);
              dds_gpior_adf_ce_int <= wrdata_reg(8);
              dds_gpior_adf_clk_int <= wrdata_reg(9);
              dds_gpior_adf_le_int <= wrdata_reg(10);
              dds_gpior_adf_data_int <= wrdata_reg(11);
            end if;
            rddata_reg(0) <= dds_gpior_pll_sys_cs_n_int;
            rddata_reg(1) <= dds_gpior_pll_sys_reset_n_int;
            rddata_reg(2) <= dds_gpior_pll_sclk_int;
            rddata_reg(3) <= regs_i.gpior_pll_sdio_i;
            rddata_reg(4) <= dds_gpior_pll_sdio_dir_int;
            rddata_reg(5) <= dds_gpior_pll_vcxo_reset_n_int;
            rddata_reg(6) <= dds_gpior_pll_vcxo_cs_n_int;
            rddata_reg(7) <= regs_i.gpior_pll_vcxo_sdo_i;
            rddata_reg(8) <= dds_gpior_adf_ce_int;
            rddata_reg(9) <= dds_gpior_adf_clk_int;
            rddata_reg(10) <= dds_gpior_adf_le_int;
            rddata_reg(11) <= dds_gpior_adf_data_int;
            rddata_reg(12) <= regs_i.gpior_serdes_pll_locked_i;
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
          when "00011" => 
            if (wb_we_i = '1') then
              regs_o.pd_data_valid_load_o <= '1';
            end if;
            rddata_reg(15 downto 0) <= regs_i.pd_data_data_i;
            rddata_reg(16) <= regs_i.pd_data_valid_i;
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
              dds_tune_val_tune_int <= wrdata_reg(27 downto 0);
              dds_tune_val_tune_swb <= '1';
              dds_tune_val_tune_swb_delay <= '1';
              dds_tune_val_load_acc_int_write <= wrdata_reg(28);
              dds_tune_val_load_acc_lw <= '1';
              dds_tune_val_load_acc_lw_delay <= '1';
              dds_tune_val_load_acc_lw_read_in_progress <= '0';
              dds_tune_val_load_acc_rwsel <= '1';
            end if;
            rddata_reg(27 downto 0) <= dds_tune_val_tune_int;
            if (wb_we_i = '0') then
              rddata_reg(28) <= 'X';
              dds_tune_val_load_acc_lw <= '1';
              dds_tune_val_load_acc_lw_delay <= '1';
              dds_tune_val_load_acc_lw_read_in_progress <= '1';
              dds_tune_val_load_acc_rwsel <= '0';
            end if;
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(5) <= '1';
            ack_in_progress <= '1';
          when "00101" => 
            if (wb_we_i = '1') then
              dds_freq_hi_int <= wrdata_reg(31 downto 0);
              dds_freq_hi_swb <= '1';
              dds_freq_hi_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= dds_freq_hi_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "00110" => 
            if (wb_we_i = '1') then
              dds_freq_lo_int <= wrdata_reg(31 downto 0);
              dds_freq_lo_swb <= '1';
              dds_freq_lo_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= dds_freq_lo_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "00111" => 
            if (wb_we_i = '1') then
            end if;
            if (wb_we_i = '0') then
              dds_acc_snap_hi_lwb <= '1';
              dds_acc_snap_hi_lwb_delay <= '1';
              dds_acc_snap_hi_lwb_in_progress <= '1';
            end if;
            ack_sreg(5) <= '1';
            ack_in_progress <= '1';
          when "01000" => 
            if (wb_we_i = '1') then
            end if;
            if (wb_we_i = '0') then
              dds_acc_snap_lo_lwb <= '1';
              dds_acc_snap_lo_lwb_delay <= '1';
              dds_acc_snap_lo_lwb_in_progress <= '1';
            end if;
            ack_sreg(5) <= '1';
            ack_in_progress <= '1';
          when "01001" => 
            if (wb_we_i = '1') then
              dds_acc_load_hi_int <= wrdata_reg(31 downto 0);
              dds_acc_load_hi_swb <= '1';
              dds_acc_load_hi_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= dds_acc_load_hi_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "01010" => 
            if (wb_we_i = '1') then
              dds_acc_load_lo_int <= wrdata_reg(31 downto 0);
              dds_acc_load_lo_swb <= '1';
              dds_acc_load_lo_swb_delay <= '1';
            end if;
            rddata_reg(31 downto 0) <= dds_acc_load_lo_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "01011" => 
            if (wb_we_i = '1') then
              dds_gain_int <= wrdata_reg(15 downto 0);
              dds_gain_swb <= '1';
              dds_gain_swb_delay <= '1';
            end if;
            rddata_reg(15 downto 0) <= dds_gain_int;
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
          when "01100" => 
            if (wb_we_i = '1') then
              dds_rstr_pll_rst_int <= wrdata_reg(0);
              dds_rstr_sw_rst_int <= wrdata_reg(1);
            end if;
            rddata_reg(0) <= dds_rstr_pll_rst_int;
            rddata_reg(1) <= dds_rstr_sw_rst_int;
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
          when "01101" => 
            if (wb_we_i = '1') then
              dds_i2cr_scl_out_int <= wrdata_reg(0);
              dds_i2cr_sda_out_int <= wrdata_reg(1);
            end if;
            rddata_reg(0) <= dds_i2cr_scl_out_int;
            rddata_reg(1) <= dds_i2cr_sda_out_int;
            rddata_reg(2) <= regs_i.i2cr_scl_in_i;
            rddata_reg(3) <= regs_i.i2cr_sda_in_i;
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
          when "01110" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(31 downto 0) <= regs_i.freq_meas_vcxo_ref_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "01111" => 
            if (wb_we_i = '1') then
              dds_freq_meas_gate_int <= wrdata_reg(31 downto 0);
            end if;
            rddata_reg(31 downto 0) <= dds_freq_meas_gate_int;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "10000" => 
            if (wb_we_i = '1') then
            end if;
            if (wb_we_i = '0') then
              dds_sample_idx_lwb <= '1';
              dds_sample_idx_lwb_delay <= '1';
              dds_sample_idx_lwb_in_progress <= '1';
            end if;
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(5) <= '1';
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
-- Sampling Enable
-- synchronizer chain for field : Sampling Enable (type RW/RO, clk_sys_i <-> clk_ref_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      regs_o.cr_samp_en_o <= '0';
      dds_cr_samp_en_sync0 <= '0';
      dds_cr_samp_en_sync1 <= '0';
    elsif rising_edge(clk_ref_i) then
      dds_cr_samp_en_sync0 <= dds_cr_samp_en_int;
      dds_cr_samp_en_sync1 <= dds_cr_samp_en_sync0;
      regs_o.cr_samp_en_o <= dds_cr_samp_en_sync1;
    end if;
  end process;
  
  
-- Sample rate divider
-- asynchronous std_logic_vector register : Sample rate divider (type RW/RO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_cr_samp_div_swb_s0 <= '0';
      dds_cr_samp_div_swb_s1 <= '0';
      dds_cr_samp_div_swb_s2 <= '0';
      regs_o.cr_samp_div_o <= "0000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_cr_samp_div_swb_s0 <= dds_cr_samp_div_swb;
      dds_cr_samp_div_swb_s1 <= dds_cr_samp_div_swb_s0;
      dds_cr_samp_div_swb_s2 <= dds_cr_samp_div_swb_s1;
      if ((dds_cr_samp_div_swb_s2 = '0') and (dds_cr_samp_div_swb_s1 = '1')) then
        regs_o.cr_samp_div_o <= dds_cr_samp_div_int;
      end if;
    end if;
  end process;
  
  
-- WR Lock Enable
  regs_o.tcr_wr_lock_en_o <= dds_tcr_wr_lock_en_int;
-- WR Locked
-- WR Link
-- WR Time Valid
-- System PLL CS
  regs_o.gpior_pll_sys_cs_n_o <= dds_gpior_pll_sys_cs_n_int;
-- System Reset
  regs_o.gpior_pll_sys_reset_n_o <= dds_gpior_pll_sys_reset_n_int;
-- PLL SCLK (shared)
  regs_o.gpior_pll_sclk_o <= dds_gpior_pll_sclk_int;
-- PLL SDIO (shared)
  regs_o.gpior_pll_sdio_o <= wrdata_reg(3);
-- PLL SDIO direction (shared)
  regs_o.gpior_pll_sdio_dir_o <= dds_gpior_pll_sdio_dir_int;
-- VCXO PLL Reset
  regs_o.gpior_pll_vcxo_reset_n_o <= dds_gpior_pll_vcxo_reset_n_int;
-- VCXO PLL Chip Select
  regs_o.gpior_pll_vcxo_cs_n_o <= dds_gpior_pll_vcxo_cs_n_int;
-- VCXO PLL SDO
-- ADF4002 Chip Enable
  regs_o.gpior_adf_ce_o <= dds_gpior_adf_ce_int;
-- ADF4002 Clock
  regs_o.gpior_adf_clk_o <= dds_gpior_adf_clk_int;
-- ADF4002 Latch Enable
  regs_o.gpior_adf_le_o <= dds_gpior_adf_le_int;
-- ADF4002 Data
  regs_o.gpior_adf_data_o <= dds_gpior_adf_data_int;
-- Serdes PLL locked
-- ADC data
-- ADC data valid
  regs_o.pd_data_valid_o <= wrdata_reg(16);
-- DDS tune word
-- asynchronous std_logic_vector register : DDS tune word (type RW/RO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_tune_val_tune_swb_s0 <= '0';
      dds_tune_val_tune_swb_s1 <= '0';
      dds_tune_val_tune_swb_s2 <= '0';
      regs_o.tune_val_tune_o <= "0000000000000000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_tune_val_tune_swb_s0 <= dds_tune_val_tune_swb;
      dds_tune_val_tune_swb_s1 <= dds_tune_val_tune_swb_s0;
      dds_tune_val_tune_swb_s2 <= dds_tune_val_tune_swb_s1;
      if ((dds_tune_val_tune_swb_s2 = '0') and (dds_tune_val_tune_swb_s1 = '1')) then
        regs_o.tune_val_tune_o <= dds_tune_val_tune_int;
      end if;
    end if;
  end process;
  
  
-- Load DDS Accumulator along with next tune sample.
-- asynchronous BIT register : Load DDS Accumulator along with next tune sample. (type RW/WO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_tune_val_load_acc_lw_s0 <= '0';
      dds_tune_val_load_acc_lw_s1 <= '0';
      dds_tune_val_load_acc_lw_s2 <= '0';
      dds_tune_val_load_acc_int_read <= '0';
      regs_o.tune_val_load_acc_load_o <= '0';
      regs_o.tune_val_load_acc_o <= '0';
    elsif rising_edge(clk_ref_i) then
      dds_tune_val_load_acc_lw_s0 <= dds_tune_val_load_acc_lw;
      dds_tune_val_load_acc_lw_s1 <= dds_tune_val_load_acc_lw_s0;
      dds_tune_val_load_acc_lw_s2 <= dds_tune_val_load_acc_lw_s1;
      if ((dds_tune_val_load_acc_lw_s2 = '0') and (dds_tune_val_load_acc_lw_s1 = '1')) then
        if (dds_tune_val_load_acc_rwsel = '1') then
          regs_o.tune_val_load_acc_o <= dds_tune_val_load_acc_int_write;
          regs_o.tune_val_load_acc_load_o <= '1';
        else
          regs_o.tune_val_load_acc_load_o <= '0';
          dds_tune_val_load_acc_int_read <= regs_i.tune_val_load_acc_i;
        end if;
      else
        regs_o.tune_val_load_acc_load_o <= '0';
      end if;
    end if;
  end process;
  
  
-- Center freq HI
-- asynchronous std_logic_vector register : Center freq HI (type RW/RO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_freq_hi_swb_s0 <= '0';
      dds_freq_hi_swb_s1 <= '0';
      dds_freq_hi_swb_s2 <= '0';
      regs_o.freq_hi_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_freq_hi_swb_s0 <= dds_freq_hi_swb;
      dds_freq_hi_swb_s1 <= dds_freq_hi_swb_s0;
      dds_freq_hi_swb_s2 <= dds_freq_hi_swb_s1;
      if ((dds_freq_hi_swb_s2 = '0') and (dds_freq_hi_swb_s1 = '1')) then
        regs_o.freq_hi_o <= dds_freq_hi_int;
      end if;
    end if;
  end process;
  
  
-- Center freq LO
-- asynchronous std_logic_vector register : Center freq LO (type RW/RO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_freq_lo_swb_s0 <= '0';
      dds_freq_lo_swb_s1 <= '0';
      dds_freq_lo_swb_s2 <= '0';
      regs_o.freq_lo_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_freq_lo_swb_s0 <= dds_freq_lo_swb;
      dds_freq_lo_swb_s1 <= dds_freq_lo_swb_s0;
      dds_freq_lo_swb_s2 <= dds_freq_lo_swb_s1;
      if ((dds_freq_lo_swb_s2 = '0') and (dds_freq_lo_swb_s1 = '1')) then
        regs_o.freq_lo_o <= dds_freq_lo_int;
      end if;
    end if;
  end process;
  
  
-- HI
-- asynchronous std_logic_vector register : HI (type RO/WO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_acc_snap_hi_lwb_s0 <= '0';
      dds_acc_snap_hi_lwb_s1 <= '0';
      dds_acc_snap_hi_lwb_s2 <= '0';
      dds_acc_snap_hi_int <= "00000000000000000000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_acc_snap_hi_lwb_s0 <= dds_acc_snap_hi_lwb;
      dds_acc_snap_hi_lwb_s1 <= dds_acc_snap_hi_lwb_s0;
      dds_acc_snap_hi_lwb_s2 <= dds_acc_snap_hi_lwb_s1;
      if ((dds_acc_snap_hi_lwb_s1 = '1') and (dds_acc_snap_hi_lwb_s2 = '0')) then
        dds_acc_snap_hi_int <= regs_i.acc_snap_hi_i;
      end if;
    end if;
  end process;
  
  
-- LO
-- asynchronous std_logic_vector register : LO (type RO/WO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_acc_snap_lo_lwb_s0 <= '0';
      dds_acc_snap_lo_lwb_s1 <= '0';
      dds_acc_snap_lo_lwb_s2 <= '0';
      dds_acc_snap_lo_int <= "00000000000000000000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_acc_snap_lo_lwb_s0 <= dds_acc_snap_lo_lwb;
      dds_acc_snap_lo_lwb_s1 <= dds_acc_snap_lo_lwb_s0;
      dds_acc_snap_lo_lwb_s2 <= dds_acc_snap_lo_lwb_s1;
      if ((dds_acc_snap_lo_lwb_s1 = '1') and (dds_acc_snap_lo_lwb_s2 = '0')) then
        dds_acc_snap_lo_int <= regs_i.acc_snap_lo_i;
      end if;
    end if;
  end process;
  
  
-- HI
-- asynchronous std_logic_vector register : HI (type RW/RO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_acc_load_hi_swb_s0 <= '0';
      dds_acc_load_hi_swb_s1 <= '0';
      dds_acc_load_hi_swb_s2 <= '0';
      regs_o.acc_load_hi_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_acc_load_hi_swb_s0 <= dds_acc_load_hi_swb;
      dds_acc_load_hi_swb_s1 <= dds_acc_load_hi_swb_s0;
      dds_acc_load_hi_swb_s2 <= dds_acc_load_hi_swb_s1;
      if ((dds_acc_load_hi_swb_s2 = '0') and (dds_acc_load_hi_swb_s1 = '1')) then
        regs_o.acc_load_hi_o <= dds_acc_load_hi_int;
      end if;
    end if;
  end process;
  
  
-- LO
-- asynchronous std_logic_vector register : LO (type RW/RO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_acc_load_lo_swb_s0 <= '0';
      dds_acc_load_lo_swb_s1 <= '0';
      dds_acc_load_lo_swb_s2 <= '0';
      regs_o.acc_load_lo_o <= "00000000000000000000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_acc_load_lo_swb_s0 <= dds_acc_load_lo_swb;
      dds_acc_load_lo_swb_s1 <= dds_acc_load_lo_swb_s0;
      dds_acc_load_lo_swb_s2 <= dds_acc_load_lo_swb_s1;
      if ((dds_acc_load_lo_swb_s2 = '0') and (dds_acc_load_lo_swb_s1 = '1')) then
        regs_o.acc_load_lo_o <= dds_acc_load_lo_int;
      end if;
    end if;
  end process;
  
  
-- DDS gain (4.12 unsigned)
-- asynchronous std_logic_vector register : DDS gain (4.12 unsigned) (type RW/RO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_gain_swb_s0 <= '0';
      dds_gain_swb_s1 <= '0';
      dds_gain_swb_s2 <= '0';
      regs_o.gain_o <= "0000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_gain_swb_s0 <= dds_gain_swb;
      dds_gain_swb_s1 <= dds_gain_swb_s0;
      dds_gain_swb_s2 <= dds_gain_swb_s1;
      if ((dds_gain_swb_s2 = '0') and (dds_gain_swb_s1 = '1')) then
        regs_o.gain_o <= dds_gain_int;
      end if;
    end if;
  end process;
  
  
-- FPGA REF/Serdes PLL Reset
  regs_o.rstr_pll_rst_o <= dds_rstr_pll_rst_int;
-- FPGA DDS Logic software reset
  regs_o.rstr_sw_rst_o <= dds_rstr_sw_rst_int;
-- SCL Line out
  regs_o.i2cr_scl_out_o <= dds_i2cr_scl_out_int;
-- SDA Line out
  regs_o.i2cr_sda_out_o <= dds_i2cr_sda_out_int;
-- SCL Line in
-- SDA Line in
-- Freq
-- Freq
  regs_o.freq_meas_gate_o <= dds_freq_meas_gate_int;
-- IDX
-- asynchronous std_logic_vector register : IDX (type RO/WO, clk_ref_i <-> clk_sys_i)
  process (clk_ref_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      dds_sample_idx_lwb_s0 <= '0';
      dds_sample_idx_lwb_s1 <= '0';
      dds_sample_idx_lwb_s2 <= '0';
      dds_sample_idx_int <= "000000000000000000000000";
    elsif rising_edge(clk_ref_i) then
      dds_sample_idx_lwb_s0 <= dds_sample_idx_lwb;
      dds_sample_idx_lwb_s1 <= dds_sample_idx_lwb_s0;
      dds_sample_idx_lwb_s2 <= dds_sample_idx_lwb_s1;
      if ((dds_sample_idx_lwb_s1 = '1') and (dds_sample_idx_lwb_s2 = '0')) then
        dds_sample_idx_int <= regs_i.sample_idx_i;
      end if;
    end if;
  end process;
  
  
  rwaddr_reg <= wb_adr_i;
  wb_stall_o <= (not ack_sreg(0)) and (wb_stb_i and wb_cyc_i);
-- ACK signal generation. Just pass the LSB of ACK counter.
  wb_ack_o <= ack_sreg(0);
end syn;

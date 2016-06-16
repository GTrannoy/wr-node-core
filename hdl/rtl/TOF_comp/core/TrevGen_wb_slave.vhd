---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for TOF
---------------------------------------------------------------------------------------
-- File           : ../core/TrevGen_wb_slave.vhd
-- Author         : auto-generated by wbgen2 from TrevGen_wb_slave.wb
-- Created        : Thu Jun 16 16:54:34 2016
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE TrevGen_wb_slave.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.TOF_wbgen2_pkg.all;


entity TrevGen_wb_slave is
  port (
    rst_n_i                                  : in     std_logic;
    clk_sys_i                                : in     std_logic;
    wb_adr_i                                 : in     std_logic_vector(1 downto 0);
    wb_dat_i                                 : in     std_logic_vector(31 downto 0);
    wb_dat_o                                 : out    std_logic_vector(31 downto 0);
    wb_cyc_i                                 : in     std_logic;
    wb_sel_i                                 : in     std_logic_vector(3 downto 0);
    wb_stb_i                                 : in     std_logic;
    wb_we_i                                  : in     std_logic;
    wb_ack_o                                 : out    std_logic;
    wb_stall_o                               : out    std_logic;
    regs_i                                   : in     t_TOF_in_registers;
    regs_o                                   : out    t_TOF_out_registers
  );
end TrevGen_wb_slave;

architecture syn of TrevGen_wb_slave is

signal tof_mintrev_int                          : std_logic_vector(30 downto 0);
signal tof_maxtrev_int                          : std_logic_vector(30 downto 0);
signal tof_ctrl_wrltcy_int                      : std_logic_vector(19 downto 0);
signal tof_ctrl_gmargin_int                     : std_logic_vector(1 downto 0);
signal tof_ctrl_gwidth_int                      : std_logic_vector(1 downto 0);
signal ack_sreg                                 : std_logic_vector(9 downto 0);
signal rddata_reg                               : std_logic_vector(31 downto 0);
signal wrdata_reg                               : std_logic_vector(31 downto 0);
signal bwsel_reg                                : std_logic_vector(3 downto 0);
signal rwaddr_reg                               : std_logic_vector(1 downto 0);
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
      tof_mintrev_int <= "0000000000000000000000000000000";
      tof_maxtrev_int <= "0000000000000000000000000000000";
      tof_ctrl_wrltcy_int <= "00000000000000000000";
      tof_ctrl_gmargin_int <= "00";
      tof_ctrl_gwidth_int <= "00";
    elsif rising_edge(clk_sys_i) then
-- advance the ACK generator shift register
      ack_sreg(8 downto 0) <= ack_sreg(9 downto 1);
      ack_sreg(9) <= '0';
      if (ack_in_progress = '1') then
        if (ack_sreg(0) = '1') then
          ack_in_progress <= '0';
        else
        end if;
      else
        if ((wb_cyc_i = '1') and (wb_stb_i = '1')) then
          case rwaddr_reg(1 downto 0) is
          when "00" => 
            if (wb_we_i = '1') then
              tof_mintrev_int <= wrdata_reg(30 downto 0);
            end if;
            rddata_reg(30 downto 0) <= tof_mintrev_int;
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "01" => 
            if (wb_we_i = '1') then
              tof_maxtrev_int <= wrdata_reg(30 downto 0);
            end if;
            rddata_reg(30 downto 0) <= tof_maxtrev_int;
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "10" => 
            if (wb_we_i = '1') then
              tof_ctrl_wrltcy_int <= wrdata_reg(19 downto 0);
              tof_ctrl_gmargin_int <= wrdata_reg(25 downto 24);
              tof_ctrl_gwidth_int <= wrdata_reg(27 downto 26);
            end if;
            rddata_reg(19 downto 0) <= tof_ctrl_wrltcy_int;
            rddata_reg(25 downto 24) <= tof_ctrl_gmargin_int;
            rddata_reg(27 downto 26) <= tof_ctrl_gwidth_int;
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
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
-- MinTrev
  regs_o.tof_mintrev_o <= unsigned(tof_mintrev_int);
-- MaxTrev
  regs_o.tof_maxtrev_o <= unsigned(tof_maxtrev_int);
-- WRLtcy
  regs_o.tof_ctrl_wrltcy_o <= unsigned(tof_ctrl_wrltcy_int);
-- GMargin
  regs_o.tof_ctrl_gmargin_o <= unsigned(tof_ctrl_gmargin_int);
-- GWidth
  regs_o.tof_ctrl_gwidth_o <= unsigned(tof_ctrl_gwidth_int);
  rwaddr_reg <= wb_adr_i;
  wb_stall_o <= (not ack_sreg(0)) and (wb_stb_i and wb_cyc_i);
-- ACK signal generation. Just pass the LSB of ACK counter.
  wb_ack_o <= ack_sreg(0);
end syn;

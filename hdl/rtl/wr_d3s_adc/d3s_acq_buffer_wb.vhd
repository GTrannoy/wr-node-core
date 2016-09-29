---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for D3S Acquisition buffer
---------------------------------------------------------------------------------------
-- File           : d3s_acq_buffer_wb.vhd
-- Author         : auto-generated by wbgen2 from d3s_acq_buffer_wb.wb
-- Created        : Thu Sep 29 14:44:08 2016
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE d3s_acq_buffer_wb.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.acq_wbgen2_pkg.all;


entity d3s_acq_buffer_wb is
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
    clk_acq_i                                : in     std_logic;
    regs_i                                   : in     t_acq_in_registers;
    regs_o                                   : out    t_acq_out_registers
  );
end d3s_acq_buffer_wb;

architecture syn of d3s_acq_buffer_wb is

signal acq_cr_start_int                         : std_logic      ;
signal acq_cr_start_int_delay                   : std_logic      ;
signal acq_cr_start_sync0                       : std_logic      ;
signal acq_cr_start_sync1                       : std_logic      ;
signal acq_cr_start_sync2                       : std_logic      ;
signal acq_cr_ready_sync0                       : std_logic      ;
signal acq_cr_ready_sync1                       : std_logic      ;
signal acq_addr_int                             : std_logic_vector(31 downto 0);
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
      acq_cr_start_int <= '0';
      acq_cr_start_int_delay <= '0';
      acq_addr_int <= "00000000000000000000000000000000";
    elsif rising_edge(clk_sys_i) then
-- advance the ACK generator shift register
      ack_sreg(8 downto 0) <= ack_sreg(9 downto 1);
      ack_sreg(9) <= '0';
      if (ack_in_progress = '1') then
        if (ack_sreg(0) = '1') then
          ack_in_progress <= '0';
        else
          acq_cr_start_int <= acq_cr_start_int_delay;
          acq_cr_start_int_delay <= '0';
        end if;
      else
        if ((wb_cyc_i = '1') and (wb_stb_i = '1')) then
          case rwaddr_reg(1 downto 0) is
          when "00" => 
            if (wb_we_i = '1') then
              acq_cr_start_int <= wrdata_reg(0);
              acq_cr_start_int_delay <= wrdata_reg(0);
            end if;
            rddata_reg(0) <= '0';
            rddata_reg(1) <= acq_cr_ready_sync1;
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
            ack_sreg(4) <= '1';
            ack_in_progress <= '1';
          when "01" => 
            if (wb_we_i = '1') then
              acq_addr_int <= wrdata_reg(31 downto 0);
            end if;
            rddata_reg(31 downto 0) <= acq_addr_int;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "10" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(31 downto 0) <= regs_i.data_i;
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
-- Start sampling
  process (clk_acq_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      regs_o.cr_start_o <= '0';
      acq_cr_start_sync0 <= '0';
      acq_cr_start_sync1 <= '0';
      acq_cr_start_sync2 <= '0';
    elsif rising_edge(clk_acq_i) then
      acq_cr_start_sync0 <= acq_cr_start_int;
      acq_cr_start_sync1 <= acq_cr_start_sync0;
      acq_cr_start_sync2 <= acq_cr_start_sync1;
      regs_o.cr_start_o <= acq_cr_start_sync2 and (not acq_cr_start_sync1);
    end if;
  end process;
  
  
-- Ready
-- synchronizer chain for field : Ready (type RO/WO, clk_acq_i -> clk_sys_i)
  process (clk_acq_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      acq_cr_ready_sync0 <= '0';
      acq_cr_ready_sync1 <= '0';
    elsif rising_edge(clk_acq_i) then
      acq_cr_ready_sync0 <= regs_i.cr_ready_i;
      acq_cr_ready_sync1 <= acq_cr_ready_sync0;
    end if;
  end process;
  
  
-- Address
  regs_o.addr_o <= acq_addr_int;
-- Data
  rwaddr_reg <= wb_adr_i;
  wb_stall_o <= (not ack_sreg(0)) and (wb_stb_i and wb_cyc_i);
-- ACK signal generation. Just pass the LSB of ACK counter.
  wb_ack_o <= ack_sreg(0);
end syn;

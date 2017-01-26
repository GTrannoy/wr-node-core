---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for WR Node CPU Control/Status registers block
---------------------------------------------------------------------------------------
-- File           : wrn_cpu_csr_wb.vhd
-- Author         : auto-generated by wbgen2 from wrn_cpu_csr.wb
-- Created        : Wed Jan 25 15:13:16 2017
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE wrn_cpu_csr.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wrn_cpu_csr_wbgen2_pkg.all;


entity wrn_cpu_csr_wb_slave is
  port (
    rst_n_i                                  : in     std_logic;
    clk_sys_i                                : in     std_logic;
    wb_adr_i                                 : in     std_logic_vector(3 downto 0);
    wb_dat_i                                 : in     std_logic_vector(31 downto 0);
    wb_dat_o                                 : out    std_logic_vector(31 downto 0);
    wb_cyc_i                                 : in     std_logic;
    wb_sel_i                                 : in     std_logic_vector(3 downto 0);
    wb_stb_i                                 : in     std_logic;
    wb_we_i                                  : in     std_logic;
    wb_ack_o                                 : out    std_logic;
    wb_stall_o                               : out    std_logic;
    dbg_msg_data_rd_ack_o                    : out    std_logic;
    regs_i                                   : in     t_wrn_cpu_csr_in_registers;
    regs_o                                   : out    t_wrn_cpu_csr_out_registers
  );
end wrn_cpu_csr_wb_slave;

architecture syn of wrn_cpu_csr_wb_slave is

signal wrn_cpu_csr_reset_int                    : std_logic_vector(7 downto 0);
signal wrn_cpu_csr_enable_int                   : std_logic_vector(7 downto 0);
signal wrn_cpu_csr_uaddr_addr_int               : std_logic_vector(19 downto 0);
signal wrn_cpu_csr_core_sel_int                 : std_logic_vector(3 downto 0);
signal wrn_cpu_csr_dbg_imsk_enable_int          : std_logic_vector(7 downto 0);
signal wrn_cpu_csr_smem_op_int                  : std_logic_vector(2 downto 0);
signal ack_sreg                                 : std_logic_vector(9 downto 0);
signal rddata_reg                               : std_logic_vector(31 downto 0);
signal wrdata_reg                               : std_logic_vector(31 downto 0);
signal bwsel_reg                                : std_logic_vector(3 downto 0);
signal rwaddr_reg                               : std_logic_vector(3 downto 0);
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
      wrn_cpu_csr_reset_int <= "11111111";
      wrn_cpu_csr_enable_int <= "00000000";
      wrn_cpu_csr_uaddr_addr_int <= "00000000000000000000";
      wrn_cpu_csr_core_sel_int <= "0000";
      regs_o.udata_load_o <= '0';
      regs_o.dbg_jtag_jdata_load_o <= '0';
      regs_o.dbg_jtag_jaddr_load_o <= '0';
      regs_o.dbg_jtag_rstn_load_o <= '0';
      regs_o.dbg_jtag_tck_load_o <= '0';
      regs_o.dbg_jtag_update_load_o <= '0';
      dbg_msg_data_rd_ack_o <= '0';
      wrn_cpu_csr_dbg_imsk_enable_int <= "00000000";
      wrn_cpu_csr_smem_op_int <= "000";
    elsif rising_edge(clk_sys_i) then
-- advance the ACK generator shift register
      ack_sreg(8 downto 0) <= ack_sreg(9 downto 1);
      ack_sreg(9) <= '0';
      if (ack_in_progress = '1') then
        if (ack_sreg(0) = '1') then
          regs_o.udata_load_o <= '0';
          regs_o.dbg_jtag_jdata_load_o <= '0';
          regs_o.dbg_jtag_jaddr_load_o <= '0';
          regs_o.dbg_jtag_rstn_load_o <= '0';
          regs_o.dbg_jtag_tck_load_o <= '0';
          regs_o.dbg_jtag_update_load_o <= '0';
          dbg_msg_data_rd_ack_o <= '0';
          ack_in_progress <= '0';
        else
          regs_o.udata_load_o <= '0';
          regs_o.dbg_jtag_jdata_load_o <= '0';
          regs_o.dbg_jtag_jaddr_load_o <= '0';
          regs_o.dbg_jtag_rstn_load_o <= '0';
          regs_o.dbg_jtag_tck_load_o <= '0';
          regs_o.dbg_jtag_update_load_o <= '0';
        end if;
      else
        if ((wb_cyc_i = '1') and (wb_stb_i = '1')) then
          case rwaddr_reg(3 downto 0) is
          when "0000" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(31 downto 0) <= regs_i.app_id_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "0001" => 
            if (wb_we_i = '1') then
              wrn_cpu_csr_reset_int <= wrdata_reg(7 downto 0);
            end if;
            rddata_reg(7 downto 0) <= wrn_cpu_csr_reset_int;
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
          when "0010" => 
            if (wb_we_i = '1') then
              wrn_cpu_csr_enable_int <= wrdata_reg(7 downto 0);
            end if;
            rddata_reg(7 downto 0) <= wrn_cpu_csr_enable_int;
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
          when "0011" => 
            if (wb_we_i = '1') then
              wrn_cpu_csr_uaddr_addr_int <= wrdata_reg(19 downto 0);
            end if;
            rddata_reg(19 downto 0) <= wrn_cpu_csr_uaddr_addr_int;
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
          when "0100" => 
            if (wb_we_i = '1') then
              wrn_cpu_csr_core_sel_int <= wrdata_reg(3 downto 0);
            end if;
            rddata_reg(3 downto 0) <= wrn_cpu_csr_core_sel_int;
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
          when "0101" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(3 downto 0) <= regs_i.core_count_i;
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
          when "0110" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(31 downto 0) <= regs_i.core_memsize_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "0111" => 
            if (wb_we_i = '1') then
              regs_o.udata_load_o <= '1';
            end if;
            rddata_reg(31 downto 0) <= regs_i.udata_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "1000" => 
            if (wb_we_i = '1') then
              regs_o.dbg_jtag_jdata_load_o <= '1';
              regs_o.dbg_jtag_jaddr_load_o <= '1';
              regs_o.dbg_jtag_rstn_load_o <= '1';
              regs_o.dbg_jtag_tck_load_o <= '1';
              regs_o.dbg_jtag_update_load_o <= '1';
            end if;
            rddata_reg(7 downto 0) <= regs_i.dbg_jtag_jdata_i;
            rddata_reg(10 downto 8) <= regs_i.dbg_jtag_jaddr_i;
            rddata_reg(16) <= regs_i.dbg_jtag_rstn_i;
            rddata_reg(17) <= regs_i.dbg_jtag_tck_i;
            rddata_reg(18) <= regs_i.dbg_jtag_update_i;
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
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
          when "1001" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(7 downto 0) <= regs_i.dbg_msg_data_i;
            dbg_msg_data_rd_ack_o <= '1';
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
          when "1010" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(7 downto 0) <= regs_i.dbg_poll_ready_i;
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
          when "1011" => 
            if (wb_we_i = '1') then
              wrn_cpu_csr_dbg_imsk_enable_int <= wrdata_reg(7 downto 0);
            end if;
            rddata_reg(7 downto 0) <= wrn_cpu_csr_dbg_imsk_enable_int;
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
          when "1100" => 
            if (wb_we_i = '1') then
              wrn_cpu_csr_smem_op_int <= wrdata_reg(2 downto 0);
            end if;
            rddata_reg(2 downto 0) <= wrn_cpu_csr_smem_op_int;
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
-- User application ID
-- CPU reset lines
  regs_o.reset_o <= wrn_cpu_csr_reset_int;
-- CPU enable lines
  regs_o.enable_o <= wrn_cpu_csr_enable_int;
-- Address
  regs_o.uaddr_addr_o <= wrn_cpu_csr_uaddr_addr_int;
-- CPU core select
  regs_o.core_sel_o <= wrn_cpu_csr_core_sel_int;
-- Number of CPU Cores
-- Memory size for the selected core.
-- CPU IRAM read/write data
  regs_o.udata_o <= wrdata_reg(31 downto 0);
-- JTAG data
  regs_o.dbg_jtag_jdata_o <= wrdata_reg(7 downto 0);
-- JTAG address
  regs_o.dbg_jtag_jaddr_o <= wrdata_reg(10 downto 8);
-- JTAG reset
  regs_o.dbg_jtag_rstn_o <= wrdata_reg(16);
-- JTAG TCK
  regs_o.dbg_jtag_tck_o <= wrdata_reg(17);
-- JTAG Update
  regs_o.dbg_jtag_update_o <= wrdata_reg(18);
-- Debug message byte for the selected core
-- Debug Message data available
-- Per-CPU Debug Message Interrupt Enable
  regs_o.dbg_imsk_enable_o <= wrn_cpu_csr_dbg_imsk_enable_int;
-- Operation code
  regs_o.smem_op_o <= wrn_cpu_csr_smem_op_int;
  rwaddr_reg <= wb_adr_i;
  wb_stall_o <= (not ack_sreg(0)) and (wb_stb_i and wb_cyc_i);
-- ACK signal generation. Just pass the LSB of ACK counter.
  wb_ack_o <= ack_sreg(0);
end syn;

-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_cpu_cb.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2014-11-26
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- WR Node CPU Core block top level. Connects an LM32, dedicated peripheral,
-- program/data memory and control registers.
-------------------------------------------------------------------------------
--
-- Copyright (c) 2014 CERN
--
-- This source file is free software; you can redistribute it   
-- and/or modify it under the terms of the GNU Lesser General   
-- Public License as published by the Free Software Foundation; 
-- either version 2.1 of the License, or (at your option) any   
-- later version.                                               
--
-- This source is distributed in the hope that it will be       
-- useful, but WITHOUT ANY WARRANTY; without even the implied   
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      
-- PURPOSE.  See the GNU Lesser General Public License for more 
-- details.                                                     
--
-- You should have received a copy of the GNU Lesser General    
-- Public License along with this source; if not, download it   
-- from http://www.gnu.org/licenses/lgpl-2.1.html
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.wishbone_pkg.all;
use work.gencores_pkg.all;

use work.wrn_cpu_csr_wbgen2_pkg.all;
use work.wrn_cpu_lr_wbgen2_pkg.all;

use work.wr_node_pkg.all;

entity wrn_cpu_cb is
  
  generic (
    g_cpu_id    : integer;
    g_iram_size : integer
    );

  port (
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    clk_ref_i   : in std_logic;
    rst_n_ref_i : in std_logic;

    tm_i : in t_wrn_timing_if;

    sh_master_i : in  t_wishbone_master_in := cc_dummy_master_in;
    sh_master_o : out t_wishbone_master_out;

    dp_master_i : in  t_wishbone_master_in := cc_dummy_master_in;
    dp_master_o : out t_wishbone_master_out;

    cpu_csr_i : in  t_wrn_cpu_csr_out_registers;
    cpu_csr_o : out t_wrn_cpu_csr_in_registers := c_wrn_cpu_csr_in_registers_init_value;

    rmq_ready_i : in std_logic_vector(15 downto 0);
    hmq_ready_i : in std_logic_vector(15 downto 0);

    gpio_i : in  std_logic_vector(31 downto 0);
    gpio_o : out std_logic_vector(31 downto 0)
    );


end wrn_cpu_cb;

architecture rtl of wrn_cpu_cb is

  component wrn_cpu_lr_wb_slave
    port (
      rst_n_i             : in  std_logic;
      clk_sys_i           : in  std_logic;
      wb_adr_i            : in  std_logic_vector(2 downto 0);
      wb_dat_i            : in  std_logic_vector(31 downto 0);
      wb_dat_o            : out std_logic_vector(31 downto 0);
      wb_cyc_i            : in  std_logic;
      wb_sel_i            : in  std_logic_vector(3 downto 0);
      wb_stb_i            : in  std_logic;
      wb_we_i             : in  std_logic;
      wb_ack_o            : out std_logic;
      wb_stall_o          : out std_logic;
      tai_sec_rd_ack_o : out std_logic;
      regs_i              : in  t_wrn_cpu_lr_in_registers;
      regs_o              : out t_wrn_cpu_lr_out_registers);
  end component;

  component wrn_lm32_wrapper
    generic (
      g_iram_size : integer;
      g_cpu_id    : integer);
    port (
      clk_sys_i : in  std_logic;
      rst_n_i   : in  std_logic;
      irq_i     : in  std_logic_vector(31 downto 0) := x"00000000";
      dwb_o     : out t_wishbone_master_out;
      dwb_i     : in  t_wishbone_master_in;
      cpu_csr_i : in  t_wrn_cpu_csr_out_registers;
      cpu_csr_o : out t_wrn_cpu_csr_in_registers);
  end component;

  constant c_local_wishbone_masters : integer := 3;

  signal cnx_master_in  : t_wishbone_master_in_array(c_local_wishbone_masters-1 downto 0);
  signal cnx_master_out : t_wishbone_master_out_array(c_local_wishbone_masters-1 downto 0);

  constant c_slave_lr : integer := 0;
  constant c_slave_dp : integer := 1;
  constant c_slave_si : integer := 2;
  
  constant c_cnx_address : t_wishbone_address_array(2 downto 0) := (
    c_slave_lr => x"00100000",          -- local regs
    c_slave_dp => x"00200000",          -- dedicated peripheral port
    c_slave_si => x"40000000"           -- shared interconnect
    );

  constant c_cnx_mask : t_wishbone_address_array(2 downto 0) := (
    c_slave_lr => x"fff00000",
    c_slave_dp => x"fff00000",
    c_slave_si => x"c0000000"
    );

  signal tai_sec_rd_ack : std_logic;
  signal local_regs_in     : t_wrn_cpu_lr_in_registers;
  signal local_regs_out    : t_wrn_cpu_lr_out_registers;

  signal cpu_dwb_out : t_wishbone_master_out;
  signal cpu_dwb_in  : t_wishbone_master_in;

  signal tai_sys                        : std_logic_vector(31 downto 0);
  signal cycles_sys, cycles_sys_d0, cycles_sys_d1 : std_logic_vector(27 downto 0);

  signal tai_ref    : std_logic_vector(31 downto 0);
  signal cycles_ref : std_logic_vector(27 downto 0);

  signal tm_p_ref, tm_ready_ref, tm_p_sys, tm_p_ref_d0 : std_logic;
  
begin  -- rtl


  U_Sync1 : gc_pulse_synchronizer
    port map (
      clk_in_i  => clk_ref_i,
      clk_out_i => clk_sys_i,
      rst_n_i   => rst_n_i,
      d_ready_o => tm_ready_ref,
      d_p_i     => tm_p_ref,
      q_p_o     => tm_p_sys);

  U_Sync2 : gc_sync_ffs
    port map (
      clk_i  => clk_sys_i,
      rst_n_i   => rst_n_i,
      data_i => tm_i.link_up,
      synced_o => local_regs_in.stat_wr_link_i);

  U_Sync3 : gc_sync_ffs
    port map (
      clk_i  => clk_sys_i,
      rst_n_i   => rst_n_i,
      data_i => tm_i.time_valid,
      synced_o => local_regs_in.stat_wr_time_ok_i);

  U_Sync4 : gc_sync_register
    generic map (
      g_width => 8)
    port map (
      clk_i  => clk_sys_i,
      rst_n_a_i   => rst_n_i,
      d_i => tm_i.aux_locked,
      q_o => local_regs_in.stat_wr_aux_clock_ok_i);

  process(clk_ref_i)
  begin
    if rising_edge(clk_ref_i) then
      if rst_n_ref_i = '0' then
        tm_p_ref    <= '0';
      else
        tm_p_ref    <= not tm_p_ref and tm_ready_ref;

        if(tm_p_ref = '1') then
          tai_ref    <= tm_i.tai (31 downto 0);
          cycles_ref <= tm_i.cycles;
        end if;
      end if;
    end if;
  end process;

  process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if(tm_p_sys = '1') then
        cycles_sys <= cycles_ref;
        tai_sys <= tai_ref;
      end if;
      cycles_sys_d0 <= cycles_sys;
    end if;
  end process;

  -- ugly hack!
  process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if(tai_sec_rd_ack = '1') then
        local_regs_in.tai_cycles_i <= cycles_sys_d0;
      end if;
    end if;
  end process;

  local_regs_in.tai_sec_i    <= tai_sys;

  p_gpio : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' then
        gpio_o <= (others => '0');
      else
        for i in 0 to 31 loop
        local_regs_in.gpio_in_i(i) <= gpio_i(i);

          if local_regs_out.gpio_set_wr_o = '1' and local_regs_out.gpio_set_o(i) = '1' then
            gpio_o(i) <= '1';
          end if;

          if local_regs_out.gpio_clear_wr_o = '1' and local_regs_out.gpio_clear_o(i) = '1' then
            gpio_o(i) <= '0';
          end if;
        end loop;
      end if;
    end if;
  end process;

  U_TheCoreCPU : wrn_lm32_wrapper
    generic map (
      g_iram_size => g_iram_size,
      g_cpu_id    => g_cpu_id)
    port map (
      clk_sys_i => clk_sys_i,
      rst_n_i   => rst_n_i,
      irq_i     => x"00000000",  -- no irqs, we want to be deterministic...
      dwb_o     => cpu_dwb_out,
      dwb_i     => cpu_dwb_in,
      cpu_csr_i => cpu_csr_i,
      cpu_csr_o => cpu_csr_o);


  U_Local_Registrers : wrn_cpu_lr_wb_slave
    port map (
      rst_n_i             => rst_n_i,
      clk_sys_i           => clk_sys_i,
      wb_adr_i            => cnx_master_out(c_slave_lr).adr(4 downto 2),
      wb_dat_i            => cnx_master_out(c_slave_lr).dat,
      wb_dat_o            => cnx_master_in(c_slave_lr).dat,
      wb_cyc_i            => cnx_master_out(c_slave_lr).cyc,
      wb_sel_i            => cnx_master_out(c_slave_lr).sel,
      wb_stb_i            => cnx_master_out(c_slave_lr).stb,
      wb_we_i             => cnx_master_out(c_slave_lr).we,
      wb_ack_o            => cnx_master_in(c_slave_lr).ack,
      wb_stall_o          => cnx_master_in(c_slave_lr).stall,
      tai_sec_rd_ack_o => tai_sec_rd_ack,
      regs_i              => local_regs_in,
      regs_o              => local_regs_out);

  cnx_master_in(c_slave_lr).err <= '0';
  cnx_master_in(c_slave_lr).rty <= '0';

  local_regs_in.poll_hmq_i <= hmq_ready_i;
  local_regs_in.poll_rmq_i <= rmq_ready_i;


  U_Local_Interconnect : xwb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => c_local_wishbone_masters,
      g_registered  => true,
      g_address     => c_cnx_address,
      g_mask        => c_cnx_mask)
    port map (
      clk_sys_i  => clk_sys_i,
      rst_n_i    => rst_n_i,
      slave_i(0) => cpu_dwb_out,
      slave_o(0) => cpu_dwb_in,
      master_i   => cnx_master_in,
      master_o   => cnx_master_out);

  dp_master_o               <= cnx_master_out(c_slave_dp);
  cnx_master_in(c_slave_dp) <= dp_master_i;

  sh_master_o               <= cnx_master_out(c_slave_si);
  cnx_master_in(c_slave_si) <= sh_master_i;


end rtl;

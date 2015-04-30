-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wr_node_core.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2015-04-29
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- White Rabbit Node Core - top level, interconnecting the CPU cores,
-- Message Queues, Host interface and the Shared Memory.
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
use ieee.numeric_std.all;

use work.wr_node_pkg.all;
use work.wishbone_pkg.all;
use work.wrn_cpu_csr_wbgen2_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.gencores_pkg.all;

entity wr_node_core is
  
  generic (
    g_config : t_wr_node_config := c_default_node_config;
    g_double_core_clock : boolean := false);

  port (
    clk_i   : in std_logic;
    -- optional, 2x faster CPU core clock
    clk_cpu_i : in std_logic := '0';
    rst_n_i : in std_logic;

    sp_master_o : out t_wishbone_master_out;
    sp_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    dp_master_o : out t_wishbone_master_out_array(0 to g_config.cpu_count-1);
    dp_master_i : in  t_wishbone_master_in_array(0 to g_config.cpu_count-1) := f_dummy_master_in_array(g_config.cpu_count);

    ebm_master_o : out t_wishbone_master_out;
    ebm_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    ebs_slave_o : out t_wishbone_slave_out;
    ebs_slave_i : in  t_wishbone_slave_in := cc_dummy_slave_in;

    host_slave_i : in  t_wishbone_slave_in;
    host_slave_o : out t_wishbone_slave_out;

    clk_ref_i : in std_logic;
    tm_i      : in t_wrn_timing_if;

    gpio_o : out std_logic_vector(31 downto 0);
    gpio_i : in  std_logic_vector(31 downto 0);

    host_irq_o      : out std_logic;
    debug_msg_irq_o : out std_logic
    );

end wr_node_core;

architecture rtl of wr_node_core is

  component wrn_cpu_cb
    generic (
      g_cpu_id    : integer;
      g_iram_size : integer;
      g_double_core_clock : boolean);
    port (
      clk_sys_i   : in  std_logic;
      rst_n_i     : in  std_logic;
      clk_ref_i   : in  std_logic;
      rst_n_ref_i : in  std_logic;
      clk_cpu_i : in std_logic;
      tm_i        : in  t_wrn_timing_if;
      sh_master_i : in  t_wishbone_master_in;
      sh_master_o : out t_wishbone_master_out;
      dp_master_i : in  t_wishbone_master_in;
      dp_master_o : out t_wishbone_master_out;
      cpu_csr_i   : in  t_wrn_cpu_csr_out_registers;
      cpu_csr_o   : out t_wrn_cpu_csr_in_registers;
      rmq_ready_i : in  std_logic_vector(15 downto 0);
      hmq_ready_i : in  std_logic_vector(15 downto 0);
      gpio_o      : out std_logic_vector(31 downto 0);
      gpio_i      : in  std_logic_vector(31 downto 0);
      dbg_drdy_o  : out std_logic;
      dbg_dack_i  : in  std_logic;
      dbg_data_o  : out std_logic_vector(7 downto 0)
      );
  end component;

  component wrn_cpu_csr_wb_slave is
    port (
      rst_n_i               : in  std_logic;
      clk_sys_i             : in  std_logic;
      wb_adr_i              : in  std_logic_vector(3 downto 0);
      wb_dat_i              : in  std_logic_vector(31 downto 0);
      wb_dat_o              : out std_logic_vector(31 downto 0);
      wb_cyc_i              : in  std_logic;
      wb_sel_i              : in  std_logic_vector(3 downto 0);
      wb_stb_i              : in  std_logic;
      wb_we_i               : in  std_logic;
      wb_ack_o              : out std_logic;
      wb_stall_o            : out std_logic;
      dbg_msg_data_rd_ack_o : out std_logic;
      regs_i                : in  t_wrn_cpu_csr_in_registers;
      regs_o                : out t_wrn_cpu_csr_out_registers);
  end component wrn_cpu_csr_wb_slave;

  component wrn_mqueue_host
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      si_slave_i   : in  t_wishbone_slave_in;
      si_slave_o   : out t_wishbone_slave_out;
      host_slave_i : in  t_wishbone_slave_in;
      host_slave_o : out t_wishbone_slave_out;
      host_irq_o   : out std_logic;
      hmq_status_o : out std_logic_vector(15 downto 0));
  end component;

  component wrn_mqueue_remote
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      si_slave_i   : in  t_wishbone_slave_in;
      si_slave_o   : out t_wishbone_slave_out;
      ebm_master_o : out t_wishbone_master_out;
      ebm_master_i : in  t_wishbone_master_in := cc_dummy_master_in;
      ebs_slave_o  : out t_wishbone_slave_out;
      ebs_slave_i  : in  t_wishbone_slave_in  := cc_dummy_slave_in;
      rmq_status_o : out std_logic_vector(15 downto 0));
  end component;

  component wrn_shared_mem is
    generic (
      g_size : integer);
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      slave_i : in  t_wishbone_slave_in;
      slave_o : out t_wishbone_slave_out);
  end component wrn_shared_mem;

  component wb_remapper is
    generic (
      g_num_ranges : integer;
      g_base_in    : t_wishbone_address_array;
      g_base_out   : t_wishbone_address_array;
      g_mask_in    : t_wishbone_address_array;
      g_mask_out   : t_wishbone_address_array);
    port (
      slave_i  : in  t_wishbone_slave_in;
      slave_o  : out t_wishbone_slave_out;
      master_i : in  t_wishbone_master_in;
      master_o : out t_wishbone_master_out);
  end component wb_remapper;

  constant c_smem_remap_mask_in  : t_wishbone_address_array(0 downto 0) := (0 => x"00018000");
  constant c_smem_remap_mask_out : t_wishbone_address_array(0 downto 0) := (0 => x"00007fff");

  constant c_smem_remap_base_in  : t_wishbone_address_array(0 downto 0) := (0 => x"00018000");
  constant c_smem_remap_base_out : t_wishbone_address_array(0 downto 0) := (0 => x"00200000");


  constant c_hac_wishbone_masters : integer := 3;
  constant c_hac_master_hmq       : integer := 0;
  constant c_hac_master_cpu_csr   : integer := 1;
  constant c_hac_master_si        : integer := 2;

  constant c_hac_address : t_wishbone_address_array(c_hac_wishbone_masters-1 downto 0) := (
    c_hac_master_hmq     => x"00000000",  -- Host MQ
    c_hac_master_cpu_csr => x"00010000",  -- CPU CSR
    c_hac_master_si      => x"00200000"   -- shared interconnect
    );

  constant c_hac_mask : t_wishbone_address_array(c_hac_wishbone_masters-1 downto 0) := (
    c_hac_master_hmq     => x"00210000",  -- Host MQ
    c_hac_master_cpu_csr => x"00210000",  -- CPU CSR
    c_hac_master_si      => x"00200000"   -- shared interconnect
    );

  signal hac_master_out : t_wishbone_master_out_array(c_hac_wishbone_masters-1 downto 0);
  signal hac_master_in  : t_wishbone_master_in_array(c_hac_wishbone_masters-1 downto 0);

  constant c_si_wishbone_masters : integer := 4;
  constant c_si_wishbone_slaves  : integer := g_config.cpu_count + 2;
  constant c_si_master_hmq       : integer := 0;
  constant c_si_master_rmq       : integer := 1;
  constant c_si_master_smem      : integer := 2;
  constant c_si_master_sp        : integer := 3;

  constant c_si_slave_hac  : integer := 0;
  constant c_si_slave_ebs  : integer := 1;
  constant c_si_slave_cpu0 : integer := 2;
  

  constant c_si_address : t_wishbone_address_array(c_si_wishbone_masters-1 downto 0) := (
    c_si_master_hmq  => x"00010000",    -- Host MQ
    c_si_master_rmq  => x"00020000",    -- Remote MQ
    c_si_master_smem => x"00000000",    -- Shared Memory
    c_si_master_sp   => x"00100000"
    );

  constant c_si_mask : t_wishbone_address_array(c_si_wishbone_masters-1 downto 0) := (
    c_si_master_hmq  => x"001f0000",    -- Host MQ
    c_si_master_rmq  => x"001f0000",    -- Remote MQ
    c_si_master_smem => x"001f0000",    -- Shared Memory
    c_si_master_sp   => x"00100000"
    );

  signal si_slave_in  : t_wishbone_slave_in_array(c_si_wishbone_slaves-1 downto 0);
  signal si_slave_out : t_wishbone_slave_out_array(c_si_wishbone_slaves-1 downto 0);

  signal si_master_in  : t_wishbone_master_in_array(c_si_wishbone_masters-1 downto 0);
  signal si_master_out : t_wishbone_master_out_array(c_si_wishbone_masters-1 downto 0);


  signal cpu_csr_fromwb : t_wrn_cpu_csr_out_registers;
  signal cpu_csr_towb   : t_wrn_cpu_csr_in_registers;

  signal hmq_status, rmq_status : std_logic_vector(15 downto 0);


  signal cpu_index : integer := 0;

  type t_wrn_cpu_csr_in_registers_array is array(integer range <>) of t_wrn_cpu_csr_in_registers;

  type t_gpio_out_array is array(integer range <>) of std_logic_vector(31 downto 0);
  type t_dbg_msg_data_array is array(integer range <>) of std_logic_vector(7 downto 0);

  signal cpu_dbg_drdy, cpu_dbg_dack : std_logic_vector(g_config.cpu_count-1 downto 0);
  signal cpu_dbg_msg_data           : t_dbg_msg_data_array(g_config.cpu_count-1 downto 0);
  signal dbg_msg_data_read_ack      : std_logic;




  signal cpu_csr_towb_cb : t_wrn_cpu_csr_in_registers_array (g_config.cpu_count-1 downto 0);
  signal cpu_gpio_out    : t_gpio_out_array (g_config.cpu_count-1 downto 0);

  signal rst_n_ref : std_logic;

  signal host_remapped_in  : t_wishbone_slave_in;
  signal host_remapped_out : t_wishbone_slave_out;

  function f_reduce_or (x : t_gpio_out_array) return std_logic_vector is
    variable rv : std_logic_vector(31 downto 0);
  begin
    rv := (others => '0');
    for n in 0 to x'length-1 loop
      for i in 0 to 31 loop
        if(x(n)(i) = '1') then
          rv(i) := '1';
        end if;
      end loop;
    end loop;
    return rv;
  end f_reduce_or;
  
begin  -- rtl

  U_Sync_Refclk : gc_sync_ffs
    port map (
      clk_i    => clk_ref_i,
      rst_n_i  => '1',
      data_i   => rst_n_i,
      synced_o => rst_n_ref);


  U_Remap_SMEM : wb_remapper
    generic map (
      g_num_ranges => 1,
      g_base_in    => c_smem_remap_base_in,
      g_base_out   => c_smem_remap_base_out,
      g_mask_in    => c_smem_remap_mask_in,
      g_mask_out   => c_smem_remap_mask_out)
    port map (
      slave_i  => host_slave_i,
      slave_o  => host_slave_o,
      master_i => host_remapped_out,
      master_o => host_remapped_in);

  U_Host_Access_CB : xwb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => c_hac_wishbone_masters,
      g_registered  => true,
      g_address     => c_hac_address,
      g_mask        => c_hac_mask)
    port map (
      clk_sys_i  => clk_i,
      rst_n_i    => rst_n_i,
      slave_i(0) => host_remapped_in,
      slave_o(0) => host_remapped_out,
      master_i   => hac_master_in,
      master_o   => hac_master_out);


  U_Shared_Interconnect : xwb_crossbar
    generic map (
      g_num_masters => c_si_wishbone_slaves,
      g_num_slaves  => c_si_wishbone_masters,
      g_registered  => true,
      g_address     => c_si_address,
      g_mask        => c_si_mask)
    port map (
      clk_sys_i => clk_i,
      rst_n_i   => rst_n_i,
      slave_i   => si_slave_in,
      slave_o   => si_slave_out,
      master_i  => si_master_in,
      master_o  => si_master_out);

  sp_master_o                   <= si_master_out(c_si_master_sp);
  si_master_in (c_si_master_sp) <= sp_master_i;


  si_slave_in(c_si_slave_hac)    <= hac_master_out(c_hac_master_si);
  hac_master_in(c_hac_master_si) <= si_slave_out(c_si_slave_hac);

  si_slave_in(c_si_slave_ebs) <= cc_dummy_slave_in;
  -- fixme: bypass for EB slave
--  si_slave_in(c_si_slave_ebs) <= ebs_slave_i;
--  ebs_slave_o                 <= si_slave_out(c_si_slave_ebs);


  U_CPU_CSR : wrn_cpu_csr_wb_slave
    port map (
      rst_n_i               => rst_n_i,
      clk_sys_i             => clk_i,
      wb_adr_i              => hac_master_out(c_hac_master_cpu_csr).adr(5 downto 2),
      wb_dat_i              => hac_master_out(c_hac_master_cpu_csr).dat,
      wb_dat_o              => hac_master_in(c_hac_master_cpu_csr).dat,
      wb_cyc_i              => hac_master_out(c_hac_master_cpu_csr).cyc,
      wb_sel_i              => hac_master_out(c_hac_master_cpu_csr).sel,
      wb_stb_i              => hac_master_out(c_hac_master_cpu_csr).stb,
      wb_we_i               => hac_master_out(c_hac_master_cpu_csr).we,
      wb_ack_o              => hac_master_in(c_hac_master_cpu_csr).ack,
      wb_stall_o            => hac_master_in(c_hac_master_cpu_csr).stall,
      dbg_msg_data_rd_ack_o => dbg_msg_data_read_ack,
      regs_i                => cpu_csr_towb,
      regs_o                => cpu_csr_fromwb);

  hac_master_in(c_hac_master_cpu_csr).err <= '0';
  hac_master_in(c_hac_master_cpu_csr).rty <= '0';

  cpu_index <= to_integer(unsigned(cpu_csr_fromwb.core_sel_o));

  cpu_csr_towb.app_id_i       <= g_config.app_id;
  cpu_csr_towb.core_count_i   <= std_logic_vector(to_unsigned(g_config.cpu_count, 4));
  cpu_csr_towb.core_memsize_i <= std_logic_vector(to_unsigned(g_config.cpu_memsizes(cpu_index), 16));

  gen_cpus : for i in 0 to g_config.cpu_count-1 generate

    U_CPU_Block : wrn_cpu_cb
      generic map (
        g_cpu_id    => i,
        g_iram_size => g_config.cpu_memsizes(i),
        g_double_core_clock => g_double_core_clock)
      port map (
        clk_sys_i   => clk_i,
        rst_n_i     => rst_n_i,
        clk_ref_i   => clk_ref_i,
        rst_n_ref_i => rst_n_ref,
        clk_cpu_i => clk_cpu_i,
        tm_i        => tm_i,
        sh_master_i => si_slave_out(c_si_slave_cpu0 + i),
        sh_master_o => si_slave_in(c_si_slave_cpu0 + i),
        dp_master_i => dp_master_i(i),
        dp_master_o => dp_master_o(i),
        cpu_csr_i   => cpu_csr_fromwb,
        cpu_csr_o   => cpu_csr_towb_cb(i),
        rmq_ready_i => rmq_status,
        hmq_ready_i => hmq_status,
        gpio_o      => cpu_gpio_out(i),
        gpio_i      => gpio_i,
        dbg_drdy_o  => cpu_dbg_drdy(i),
        dbg_dack_i  => cpu_dbg_dack(i),
        dbg_data_o  => cpu_dbg_msg_data(i));

  end generate gen_cpus;

  cpu_csr_towb.udata_i <= cpu_csr_towb_cb(cpu_index).udata_i;

  U_Host_MQ : wrn_mqueue_host
    generic map (
      g_config => g_config.hmq_config)
    port map (
      clk_i        => clk_i,
      rst_n_i      => rst_n_i,
      si_slave_i   => si_master_out(c_si_master_hmq),
      si_slave_o   => si_master_in(c_si_master_hmq),
      host_slave_i => hac_master_out(c_hac_master_hmq),
      host_slave_o => hac_master_in(c_hac_master_hmq),
      host_irq_o   => host_irq_o,
      hmq_status_o => hmq_status);

  U_Remote_MQ : wrn_mqueue_remote
    generic map (
      g_config => g_config.rmq_config)
    port map (
      clk_i        => clk_i,
      rst_n_i      => rst_n_i,
      si_slave_i   => si_master_out(c_si_master_rmq),
      si_slave_o   => si_master_in(c_si_master_rmq),
      ebm_master_o => ebm_master_o,
      ebm_master_i => ebm_master_i,
      ebs_slave_o  => ebs_slave_o,
      ebs_slave_i  => ebs_slave_i,
      rmq_status_o => rmq_status);

  
  U_Shared_Mem : wrn_shared_mem
    generic map (
      g_size => 2048)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      slave_i => si_master_out(c_si_master_smem),
      slave_o => si_master_in(c_si_master_smem));


  p_mux_debug_data : process(cpu_dbg_msg_data, cpu_csr_fromwb, dbg_msg_data_read_ack)
  begin

    cpu_csr_towb.dbg_msg_data_i <= (others => 'X');

    for i in 0 to g_config.cpu_count-1 loop
      if unsigned(cpu_csr_fromwb.core_sel_o) = to_unsigned(i, 4) then
        cpu_csr_towb.dbg_msg_data_i <= cpu_dbg_msg_data(i);
        cpu_dbg_dack(i)             <= dbg_msg_data_read_ack;
      else
        cpu_dbg_dack(i) <= '0';
      end if;
    end loop;
  end process;

  p_debug_irq : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        debug_msg_irq_o <= '0';
      else
        debug_msg_irq_o <= '0';

        for i in 0 to g_config.cpu_count-1 loop
          if (cpu_dbg_drdy(i) and cpu_csr_fromwb.dbg_imsk_enable_o(i)) = '1' then
            debug_msg_irq_o <= '1';
          end if;
        end loop;
      end if;
    end if;
  end process;

  cpu_csr_towb.dbg_poll_ready_i(g_config.cpu_count-1 downto 0) <= cpu_dbg_drdy;
  
  gpio_o <= f_reduce_or(cpu_gpio_out);
end rtl;



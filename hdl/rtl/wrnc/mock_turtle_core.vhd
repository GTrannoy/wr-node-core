-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mock_turtle_core.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-20
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Mock Turtle Core - top level, interconnecting the CPU cores,
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

use work.mock_turtle_pkg.all;
use work.wishbone_pkg.all;
use work.mt_cpu_csr_wbgen2_pkg.all;
use work.mt_mqueue_pkg.all;
use work.gencores_pkg.all;
use work.wr_fabric_pkg.all;

entity mock_turtle_core is
  
  generic (
-- Message Queue and CPU configuration
    g_config            : t_mock_turtle_config := c_default_mock_turtle_config;
-- When true, the CPUs can run with 2x the system clock. User design must
--    supply the clk_cpu_i signal which is in phase with the clk_i signal.
    g_double_core_clock : boolean          := false;
-- When true, the Remote Message Queue is implemented.
    g_with_rmq          : boolean          := true;
    g_use_wr_fabric     : boolean          := true;
-- Frequency of clk_sys_i, in Hz
    g_system_clock_freq : integer          := 62500000;
-- Enables/disables WR support
    g_with_white_rabbit : boolean          := false
    );

  port (
    clk_i     : in std_logic;
    -- optional, 2x faster CPU core clock
    clk_cpu_i : in std_logic := '0';
    rst_n_i   : in std_logic;

    sp_master_o : out t_wishbone_master_out;
    sp_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    dp_master_o : out t_wishbone_master_out_array(0 to g_config.cpu_count-1);
    dp_master_i : in  t_wishbone_master_in_array(0 to g_config.cpu_count-1) := f_dummy_master_in_array(g_config.cpu_count);

    rmq_src_o : out t_mt_stream_source_out;
    rmq_src_i : in  t_mt_stream_source_in := c_mt_dummy_source_in;
    rmq_snk_o : out t_mt_stream_sink_out;
    rmq_snk_i : in  t_mt_stream_sink_in   := c_mt_dummy_sink_in;

    wr_src_o : out t_wrf_source_out;
    wr_src_i : in  t_wrf_source_in := c_dummy_src_in;
    wr_snk_o : out t_wrf_sink_out;
    wr_snk_i : in  t_wrf_sink_in   := c_dummy_snk_in;

    host_slave_i : in  t_wishbone_slave_in;
    host_slave_o : out t_wishbone_slave_out;

    clk_ref_i : in std_logic := '0';
    tm_i      : in t_mt_timing_if;

    gpio_o : out std_logic_vector(31 downto 0);
    gpio_i : in  std_logic_vector(31 downto 0);

    rmq_swrst_o : out std_logic;

    host_irq_o      : out std_logic;
    debug_msg_irq_o : out std_logic
    );

end mock_turtle_core;

architecture rtl of mock_turtle_core is

  ------------------------------------------
  --        COMPONENTs DECLARATION  
  ------------------------------------------ 
  
  component mt_cpu_cb is
    generic (
      g_cpu_id            : integer;
      g_iram_size         : integer;
      g_system_clock_freq : integer;
      g_double_core_clock : boolean;
      g_with_white_rabbit : boolean);
    port (
      clk_sys_i   : in  std_logic;
      rst_n_i     : in  std_logic;
      clk_ref_i   : in  std_logic;
      rst_n_ref_i : in  std_logic;
      clk_cpu_i   : in  std_logic;
      tm_i        : in  t_mt_timing_if;
      sh_master_i : in  t_wishbone_master_in       := cc_dummy_master_in;
      sh_master_o : out t_wishbone_master_out;
      dp_master_i : in  t_wishbone_master_in       := cc_dummy_master_in;
      dp_master_o : out t_wishbone_master_out;
      cpu_csr_i   : in  t_mt_cpu_csr_out_registers;
      cpu_csr_o   : out t_mt_cpu_csr_in_registers := c_mt_cpu_csr_in_registers_init_value;
      rmq_ready_i : in  std_logic_vector(15 downto 0);
      hmq_ready_i : in  std_logic_vector(15 downto 0);
      gpio_i      : in  std_logic_vector(31 downto 0);
      gpio_o      : out std_logic_vector(31 downto 0);
      dbg_drdy_o  : out std_logic;
      dbg_dack_i  : in  std_logic;
      dbg_data_o  : out std_logic_vector(7 downto 0));
  end component mt_cpu_cb;

  component mt_cpu_csr_wb_slave is
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
      regs_i                : in  t_mt_cpu_csr_in_registers;
      regs_o                : out t_mt_cpu_csr_out_registers);
  end component mt_cpu_csr_wb_slave;

  component mt_mqueue_host
    generic (
      g_config : t_mt_mqueue_config);
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

  component mt_mqueue_remote is
    generic (
      g_config        : t_mt_mqueue_config;
      g_use_wr_fabric : boolean);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      si_slave_i   : in  t_wishbone_slave_in;
      si_slave_o   : out t_wishbone_slave_out;
      src_o        : out t_mt_stream_source_out;
      src_i        : in  t_mt_stream_source_in;
      snk_o        : out t_mt_stream_sink_out;
      snk_i        : in  t_mt_stream_sink_in;
      wr_snk_i     : in  t_wrf_sink_in   := c_dummy_snk_in;
      wr_snk_o     : out t_wrf_sink_out;
      wr_src_i     : in  t_wrf_source_in := c_dummy_src_in;
      wr_src_o     : out t_wrf_source_out;
      rmq_swrst_o  : out std_logic;
      rmq_status_o : out std_logic_vector(15 downto 0);
      debug_o      : out std_logic_vector(31 downto 0));
  end component mt_mqueue_remote;

  component mt_shared_mem is
    generic (
      g_size : integer);
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      slave_i : in  t_wishbone_slave_in;
      slave_o : out t_wishbone_slave_out);
  end component mt_shared_mem;

  component mt_wb_remapper is
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
  end component mt_wb_remapper;

  component chipscope_ila
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      CLK     : in    std_logic;
      TRIG0   : in    std_logic_vector(31 downto 0);
      TRIG1   : in    std_logic_vector(31 downto 0);
      TRIG2   : in    std_logic_vector(31 downto 0);
      TRIG3   : in    std_logic_vector(31 downto 0));
  end component;

  component chipscope_icon
    port (
      CONTROL0 : inout std_logic_vector (35 downto 0));
  end component;

  ------------------------------------------
  --        CONSTANTS DECLARATION  
  ------------------------------------------
  
  constant c_smem_remap_mask_in : t_wishbone_address_array(4 downto 0) := (
    0 => x"0001c000",
    1 => x"0001c000",
    2 => x"0001c000",
    3 => x"0001c000",
    4 => x"00010000"
    );
  constant c_smem_remap_mask_out : t_wishbone_address_array(4 downto 0) := (
    0 => x"00003fff",
    1 => x"00003fff",
    2 => x"00003fff",
    3 => x"00003fff",
    4 => x"0000ffff"
    );

  constant c_smem_remap_base_in : t_wishbone_address_array(4 downto 0) := (
    0 => x"00000000",
    1 => x"00004000",
    2 => x"00008000",
    3 => x"0000c000",
    4 => x"00010000"
    );

  -- remapping to squeeze the host address space to 128 kB
  constant c_smem_remap_base_out : t_wishbone_address_array(4 downto 0) := (
    0 => x"00000000",                   -- 0x0000-0x3fff -> HMQ GCR
    1 => x"00004000",                   -- 0x4000-0x7fff -> HMQ IN (muxed)
    2 => x"00008000",                   -- 0x8000-0xbfff -> HMQ OUT (muxed)
    3 => x"00010000",                   -- 0xc000-0xffff -> CPU CSR
    4 => x"00200000"                    -- 0x10000-0x1ffff -> SMEM
    );


  constant c_hac_wishbone_masters : integer := 3;
  constant c_hac_master_hmq       : integer := 0;
  constant c_hac_master_cpu_csr   : integer := 1;
  constant c_hac_master_si        : integer := 2;

  constant c_hac_address : t_wishbone_address_array(c_hac_wishbone_masters-1 downto 0) := (
    c_hac_master_hmq     => x"00000000",  -- Host MQ
    c_hac_master_cpu_csr => x"00010000",  -- CPU CSR
    c_hac_master_si      => x"00200000"   -- SMEM
    );

  constant c_hac_mask : t_wishbone_address_array(c_hac_wishbone_masters-1 downto 0) := (
    c_hac_master_hmq     => x"003f0000",  -- Host MQ
    c_hac_master_cpu_csr => x"003f0000",  -- CPU CSR
    c_hac_master_si      => x"00300000"   -- SMEM
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
    c_si_master_hmq  => x"00000000",    -- Host MQ
    c_si_master_rmq  => x"00100000",    -- Remote MQ
    c_si_master_smem => x"00200000",    -- Shared Memory
    c_si_master_sp   => x"08000000"
    );

  constant c_si_mask : t_wishbone_address_array(c_si_wishbone_masters-1 downto 0) := (
    c_si_master_hmq  => x"0ff00000",    -- Host MQ
    c_si_master_rmq  => x"0ff00000",    -- Remote MQ
    c_si_master_smem => x"0ff00000",    -- Shared Memory
    c_si_master_sp   => x"08000000"
    );

  signal si_slave_in  : t_wishbone_slave_in_array(c_si_wishbone_slaves-1 downto 0);
  signal si_slave_out : t_wishbone_slave_out_array(c_si_wishbone_slaves-1 downto 0);

  signal si_master_in  : t_wishbone_master_in_array(c_si_wishbone_masters-1 downto 0);
  signal si_master_out : t_wishbone_master_out_array(c_si_wishbone_masters-1 downto 0);


  signal cpu_csr_fromwb : t_mt_cpu_csr_out_registers;
  signal cpu_csr_towb   : t_mt_cpu_csr_in_registers;

  signal hmq_status, rmq_status : std_logic_vector(15 downto 0);


  signal cpu_index : integer := 0;

  type t_mt_cpu_csr_in_registers_array is array(integer range <>) of t_mt_cpu_csr_in_registers;

  type t_gpio_out_array is array(integer range <>) of std_logic_vector(31 downto 0);
  type t_dbg_msg_data_array is array(integer range <>) of std_logic_vector(7 downto 0);

  signal cpu_dbg_drdy, cpu_dbg_dack : std_logic_vector(g_config.cpu_count-1 downto 0);
  signal cpu_dbg_msg_data           : t_dbg_msg_data_array(g_config.cpu_count-1 downto 0);
  signal dbg_msg_data_read_ack      : std_logic;


  signal cpu_csr_towb_cb : t_mt_cpu_csr_in_registers_array (g_config.cpu_count-1 downto 0);
  signal cpu_gpio_out    : t_gpio_out_array (g_config.cpu_count-1 downto 0);

  signal rst_n_ref : std_logic;

  signal host_remapped_in  : t_wishbone_slave_in;
  signal host_remapped_out : t_wishbone_slave_out;

  signal ebm_master : t_wishbone_master_out;
  --  Signals for chip Scope  -----------------
  signal CONTROL    : std_logic_vector(35 downto 0);
  signal CLK        : std_logic;
  signal TRIG0      : std_logic_vector(31 downto 0);
  signal TRIG1      : std_logic_vector(31 downto 0);
  signal TRIG2      : std_logic_vector(31 downto 0);
  signal TRIG3      : std_logic_vector(31 downto 0);
  ---------------------------------------------

  ------------------------------------------
  --        FUNCTIONS DECLARATION 
  ------------------------------------------
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


  U_Remap_SMEM : mt_wb_remapper
    generic map (
      g_num_ranges => 5,
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

-- hack: replace SMEM high address bits with the SMEM_OP register value. This way,
-- the entire 64 kB SMEM window can be visible to the host with direct addressing,
-- and only the type of atomic operation has to be chosen indirectly (by
-- writing to SMEM_OP).

  si_slave_in(c_si_slave_hac).cyc               <= hac_master_out(c_hac_master_si).cyc;
  si_slave_in(c_si_slave_hac).stb               <= hac_master_out(c_hac_master_si).stb;
  si_slave_in(c_si_slave_hac).we                <= hac_master_out(c_hac_master_si).we;
  si_slave_in(c_si_slave_hac).sel               <= hac_master_out(c_hac_master_si).sel;
  si_slave_in(c_si_slave_hac).dat               <= hac_master_out(c_hac_master_si).dat;
  si_slave_in(c_si_slave_hac).adr(15 downto 0)  <= hac_master_out(c_hac_master_si).adr(15 downto 0);
  si_slave_in(c_si_slave_hac).adr(19 downto 16) <= '0' & cpu_csr_fromwb.smem_op_o;
  si_slave_in(c_si_slave_hac).adr(31 downto 20) <= x"002";

  hac_master_in(c_hac_master_si) <= si_slave_out(c_si_slave_hac);

  si_slave_in(c_si_slave_ebs) <= cc_dummy_slave_in;
  -- fixme: bypass for EB slave
--  si_slave_in(c_si_slave_ebs) <= ebs_slave_i;
--  ebs_slave_o                 <= si_slave_out(c_si_slave_ebs);


  U_CPU_CSR : mt_cpu_csr_wb_slave
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
  cpu_csr_towb.core_memsize_i <= std_logic_vector(to_unsigned(g_config.cpu_memsizes(cpu_index), 32));

  gen_cpus : for i in 0 to g_config.cpu_count-1 generate

    U_CPU_Block : mt_cpu_cb
      generic map (
        g_cpu_id            => i,
        g_iram_size         => g_config.cpu_memsizes(i),
        g_double_core_clock => g_double_core_clock,
        g_with_white_rabbit => g_with_white_rabbit,
        g_system_clock_freq => g_system_clock_freq)
      port map (
        clk_sys_i   => clk_i,
        rst_n_i     => rst_n_i,
        clk_ref_i   => clk_ref_i,
        rst_n_ref_i => rst_n_ref,
        clk_cpu_i   => clk_cpu_i,
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

  U_Host_MQ : mt_mqueue_host
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

  gen_with_rmq : if g_with_rmq generate
    
    U_Remote_MQ : mt_mqueue_remote
      generic map (
        g_config        => g_config.rmq_config,
        g_use_wr_fabric => g_use_wr_fabric
        )
      port map (
        clk_i        => clk_i,
        rst_n_i      => rst_n_i,
        rmq_swrst_o  => rmq_swrst_o,
        si_slave_i   => si_master_out(c_si_master_rmq),
        si_slave_o   => si_master_in(c_si_master_rmq),
        src_o        => rmq_src_o,
        src_i        => rmq_src_i,
        snk_i        => rmq_snk_i,
        snk_o        => rmq_snk_o,
        wr_src_o     => wr_src_o,
        wr_src_i     => wr_src_i,
        wr_snk_o     => wr_snk_o,
        wr_snk_i     => wr_snk_i,
        rmq_status_o => rmq_status,
        debug_o      => trig2);

    
  end generate gen_with_rmq;

  gen_without_rmq : if not g_with_rmq generate
    
    rmq_status                    <= (others => '0');
    si_master_in(c_si_master_rmq) <= cc_dummy_slave_out;

  end generate gen_without_rmq;




  U_Shared_Mem : mt_shared_mem
    generic map (
      g_size => g_config.shared_mem_size / 4)
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



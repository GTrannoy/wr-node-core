-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mock_turtle_pkg.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-21
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Mock Turtle Core - top level package, with public types, definitions
-- and components.
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

use work.wishbone_pkg.all;
use work.mt_mqueue_pkg.all;
use work.wr_fabric_pkg.all;


package mock_turtle_pkg is

  constant c_mt_debug_message_fifo_size : integer := 512;

  type t_mt_timing_if is record
    link_up    : std_logic;
    dac_value  : std_logic_vector(23 downto 0);
    dac_wr     : std_logic;
    time_valid : std_logic;
    tai        : std_logic_vector(39 downto 0);
    cycles     : std_logic_vector(27 downto 0);
    aux_locked : std_logic_vector(7 downto 0);
  end record;

  type t_int_array is array(integer range<>) of integer;

  type t_mock_turtle_config is record
    app_id          : std_logic_vector(31 downto 0);
    cpu_count       : integer;
    -- CPU memory sizes, in bytes
    cpu_memsizes    : t_int_array (0 to 7);
    hmq_config      : t_mt_mqueue_config;
    rmq_config      : t_mt_mqueue_config;
    -- shared memory size, in bytes
    shared_mem_size : integer range 256 to 65536;
  end record;

  constant c_default_mock_turtle_config : t_mock_turtle_config :=
    (
      app_id          => x"115790de",
      cpu_count       => 2,
      cpu_memsizes    => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config      => c_mt_default_mqueue_config,
      rmq_config      => c_mt_default_mqueue_config,
      shared_mem_size => 8192
      );

  --- Functions

  function f_dummy_master_in_array(size : integer)
    return t_wishbone_master_in_array;

  

  constant c_mock_turtle_sdb : t_sdb_device := (
    abi_class     => x"0000",              -- undocumented device
    abi_ver_major => x"01",
    abi_ver_minor => x"00",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"7",                 -- 8/16/32-bit port granularity
    sdb_component => (
      addr_first  => x"0000000000000000",
      addr_last   => x"000000000001ffff",
      product     => (
        vendor_id => x"000000000000CE42",  -- CERN
        device_id => x"000090de",
        version   => x"00000001",
        date      => x"20141201",
        name      => "Mock-Turtle-Core   ")));


  component mock_turtle_core is
    
    generic (
-- Message Queue and CPU configuration
      g_config            : t_mock_turtle_config := c_default_mock_turtle_config;
-- When true, the CPUs can run with 2x the system clock. User design must
--    supply the clk_cpu_i signal which is in phase with the clk_i signal.
      g_double_core_clock : boolean              := false;
-- When true, the Remote Message Queue is implemented.
      g_with_rmq          : boolean              := true;
      g_use_wr_fabric     : boolean              := true;
-- Frequency of clk_sys_i, in Hz
      g_system_clock_freq : integer              := 62500000;
-- Enables/disables WR support
      g_with_white_rabbit : boolean              := false
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
      gpio_i : in  std_logic_vector(31 downto 0) := x"00000000";

      rmq_swrst_o : out std_logic;

      host_irq_o      : out std_logic;
      debug_msg_irq_o : out std_logic
      );

  end component;
  
end mock_turtle_pkg;

package body mock_turtle_pkg is

  
  function f_dummy_master_in_array(size : integer)
    return t_wishbone_master_in_array
  is
    variable rv : t_wishbone_master_in_array(0 to size-1);
  begin
    for i in 0 to size-1 loop
      rv(i) := cc_dummy_master_in;
    end loop;  -- i

    return rv;
  end function;
  
  

end mock_turtle_pkg;

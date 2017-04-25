-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mock_turtle_pkg.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-11-28
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
    app_id       : std_logic_vector(31 downto 0);
    cpu_count    : integer;
    -- CPU memory sizes, in bytes
    cpu_memsizes : t_int_array (0 to 7);
    hmq_config   : t_mt_mqueue_config;
    rmq_config   : t_mt_mqueue_config;
    -- shared memory size, in bytes
    shared_mem_size : integer range 256 to 65536;
  end record;

  constant c_default_mock_turtle_config : t_mock_turtle_config :=
    (
      app_id       => x"115790de",
      cpu_count    => 2,
      cpu_memsizes => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config   => c_mt_default_mqueue_config,
      rmq_config   => c_mt_default_mqueue_config,
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
        name      => "WR-Node-Core       ")));

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
-------------------------------------------------------------------------------
-- Title      : Mock Turtle Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_mqueue_pkg.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-20
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Global package for the Message Queues
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

use work.mt_private_pkg.all;
use work.wishbone_pkg.all;

package mt_mqueue_pkg is

  constant c_MT_STREAM_TAG_HEADER  : std_logic_vector(1 downto 0) := "00";
  constant c_MT_STREAM_TAG_PAYLOAD : std_logic_vector(1 downto 0) := "01";

  type t_rmq_outgoing_slot_config is record
    dst_mac   : std_logic_vector(47 downto 0);
    src_ip    : std_logic_vector(31 downto 0);
    dst_ip    : std_logic_vector(31 downto 0);
    src_port  : std_logic_vector(15 downto 0);
    dst_port  : std_logic_vector(15 downto 0);
    ethertype : std_logic_vector(15 downto 0);
    is_udp    : std_logic;
    payload_size : std_logic_vector(15 downto 0);
  end record;

  type t_rmq_incoming_slot_config is record
    dst_mac   : std_logic_vector(47 downto 0);
    dst_ip    : std_logic_vector(31 downto 0);
    dst_port  : std_logic_vector(15 downto 0);
    ethertype : std_logic_vector(15 downto 0);
    type0 : std_logic_vector(31 downto 0);
    type1 : std_logic_vector(31 downto 0);
    type2 : std_logic_vector(31 downto 0);
    type3 : std_logic_vector(31 downto 0);

    is_tlv : std_logic;
    filter_dst_mac : std_logic;
    filter_dst_ip : std_logic;
    filter_dst_port : std_logic;
    filter_ethertype : std_logic;
    filter_udp    : std_logic;
    filter_type0 : std_logic;
    filter_type1 : std_logic;
    filter_type2 : std_logic;
    filter_type3 : std_logic;
    filter_raw : std_logic;
  end record;

  type t_rmq_rx_header is record
    is_udp       : std_logic;
    is_raw       : std_logic;
    is_tlv       : std_logic;
    src_mac      : std_logic_vector(47 downto 0);
    dst_mac      : std_logic_vector(47 downto 0);
    ethertype    : std_logic_vector(15 downto 0);
    src_port    : std_logic_vector(15 downto 0);
    dst_port     : std_logic_vector(15 downto 0);
    src_ip       : std_logic_vector(31 downto 0);
    dst_ip       : std_logic_vector(31 downto 0);
    udp_length   : std_logic_vector(15 downto 0);
    tlv_type     : std_logic_vector(31 downto 0);
    tlv_size     : std_logic_vector(15 downto 0);
  end record;
  
  type t_mt_stream_sink_in is record
    data  : std_logic_vector(31 downto 0);
    tag   : std_logic_vector(1 downto 0);
    valid : std_logic;
    last  : std_logic;
    error : std_logic;
  end record;

  type t_mt_stream_sink_out is record
    ready : std_logic;
  end record;

  
  
  subtype t_mt_stream_source_in is t_mt_stream_sink_out;
  subtype t_mt_stream_source_out is t_mt_stream_sink_in;

  constant c_mt_dummy_source_in : t_mt_stream_sink_out := ( ready => '0' );
  constant c_mt_dummy_sink_in : t_mt_stream_sink_in :=
    (x"00000000", "00", '0', '0', '0');

  
  type t_mt_stream_sink_in_array is array(integer range<> ) of t_mt_stream_sink_in;
  type t_mt_stream_sink_out_array is array(integer range<> ) of t_mt_stream_sink_out;
  type t_rmq_outgoing_slot_config_array is array(integer range<> ) of t_rmq_outgoing_slot_config;

  type t_mt_mqueue_slot_config is record
    width   : integer;
    entries : integer;
  end record;

  type t_mt_mqueue_slot_config_array is array(integer range<>) of t_mt_mqueue_slot_config;

  type t_mt_mqueue_config is record
    in_slot_count   : integer;
    out_slot_count  : integer;
    in_slot_config  : t_mt_mqueue_slot_config_array(0 to 15);
    out_slot_config : t_mt_mqueue_slot_config_array(0 to 15);
  end record;

  constant c_mt_default_mqueue_config : t_mt_mqueue_config :=
    (2,
     2,
     ((64, 128), (64, 16),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0)),

     ((128, 16), (128, 16),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0),
      (0, 0), (0, 0)));

  type t_slot_bus_in is record
    sel   : std_logic;
    dat   : std_logic_vector(31 downto 0);
    adr   : std_logic_vector(9 downto 0);
    we    : std_logic;
    wmask : std_logic_vector(3 downto 0);
  end record;

  type t_slot_bus_out is record
    dat : std_logic_vector(31 downto 0);
  end record;

  type t_slot_status_out is record
    full         : std_logic;
    empty        : std_logic;
    count        : std_logic_vector(7 downto 0);
    current_size : std_logic_vector(15 downto 0);
    ready        : std_logic;
    commit_mask  : std_logic;
  end record;

  type t_slot_bus_in_array is array(integer range <>) of t_slot_bus_in;
  type t_slot_bus_out_array is array(integer range <>) of t_slot_bus_out;
  type t_slot_status_out_array is array(integer range <>) of t_slot_status_out;


  type t_mt_irq_config is record
    mask_in   : std_logic_vector(15 downto 0);
    mask_out  : std_logic_vector(15 downto 0);
    threshold : std_logic_vector(7 downto 0);
    timeout   : std_logic_vector(7 downto 0);
  end record;

  constant c_dummy_status_out : t_slot_status_out := (
    '0', '0', x"00", x"0000", '0', '0');

  constant c_dummy_slot_bus_in : t_slot_bus_out := (
    dat => x"00000000"
    );


  -----------------------------------------------------------------------------
  -- Components
  -----------------------------------------------------------------------------

  component mt_mqueue_slot
    generic (
      g_entries : integer;
      g_width   : integer);
    port (
      clk_i         : in  std_logic;
      rst_n_i       : in  std_logic;
      stat_o        : out t_slot_status_out;
      inb_i         : in  t_slot_bus_in;
      inb_o         : out t_slot_bus_out;
      outb_i        : in  t_slot_bus_in;
      outb_o        : out t_slot_bus_out;
      out_discard_i : in  std_logic := '0';
      rmq_swrst_o   : out std_logic);
  end component;

  component mt_mqueue_wishbone_slave
    generic (
      g_with_gcr : boolean;
      g_config   : t_mt_mqueue_config);
    port (
      clk_i             : in  std_logic;
      rst_n_i           : in  std_logic;
      incoming_status_i :     t_slot_status_out_array(0 to g_config.in_slot_count-1);
      outgoing_status_i :     t_slot_status_out_array(0 to g_config.out_slot_count-1);
      incoming_o        : out t_slot_bus_in_array(0 to g_config.in_slot_count-1);
      incoming_i        : in  t_slot_bus_out_array(0 to g_config.in_slot_count-1);
      outgoing_o        : out t_slot_bus_in_array(0 to g_config.out_slot_count-1);
      outgoing_i        : in  t_slot_bus_out_array(0 to g_config.out_slot_count-1);
      slave_i           : in  t_wishbone_slave_in;
      slave_o           : out t_wishbone_slave_out;
      irq_config_o      : out t_mt_irq_config);
  end component;

  component mt_mqueue_irq_unit
    generic (
      g_config : t_mt_mqueue_config);
    port (
      clk_i             : in  std_logic;
      rst_n_i           : in  std_logic;
      incoming_status_i :     t_slot_status_out_array(0 to g_config.in_slot_count-1);
      outgoing_status_i :     t_slot_status_out_array(0 to g_config.out_slot_count-1);
      irq_o             : out std_logic);
  end component;
  

end mt_mqueue_pkg;

-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_rmq_rx_path.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-03-30
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Remote MQ RX path
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

entity mt_rmq_rx_path is

  port (
    clk_i            : in  std_logic;
    rst_n_i          : in  std_logic;
    snk_i            : in  t_mt_stream_sink_in;
    snk_o            : out t_mt_stream_sink_out;
    src_i            : in  t_mt_stream_source_in;
    src_o            : out t_mt_stream_source_out;
    p_header_valid_o : out std_logic;
    p_header_o : out t_rmq_rx_header
    );

end entity mt_rmq_rx_path;

architecture rtl of mt_rmq_rx_path is

  component mt_rmq_rx_deframer is
    port (
      clk_i            : in  std_logic;
      rst_n_i          : in  std_logic;
      snk_i            : in  t_mt_stream_sink_in;
      snk_o            : out t_mt_stream_sink_out;
      src_i            : in  t_mt_stream_source_in;
      src_o            : out t_mt_stream_source_out;
      p_header_valid_o : out std_logic;
      p_is_udp_o       : out std_logic;
      p_is_raw_o       : out std_logic;
      p_is_tlv_o       : out std_logic;
      p_src_mac_o      : out std_logic_vector(47 downto 0);
      p_dst_mac_o      : out std_logic_vector(47 downto 0);
      p_ethertype_o    : out std_logic_vector(15 downto 0);
      p_src_port_o     : out std_logic_vector(15 downto 0);
      p_dst_port_o     : out std_logic_vector(15 downto 0);
      p_src_ip_o       : out std_logic_vector(31 downto 0);
      p_dst_ip_o       : out std_logic_vector(31 downto 0);
      p_udp_length_o   : out std_logic_vector(15 downto 0);
      p_tlv_type_o     : out std_logic_vector(31 downto 0);
      p_tlv_size_o     : out std_logic_vector(15 downto 0));
  end component mt_rmq_rx_deframer;

  component mt_rmq_stream_register is
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      snk_i   : in  t_mt_stream_sink_in;
      snk_o   : out t_mt_stream_sink_out;
      src_i   : in  t_mt_stream_source_in;
      src_o   : out t_mt_stream_source_out);
  end component mt_rmq_stream_register;
  
  type t_mt_stream_source_out_array is array(integer range<>) of t_mt_stream_source_out;
  type t_mt_stream_source_in_array is array(integer range<>) of t_mt_stream_source_in;

  signal fwd_pipe : t_mt_stream_source_out_array(0 to 2);
  signal rev_pipe : t_mt_stream_source_in_array(0 to 2);

  
  begin

    U_rmq_rx_deframer:  mt_rmq_rx_deframer
      port map (
        clk_i            => clk_i,
        rst_n_i          => rst_n_i,
        snk_i            => snk_i,
        snk_o            => snk_o,
        src_i            => rev_pipe(0),
        src_o            => fwd_pipe(0),
        p_header_valid_o => p_header_valid_o,
        p_is_udp_o       => p_header_o.is_udp,
        p_is_raw_o       => p_header_o.is_raw,
        p_is_tlv_o       => p_header_o.is_tlv,
        p_src_mac_o      => p_header_o.src_mac,
        p_dst_mac_o      => p_header_o.dst_mac,
        p_ethertype_o    => p_header_o.ethertype,
        p_src_port_o     => p_header_o.src_port,
        p_dst_port_o     => p_header_o.dst_port,
        p_src_ip_o       => p_header_o.src_ip,
        p_dst_ip_o       => p_header_o.dst_ip,
        p_udp_length_o   => p_header_o.udp_length,
        p_tlv_type_o     => p_header_o.tlv_type,
        p_tlv_size_o     => p_header_o.tlv_size);

    U_stream_register: mt_rmq_stream_register
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        snk_i   => fwd_pipe(0),
        snk_o   => rev_pipe(0),
        src_i   => src_i,
        src_o   => src_o);
    
  end rtl;
    

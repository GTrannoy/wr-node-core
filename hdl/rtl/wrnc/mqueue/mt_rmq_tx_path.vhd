-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_rmq_tx_path.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-03-24
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Remote MQ implementation: TX packet assembler
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


entity mt_rmq_tx_path is
  port (

    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;
    src_o : out t_mt_stream_source_out;

    p_use_udp_i       :    std_logic;
    p_dst_mac_i       : in std_logic_vector(47 downto 0);
    p_ethertype_i     : in std_logic_vector(15 downto 0);
    p_src_port_i      : in std_logic_vector(15 downto 0);
    p_dst_port_i      : in std_logic_vector(15 downto 0);
    p_src_ip_i        : in std_logic_vector(31 downto 0);
    p_dst_ip_i        : in std_logic_vector(31 downto 0);
    p_payload_words_i : in std_logic_vector(15 downto 0)
    );

end mt_rmq_tx_path;

architecture rtl of mt_rmq_tx_path is

  type t_mt_stream_source_out_array is array(integer range<>) of t_mt_stream_source_out;
  type t_mt_stream_source_in_array is array(integer range<>) of t_mt_stream_source_in;

  signal fwd_pipe : t_mt_stream_source_out_array(0 to 2);
  signal rev_pipe : t_mt_stream_source_in_array(0 to 2);

  component mt_rmq_tx_packer is
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      snk_i   : in  t_mt_stream_sink_in;
      snk_o   : out t_mt_stream_sink_out;
      src_i   : in  t_mt_stream_source_in;
      src_o   : out t_mt_stream_source_out);
  end component mt_rmq_tx_packer;

  component mt_udp_tx_framer is
    port (
      clk_i           : in  std_logic;
      rst_n_i         : in  std_logic;
      snk_i           : in  t_mt_stream_sink_in;
      snk_o           : out t_mt_stream_sink_out;
      src_i           : in  t_mt_stream_source_in;
      src_o           : out t_mt_stream_source_out;
      p_src_port_i    : in  std_logic_vector(15 downto 0);
      p_dst_port_i    : in  std_logic_vector(15 downto 0);
      p_src_ip_i      : in  std_logic_vector(31 downto 0);
      p_dst_ip_i      : in  std_logic_vector(31 downto 0);
      p_payload_len_i : in  std_logic_vector(15 downto 0));
  end component mt_udp_tx_framer;

  component mt_ethernet_tx_framer is
    port (
      clk_i         : in  std_logic;
      rst_n_i       : in  std_logic;
      snk_i         : in  t_mt_stream_sink_in;
      snk_o         : out t_mt_stream_sink_out;
      src_i         : in  t_mt_stream_source_in;
      src_o         : out t_mt_stream_source_out;
      p_dst_mac_i   : in  std_logic_vector(47 downto 0);
      p_ethertype_i : in  std_logic_vector(15 downto 0));
  end component mt_ethernet_tx_framer;

begin

fwd_pipe(0) <= snk_i;
snk_o <= rev_pipe(0);

  --U_Packer : mt_rmq_tx_packer
  --  port map (
  --    clk_i   => clk_i,
  --    rst_n_i => rst_n_i,
  --    snk_i   => snk_i,
  --    snk_o   => snk_o,
  --    src_i   => rev_pipe(0),
  --    src_o   => fwd_pipe(0));

  U_UDPFramer : mt_udp_tx_framer
    port map (
      clk_i           => clk_i,
      rst_n_i         => rst_n_i,
      snk_i           => fwd_pipe(0),
      snk_o           => rev_pipe(0),
      src_i           => rev_pipe(1),
      src_o           => fwd_pipe(1),
      p_src_port_i    => p_src_port_i,
      p_dst_port_i    => p_dst_port_i,
      p_src_ip_i      => p_src_ip_i,
      p_dst_ip_i      => p_dst_ip_i,
      p_payload_len_i => std_logic_vector(unsigned(p_payload_words_i) sll 1));

  U_EthernetFramer : mt_ethernet_tx_framer
    port map (
      clk_i         => clk_i,
      rst_n_i       => rst_n_i,
      snk_i         => fwd_pipe(1),
      snk_o         => rev_pipe(1),
      src_i         => rev_pipe(2),
      src_o         => fwd_pipe(2),
      p_dst_mac_i   => p_dst_mac_i,
      p_ethertype_i => p_ethertype_i);

  src_o       <= fwd_pipe(2);
  rev_pipe(2) <= src_i;
  
end rtl;


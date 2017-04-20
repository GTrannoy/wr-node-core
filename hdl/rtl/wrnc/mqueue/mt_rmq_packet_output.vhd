-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_rmq_packet_output.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-03-24
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Packet assembler for the TX path of the RMQ.
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
use work.mock_turtle_pkg.all;
use work.mt_mqueue_pkg.all;
use work.genram_pkg.all;


entity mt_rmq_packet_output is
  
  generic (
    g_config : t_mt_mqueue_config);

  port (
    clk_i       : in std_logic;
    rst_n_i     : in std_logic;
    rmq_swrst_i : in std_logic;

    snks_i : in t_mt_stream_sink_in_array( 0 to g_config.out_slot_count-1 );
    snks_o : out t_mt_stream_sink_out_array( 0 to g_config.out_slot_count-1 );
    cfgs_i : in t_rmq_outgoing_slot_config_array( 0 to g_config.out_slot_count-1 );

    tx_req_i : in std_logic_vector(g_config.out_slot_count-1 downto 0);
    tx_grant_o : out std_logic_vector(g_config.out_slot_count-1 downto 0);

    src_o : out t_mt_stream_source_out;
    src_i : in t_mt_stream_source_in;

    debug_o : out std_logic_vector(31 downto 0)
    );

end mt_rmq_packet_output;

architecture rtl of mt_rmq_packet_output is

  component mt_rmq_tx_path is
    port (
      clk_i             : in  std_logic;
      rst_n_i           : in  std_logic;
      snk_i             : in  t_mt_stream_sink_in;
      snk_o             : out t_mt_stream_sink_out;
      src_i             : in  t_mt_stream_source_in;
      src_o             : out t_mt_stream_source_out;
      p_use_udp_i       :     std_logic;
      p_dst_mac_i       : in  std_logic_vector(47 downto 0);
      p_ethertype_i     : in  std_logic_vector(15 downto 0);
      p_src_port_i      : in  std_logic_vector(15 downto 0);
      p_dst_port_i      : in  std_logic_vector(15 downto 0);
      p_src_ip_i        : in  std_logic_vector(31 downto 0);
      p_dst_ip_i        : in  std_logic_vector(31 downto 0);
      p_payload_words_i : in  std_logic_vector(15 downto 0));
  end component mt_rmq_tx_path;
  
  function f_prio_encode (x : std_logic_vector) return std_logic_vector is
    variable rv : std_logic_vector(f_log2_size(x'length) -1 downto 0);
  begin
    rv := (others => '0');
    for i in 0 to x'length-1 loop
      if x(i) = '1' then
        rv := std_logic_vector(to_unsigned(i, f_log2_size(x'length)));
        return rv;
      end if;
    end loop;  -- i 
    return rv;
  end function;

  function f_onehot_decode ( x: integer; size : integer ) return std_logic_vector is
    variable rv : std_logic_vector(size-1 downto 0);
  begin
    rv := (others => '0');
    rv(x) := '1';
    return rv;
  end function;

  
  type t_arb_state is (ARB_IDLE, ARB_SEND);

  constant c_slot_index_size : integer := f_log2_size(g_config.out_slot_count);


  signal arb_state : t_arb_state;

  signal slot_ready : std_logic;
  signal slot_sel   : std_logic_vector(c_slot_index_size-1 downto 0);
  signal slot_done  : std_logic;

  signal slot_req : std_logic_vector(g_config.out_slot_count-1 downto 0);


  signal slot_in      : t_slot_bus_out;
  signal slot_stat    : t_slot_status_out;
  signal slot_out     : t_slot_bus_in;
  signal slot_discard : std_logic;


  signal rst_n_int : std_logic;

  signal src_out : t_mt_stream_source_out;
  signal src_in : t_mt_stream_source_in;
  signal config : t_rmq_outgoing_slot_config;
  
begin  -- rtl

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      rst_n_int <= rst_n_i and not rmq_swrst_i;
    end if;
  end process;

  gen_slot_status : for i in 0 to g_config.out_slot_count-1 generate
    slot_req(i) <= tx_req_i(i);
  end generate gen_slot_status;

  p_arbitrate_slots : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_int = '0' then
        arb_state  <= ARB_IDLE;
        slot_ready <= '0';
        slot_sel   <= (others => '0');
        tx_grant_o <= (others => '0');
      else
        case arb_state is
          when ARB_IDLE =>
            if unsigned(slot_req) /= 0 then
              slot_sel   <= f_prio_encode(slot_req);
              slot_ready <= '1';
              arb_state  <= ARB_SEND;
            end if;

          when ARB_SEND =>
            tx_grant_o <= f_onehot_decode(to_integer(unsigned(slot_sel)), tx_grant_o'length);

            if(slot_done = '1') then
              slot_ready <= '0';
              arb_state  <= ARB_IDLE;
            end if;
        end case;
      end if;
    end if;
  end process;


  p_pick_slot : process(snks_i, cfgs_i, slot_sel, src_in)
    variable idx : integer;
    variable tmp : std_logic_vector(g_config.out_slot_count-1 downto 0);
    
  begin
    idx := to_integer(unsigned(slot_sel));

    src_out <= snks_i(idx);
    snks_o(idx) <= src_in;
    config <= cfgs_i(idx);
    
  end process;

  slot_done <= src_out.valid and src_in.ready and src_out.last;
  
  U_TX_Path : mt_rmq_tx_path
    port map (
      clk_i             => clk_i,
      rst_n_i           => rst_n_int,
      snk_i             => src_out,
      snk_o             => src_in,
      src_i             => src_i,
      src_o             => src_o,
      p_use_udp_i       => config.is_udp,
      p_dst_mac_i       => config.dst_mac,
      p_ethertype_i     => config.ethertype,
      p_src_port_i      => config.src_port,
      p_dst_port_i      => config.dst_port,
      p_src_ip_i        => config.src_ip,
      p_dst_ip_i        => config.dst_ip,
      p_payload_words_i => config.payload_size);


  
end rtl;

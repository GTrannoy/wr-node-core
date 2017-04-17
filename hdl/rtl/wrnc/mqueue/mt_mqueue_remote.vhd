-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_mqueue_remote.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-03-30
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Remote MQ implementation. Exchanges messages between CPU CBs in remote
-- nodes.
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
use work.wrn_mqueue_pkg.all;

entity mt_mqueue_remote is
  generic (
    g_config : t_wrn_mqueue_config := c_wrn_default_mqueue_config
    );

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    si_slave_i : in  t_wishbone_slave_in;
    si_slave_o : out t_wishbone_slave_out;

    src_o : out t_mt_stream_source_out;
    src_i : in  t_mt_stream_source_in;

    snk_o : out t_mt_stream_sink_out;
    snk_i : in  t_mt_stream_sink_in;

    -- software reset for etherbone
    rmq_swrst_o : out std_logic;

    rmq_status_o : out std_logic_vector(15 downto 0);

    debug_o : out std_logic_vector(31 downto 0)
    );

end mt_mqueue_remote;

architecture rtl of mt_mqueue_remote is

  component mt_rmq_packet_output is
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i       : in  std_logic;
      rst_n_i     : in  std_logic;
      rmq_swrst_i : in  std_logic;
      snks_i      : in  t_mt_stream_sink_in_array(0 to g_config.out_slot_count-1);
      snks_o      : out t_mt_stream_sink_out_array(0 to g_config.out_slot_count-1);
      cfgs_i      : in  t_rmq_outgoing_slot_config_array(0 to g_config.out_slot_count-1);
      tx_req_i    : in  std_logic_vector(g_config.out_slot_count-1 downto 0);
      tx_grant_o  : out std_logic_vector(g_config.out_slot_count-1 downto 0);
      src_o       : out t_mt_stream_source_out;
      src_i       : in  t_mt_stream_source_in;
      debug_o     : out std_logic_vector(31 downto 0));
  end component mt_rmq_packet_output;


  component mt_rmq_outgoing_slot is
    generic (
      g_entries : integer;
      g_width   : integer);
    port (
      clk_i         : in  std_logic;
      rst_n_i       : in  std_logic;
      stat_o        : out t_slot_status_out;
      inb_i         : in  t_slot_bus_in;
      inb_o         : out t_slot_bus_out;
      config_o      : out t_rmq_outgoing_slot_config;
      src_o         : out t_mt_stream_source_out;
      src_i         : in  t_mt_stream_source_in;
      tx_req_o      : out std_logic;
      tx_grant_i    : in  std_logic;
      rmq_swrst_o   : out std_logic;
      out_discard_i : in  std_logic := '0');
  end component mt_rmq_outgoing_slot;

  component mt_rmq_incoming_slot is
    generic (
      g_entries : integer;
      g_width   : integer);
    port (
      clk_i            : in  std_logic;
      rst_n_i          : in  std_logic;
      stat_o           : out t_slot_status_out;
      outb_i           : in  t_slot_bus_in;
      outb_o           : out t_slot_bus_out;
      snk_i            : in  t_mt_stream_sink_in;
      snk_o            : out t_mt_stream_sink_out;
      p_header_valid_i : in  std_logic;
      p_header_i       : in  t_rmq_rx_header;
      out_discard_i    : in  std_logic := '0');
  end component mt_rmq_incoming_slot;

  component mt_rmq_rx_path is
    port (
      clk_i            : in  std_logic;
      rst_n_i          : in  std_logic;
      snk_i            : in  t_mt_stream_sink_in;
      snk_o            : out t_mt_stream_sink_out;
      src_i            : in  t_mt_stream_source_in;
      src_o            : out t_mt_stream_source_out;
      p_header_valid_o : out std_logic;
      p_header_o       : out t_rmq_rx_header);
  end component mt_rmq_rx_path;

  function f_dummy_slots (n : integer) return t_slot_bus_out_array is
    variable tmp : t_slot_bus_out_array(0 to n-1);
  begin
    for i in 0 to n-1 loop
      tmp(i).dat := (others => '0');
    end loop;
    return tmp;
  end function;



  signal si_incoming_in  : t_slot_bus_in_array(0 to g_config.in_slot_count-1);
  signal si_incoming_out : t_slot_bus_out_array(0 to g_config.in_slot_count-1);
  signal si_outgoing_in  : t_slot_bus_in_array(0 to g_config.out_slot_count-1);
  signal si_outgoing_out : t_slot_bus_out_array(0 to g_config.out_slot_count-1);

  signal incoming_stat : t_slot_status_out_array(0 to g_config.in_slot_count-1);
  signal outgoing_stat : t_slot_status_out_array(0 to g_config.out_slot_count-1);
  signal rmq_status    : std_logic_vector(g_config.in_slot_count-1 downto 0);
  signal rmq_swrst_vec : std_logic_vector(g_config.out_slot_count-1 downto 0);


  signal out_req, out_grant : std_logic_vector(g_config.out_slot_count-1 downto 0);

  signal out_snks_ins  : t_mt_stream_sink_in_array(0 to g_config.out_slot_count-1);
  signal out_snks_outs : t_mt_stream_sink_out_array(0 to g_config.out_slot_count-1);
  signal out_cfgs      : t_rmq_outgoing_slot_config_array(0 to g_config.out_slot_count-1);

  signal snk_in : t_mt_stream_sink_in;
  signal snk_out : t_mt_stream_sink_out;
  signal p_header : t_rmq_rx_header;
  signal p_header_valid : std_logic;
  
begin  -- rtl

  rmq_swrst_o <= rmq_swrst_vec(0);

  U_SI_Wishbone_Slave : wrn_mqueue_wishbone_slave
    generic map (
      g_with_gcr => true,
      g_config   => g_config)
    port map (
      clk_i             => clk_i,
      rst_n_i           => rst_n_i,
      incoming_status_i => incoming_stat,
      outgoing_status_i => outgoing_stat,

      incoming_o => si_incoming_in,
      incoming_i => si_incoming_out,
      outgoing_o => si_outgoing_in,
      outgoing_i => si_outgoing_out,

      slave_i => si_slave_i,
      slave_o => si_slave_o);

  -- CB to Etherbone direction (outgoing slots)
  gen_outgoing_slots : for i in 0 to g_config.out_slot_count-1 generate

    U_Out_SlotX : mt_rmq_outgoing_slot
      generic map (
        g_entries => g_config.out_slot_config(i).entries,
        g_width   => g_config.out_slot_config(i).width)
      port map (
        clk_i       => clk_i,
        rst_n_i     => rst_n_i,
        stat_o      => outgoing_stat(i),
        inb_i       => si_outgoing_in(i),
        inb_o       => si_outgoing_out(i),
        tx_req_o    => out_req(i),
        tx_grant_i  => out_grant(i),
        src_o       => out_snks_ins(i),
        src_i       => out_snks_outs(i),
        config_o    => out_cfgs(i),
        rmq_swrst_o => rmq_swrst_vec(i));

  end generate gen_outgoing_slots;

  -- Host to CB direction (incoming slots)
  gen_incoming_slots : for i in 0 to g_config.in_slot_count-1 generate

    U_In_SlotX : mt_rmq_incoming_slot
      generic map (
        g_entries => g_config.in_slot_config(i).entries,
        g_width   => g_config.in_slot_config(i).width)
      port map (
        clk_i            => clk_i,
        rst_n_i          => rst_n_i,
        stat_o           => incoming_stat(i),
        outb_i           => si_incoming_in(i),
        outb_o           => si_incoming_out(i),
        snk_i            => snk_in,
        snk_o            => open,       -- no flow throttling here
        p_header_valid_i => p_header_valid,
        p_header_i       => p_header,
        out_discard_i    => '0');


    rmq_status (i) <= not incoming_stat(i).empty;

  end generate gen_incoming_slots;

  U_RX_Path : mt_rmq_rx_path
    port map (
      clk_i            => clk_i,
      rst_n_i          => rst_n_i,
      snk_i            => snk_i,
      snk_o            => snk_o,
      src_i            => snk_out,
      src_o            => snk_in,
      p_header_valid_o => p_header_valid,
      p_header_o       => p_header);

  snk_out.READY <= '1';
  
  U_Packet_Output : mt_rmq_packet_output
    generic map (
      g_config => g_config)
    port map (
      clk_i       => clk_i,
      rst_n_i     => rst_n_i,
      rmq_swrst_i => rmq_swrst_vec(0),
      snks_i      => out_snks_ins,
      snks_o      => out_snks_outs,
      cfgs_i      => out_cfgs,
      tx_req_i    => out_req,
      tx_grant_o  => out_grant,
      src_o       => src_o,
      src_i       => src_i,
      debug_o     => open);


  process(rmq_status)
  begin
    rmq_status_o                                    <= (others => '0');
    rmq_status_o(g_config.in_slot_count-1 downto 0) <= rmq_status;
  end process;
  
end rtl;

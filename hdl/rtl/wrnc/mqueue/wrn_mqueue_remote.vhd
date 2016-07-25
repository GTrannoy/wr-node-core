-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_mqueue_remote.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-05-31
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

entity wrn_mqueue_remote is
  generic (
    g_config : t_wrn_mqueue_config := c_wrn_default_mqueue_config
    );

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    si_slave_i : in  t_wishbone_slave_in;
    si_slave_o : out t_wishbone_slave_out;

    ebm_master_o : out t_wishbone_master_out;
    ebm_master_i : in  t_wishbone_master_in := cc_dummy_master_in;

    ebs_slave_o : out t_wishbone_slave_out;
    ebs_slave_i : in  t_wishbone_slave_in := cc_dummy_slave_in;

    rmq_status_o : out std_logic_vector(15 downto 0)
    );

end wrn_mqueue_remote;

architecture rtl of wrn_mqueue_remote is

  component wrn_mqueue_etherbone_output
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i        : in  std_logic;
      rst_n_i      : in  std_logic;
      slots_i      : in  t_slot_bus_out_array(0 to g_config.out_slot_count-1);
      slots_o      : out t_slot_bus_in_array(0 to g_config.out_slot_count-1);
      stat_i       : in  t_slot_status_out_array(0 to g_config.out_slot_count-1);
      discard_o    : out std_logic_vector(g_config.out_slot_count-1 downto 0);
      ebm_o        : out t_wishbone_master_out;
      ebm_i        : in  t_wishbone_master_in := cc_dummy_master_in;
      host_slave_i : in  t_wishbone_slave_in;
      host_slave_o : out t_wishbone_slave_out);
  end component;

  function f_dummy_slots (n : integer) return t_slot_bus_out_array is
    variable tmp : t_slot_bus_out_array(0 to n-1);
  begin
    for i in 0 to n-1 loop
      tmp(i).dat := (others => '0');
    end loop;
    return tmp;
  end function;



  signal si_incoming_in, eb_incoming_in   : t_slot_bus_in_array(0 to g_config.in_slot_count-1);
  signal si_incoming_out, eb_incoming_out : t_slot_bus_out_array(0 to g_config.in_slot_count-1);
  signal si_outgoing_in, eb_outgoing_in   : t_slot_bus_in_array(0 to g_config.out_slot_count-1);
  signal si_outgoing_out, eb_outgoing_out : t_slot_bus_out_array(0 to g_config.out_slot_count-1);

  signal incoming_stat : t_slot_status_out_array(0 to g_config.in_slot_count-1);
  signal outgoing_stat : t_slot_status_out_array(0 to g_config.out_slot_count-1);

  signal eb_outgoing_discard : std_logic_vector(g_config.out_slot_count-1 downto 0);

  signal rmq_status : std_logic_vector(g_config.in_slot_count-1 downto 0);
  
begin  -- rtl

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

    U_Out_SlotX : wrn_mqueue_slot
      generic map (
        g_entries => g_config.in_slot_config(i).entries,
        g_width   => g_config.in_slot_config(i).width)
      port map (
        clk_i         => clk_i,
        rst_n_i       => rst_n_i,
        stat_o        => outgoing_stat(i),
        inb_i         => si_outgoing_in(i),
        inb_o         => si_outgoing_out(i),
        outb_i        => eb_outgoing_in(i),
        outb_o        => eb_outgoing_out(i),
        out_discard_i => eb_outgoing_discard(i));

  end generate gen_outgoing_slots;

  -- Host to CB direction (incoming slots)
  gen_incoming_slots : for i in 0 to g_config.in_slot_count-1 generate

    U_In_SlotX : wrn_mqueue_slot
      generic map (
        g_entries => g_config.in_slot_config(i).entries,
        g_width   => g_config.in_slot_config(i).width)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        stat_o  => incoming_stat(i),
        inb_i   => eb_incoming_in(i),
        inb_o   => eb_incoming_out(i),
        outb_i  => si_incoming_in(i),
        outb_o  => si_incoming_out(i));

    rmq_status (i) <= not incoming_stat(i).empty;

  end generate gen_incoming_slots;

  U_EB_Wishbone_Slave : wrn_mqueue_wishbone_slave
    generic map (
      g_with_gcr => true,
      g_config   => g_config)
    port map (
      clk_i             => clk_i,
      rst_n_i           => rst_n_i,
      incoming_status_i => incoming_stat,
      outgoing_status_i => outgoing_stat,

      incoming_o => eb_incoming_in,
      incoming_i => eb_incoming_out,

      outgoing_i => f_dummy_slots(g_config.out_slot_count),

      slave_i => ebs_slave_i,
      slave_o => ebs_slave_o);

  U_EB_Output : wrn_mqueue_etherbone_output
    generic map (
      g_config => g_config)
    port map (
      clk_i        => clk_i,
      rst_n_i      => rst_n_i,
      slots_i      => eb_outgoing_out,
      slots_o      => eb_outgoing_in,
      stat_i       => outgoing_stat,
      discard_o    => eb_outgoing_discard,
      ebm_o        => ebm_master_o,
      ebm_i        => ebm_master_i,
      host_slave_i => cc_dummy_slave_in);

  --ebs_slave_o.stall <= '0';
  --ebs_slave_o.rty <= '0';
  --ebs_slave_o.err <= '0';
  --process(clk_i)
  --begin
  --  if rising_edge(clk_i) then
  --    ebs_slave_o.ack <= ebs_slave_i.cyc and ebs_slave_i.stb;
  --  end if;


  --end process;
  process(rmq_status)
    begin
      rmq_status_o <= (others => '0');
      rmq_status_o(g_config.in_slot_count-1 downto 0) <= rmq_status;
    end process;
      
end rtl;

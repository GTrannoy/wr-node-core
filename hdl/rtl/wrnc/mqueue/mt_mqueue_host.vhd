-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_mqueue_host.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-05-31
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Host Message Queue implementation. Exchanges messages between the CPU CBs
-- and the host system.
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

entity mt_mqueue_host is
  generic (
    g_config : t_mt_mqueue_config := c_mt_default_mqueue_config
    );

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    si_slave_i : in  t_wishbone_slave_in;
    si_slave_o : out t_wishbone_slave_out;

    host_slave_i : in  t_wishbone_slave_in;
    host_slave_o : out t_wishbone_slave_out;
    host_irq_o   : out std_logic;

    hmq_status_o : out std_logic_vector(15 downto 0)
    );

end mt_mqueue_host;

architecture rtl of mt_mqueue_host is

  signal si_incoming_in, host_incoming_in   : t_slot_bus_in_array(0 to g_config.in_slot_count-1);
  signal si_incoming_out, host_incoming_out : t_slot_bus_out_array(0 to g_config.in_slot_count-1);
  signal si_outgoing_in, host_outgoing_in   : t_slot_bus_in_array(0 to g_config.out_slot_count-1);
  signal si_outgoing_out, host_outgoing_out : t_slot_bus_out_array(0 to g_config.out_slot_count-1);

  signal incoming_stat : t_slot_status_out_array(0 to g_config.in_slot_count-1);
  signal outgoing_stat : t_slot_status_out_array(0 to g_config.out_slot_count-1);


  signal hmq_status : std_logic_vector(g_config.in_slot_count-1 downto 0);
  signal irq_config : t_mt_irq_config;

  signal tmr_div     : unsigned(23 downto 0);
  signal tmr_tick    : std_logic;
  signal tmr_timeout : unsigned(9 downto 0);

  signal irq_vec_in, irq_vec_out : std_logic_vector(15 downto 0);
  
begin  -- rtl

  U_SI_Wishbone_Slave : mt_mqueue_wishbone_slave
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

  -- CB to Host direction (outgoing slots)
  gen_outgoing_slots : for i in 0 to g_config.out_slot_count-1 generate

    U_Out_SlotX : mt_mqueue_slot
      generic map (
        g_entries => g_config.out_slot_config(i).entries,
        g_width   => g_config.out_slot_config(i).width)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        stat_o  => outgoing_stat(i),
        inb_i   => si_outgoing_in(i),
        inb_o   => si_outgoing_out(i),
        outb_i  => host_outgoing_in(i),
        outb_o  => host_outgoing_out(i));

  end generate gen_outgoing_slots;

  -- Host to CB direction (incoming slots)
  gen_incoming_slots : for i in 0 to g_config.in_slot_count-1 generate

    U_In_SlotX : mt_mqueue_slot
      generic map (
        g_entries => g_config.in_slot_config(i).entries,
        g_width   => g_config.in_slot_config(i).width)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        stat_o  => incoming_stat(i),
        inb_i   => host_incoming_in(i),
        inb_o   => host_incoming_out(i),
        outb_i  => si_incoming_in(i),
        outb_o  => si_incoming_out(i));

    hmq_status (i) <= not incoming_stat(i).empty;

  end generate gen_incoming_slots;

  U_Host_Wishbone_Slave : mt_mqueue_wishbone_slave
    generic map (
      g_with_gcr => true,
      g_config   => g_config)
    port map (
      clk_i             => clk_i,
      rst_n_i           => rst_n_i,
      incoming_status_i => incoming_stat,
      outgoing_status_i => outgoing_stat,

      incoming_o => host_incoming_in,
      incoming_i => host_incoming_out,
      outgoing_o => host_outgoing_in,
      outgoing_i => host_outgoing_out,

      slave_i      => host_slave_i,
      slave_o      => host_slave_o,
      irq_config_o => irq_config);

  process(hmq_status)
  begin
    hmq_status_o                                    <= (others => '0');
    hmq_status_o(g_config.in_slot_count-1 downto 0) <= hmq_status;
  end process;


  p_coalesce_tick : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        tmr_div  <= (others => '0');
        tmr_tick <= '0';
      else
        if(tmr_div /= 6250) then        -- 100us coelesce tick
          tmr_div  <= tmr_div + 1;
          tmr_tick <= '1';
        else
          tmr_div  <= (others => '0');
          tmr_tick <= '0';
        end if;
      end if;
    end if;
  end process;


  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        host_irq_o <= '0';
      else
        irq_vec_in  <= (others => '0');
        irq_vec_out <= (others => '0');

        for i in 0 to g_config.in_slot_count-1 loop
          irq_vec_in(i) <= incoming_stat(i).empty;
        end loop;

        for i in 0 to g_config.out_slot_count-1 loop
          irq_vec_out(i) <= not outgoing_stat(i).empty and outgoing_stat(i).commit_mask;
        end loop;

        if((irq_vec_out and irq_config.mask_out) /= x"0000")
          or((irq_vec_in and irq_config.mask_in) /= x"0000") then
          host_irq_o <= '1';
        else
          host_irq_o <= '0';
        end if;
      end if;
    end if;
  end process;
  
end rtl;

-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_mqueue_remote.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-25
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
use work.mt_mqueue_pkg.all;
use work.wr_fabric_pkg.all;

entity mt_ethernet_tx_framer is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;
    src_o : out t_mt_stream_source_out;

    p_dst_mac_i   : in std_logic_vector(47 downto 0);
    p_ethertype_i : in std_logic_vector(15 downto 0)

    );

end entity;

architecture rtl of mt_ethernet_tx_framer is
  type t_state is (IDLE, DMAC0, DMAC1, SMAC0, SMAC1, SMAC2, ETHERTYPE, PAYLOAD);
  signal state  : t_state;
  signal d_prev : std_logic_vector(15 downto 0);
begin

  p_comb : process(state, snk_i, src_i)
  begin
    if state = IDLE then
      snk_o.ready <= '0';
    elsif state = PAYLOAD then
      snk_o.ready <= src_i.ready;
    end if;
  end process;

  p_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state       <= IDLE;
        src_o.valid <= '0';
      else
        case state is
          when IDLE =>
            if src_i.ready = '1' then
              src_o.valid <= '0';
            end if;

            if snk_i.valid = '1' then
              state                   <= DMAC0;
              src_o.last              <= '0';
              src_o.data(15 downto 0) <= p_dst_mac_i(47 downto 32);
              src_o.valid             <= '1';
            end if;

          when DMAC0 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= p_dst_mac_i(31 downto 16);
              src_o.valid             <= '1';
              state                   <= DMAC1;
            end if;

          when DMAC1 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= p_dst_mac_i(15 downto 0);
              src_o.valid             <= '1';
              state                   <= SMAC0;
            end if;
            
          when SMAC0 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= (others => '0');
              src_o.valid             <= '1';
              state                   <= SMAC1;
            end if;

          when SMAC1 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= (others => '0');
              src_o.valid             <= '1';
              state                   <= SMAC2;
            end if;

          when SMAC2 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= (others => '0');
              src_o.valid             <= '1';
              state                   <= ETHERTYPE;
            end if;

          when ETHERTYPE =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= p_ethertype_i;
              src_o.valid             <= '1';
              state                   <= PAYLOAD;
            end if;

          when PAYLOAD =>
            if(src_i.ready = '1') then
              src_o.data(15 downto 0) <= snk_i.data(15 downto 0);
              src_o.valid             <= snk_i.valid;
              src_o.last              <= snk_i.last;

              if(snk_i.last = '1' and snk_i.valid = '1') then
                state <= IDLE;
              end if;
            end if;
        end case;
      end if;
    end if;
  end process;

  src_o.tag <= "00";
  src_o.error <= '0';
end rtl;



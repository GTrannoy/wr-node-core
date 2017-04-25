-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_udp_tx_framer.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-21
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
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.mt_mqueue_pkg.all;
use work.wr_fabric_pkg.all;

entity mt_udp_tx_framer is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;
    src_o : out t_mt_stream_source_out;

    p_src_port_i    : in std_logic_vector(15 downto 0);
    p_dst_port_i    : in std_logic_vector(15 downto 0);
    p_src_ip_i      : in std_logic_vector(31 downto 0);
    p_dst_ip_i      : in std_logic_vector(31 downto 0);
    p_payload_len_i : in std_logic_vector(15 downto 0)

    );

end entity;

architecture rtl of mt_udp_tx_framer is
  type t_state is (IDLE, IP_TLEN, IP_ID, IP_FLAGS, IP_TTL_PROTO, IP_CKSUM, IP_SRC0, IP_SRC1, IP_DST0, IP_DST1, UDP_PAYLOAD, UDP_SPORT, UDP_DPORT, UDP_LEN, UDP_CKSUM, UDP_FIRST, FINISH);
  signal state    : t_state;
  signal checksum : unsigned(19 downto 0);

  procedure f_send_hdr(data : in std_logic_vector(15 downto 0); next_state : t_state; signal checksum : inout unsigned; signal src_o : out t_mt_stream_source_out; signal state : inout t_state) is
  begin
    src_o.valid <= '1';
    if src_i.ready = '1' then
      checksum                <= checksum + unsigned(data);
      src_o.data(15 downto 0) <= data;
      state                   <= next_state;
    end if;
  end procedure;

  signal d_prev : std_logic_vector(15 downto 0);
  
begin

  p_comb : process(state, snk_i, src_i)
  begin
    if state = IDLE then
      snk_o.ready <= '0';
    elsif state = UDP_PAYLOAD or state = UDP_FIRST then
      snk_o.ready <= src_i.ready;
    else
      snk_o.ready <= '0';
    end if;
  end process;


  p_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state       <= IDLE;
        src_o.valid <= '0';
        checksum    <= (others => '0');
      else
        case state is
          when FINISH =>
            if src_i.ready = '1' then
              src_o.valid <= '0';
              state       <= IDLE;
            end if;
            
          when IDLE =>

            if snk_i.valid = '1' then
              src_o.valid             <= '1';
              src_o.last              <= '0';
              src_o.data(15 downto 0) <= x"4500";
              state                   <= IP_TLEN;
            end if;
            

          when IP_TLEN =>
            f_send_hdr(
              std_logic_vector(
              ( unsigned(p_payload_len_i) sll 1 ) + to_unsigned(20 + 8, 16)), IP_ID, checksum, src_o, state); 

          when IP_ID =>
            f_send_hdr(x"0000", IP_FLAGS, checksum, src_o, state);

          when IP_FLAGS =>
            f_send_hdr(x"4000", IP_TTL_PROTO, checksum, src_o, state);  -- don't fragment

          when IP_TTL_PROTO =>
            f_send_hdr(x"3c11", IP_CKSUM, checksum, src_o, state);  -- ttl = 60, proto = UDP

          when IP_CKSUM =>
            f_send_hdr(std_logic_vector(not (checksum(15 downto 0) + checksum(19 downto 16))), IP_SRC0, checksum, src_o, state);

          when IP_SRC0 =>
            f_send_hdr(p_src_ip_i(31 downto 16), IP_SRC1, checksum, src_o, state);

          when IP_SRC1=>
            f_send_hdr(p_src_ip_i(15 downto 0), IP_DST0, checksum, src_o, state);

          when IP_DST0=>
            f_send_hdr(p_dst_ip_i(31 downto 16), IP_DST1, checksum, src_o, state);

          when IP_DST1=>
            f_send_hdr(p_dst_ip_i(15 downto 0), UDP_SPORT, checksum, src_o, state);
            
          when UDP_SPORT =>
            f_send_hdr(p_src_port_i, UDP_DPORT, checksum, src_o, state);

          when UDP_DPORT =>
            f_send_hdr(p_dst_port_i, UDP_LEN, checksum, src_o, state);

          when UDP_LEN =>
            f_send_hdr(std_logic_vector((unsigned(p_payload_len_i) sll 1) + 8), UDP_CKSUM, checksum, src_o, state);

          when UDP_CKSUM =>
            f_send_hdr(x"0000", UDP_FIRST, checksum, src_o, state);

          when UDP_FIRST =>
            f_send_hdr(snk_i.data(15 downto 0), UDP_PAYLOAD, checksum, src_o, state);
            
            
            
          when UDP_PAYLOAD =>
            if(src_i.ready = '1') then
              src_o.data(15 downto 0) <= snk_i.data(15 downto 0);
              src_o.valid             <= snk_i.valid;
              src_o.last              <= snk_i.last;
            end if;

            if(snk_i.last = '1' and snk_i.valid = '1' and src_i.ready = '1') then
              checksum <= (others => '0');
              state    <= FINISH;
            end if;
            
            
        end case;
      end if;
    end if;
  end process;
  
end rtl;


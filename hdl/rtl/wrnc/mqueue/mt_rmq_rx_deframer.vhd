-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_rmq_rx_deframer.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-03-31
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Remote MQ ethernet/UDP packet deframer.
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

entity mt_rmq_rx_deframer is
  port(
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;
    src_o : out t_mt_stream_source_out;

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
    p_tlv_size_o     : out std_logic_vector(15 downto 0)
    );

end mt_rmq_rx_deframer;

architecture rtl of mt_rmq_rx_deframer is
  type t_state is (IDLE, DMAC0, DMAC1, SMAC0, SMAC1, SMAC2, ETHERTYPE, IP_HDR0, IP_HDR1, IP_HDR2, IP_HDR3, IP_HDR4, IP_HDR5, IP_SRC_IP_MSB, IP_SRC_IP_LSB, IP_DST_IP_MSB, IP_DST_IP_LSB, UDP_SRC_PORT, UDP_DST_PORT, UDP_CHECKSUM, UDP_LENGTH, PAYLOAD);

  function f_pick(cond : boolean; if_true : t_state; if_false : t_state) return t_state is
  begin
    if(cond) then
      return if_true;
    else
      return if_false;
    end if;
  end f_pick;

  procedure f_rx(signal state : inout t_state; next_state : t_state; signal target : out std_logic_vector) is
  begin
    if (snk_i.valid = '1' and src_i.ready = '1') then
      if (snk_i.error = '1') then
        state <= IDLE;
      elsif (snk_i.last = '1') then
        state <= IDLE;
      else
        target <= snk_i.data(15 downto 0);
        state  <= next_state;
      end if;
    end if;
  end f_rx;

  signal dummy : std_logic_vector(15 downto 0);
  signal state : t_state;

  signal valid_mask : std_logic;
  
begin

  snk_o.ready <= src_i.ready;
  src_o.last  <= snk_i.last;
  src_o.error <= snk_i.error;
  src_o.valid <= snk_i.valid;
  src_o.data  <= snk_i.data;
  src_o.tag <= c_MT_STREAM_TAG_HEADER when valid_mask = '0' else c_MT_STREAM_TAG_PAYLOAD;
    
  p_fsm : process(clk_i)
    variable next_state : t_state;
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state            <= IDLE;
        p_header_valid_o <= '0';
        valid_mask       <= '0';
      else
        
        case state is
          when IDLE =>
            p_header_valid_o <= '0';
            p_is_raw_o       <= '0';
            p_is_udp_o       <= '0';
            valid_mask       <= '0';

            f_rx(state, DMAC0, p_dst_mac_o(47 downto 32));
          when DMAC0 =>
            f_rx(state, DMAC1, p_dst_mac_o(31 downto 16));
          when DMAC1 =>
            f_rx(state, SMAC0, p_dst_mac_o(15 downto 0));
          when SMAC0 =>
            f_rx(state, SMAC1, p_src_mac_o(47 downto 32));
          when SMAC1 =>
            f_rx(state, SMAC2, p_src_mac_o(31 downto 16));
          when SMAC2 =>
            f_rx(state, ETHERTYPE, p_src_mac_o(15 downto 0));
          when ETHERTYPE =>

            if (snk_i.data(15 downto 0) = x"0800") then
              next_state := IP_HDR0;
            --          elsif (snk_i.data = x"dead") then
--              next_state := TLV_HDR0;
            else

              if (snk_i.valid = '1' and src_i.ready = '1') then
                valid_mask <= '1';
              end if;


              p_is_raw_o <= '1';
              next_state := PAYLOAD;
            end if;

            f_rx(state, next_state, p_ethertype_o(15 downto 0));

          when IP_HDR0 =>               -- version/IHL
            -- not IPV4? reject
            next_state := f_pick(snk_i.data(15 downto 8) = x"45", IP_HDR1, IDLE);
            f_rx(state, next_state, dummy);

          when IP_HDR1 =>               -- total length
            f_rx(state, IP_HDR2, dummy);

          when IP_HDR2 =>               -- identification
            f_rx(state, IP_HDR3, dummy);
          when IP_HDR3 =>               -- flags/fragment offset
            f_rx(state, IP_HDR4, dummy);
          when IP_HDR4 =>               -- ttl/protocol
            -- not UDP? reject
            next_state := f_pick(snk_i.data(7 downto 0) = x"11", IP_HDR5, IDLE);
            f_rx(state, next_state, dummy);
          when IP_HDR5 =>               -- checksum
            p_is_udp_o <= '1';
            f_rx(state, IP_SRC_IP_MSB, dummy);
          when IP_SRC_IP_MSB =>
            f_rx(state, IP_SRC_IP_LSB, p_src_ip_o(31 downto 16));
          when IP_SRC_IP_LSB =>
            f_rx(state, IP_DST_IP_MSB, p_src_ip_o(15 downto 0));
          when IP_DST_IP_MSB =>
            f_rx(state, IP_DST_IP_LSB, p_dst_ip_o(31 downto 16));
          when IP_DST_IP_LSB =>
            f_rx(state, UDP_SRC_PORT, p_dst_ip_o(15 downto 0));

          when UDP_SRC_PORT =>
            f_rx(state, UDP_DST_PORT, p_src_port_o(15 downto 0));
            
          when UDP_DST_PORT =>
            f_rx(state, UDP_LENGTH, p_dst_port_o(15 downto 0));
          when UDP_LENGTH =>
            f_rx(state, UDP_CHECKSUM, dummy);
            
          when UDP_CHECKSUM =>
            if (snk_i.valid = '1' and src_i.ready = '1') then
              valid_mask <= '1';
            end if;

            f_rx(state, PAYLOAD, dummy);

          when PAYLOAD =>

            p_header_valid_o <= '1';
            f_rx(state, PAYLOAD, dummy);

--            f_rx(
        end case;


      end if;
    end if;

  end process;

  p_is_tlv_o <= '0';
  
  
end rtl;




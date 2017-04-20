-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_rmq_stream_register.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-13
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

entity mt_rmq_stream_register is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;    -- 32-bit data
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;  -- 16-bit data
    src_o : out t_mt_stream_source_out
    );

end entity;

architecture rtl of mt_rmq_stream_register is

  signal tmp_src_out : t_mt_stream_source_out;
  signal tmp_src_in  : t_mt_stream_source_in;

  signal src_out : t_mt_stream_source_out;
  signal src_in  : t_mt_stream_source_in;

  signal src_valid_next : std_logic;
  signal tmp_valid_next : std_logic;
  signal ready_early    : std_logic;

  signal input_to_output : std_logic;
  signal input_to_temp   : std_logic;
  signal temp_to_output  : std_logic;

  signal ready_reg : std_logic;

begin
  
  ready_early <= src_i.ready or (not tmp_src_out.valid and (not src_out.valid or not snk_i.valid));

  process (src_out, tmp_src_out, ready_reg, snk_i, src_i)
  begin
    src_valid_next <= src_out.valid;
    tmp_valid_next <= tmp_src_out.valid;

    input_to_output <= '0';
    input_to_temp   <= '0';
    temp_to_output  <= '0';

    if (ready_reg = '1') then
      if (src_i.ready = '1' or src_out.valid = '0') then
        src_valid_next  <= snk_i.valid;
        input_to_output <= '1';
      else
        tmp_valid_next <= snk_i.valid;
        input_to_temp  <= '1';
      end if;
    elsif (src_i.ready = '1') then
      src_valid_next <= tmp_src_out.valid;
      tmp_valid_next <= '0';
      temp_to_output <= '1';
    end if;
  end process;

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ready_reg         <= '0';
        src_out.valid     <= '0';
        tmp_src_out.valid <= '0';
      else
        ready_reg         <= ready_early;
        src_out.valid     <= src_valid_next;
        tmp_src_out.valid <= tmp_valid_next;

        if (input_to_output = '1') then
          src_out.data <= snk_i.data;
          src_out.tag <= snk_i.tag;
          src_out.last <= snk_i.last;
          src_out.error <= snk_i.error;
        elsif (temp_to_output = '1') then
          src_out.data <= tmp_src_out.data;
          src_out.tag <= tmp_src_out.tag;
          src_out.last <= tmp_src_out.last;
          src_out.error <= tmp_src_out.error;
        end if;

        if (input_to_temp = '1') then
          tmp_src_out.data <= snk_i.data;
          tmp_src_out.tag <= snk_i.tag;
          tmp_src_out.last <= snk_i.last;
          tmp_src_out.error <= snk_i.error;

        end if;
      end if;
    end if;
  end process;

  src_o       <= src_out;
  snk_o.ready <= ready_reg;
  
end rtl;


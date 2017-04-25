-------------------------------------------------------------------------------
-- Title      : Mock Turtle Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_wr_sink.vhd
-- Author     : Tomasz Wlostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2012-01-16
-- Last update: 2017-04-25
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
--
-- Copyright (c) 2011 CERN
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
-- Revisions  :
-- Date        Version  Author          Description
-- 2011-01-16  1.0      twlostow        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.genram_pkg.all;
use work.wr_fabric_pkg.all;
use work.mt_mqueue_pkg.all;

entity mt_wr_sink is
  
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    -- Wishbone Fabric Interface I/O
    snk_i : in  t_wrf_sink_in;
    snk_o : out t_wrf_sink_out;

    -- MT internal fabric source
    src_o : out t_mt_stream_source_out;
    src_i : in  t_mt_stream_source_in
    );

end mt_wr_sink;

architecture rtl of mt_wr_sink is

  constant c_fifo_width : integer := 16 + 2 + 4;

  signal q_valid, full, we, rd : std_logic;
  signal fin, fout, fout_reg   : std_logic_vector(c_fifo_width-1 downto 0);
  signal cyc_d0, rd_d0         : std_logic;

  signal pre_sof, pre_eof, pre_bytesel, pre_dvalid : std_logic;
  signal post_sof, post_dvalid                     : std_logic;
  signal post_addr                                 : std_logic_vector(1 downto 0);
  signal post_data                                 : std_logic_vector(15 downto 0);

  signal snk_out : t_wrf_sink_out;
  signal data_present : std_logic;
  signal is_data : std_logic;
  
begin  -- rtl


  p_delay_cyc_and_rd : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        cyc_d0 <= '0';
        rd_d0  <= '0';
      else
        if(full = '0') then
          cyc_d0 <= snk_i.cyc;
        end if;

        rd_d0 <= rd;
      end if;
    end if;
  end process;


  is_data <= '1' when snk_i.adr = c_WRF_DATA else '0';
                                                
  pre_eof     <= not snk_i.cyc and cyc_d0;  -- eof
  pre_bytesel <= not snk_i.sel(0);      -- bytesel
  pre_dvalid  <= is_data and snk_i.stb and snk_i.we and snk_i.cyc and not snk_out.stall;  -- data valid

  snk_out.stall <= full or (snk_i.cyc and not cyc_d0);
  snk_out.err   <= '0';
  snk_out.rty   <= '0';

  p_gen_ack : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        snk_out.ack <= '0';
      else
        snk_out.ack <= snk_i.cyc and snk_i.stb and snk_i.we and not snk_out.stall;
      end if;
    end if;
  end process;

fin(18) <= pre_eof;
  
  p_latch_data : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' or pre_sof = '1' then
        data_present <= '0';
--        we <= '0';
      else
        
        if pre_dvalid = '1' then
          fin(15 downto 0)  <= snk_i.dat;
          fin(17 downto 16) <= snk_i.adr;
          data_present      <= '1';
        elsif pre_eof = '1' then
          data_present <= '0';
  --        we <= '0';
        end if;
      end if;
    end if;
  end process;

  we <= data_present and (pre_dvalid or pre_eof);
  
  snk_o <= snk_out;

  rd <= q_valid and src_i.ready;

  -- fixme: we assume this doesn't get full.
  U_FIFO : generic_shiftreg_fifo
    generic map (
      g_data_width => c_fifo_width,
      g_size       => 16)
    port map (
      rst_n_i       => rst_n_i,
      clk_i         => clk_i,
      d_i           => fin,
      we_i          => we,
      q_o           => fout,
      rd_i          => rd,
      almost_full_o => full,
      q_valid_o     => q_valid);

  post_data              <= fout(15 downto 0);
  src_o.data(15 downto 0) <= post_data;
  post_addr              <= fout(17 downto 16);
  src_o.tag              <= post_addr;
  src_o.last             <= q_valid and fout(18);
  src_o.error            <= '0';        -- fixme
  src_o.valid <= q_valid;
  
  --
  ----q_valid and (post_addr = c_WRF_STATUS) and (f_unmarshall_wrf_status(post_data).error = '1') else '0';

  
end rtl;

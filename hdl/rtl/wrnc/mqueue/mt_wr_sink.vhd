-------------------------------------------------------------------------------
-- Title      : Wishbone Packet Fabric buffered packet sink
-- Project    : WR Cores Collection
-------------------------------------------------------------------------------
-- File       : xwb_fabric_sink.vhd
-- Author     : Tomasz Wlostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2012-01-16
-- Last update: 2017-04-13
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: A simple WB packet streaming sink with builtin FIFO buffer.
-- Outputs a trivial interface (start-of-packet, end-of-packet, data-valid)
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
use work.wrn_mqueue_pkg.all;

entity mt_wr_sink is
  
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    -- Wishbone Fabric Interface I/O
    snk_i : in  t_wrf_sink_in;
    snk_o : out t_wrf_sink_out;

    -- MT internal fabric source
    src_o : out t_mt_stream_source_out;
    src_i : in t_mt_stream_source_in;
    
    --addr_o    : out std_logic_vector(1 downto 0);
    --data_o    : out std_logic_vector(15 downto 0);
    --dvalid_o  : out std_logic;
    --sof_o     : out std_logic;
    --eof_o     : out std_logic;
    --error_o   : out std_logic;
    --bytesel_o : out std_logic;
    --dreq_i    : in  std_logic
    );

end xwb_fabric_sink;

architecture rtl of xwb_fabric_sink is

  constant c_fifo_width : integer := 16 + 2 + 4;

  signal q_valid, full, we, rd : std_logic;
  signal fin, fout, fout_reg   : std_logic_vector(c_fifo_width-1 downto 0);
  signal cyc_d0, rd_d0         : std_logic;

  signal pre_sof, pre_eof, pre_bytesel, pre_dvalid : std_logic;
  signal post_sof, post_dvalid                     : std_logic;
  signal post_addr                                 : std_logic_vector(1 downto 0);
  signal post_data                                 : std_logic_vector(15 downto 0);

  signal snk_out : t_wrf_sink_out;
  
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


  pre_sof     <= snk_i.cyc and not cyc_d0;  -- sof
  pre_eof     <= not snk_i.cyc and cyc_d0;  -- eof
  pre_bytesel <= not snk_i.sel(0);      -- bytesel
  pre_dvalid  <= snk_i.stb and snk_i.we and snk_i.cyc and not snk_out.stall;  -- data valid

  fin(15 downto 0)  <= snk_i.dat;
  fin(17 downto 16) <= snk_i.adr;
  fin(21 downto 18) <= pre_sof & pre_eof & pre_bytesel & pre_dvalid;


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

  snk_o <= snk_out;

  we <= '1' when fin(21 downto 18) /= "0000" and full = '0' else '0';
  rd <= q_valid and dreq_i and not post_sof;

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

  p_fout_reg : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        fout_reg <= (others => '0');
      elsif(rd = '1') then
        fout_reg <= fout;
      end if;
    end if;
  end process;

 

  post_data <= fout_reg(15 downto 0);
  src_o.dat(15 downto 0) <= post_data;
  post_addr <= fout_reg(17 downto 16);
  src_o.tag <= post_addr;
  src_o.valid <= fout_reg(18);
  src_o.error <= '1' when rd_d0 = '1' and (post_addr = c_WRF_STATUS) and (f_unmarshall_wrf_status(post_data).error = '1') else '0';
  src_o.last <= fout_reg(20) and rd_d0;

  post_dvalid <= fout_reg(18);

  sof_o     <= post_sof and rd_d0;
  dvalid_o  <= post_dvalid and rd_d0;
  error_o   <= '1' when rd_d0 = '1' and (post_addr = c_WRF_STATUS) and (f_unmarshall_wrf_status(post_data).error = '1') else '0';
  eof_o     <= fout_reg(20) and rd_d0;
  bytesel_o <= fout_reg(19);
  data_o    <= post_data;
  addr_o    <= post_addr;

  
end rtl;

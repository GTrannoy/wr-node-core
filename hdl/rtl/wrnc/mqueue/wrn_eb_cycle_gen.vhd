-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_eb_cycle_gen.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2015-06-01
-- Last update: 2015-07-23
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Wishbone cycle generator for EB master (glue code for RMQ)
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
use work.wr_node_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.etherbone_pkg.all;
use work.genram_pkg.all;

entity wrn_eb_cycle_gen is
  port(
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    rq_adr_i : in std_logic_vector(31 downto 0);
    rq_dat_i : in std_logic_vector(31 downto 0);
    rq_wr_i  : in std_logic;
    rq_rd_i  : in std_logic;


    rq_dat_o   : out std_logic_vector(31 downto 0);
    rq_ready_o : out std_logic;
    rq_done_o : out std_logic;

    master_o : out t_wishbone_master_out;
    master_i : in  t_wishbone_master_in

    );

end entity;

architecture rtl of wrn_eb_cycle_gen is

  type t_state is (idle, gen_req, wait_ack);

  signal state : t_state;
  
  
begin

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state        <= idle;
        master_o.cyc <= '0';
        master_o.stb <= '0';
        
      else
        case (state) is
          when idle =>
            if(rq_rd_i = '1' or rq_wr_i = '1') then
              master_o.cyc <= '1';
              master_o.stb <= '1';
              master_o.we  <= rq_wr_i;
              master_o.sel <= (others => '1');
              master_o.adr <= rq_adr_i;
              master_o.dat <= rq_dat_i;
              state        <= gen_req;
            end if;

          when gen_req=>
            if (master_i.stall = '0') then
              master_o.stb <= '0';

              if(master_i.ack = '1') then
                master_o.cyc <= '0';
                state        <= idle;
                
              else
                state <= wait_ack;
              end if;
              
            end if;

          when wait_ack =>
            
            if(master_i.ack = '1') then
              master_o.cyc <= '0';
              state        <= idle;
            end if;
            
        end case;
      end if;
    end if;
  end process;

  rq_ready_o <= '1' when state = idle else '0';
  rq_done_o <= '1' when (state /= idle) and master_i.ack = '1' else '0';
  rq_dat_o     <= master_i.dat;

end rtl;


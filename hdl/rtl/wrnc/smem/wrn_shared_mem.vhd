-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_shared_mem.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2014-11-18
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- WR Node CPU Shared Memory block.
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

use work.genram_pkg.all;
use work.wishbone_pkg.all;

entity wrn_shared_mem is
  
  generic (
    g_size : integer := 8192);

  port(
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out);

end wrn_shared_mem;

architecture rtl of wrn_shared_mem is

  constant c_RANGE_DIRECT : std_logic_vector(2 downto 0) := "000";
  constant c_RANGE_ADD    : std_logic_vector(2 downto 0) := "001";
  constant c_RANGE_SUB    : std_logic_vector(2 downto 0) := "010";
  constant c_RANGE_SET    : std_logic_vector(2 downto 0) := "011";
  constant c_RANGE_CLEAR  : std_logic_vector(2 downto 0) := "100";
  constant c_RANGE_FLIP   : std_logic_vector(2 downto 0) := "101";

  constant c_SMEM_SIZE : integer := 2048;

  type t_smem_array is array (0 to c_SMEM_SIZE-1) of std_logic_vector(31 downto 0);
  type t_state is (FETCH_IDLE, WRITEBACK);

  signal mem                : t_smem_array;
  signal op_sel             : std_logic_vector(2 downto 0);
  signal op_addr            : std_logic_vector(12 downto 0);
  signal fetch_data, result : std_logic_vector(31 downto 0);
  signal state              : t_state;
begin  -- rtl

  op_sel  <= slave_i.adr(15 downto 13);
  op_addr <= slave_i.adr(12 downto 0);

  p_readout : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if(slave_i.cyc = '1' and slave_i.stb = '1') then
        if(state = WRITEBACK or (op_sel = c_RANGE_DIRECT and slave_i.we = '1')) then
          mem(to_integer(unsigned(op_addr))) <= result;
        end if;

        fetch_data <= mem(to_integer(unsigned(op_addr)));
      end if;
    end if;
  end process;


  p_op : process(fetch_data, op_sel, slave_i)
  begin
    case op_sel is
      when c_RANGE_FLIP   => result <= fetch_data xor slave_i.dat;
      when c_RANGE_SET    => result <= fetch_data or slave_i.dat;
      when c_RANGE_CLEAR  => result <= fetch_data and not slave_i.dat;
      when c_RANGE_ADD    => result <= std_logic_vector(unsigned(fetch_data) + unsigned(slave_i.dat));
      when c_RANGE_SUB    => result <= std_logic_vector(unsigned(fetch_data) - unsigned(slave_i.dat));
      when c_RANGE_DIRECT => result <= slave_i.dat;
      when others         => result <= slave_i.dat;
    end case;
  end process;

  p_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state       <= FETCH_IDLE;
        slave_o.ack <= '0';
      else
        case state is
          when FETCH_IDLE =>
            slave_o.ack <= '0';
            if(slave_i.cyc = '1' and slave_i.stb = '1') then
              if(slave_i.we = '1' and op_sel /= c_RANGE_DIRECT) then
                state <= WRITEBACK;
              else
                slave_o.ack <= '1';
              end if;
              
            end if;
          when WRITEBACK =>
            state       <= FETCH_IDLE;
            slave_o.ack <= '1';
        end case;
      end if;
    end if;
  end process;

  p_stall : process(slave_i, op_sel, state)
  begin
    if(slave_i.cyc = '1' and slave_i.stb = '1' and slave_i.we = '1' and op_sel /= c_RANGE_DIRECT and state = FETCH_IDLE) then
      slave_o.stall <= '1';
    else
      slave_o.stall <= '0';
    end if;
  end process;

  slave_o.dat <= fetch_data;
  slave_o.err <= '0';
  slave_o.rty <= '0';

end rtl;

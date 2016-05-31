-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_shared_mem.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-05-27
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
    g_size : integer := 16384);

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
  constant c_RANGE_TEST_AND_SET   : std_logic_vector(2 downto 0) := "110";

  type t_smem_array is array (0 to g_size-1) of std_logic_vector(7 downto 0);
  type t_state is (FETCH_IDLE, UPDATE, WRITEBACK);

  function f_is_synthesis return boolean is
  begin
    -- synthesis translate_off
    return false;
    -- synthesis translate_on
    return true;
  end f_is_synthesis;


  impure function f_sanitize_address (adr : std_logic_vector) return integer is
  begin
    if f_is_synthesis then
      return to_integer(unsigned(adr));
    else
      return to_integer(unsigned(adr)) mod g_size;
    end if;
  end f_sanitize_address;


  function f_clear_smem return t_smem_array is
    variable tmp: t_smem_array;
    begin
      for i in 0 to g_size-1 loop
        tmp(i) := (others =>'0');
        end loop;
        return tmp;
      end f_clear_smem;
  
  signal mem0                : t_smem_array := f_clear_smem;
  signal mem1                : t_smem_array := f_clear_smem;
  signal mem2                : t_smem_array := f_clear_smem;
  signal mem3                : t_smem_array := f_clear_smem;
  signal op_addr            : integer;
  signal op_sel             : std_logic_vector(2 downto 0);
  signal fetch_data, result : std_logic_vector(31 downto 0);
  signal state              : t_state;

  signal wr_mask :std_logic_vector(3 downto 0);
begin  -- rtl

  op_sel  <= slave_i.adr(18 downto 16);
  op_addr <= f_sanitize_address( slave_i.adr(15 downto 2) );

  p_byte_mask: process(state, op_sel, slave_i)
    begin
      if state = WRITEBACK then
        wr_mask <= (others => '1');
      elsif (op_sel = c_RANGE_DIRECT and slave_i.we = '1') then
        wr_mask <= slave_i.sel;
        else
          wr_mask <= (others => '0');
          end if;
       
      end process;
          
  p_readout : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if(slave_i.cyc = '1' and slave_i.stb = '1') then

        if wr_mask(0) = '1' then
          mem0(op_addr) <= result(7 downto 0);
        end if;
        if wr_mask(1) = '1' then
          mem1(op_addr) <= result(15 downto 8);
        end if;
        if wr_mask(2) = '1' then
          mem2(op_addr) <= result(23 downto 16);
        end if;
        if wr_mask(3) = '1' then
          mem3(op_addr) <= result(31 downto 24);
        end if;

        fetch_data(7 downto 0) <= mem0(op_addr);
        fetch_data(15 downto 8) <= mem1(op_addr);
        fetch_data(23 downto 16) <= mem2(op_addr);
        fetch_data(31 downto 24) <= mem3(op_addr);
      end if;
    end if;
  end process;


  p_op : process(clk_i)
  begin
    if rising_edge(clk_i) then
      case op_sel is
        when c_RANGE_FLIP         => result <= fetch_data xor slave_i.dat;
        when c_RANGE_SET          => result <= fetch_data or slave_i.dat;
        when c_RANGE_CLEAR        => result <= fetch_data and not slave_i.dat;
        when c_RANGE_ADD          => result <= std_logic_vector(unsigned(fetch_data) + unsigned(slave_i.dat));
        when c_RANGE_SUB          => result <= std_logic_vector(unsigned(fetch_data) - unsigned(slave_i.dat));
        when c_RANGE_TEST_AND_SET => result <= x"00000001";
        when c_RANGE_DIRECT       => result <= slave_i.dat;
        when others               => result <= slave_i.dat;
      end case;
    end if;
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
              if(slave_i.we = '1') then
                state <= UPDATE;
              elsif (slave_i.we = '0' and op_sel = c_RANGE_TEST_AND_SET) then
                state <= UPDATE;
              else
                slave_o.ack <= '1';
              end if;
              
            end if;

          when UPDATE =>

            state <= WRITEBACK;
            
          when WRITEBACK =>
            state       <= FETCH_IDLE;
            slave_o.ack <= '1';
        end case;
      end if;
    end if;
  end process;

  p_stall : process(slave_i, op_sel, state)
  begin
    if(slave_i.cyc = '1' and slave_i.stb = '1' and
       ((slave_i.we = '1') or
        (slave_i.we = '0' and op_sel = c_RANGE_TEST_AND_SET))
       and (state = FETCH_IDLE or state = UPDATE)) then
      slave_o.stall <= '1';
    else
      slave_o.stall <= '0';
    end if;
  end process;

  slave_o.dat <= fetch_data;
  slave_o.err <= '0';
  slave_o.rty <= '0';

end rtl;

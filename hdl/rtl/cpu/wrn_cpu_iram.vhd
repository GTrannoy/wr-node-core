-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_cpu_iram.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2014-12-01
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
-- 
-- WR Node CPU Internal RAM block. To be replaced with direct cache execution.
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
use ieee.NUMERIC_STD.all;

use work.genram_pkg.all;

entity wrn_cpu_iram is
  
  generic (
    g_size : integer);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    aa_i : in std_logic_vector(f_log2_size(g_size)-1 downto 0);
    ab_i : in std_logic_vector(f_log2_size(g_size)-1 downto 0);

    da_i : in std_logic_vector(31 downto 0);
    db_i : in std_logic_vector(31 downto 0);

    qa_o : out std_logic_vector(31 downto 0);
    qb_o : out std_logic_vector(31 downto 0);

    ena_i : in std_logic;
    enb_i : in std_logic;

    wea_i : in std_logic;
    web_i : in std_logic
    );

end wrn_cpu_iram;

architecture rtl of wrn_cpu_iram is

  type t_ram_type is array(0 to g_size - 1) of std_logic_vector(31 downto 0);

  function f_empty_ram_array return t_ram_type is
    variable rv : t_ram_type;
  begin
    for i in 0 to g_size-1 loop
      rv(i) := (others => '0');
    end loop;  -- i
    return rv;
  end function;

  shared variable iram : t_ram_type := f_empty_ram_array;


begin  -- rtl

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if(ena_i = '1') then
        if(wea_i = '1') then
          iram(to_integer(unsigned(aa_i))) := da_i;
        end if;
        qa_o <= iram(to_integer(unsigned(aa_i)));
      end if;
    end if;
  end process;

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      
      if(enb_i = '1') then
        if(web_i = '1') then
          iram(to_integer(unsigned(ab_i))) := db_i;
        end if;
        qb_o <= iram(to_integer(unsigned(ab_i)));
      end if;
    end if;
  end process;

end rtl;

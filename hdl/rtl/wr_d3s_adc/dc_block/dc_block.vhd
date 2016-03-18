-------------------------------------------------------------------------------
-- Title      : DC blocking module for WR RF DDS Distribution Node (SVEC)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : dc_block.vhd
-- Author     : E. Calvo
-- Company    : CERN BE-CO-HT
-- Created    : 2016-02-11
-- Last update: 2016-02-26
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- This block implements a linear phase DC blocker. 
-- The idea, presented at IEEE signal processing magazine, March 2008,
-- consist on removing from the sampled signal the result of its moving average.
--
-- This kind of implementation has been chose in order to keep the phase 
-- as linear as possible. Ripple is not an issue, since we are not interested 
-- in the amplitude information of the sampled signal, just the phase.
--
-------------------------------------------------------------------------------
--
-- Copyright (c) 2016 CERN
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
use IEEE.math_real.all;

library unisim;
use unisim.vcomponents.all;

entity DcBlock is
  generic (data_width : integer := 14;   -- default value is 14
           data_depth : integer := 32);  -- default value is 32   
  port (clk_i     : in  std_logic;
        rst_n_i   : in  std_logic;
        x_valid_i : in  std_logic;       -- 1: x_i contains a valid sample
        x_i       : in  std_logic_vector(data_width-1 downto 0);
        y_valid_o : out std_logic;       -- 1: y_o contins a valid sample
        y_o       : out std_logic_vector(data_width-1 downto 0));
end entity DcBlock;

architecture rtl of DcBlock is
  
  signal x_del_Dm1, x_del_2Dm2, x_reg : std_logic_vector(data_width-1 downto 0);
  signal MA1_y_o, MA2_y_o             : std_logic_vector(data_width-1 downto 0);

  signal x_valid_reg, MA1_valid_o : std_logic;

  component MovingAvg is
    generic (data_width : integer := 14;  -- default value is 14
             N          : integer := 5);  -- Average length (D in the article) will be 2^N. 
    port (clk_i     : in  std_logic;
          rst_n_i   : in  std_logic;
          x_valid_i : in  std_logic;    -- 1: x_i contains a valid sample
          x_i       : in  std_logic_vector(data_width-1 downto 0);
          y_valid_o : out std_logic;    -- 1: y_o contins a valid sample
          y_o       : out std_logic_vector(data_width-1 downto 0);
          del_x     : out std_logic_vector(data_width-1 downto 0));         
  end component;

begin
  
  Reg_x_i : process (clk_i, rst_n_i) is
  -- Register the inputs
  begin
    if rst_n_i = '0' then
      x_reg       <= (others => '0');
      x_valid_reg <= '0';
    elsif rising_edge(clk_i) then
      if x_valid_i = '1' then
        x_reg <= x_i;
      end if;
      x_valid_reg <= x_valid_i;
    end if;
  end process;

  MA1 : MovingAvg generic map (data_width => data_width, N => integer(ceil(log2(real(data_depth)))))
    port map(clk_i     => clk_i,
             rst_n_i   => rst_n_i,
             x_valid_i => x_valid_reg,
             x_i       => x_reg,
             y_valid_o => MA1_valid_o,
             y_o       => MA1_y_o,
             del_x     => x_del_Dm1);

  MA2 : MovingAvg generic map (data_width => data_width, N => integer(ceil(log2(real(data_depth)))))
    port map(clk_i     => clk_i,
             rst_n_i   => rst_n_i,
             x_valid_i => MA1_valid_o,
             x_i       => MA1_y_o,
             y_valid_o => y_valid_o,
             y_o       => MA2_y_o,
             del_x     => x_del_2Dm2);

  y_o <= std_logic_vector(signed(x_del_Dm1) - signed(MA2_y_o));
  
end;

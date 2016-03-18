-------------------------------------------------------------------------------
-- Title      : DC blocking module for WR RF DDS Distribution Node (SVEC)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : Moving_avg.vhd
-- Author     : E. Calvo
-- Company    : CERN BE-CO-HT
-- Created    : 2016-02-11
-- Last update: 2016-02-18
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- This block implements a moving average FIR filter. 
-- It has been implemented as shown in the IEEE signal processing magazine, March 2008,
-- page 133, "dsp tips&tricks: DC blocker algorithms"
-- 
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

library unisim;
use unisim.vcomponents.all;

entity MovingAvg is

    generic (data_width : natural := 14;	-- default value is 14
             N : natural := 5	);          -- Average length (D in the article) will be 2^N.     
    port (clk_i   :   in std_logic;
			rst_n_i :   in std_logic; 	
         x_valid_i : in std_logic;       -- 1: x_i contains a valid sample
			x_i :       in  std_logic_vector(data_width-1 downto 0);
			y_valid_o:  out std_logic;      -- 1: y_o contins a valid sample
			y_o :       out std_logic_vector(data_width-1 downto 0);
         del_x :     out std_logic_vector(data_width-1 downto 0) );
			
end MovingAvg;

architecture rtl1 of MovingAvg is
    
    signal x_del_Dm1, x_del_D: std_logic_vector(data_width-1 downto 0);  -- input delayed by D(=2^N) or D-1 samples
	 signal acc_cor: std_logic_vector(data_width-1 downto 0); -- Accumulator corr. 
	 -- The acc_cor is used to add the new sample and remove the oldest one
	 signal acc : std_logic_vector(data_width+N-1 downto 0);  -- Accumulator of the MAvg
    signal valid_o: std_logic;
	 signal fifo_valid: std_logic_vector(0 to 1);
    
    component vector_fifo is
		  generic (VECTOR_WIDTH: natural := 14;
            FIFO_DEPTH: natural := 32 );
		  port ( clk_i : 	in  std_logic;
           rst_n_i : 	in  std_logic;
			  x_valid_i : 	in  std_logic;
           x_i : 			in  std_logic_vector (VECTOR_WIDTH-1 downto 0);
           y_o : 			out std_logic_vector (VECTOR_WIDTH-1 downto 0);
			  y_valid_o: 	out std_logic );
    end component;

    begin

    Z_mDp1: vector_fifo generic map ( VECTOR_WIDTH => data_width, FIFO_DEPTH => 2**N-1) 
							   port map ( clk_i =>  clk_i,
									rst_n_i    => rst_n_i, 	
									x_valid_i  => x_valid_i,       
									x_i        => x_i,
									y_valid_o  => valid_o,
									y_o        => x_del_Dm1
									);

    del_x <= x_del_Dm1;

    Z_mD: process (clk_i, rst_n_i) is
	 -- Delay by 1 clk x_del_Dm1
 	 begin
	     if rst_n_i = '0' then 	
					x_del_D <= (others =>'0');
	     elsif rising_edge(clk_i) then
	        		x_del_D <= x_del_Dm1;
	     end if;  				              
    end process;
	   
    acc_cor <= std_logic_vector(signed(x_i) - signed(x_del_D));

    Accum: process (clk_i, rst_n_i) 
	 -- Moving average accumulator
        begin
				if rst_n_i = '0' then 	
					acc <= ( others => '0');
            elsif rising_edge(clk_i) then
					acc <= std_logic_vector(signed(acc_cor) + signed(acc));
            end if;
    end process;

    y_o <= std_logic_vector(signed(acc(acc'length-1 downto N)));   -- y_o = acc/(2^N)

    Adjust_valid_o: process (clk_i, rst_n_i) 
	 begin
        -- Adjust delay of y_valid_o : +2 clk cycles
        if (rst_n_i = '0') then
            fifo_valid <= (others => '0');
        elsif rising_edge(clk_i) then
            fifo_valid <= valid_o & fifo_valid(0 to fifo_valid'length-2);
        end if;
    end process;
	    
	 y_valid_o <= fifo_valid(fifo_valid'length-1);
 
end rtl1;

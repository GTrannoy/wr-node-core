-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_mqueue_wishbone_slave.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2014-12-01
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Wishbone slave for MQ's Slot/Global control registers.
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
use work.wrn_mqueue_pkg.all;

entity wrn_mqueue_wishbone_slave is
  
  generic (
    g_with_gcr : boolean;
    g_config   : t_wrn_mqueue_config
    );
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    incoming_status_i : t_slot_status_out_array(0 to g_config.in_slot_count-1);
    outgoing_status_i : t_slot_status_out_array(0 to g_config.out_slot_count-1);

    incoming_o : out t_slot_bus_in_array(0 to g_config.in_slot_count-1);
    incoming_i : in  t_slot_bus_out_array(0 to g_config.in_slot_count-1);

    outgoing_o : out t_slot_bus_in_array(0 to g_config.out_slot_count-1);
    outgoing_i : in  t_slot_bus_out_array(0 to g_config.out_slot_count-1);

    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out;

    irq_config_o : out t_wrn_irq_config
    );

end wrn_mqueue_wishbone_slave;

architecture rtl of wrn_mqueue_wishbone_slave is

  constant c_gcr_slot_count        : std_logic_vector(3 downto 0) := x"0";
  constant c_gcr_slot_status       : std_logic_vector(3 downto 0) := x"1";
  constant c_gcr_slot_irq_mask     : std_logic_vector(3 downto 0) := x"2";
  constant c_gcr_slot_irq_coalesce : std_logic_vector(3 downto 0) := x"3";

  signal slot_num, slot_num_d0         : std_logic_vector(3 downto 0);
  signal gcr_sel, gcr_sel_d0           : std_logic;
  signal in_area_sel, in_area_sel_d0   : std_logic;
  signal out_area_sel, out_area_sel_d0 : std_logic;

  signal wb_write : std_logic;
  signal wb_read  : std_logic;

  signal gcr_rd_data : std_logic_vector(31 downto 0) := x"00000000";

  signal irq_config : t_wrn_irq_config;
  
  
begin  -- rtl

  slot_num     <= slave_i.adr(13 downto 10);
  in_area_sel  <= '1' when slave_i.adr(15 downto 14) = "01" else '0';
  out_area_sel <= '1' when slave_i.adr(15 downto 14) = "10" else '0';
  gcr_sel      <= '1' when slave_i.adr(15 downto 14) = "00" else '0';

  wb_write <= slave_i.cyc and slave_i.stb and slave_i.we;
  wb_read  <= slave_i.cyc and slave_i.stb and not slave_i.we;

  gen_incoming_slots : for i in 0 to g_config.in_slot_count-1 generate
    incoming_o(i).sel <= '1' when in_area_sel = '1' and unsigned(slot_num) = i else '0';
    incoming_o(i).we  <= wb_write;
    incoming_o(i).dat <= slave_i.dat;
    incoming_o(i).adr <= slave_i.adr(9 downto 0);
  end generate gen_incoming_slots;

  gen_outgoing_slots : for i in 0 to g_config.out_slot_count-1 generate
    outgoing_o(i).sel <= '1' when out_area_sel = '1' and unsigned(slot_num) = i else '0';
    outgoing_o(i).we  <= wb_write;
    outgoing_o(i).dat <= slave_i.dat;
    outgoing_o(i).adr <= slave_i.adr(9 downto 0);
  end generate gen_outgoing_slots;

  p_delay : process(clk_i)
  begin
    if rising_edge(clk_i) then
      slot_num_d0     <= slot_num;
      in_area_sel_d0  <= in_area_sel;
      out_area_sel_d0 <= out_area_sel;
      gcr_sel_d0      <= gcr_sel;
    end if;
  end process;

  p_read_data : process(incoming_i, outgoing_i, gcr_rd_data, in_area_sel_d0, gcr_sel_d0, slot_num_d0)
  begin
    if(gcr_sel_d0 = '1') then
      slave_o.dat <= gcr_rd_data;
    elsif(in_area_sel_d0 = '1') then
      slave_o.dat <= incoming_i(to_integer(unsigned(slot_num_d0))).dat;
    else
      slave_o.dat <= outgoing_i(to_integer(unsigned(slot_num_d0))).dat;
    end if;
  end process;

  gen_with_gcr : if(g_with_gcr) generate
    
    
    p_gcr_regs : process(clk_i)
    begin
      if rising_edge(clk_i) then
        if rst_n_i = '0' then
          irq_config.mask_in   <= (others => '0');
          irq_config.mask_out  <= (others => '0');
          irq_config.threshold <= (others => '0');
          irq_config.timeout   <= (others => '0');
        else
          gcr_rd_data <= (others => '0');

          if(wb_write = '1' and gcr_sel = '1') then
            case slave_i.adr(5 downto 2) is
              when c_gcr_slot_irq_mask =>
                irq_config.mask_in  <= slave_i.dat(31 downto 16);
                irq_config.mask_out <= slave_i.dat(15 downto 0);
              when c_gcr_slot_irq_coalesce =>
                irq_config.threshold <= slave_i.dat(7 downto 0);
                irq_config.timeout   <= slave_i.dat(23 downto 16);
              when others => null;
            end case;
          else
            case slave_i.adr(5 downto 2) is
              when c_gcr_slot_irq_mask =>
                gcr_rd_data(31 downto 16) <= irq_config.mask_in;
                gcr_rd_data(15 downto 0)  <= irq_config.mask_out;

              when c_gcr_slot_irq_coalesce =>
                gcr_rd_data(7 downto 0)   <= irq_config.threshold;
                gcr_rd_data(23 downto 16) <= irq_config.timeout;

              when c_gcr_slot_status =>
                for i in 0 to g_config.in_slot_count-1 loop
                  gcr_rd_data(i+16) <= incoming_status_i(i).empty;
                end loop;  -- i

                for i in 0 to g_config.out_slot_count-1 loop
                  gcr_rd_data(i) <= not outgoing_status_i(i).empty;
                end loop;  -- i


              when c_gcr_slot_count =>
                gcr_rd_data(7 downto 0)  <= std_logic_vector(to_unsigned(g_config.in_slot_count, 8));
                gcr_rd_data(15 downto 8) <= std_logic_vector(to_unsigned(g_config.out_slot_count, 8));
              when others => null;
            end case;
          end if;
        end if;
      end if;
    end process;

  end generate gen_with_gcr;

  slave_o.stall <= '0';
  slave_o.err   <= '0';
  slave_o.rty   <= '0';
  slave_o.int   <= '0';

  p_ack : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        slave_o.ack <= '0';
      else
        slave_o.ack <= wb_read or wb_write;
      end if;
    end if;
  end process;

  irq_config_o <= irq_config;
  
end rtl;

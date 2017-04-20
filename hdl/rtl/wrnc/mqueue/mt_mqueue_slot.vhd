-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_mqueue_slot.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-11-28
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Single slot (FIFO) of a Message Queue.
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
use work.mt_mqueue_pkg.all;

entity mt_mqueue_slot is
  
  generic (
    g_entries : integer;
    g_width   : integer);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    stat_o : out t_slot_status_out;

    inb_i : in  t_slot_bus_in;
    inb_o : out t_slot_bus_out;

    outb_i : in  t_slot_bus_in;
    outb_o : out t_slot_bus_out;

    rmq_swrst_o : out std_logic;
    
    out_discard_i : in std_logic := '0'
    );

end mt_mqueue_slot;

architecture rtl of mt_mqueue_slot is

  constant c_counter_bits     : integer := f_log2_size(g_entries);
  constant c_slot_offset_bits : integer := f_log2_size(g_width);
  constant c_memory_size      : integer := g_width * g_entries;

  type t_slot_mem_array is array (0 to c_memory_size-1) of std_logic_vector(7 downto 0);

  shared variable mem0 : t_slot_mem_array;
  shared variable mem1 : t_slot_mem_array;
  shared variable mem2 : t_slot_mem_array;
  shared variable mem3 : t_slot_mem_array;

  signal mem_raddr, mem_waddr                   : unsigned(f_log2_size(c_memory_size)-1 downto 0);
  signal mem_wdata, mem_rdata_in, mem_rdata_out : std_logic_vector(31 downto 0);

  signal rd_ptr, wr_ptr : unsigned(c_counter_bits-1 downto 0);
  signal occupied       : unsigned(7 downto 0);
  signal words_written  : unsigned(7 downto 0);

  type t_wr_state is (IDLE, READY_SEND, ACCEPT_DATA, IGNORE_MESSAGE);
  type t_rd_state is (IDLE, READ_SIZE, WAIT_DISCARD);

  signal mem_we : std_logic_vector(3 downto 0);

  signal full, empty : std_logic;

  signal wr_state : t_wr_state;
  signal rd_state : t_rd_state;

  signal in_claim, in_purge, in_ready, in_enqueue, in_commit : std_logic;

  signal in_cmd_wr, in_stat_rd   : std_logic;
  signal out_cmd_wr, out_stat_rd : std_logic;
  signal status                  : std_logic_vector(31 downto 0);

  signal out_discard, out_purge : std_logic;

  signal q_read, q_write : std_logic;

  constant c_addr_command : integer := 0;
  constant c_addr_status  : integer := 1;
  signal n_words_last     : std_logic_vector(7 downto 0);
  
begin  -- rtl


  p_mem_write : process(inb_i, wr_ptr, wr_state)
  begin
    if(wr_state = IGNORE_MESSAGE) then
      mem_we <= (others => '0');
    else
      for i in 0 to 3 loop
        mem_we(i) <= (inb_i.we and inb_i.sel and inb_i.wmask(i));
      end loop;
    end if;

    mem_waddr <= wr_ptr & unsigned(inb_i.adr(c_slot_offset_bits+1 downto 2));
    mem_wdata <= inb_i.dat;
  end process;

  status(0)            <= full;
  status(1)            <= empty;
  status(15 downto 8)  <= std_logic_vector(occupied);
  status(23 downto 16) <= n_words_last;
  status(31 downto 28) <= std_logic_vector(to_unsigned(f_log2_size(g_width), 4));
  status(7 downto 2)   <= std_logic_vector(to_unsigned(f_log2_size(g_entries), 6));

  in_claim   <= in_cmd_wr and inb_i.dat(24);
  in_purge   <= in_cmd_wr and inb_i.dat(25);
  in_ready   <= in_cmd_wr and inb_i.dat(26);
  in_enqueue <= in_cmd_wr and inb_i.dat(29);
  in_commit  <= in_cmd_wr and inb_i.dat(30);

  in_cmd_wr  <= '1' when inb_i.sel = '1' and inb_i.we = '1' and (unsigned(inb_i.adr(9 downto 2)) = c_addr_command)    else '0';
  out_cmd_wr <= '1' when outb_i.sel = '1' and outb_i.we = '1' and (unsigned(outb_i.adr(9 downto 2)) = c_addr_command) else '0';

  out_discard <= out_discard_i or (out_cmd_wr and outb_i.dat(27));
  out_purge   <= out_cmd_wr and outb_i.dat(25);

  rmq_swrst_o <= out_purge;
  
  p_read_status : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if(unsigned(inb_i.adr(9 downto 2)) = c_addr_status) then
        in_stat_rd <= '1';
      else
        in_stat_rd <= '0';
      end if;

      if(unsigned(outb_i.adr(9 downto 2)) = c_addr_status) then
        out_stat_rd <= '1';
      else
        out_stat_rd <= '0';
      end if;

    end if;
  end process;

  inb_o.dat  <= status when in_stat_rd = '1'  else mem_rdata_in;
  outb_o.dat <= status when out_stat_rd = '1' else mem_rdata_out;

  p_mem_port1 : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if(mem_we(0) = '1') then
        mem0(to_integer(mem_waddr)) := mem_wdata(7 downto 0);
      end if;
      if(mem_we(1) = '1') then
        mem1(to_integer(mem_waddr)) := mem_wdata(15 downto 8);
      end if;
      if(mem_we(2) = '1') then
        mem2(to_integer(mem_waddr)) := mem_wdata(23 downto 16);
      end if;
      if(mem_we(3) = '1') then
        mem3(to_integer(mem_waddr)) := mem_wdata(31 downto 24);
      end if;

      mem_rdata_in(7 downto 0)   <= mem0(to_integer(unsigned(mem_waddr)));
      mem_rdata_in(15 downto 8)  <= mem1(to_integer(unsigned(mem_waddr)));
      mem_rdata_in(23 downto 16) <= mem2(to_integer(unsigned(mem_waddr)));
      mem_rdata_in(31 downto 24) <= mem3(to_integer(unsigned(mem_waddr)));
    end if;
  end process;

  p_mem_port2 : process(clk_i)
  begin
    if rising_edge(clk_i) then
      mem_rdata_out(7 downto 0)   <= mem0(to_integer(mem_raddr));
      mem_rdata_out(15 downto 8)  <= mem1(to_integer(mem_raddr));
      mem_rdata_out(23 downto 16) <= mem2(to_integer(mem_raddr));
      mem_rdata_out(31 downto 24) <= mem3(to_integer(mem_raddr));
    end if;
  end process;

  p_mem_out_addr : process(outb_i.adr, rd_state, rd_ptr)
  begin

    if(rd_state = IDLE) then
      mem_raddr <= rd_ptr & to_unsigned(0, c_slot_offset_bits);
    else
      mem_raddr <= rd_ptr & unsigned(outb_i.adr(c_slot_offset_bits+1 downto 2));
    end if;
  end process;




  p_write_side : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        wr_state           <= IDLE;
        stat_o.commit_mask <= '0';
      else

        if(in_commit = '1' or in_ready = '1') then
          stat_o.commit_mask <= '1';
        end if;

        case wr_state is
          when IDLE =>
            if in_claim = '1' then
              if full = '1' then
                wr_state <= IGNORE_MESSAGE;
              else
                wr_state <= ACCEPT_DATA;
              end if;
            end if;

          when IGNORE_MESSAGE =>
            if in_ready = '1' then
              wr_state <= IDLE;
            end if;
            
            
          when ACCEPT_DATA =>
            
            if in_ready = '1' then
              wr_state           <= READY_SEND;
            elsif in_enqueue = '1' then
              stat_o.commit_mask <= '0';
              wr_state           <= READY_SEND;
            end if;

          when READY_SEND =>
            wr_state <= IDLE;
        end case;
      end if;
    end if;
  end process;


  p_read_side : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        stat_o.ready <= '0';
        rd_state     <= IDLE;
      else
        case rd_state is
          when IDLE =>
            if(empty = '0') then
              rd_state <= READ_SIZE;
            end if;

          when READ_SIZE =>
            n_words_last        <= mem_rdata_out(7 downto 0);
            stat_o.current_size <= mem_rdata_out(7 downto 0);
            stat_o.ready        <= '1';
            rd_state            <= WAIT_DISCARD;

          when WAIT_DISCARD =>
            if(out_discard = '1') then
              rd_state     <= IDLE;
              stat_o.ready <= '0';
            end if;
        end case;
      end if;
    end if;
  end process;

  q_write <= '1' when (wr_state = READY_SEND)                         else '0';
  q_read  <= '1' when (rd_state = WAIT_DISCARD and out_discard = '1') else '0';

  p_counters : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' or in_purge = '1' or out_purge = '1' then
        rd_ptr   <= (others => '0');
        wr_ptr   <= (others => '0');
        occupied <= (others => '0');
      else
        if(q_write = '1' and full = '0') then
          wr_ptr <= wr_ptr + 1;
        end if;

        if(q_read = '1' and empty = '0') then
          rd_ptr <= rd_ptr + 1;
        end if;

        if(q_write = '1' and q_read = '0') then
          occupied <= occupied + 1;
        elsif(q_write = '0' and q_read = '1') then
          occupied <= occupied - 1;
        end if;
      end if;
    end if;
  end process;


  full  <= '1' when (wr_ptr + 1 = rd_ptr) else '0';
  empty <= '1' when (wr_ptr = rd_ptr)     else '0';

  stat_o.full  <= full;
  stat_o.empty <= empty;
  stat_o.count <= std_logic_vector(occupied);


end rtl;

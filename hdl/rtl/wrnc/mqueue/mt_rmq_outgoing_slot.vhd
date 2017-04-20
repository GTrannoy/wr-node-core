-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_rmq_outgoing slot.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-13
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Single outgoing (MT->world) slot of the Remote Message Queue.
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

entity mt_rmq_outgoing_slot is
  
  generic (
    g_entries : integer;
    g_width   : integer);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    stat_o : out t_slot_status_out;

    inb_i : in  t_slot_bus_in;
    inb_o : out t_slot_bus_out;

    config_o : out t_rmq_outgoing_slot_config;

    src_o : out t_mt_stream_source_out;
    src_i : in  t_mt_stream_source_in;

    tx_req_o   : out std_logic;
    tx_grant_i : in  std_logic;

    rmq_swrst_o : out std_logic;

    out_discard_i : in std_logic := '0'
    );

end mt_rmq_outgoing_slot;

architecture rtl of mt_rmq_outgoing_slot is

  constant c_rmq_data_start_offset : integer := 32;

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
  type t_rd_state is (IDLE, READ_SIZE, SEND_MSW, SEND_LSW, SEND_DONE);

  signal mem_we : std_logic_vector(3 downto 0);

  signal full, empty : std_logic;

  signal wr_state : t_wr_state;
  signal rd_state : t_rd_state;

  signal in_claim, in_purge, in_ready, in_enqueue, in_commit : std_logic;

  signal in_cmd_wr, in_stat_rd : std_logic;
  signal status                : std_logic_vector(31 downto 0);

  signal q_read, q_write : std_logic;

  constant c_addr_command   : integer := 0;
  constant c_addr_status    : integer := 1;
  constant c_addr_config    : integer := 2;
  constant c_addr_mac_hi    : integer := 3;
  constant c_addr_mac_lo    : integer := 4;
  constant c_addr_ethertype : integer := 5;
  constant c_addr_dst_ip    : integer := 6;
  constant c_addr_src_ip    : integer := 7;
  constant c_addr_dst_port  : integer := 8;
  constant c_addr_src_port  : integer := 9;

  signal n_words_last : std_logic_vector(15 downto 0);

  signal config : t_rmq_outgoing_slot_config;

  signal rd_count, rd_count_next : unsigned(6 downto 0);

  signal wr_mem_offset : unsigned(6 downto 0);
  signal wr_mem_valid: std_logic;
begin  -- rtl

  
  

  p_mem_write : process(inb_i, wr_ptr, wr_state, wr_mem_offset, wr_mem_valid, in_enqueue, in_commit, in_ready)
  begin

    if( in_ready = '1' or in_commit = '1' or in_enqueue = '1') then
      wr_mem_offset <= (others => '0');
      wr_mem_valid <= '1';
    elsif ( unsigned(inb_i.adr(c_slot_offset_bits+1 downto 2)) >= c_rmq_data_start_offset ) then
      wr_mem_offset <= (unsigned(inb_i.adr(c_slot_offset_bits+1 downto 2)) - c_rmq_data_start_offset + 1);
      wr_mem_valid <= '1';
    else
      wr_mem_offset <= (others => 'X');
      wr_mem_valid <= '0';
    end if;
   
    
    if(wr_state = IGNORE_MESSAGE) then
      mem_we <= (others => '0');
    else
      for i in 0 to 3 loop
        mem_we(i) <= (wr_mem_valid and inb_i.we and inb_i.sel and inb_i.wmask(i));
      end loop;
    end if;

    mem_waddr <= wr_ptr & wr_mem_offset;
    mem_wdata <= inb_i.dat;
  end process;

  status(0)            <= full;
  status(1)            <= empty;
  status(15 downto 8)  <= std_logic_vector(occupied);
  status(27 downto 16) <= n_words_last(11 downto 0);
  status(31 downto 28) <= std_logic_vector(to_unsigned(f_log2_size(g_width), 4));
  status(7 downto 2)   <= std_logic_vector(to_unsigned(f_log2_size(g_entries), 6));

  in_claim   <= in_cmd_wr and inb_i.dat(24);
  in_purge   <= in_cmd_wr and inb_i.dat(25);
  in_ready   <= in_cmd_wr and inb_i.dat(26);
  in_enqueue <= in_cmd_wr and inb_i.dat(29);
  in_commit  <= in_cmd_wr and inb_i.dat(30);

  in_cmd_wr <= '1' when inb_i.sel = '1' and inb_i.we = '1' and (unsigned(inb_i.adr(9 downto 2)) = c_addr_command) else '0';

  p_write_config_regs : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then

      else
        if (inb_i.sel = '1' and inb_i.we = '1') then
          case to_integer(unsigned(inb_i.adr(9 downto 2))) is
            when c_addr_config =>
              config.is_udp <= inb_i.dat(0);
            when c_addr_mac_hi =>
              config.dst_mac(47 downto 32) <= inb_i.dat(15 downto 0);
            when c_addr_mac_lo =>
              config.dst_mac(31 downto 0) <= inb_i.dat;
            when c_addr_dst_ip =>
              config.dst_ip <= inb_i.dat;
            when c_addr_src_ip =>
              config.src_ip <= inb_i.dat;
            when c_addr_src_port =>
              config.src_port <= inb_i.dat(15 downto 0);
            when c_addr_dst_port =>
              config.dst_port <= inb_i.dat(15 downto 0);
            when c_addr_ethertype =>
              config.ethertype <= inb_i.dat(15 downto 0);
            when others => null;
          end case;
        end if;
        
      end if;
    end if;
  end process;



  p_read_config_regs : process(inb_i, mem_rdata_in, status, config)
  begin

    case to_integer(unsigned(inb_i.adr(9 downto 2))) is
      when c_addr_command =>
        inb_o.dat <= (others => '0');
      when c_addr_status =>
        inb_o.dat <= status;
      when c_addr_config =>
        inb_o.dat <= (0 => config.is_udp, others => '0');
      when c_addr_mac_hi =>
        inb_o.dat <= x"0000" &config.dst_mac(47 downto 32);
      when c_addr_mac_lo =>
        inb_o.dat <= config.dst_mac(31 downto 0);
      when c_addr_dst_ip =>
        inb_o.dat <= config.dst_ip;
      when c_addr_src_ip =>
        inb_o.dat <= config.src_ip;
      when c_addr_src_port =>
        inb_o.dat <= x"0000" & config.src_port;
      when c_addr_dst_port =>
        inb_o.dat <= x"0000" & config.dst_port;
      when c_addr_ethertype =>
        inb_o.dat <= x"0000" & config.ethertype;
      when others =>
        inb_o.dat <= (others => '0');
    end case;
  end process;


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
              wr_state <= READY_SEND;
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

  mem_raddr <= rd_ptr & rd_count_next;


  p_read_side_seq : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        stat_o.ready <= '0';
        rd_state     <= IDLE;
        rd_count     <= (others => '0');
        tx_req_o     <= '0';
      else
        rd_count <= rd_count_next;
        tx_req_o <= '0';
        case rd_state is
          when IDLE =>
            
            if(empty = '0') then
              tx_req_o <= '1';
              if (tx_grant_i = '1') then
                rd_state <= READ_SIZE;
              end if;
            end if;

          when READ_SIZE =>
            n_words_last        <= mem_rdata_out(15 downto 0);
            stat_o.current_size <= mem_rdata_out(15 downto 0);
            config.payload_size <= mem_rdata_out(15 downto 0);
            stat_o.ready        <= '1';
            rd_state            <= SEND_MSW;

          when SEND_MSW =>
            if(src_i.ready = '1') then
              rd_state <= SEND_LSW;
            end if;
            
            
          when SEND_LSW =>
            if(src_i.ready = '1') then
              if(rd_count = unsigned(n_words_last)) then
                rd_state <= SEND_DONE;
              else
                rd_state <= SEND_MSW;
              end if;
            end if;

          when SEND_DONE =>
            rd_state <= IDLE;
            

        end case;
      end if;
    end if;
  end process;

  p_read_side_comb : process(rd_state, src_i, mem_rdata_out, rd_count)
  begin
    src_o.data    <= (others => 'X');
    src_o.last    <= '0';
    src_o.valid   <= '0';
    rd_count_next <= rd_count;

    case rd_state is
      when IDLE => null;
      when READ_SIZE =>
        rd_count_next <= to_unsigned(1, rd_count_next'length);
      when SEND_MSW =>
        src_o.data(15 downto 0)  <= mem_rdata_out(31 downto 16);
        src_o.valid <= '1';
      when SEND_LSW =>
        if ( src_i.ready = '1') then
          rd_count_next <= rd_count + 1;
        end if;
        src_o.data(15 downto 0) <= mem_rdata_out(15 downto 0);
        src_o.valid   <= '1';
        if(rd_count = unsigned(n_words_last)) then
          src_o.last <= '1';
        end if;

      when SEND_DONE => null;
                        
    end case;
  end process;

  q_write <= '1' when (wr_state = READY_SEND) else '0';
  q_read  <= '1' when (rd_state = SEND_DONE)  else '0';

  p_counters : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' or in_purge = '1' then
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

  config_o <= config;

end rtl;

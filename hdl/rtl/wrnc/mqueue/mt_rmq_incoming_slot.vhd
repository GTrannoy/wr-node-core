-------------------------------------------------------------------------------
-- Title      : Mock Turtle Node Core
-- Project    : Mock Turtle
-------------------------------------------------------------------------------
-- File       : mt_rmq_incoming_slot.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-04-17
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Single incoming slot (world->MT) of the Remote Message Queue.
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

entity mt_rmq_incoming_slot is
  
  generic (
    g_entries : integer;
    g_width   : integer);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    stat_o : out t_slot_status_out;

    outb_i : in  t_slot_bus_in;
    outb_o : out t_slot_bus_out;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    p_header_valid_i : in std_logic;
    p_header_i       : in t_rmq_rx_header;

    out_discard_i : in std_logic := '0'
    );

end mt_rmq_incoming_slot;

architecture rtl of mt_rmq_incoming_slot is


  
  constant c_counter_bits     : integer := f_log2_size(g_entries);
  constant c_slot_offset_bits : integer := f_log2_size(g_width);
  constant c_memory_size      : integer := g_width * g_entries;

  type t_slot_mem_array is array (0 to c_memory_size-1) of std_logic_vector(7 downto 0);

  shared variable mem0 : t_slot_mem_array;
  shared variable mem1 : t_slot_mem_array;
  shared variable mem2 : t_slot_mem_array;
  shared variable mem3 : t_slot_mem_array;

  signal mem_raddr, mem_waddr_hdr, mem_waddr_payload : unsigned(f_log2_size(c_memory_size)-1 downto 0);
  signal mem_waddr                                   : unsigned(f_log2_size(c_memory_size)+1 downto 0);
  signal mem_wdata                                   : std_logic_vector(15 downto 0);
  signal mem_rdata_in, mem_rdata_out                 : std_logic_vector(31 downto 0);

  signal rd_ptr, wr_ptr : unsigned(c_counter_bits-1 downto 0);
  signal occupied       : unsigned(7 downto 0);
  signal words_written  : unsigned(7 downto 0);

  type t_wr_state is (IDLE, READY_SEND, ACCEPT_DATA, IGNORE_MESSAGE);
  type t_rd_state is (IDLE, READ_SIZE, WAIT_DISCARD);

  signal mem_we : std_logic;

  signal full, empty : std_logic;

  signal wr_state : t_wr_state;
  signal rd_state : t_rd_state;

  signal in_cmd_wr, in_stat_rd   : std_logic;
  signal out_cmd_wr, out_stat_rd : std_logic;
  signal status                  : std_logic_vector(31 downto 0);

  signal current_size : unsigned(11 downto 0);

  signal out_discard, out_purge : std_logic;

  signal q_read, q_write : std_logic;
  signal n_words_last    : std_logic_vector(15 downto 0);

  constant c_addr_command    : integer := 0;
  constant c_addr_status     : integer := 1;
  constant c_addr_config     : integer := 2;
  constant c_addr_dst_mac_hi : integer := 3;
  constant c_addr_dst_mac_lo : integer := 4;
  constant c_addr_ethertype  : integer := 5;
  constant c_addr_dst_ip     : integer := 6;
  constant c_addr_dst_port   : integer := 7;
  constant c_addr_dst_type0  : integer := 8;
  constant c_addr_dst_type1  : integer := 9;
  constant c_addr_dst_type2  : integer := 10;
  constant c_addr_dst_type3  : integer := 11;

  signal config : t_rmq_incoming_slot_config;

  signal match_type0, match_type1, match_type2, match_type3, match_dst_mac, match_dst_ip, match_udp, match_ethertype, match_dst_port, match_raw, match : std_logic;

  
begin  -- rtl

  p_write_config_regs : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then

      else
        if (outb_i.sel = '1' and outb_i.we = '1') then
          case to_integer(unsigned(outb_i.adr(9 downto 2))) is
            when c_addr_config =>
              config.filter_udp       <= outb_i.dat(0);
--              config.filter_tlv       <= outb_i.dat(1);
              config.filter_raw       <= outb_i.dat(2);
              config.filter_dst_mac   <= outb_i.dat(3);
              config.filter_ethertype <= outb_i.dat(4);
              config.filter_dst_port  <= outb_i.dat(5);
              config.filter_dst_ip    <= outb_i.dat(6);
              config.filter_type0     <= outb_i.dat(7);
              config.filter_type1     <= outb_i.dat(8);
              config.filter_type2     <= outb_i.dat(9);
              config.filter_type3     <= outb_i.dat(10);
            when c_addr_dst_mac_hi =>
              config.dst_mac(47 downto 32) <= outb_i.dat(15 downto 0);
            when c_addr_dst_mac_lo =>
              config.dst_mac(31 downto 0) <= outb_i.dat;
            when c_addr_dst_ip =>
              config.dst_ip <= outb_i.dat;
            when c_addr_dst_port =>
              config.dst_port <= outb_i.dat(15 downto 0);
            when c_addr_ethertype =>
              config.ethertype <= outb_i.dat(15 downto 0);
            when c_addr_dst_type0 =>
              config.type0 <= outb_i.dat(31 downto 0);
            when c_addr_dst_type1 =>
              config.type1 <= outb_i.dat(31 downto 0);
            when c_addr_dst_type2 =>
              config.type2 <= outb_i.dat(31 downto 0);
            when c_addr_dst_type3 =>
              config.type3 <= outb_i.dat(31 downto 0);
            when others => null;
          end case;
        end if;
      end if;
    end if;
  end process;




  status(0)            <= full;
  status(1)            <= empty;
  status(15 downto 8)  <= std_logic_vector(occupied);
  status(27 downto 16) <= n_words_last(11 downto 0);
  status(31 downto 28) <= std_logic_vector(to_unsigned(f_log2_size(g_width), 4));
  status(7 downto 2)   <= std_logic_vector(to_unsigned(f_log2_size(g_entries), 6));

  out_cmd_wr <= '1' when outb_i.sel = '1' and outb_i.we = '1' and (unsigned(outb_i.adr(9 downto 2)) = c_addr_command) else '0';

  out_discard <= out_discard_i or (out_cmd_wr and outb_i.dat(27));
  out_purge   <= out_cmd_wr and outb_i.dat(25);

  p_read_status : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if(unsigned(outb_i.adr(9 downto 2)) = c_addr_status) then
        out_stat_rd <= '1';
      else
        out_stat_rd <= '0';
      end if;

    end if;
  end process;

  outb_o.dat <= status when out_stat_rd = '1' else mem_rdata_out;


  p_mem_port1 : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if(mem_we = '1') then
        if (mem_waddr(1) = '0') then
          mem2(to_integer(mem_waddr srl 2)) := mem_wdata(7 downto 0);
          mem3(to_integer(mem_waddr srl 2)) := mem_wdata(15 downto 8);
        else
          mem0(to_integer(mem_waddr srl 2)) := mem_wdata(7 downto 0);
          mem1(to_integer(mem_waddr srl 2)) := mem_wdata(15 downto 8);
        end if;
      end if;
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
      mem_raddr <= rd_ptr & to_unsigned(31, c_slot_offset_bits);
    else
      mem_raddr <= rd_ptr & unsigned(outb_i.adr(c_slot_offset_bits+1 downto 2));
    end if;
  end process;

  p_mem_in_addr : process(wr_state, wr_ptr, snk_i, mem_waddr_hdr, mem_waddr_payload)
  begin

    if (wr_state = READY_SEND) then
      mem_waddr <= wr_ptr & to_unsigned(31 * 4, c_slot_offset_bits + 2);
    else
      if (snk_i.tag = c_MT_STREAM_TAG_HEADER) then
        mem_waddr <= wr_ptr & mem_waddr_hdr(c_slot_offset_bits downto 0) & '0';
      else
        mem_waddr <= wr_ptr & mem_waddr_payload(c_slot_offset_bits downto 0) & '0';
      end if;
    end if;

  end process;

  p_mem_in_data : process(wr_state, snk_i, current_size)
  begin
    if (wr_state = READY_SEND) then
      mem_wdata <= x"0"&std_logic_vector(current_size);
    else
      mem_wdata <= snk_i.data(15 downto 0);
    end if;
  end process;

  p_mem_in_we : process(snk_i, full, wr_state)
  begin
    if(wr_state = READY_SEND) then
      mem_we <= '1';
    elsif (snk_i.valid = '1' and full = '0') then
      mem_we <= '1';
    else
      mem_we <= '0';
    end if;
  end process;


  snk_o.ready <= '1' when wr_state /= READY_SEND else '0';

  p_filter_packets : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        match <= '0';
      else
        match_dst_port  <= '1';
        match_dst_ip    <= '1';
        match_ethertype <= '1';
        match_dst_mac   <= '1';
        match_udp       <= '1';
        match_raw       <= '1';

        match_type0 <= '1';
        match_type1 <= '1';
        match_type2 <= '1';
        match_type3 <= '1';


        if(config.filter_udp = '1') then
          
          if(p_header_i.ethertype = x"0800") then
            match_ethertype <= '1';
          end if;

          if (config.filter_dst_port = '1') then
            if (config.dst_port = p_header_i.dst_port) then
              match_dst_port <= '1';
            else
              match_dst_port <= '0';
            end if;
          else
            match_dst_port <= '1';
          end if;

          if (config.filter_dst_ip = '1') then
            if (config.dst_ip = p_header_i.dst_ip) then
              match_dst_ip <= '1';
            else
              match_dst_ip <= '0';
              
            end if;
          else
            match_dst_ip <= '1';
          end if;

          if (config.filter_raw = '1') then
            match_raw <= p_header_i.is_raw;
          end if;

          if (config.filter_udp = '1') then
            match_udp <= p_header_i.is_udp;
          end if;


          --if (config.filter_type0 = '1') then
          --  if (config.type0 /= p_header_i.tlv_type) then
          --    match_type0 <= '0';
          --  end if;
          --end if;

          --if (config.filter_type1 = '1') then
          --  if (config.type1 /= p_header_i.tlv_type) then
          --    match_type1 <= '0';
          --  end if;
          --end if;

          --if (config.filter_type2 = '1') then
          --  if (config.type2 /= p_header_i.tlv_type) then
          --    match_type2 <= '0';
          --  end if;
          --end if;

        --if (config.filter_type3 = '1') then
        --  if (config.type3 /= p_header_i.tlv_type) then
        --    match_type3 <= '0';
        --  end if;
        --end if;
        end if;


        if(config.filter_raw = '1') then
          if(p_header_i.ethertype = config.ethertype) then
            match_ethertype <= '1';
          end if;

          if config.filter_dst_mac = '1' then
            if (p_header_i.dst_mac = config.dst_mac) then
              match_dst_mac <= '1';
            end if;
          else
            match_dst_mac <= '1';
          end if;


        end if;
        match <= match_type0 and match_type1 and match_type2 and match_type3 and match_dst_mac and match_dst_ip and match_ethertype and match_dst_port;

      end if;
    end if;
    
  end process;


  p_write_side : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        wr_state <= IDLE;
      else

        case wr_state is
          when IDLE =>
            current_size      <= (others => '0');
            mem_waddr_hdr     <= (others => '0');
            mem_waddr_payload <= to_unsigned(64, mem_waddr_payload'length);

            if snk_i.valid = '1' then
              if full = '1' or snk_i.error = '1' then
                wr_state <= IGNORE_MESSAGE;
              else
                wr_state <= ACCEPT_DATA;
              end if;
            end if;

          when IGNORE_MESSAGE =>
            if snk_i.valid = '1' and snk_i.last = '1' then
              wr_state <= IDLE;
            end if;
            
            
          when ACCEPT_DATA =>
            if snk_i.valid = '1' then

              if(snk_i.tag = c_MT_STREAM_TAG_HEADER) then
                mem_waddr_hdr <= mem_waddr_hdr + 1;
              else
                mem_waddr_payload <= mem_waddr_payload + 1;
                current_size      <= current_size + 2;
              end if;

              if (snk_i.last = '1') then
                if (match = '1' and snk_i.error = '0') then
                  wr_state <= READY_SEND;
                else
                  wr_state <= IDLE;
                end if;
                
              end if;
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
            n_words_last        <= mem_rdata_out(31 downto 16);
            stat_o.current_size <= mem_rdata_out(31 downto 16);
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
      if rst_n_i = '0' or out_purge = '1' then
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

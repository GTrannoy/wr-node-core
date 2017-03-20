-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_mqueue_remote.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-03-14
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Remote MQ implementation. Exchanges messages between CPU CBs in remote
-- nodes.
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

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;

entity wrn_mqueue_remote_noeb is
  generic (
    g_config : t_wrn_mqueue_config := c_wrn_default_mqueue_config
    );

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    si_slave_i : in  t_wishbone_slave_in;
    si_slave_o : out t_wishbone_slave_out;

    src_o : out t_wrf_source_out;
    src_i : in  t_wrf_source_in;

    snk_o : out t_wrf_sink_out;
    snk_i : in  t_wrf_sink_in;

    -- software reset for etherbone
    rmq_swrst_o : out std_logic;

    rmq_status_o : out std_logic_vector(15 downto 0);

    debug_o : out std_logic_vector(31 downto 0)
    );

end wrn_mqueue_remote_noeb;

architecture rtl of wrn_mqueue_remote_noeb is

  component wrn_mqueue_packet_output
    generic (
      g_config : t_wrn_mqueue_config);
    port (
      clk_i       : in  std_logic;
      rmq_swrst_i : in  std_logic;
      rst_n_i     : in  std_logic;
      slots_i     : in  t_slot_bus_out_array(0 to g_config.out_slot_count-1);
      slots_o     : out t_slot_bus_in_array(0 to g_config.out_slot_count-1);
      stat_i      : in  t_slot_status_out_array(0 to g_config.out_slot_count-1);
      discard_o   : out std_logic_vector(g_config.out_slot_count-1 downto 0);
      src_o       : out t_wrf_source_out;
      src_i       : in  t_wrf_source_in;
      debug_o     : out std_logic_vector(31 downto 0)
      );
  end component;

  function f_dummy_slots (n : integer) return t_slot_bus_out_array is
    variable tmp : t_slot_bus_out_array(0 to n-1);
  begin
    for i in 0 to n-1 loop
      tmp(i).dat := (others => '0');
    end loop;
    return tmp;
  end function;



  signal si_incoming_in, eb_incoming_in   : t_slot_bus_in_array(0 to g_config.in_slot_count-1);
  signal si_incoming_out, eb_incoming_out : t_slot_bus_out_array(0 to g_config.in_slot_count-1);
  signal si_outgoing_in, eb_outgoing_in   : t_slot_bus_in_array(0 to g_config.out_slot_count-1);
  signal si_outgoing_out, eb_outgoing_out : t_slot_bus_out_array(0 to g_config.out_slot_count-1);

  signal incoming_stat : t_slot_status_out_array(0 to g_config.in_slot_count-1);
  signal outgoing_stat : t_slot_status_out_array(0 to g_config.out_slot_count-1);

  signal eb_outgoing_discard : std_logic_vector(g_config.out_slot_count-1 downto 0);

  signal rmq_status    : std_logic_vector(g_config.in_slot_count-1 downto 0);
  signal rmq_swrst_vec : std_logic_vector(g_config.out_slot_count-1 downto 0);
  
begin  -- rtl

  rmq_swrst_o <= rmq_swrst_vec(0);

  U_SI_Wishbone_Slave : wrn_mqueue_wishbone_slave
    generic map (
      g_with_gcr => true,
      g_config   => g_config)
    port map (
      clk_i             => clk_i,
      rst_n_i           => rst_n_i,
      incoming_status_i => incoming_stat,
      outgoing_status_i => outgoing_stat,

      incoming_o => si_incoming_in,
      incoming_i => si_incoming_out,
      outgoing_o => si_outgoing_in,
      outgoing_i => si_outgoing_out,

      slave_i => si_slave_i,
      slave_o => si_slave_o);

  -- CB to Etherbone direction (outgoing slots)
  gen_outgoing_slots : for i in 0 to g_config.out_slot_count-1 generate

    U_Out_SlotX : wrn_mqueue_slot
      generic map (
        g_entries => g_config.out_slot_config(i).entries,
        g_width   => g_config.out_slot_config(i).width)
      port map (
        clk_i         => clk_i,
        rst_n_i       => rst_n_i,
        stat_o        => outgoing_stat(i),
        inb_i         => si_outgoing_in(i),
        inb_o         => si_outgoing_out(i),
        outb_i        => eb_outgoing_in(i),
        outb_o        => eb_outgoing_out(i),
        out_discard_i => eb_outgoing_discard(i),
        rmq_swrst_o   => rmq_swrst_vec(i));

  end generate gen_outgoing_slots;

  -- Host to CB direction (incoming slots)
  gen_incoming_slots : for i in 0 to g_config.in_slot_count-1 generate

    U_In_SlotX : wrn_mqueue_slot
      generic map (
        g_entries => g_config.in_slot_config(i).entries,
        g_width   => g_config.in_slot_config(i).width)
      port map (
        clk_i   => clk_i,
        rst_n_i => rst_n_i,
        stat_o  => incoming_stat(i),
        inb_i   => eb_incoming_in(i),
        inb_o   => eb_incoming_out(i),
        outb_i  => si_incoming_in(i),
        outb_o  => si_incoming_out(i));

    rmq_status (i) <= not incoming_stat(i).empty;

  end generate gen_incoming_slots;


  process(rmq_status)
  begin
    rmq_status_o                                    <= (others => '0');
    rmq_status_o(g_config.in_slot_count-1 downto 0) <= rmq_status;
  end process;
  
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;

entity mt_ethernet_tx_framer is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;
    src_o : out t_mt_stream_source_out;

    p_dst_mac_i   : in std_logic_vector(47 downto 0);
    p_ethertype_i : in std_logic_vector(15 downto 0)

    );

end entity;

architecture rtl of mt_ethernet_tx_framer is
  type t_state is (IDLE, DMAC0, DMAC1, SMAC0, SMAC1, SMAC2, ETHERTYPE, PAYLOAD);
  signal state  : t_state;
  signal d_prev : std_logic_vector(15 downto 0);
begin

  p_comb : process(state, snk_i, src_i)
  begin
    if state = IDLE then
      snk_o.ready <= '0';
    elsif state = PAYLOAD then
      snk_o.ready <= src_i.ready;
    end if;
  end process;

  p_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state       <= IDLE;
        src_o.valid <= '0';
      else
        case state is
          when IDLE =>
            if src_i.ready = '1' then
              src_o.valid <= '0';
            end if;

            if snk_i.valid = '1' then
              state                   <= DMAC0;
              src_o.last              <= '0';
              src_o.data(15 downto 0) <= p_dst_mac_i(47 downto 32);
              src_o.valid             <= '1';
            end if;

          when DMAC0 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= p_dst_mac_i(31 downto 16);
              src_o.valid             <= '1';
              state                   <= DMAC1;
            end if;

          when DMAC1 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= p_dst_mac_i(15 downto 0);
              src_o.valid             <= '1';
              state                   <= SMAC0;
            end if;
            
          when SMAC0 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= (others => '0');
              src_o.valid             <= '1';
              state                   <= SMAC1;
            end if;

          when SMAC1 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= (others => '0');
              src_o.valid             <= '1';
              state                   <= SMAC2;
            end if;

          when SMAC2 =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= (others => '0');
              src_o.valid             <= '1';
              state                   <= ETHERTYPE;
            end if;

          when ETHERTYPE =>
            if (src_i.ready = '1') then
              src_o.data(15 downto 0) <= p_ethertype_i;
              src_o.valid             <= '1';
              state                   <= PAYLOAD;
            end if;

          when PAYLOAD =>
            if(src_i.ready = '1') then
              src_o.data(15 downto 0) <= snk_i.data(15 downto 0);
              src_o.valid             <= snk_i.valid;
              src_o.last              <= snk_i.last;

              if(snk_i.last = '1' and snk_i.valid = '1') then
                state <= IDLE;
              end if;
            end if;
        end case;
      end if;
    end if;
  end process;
  
end rtl;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;

entity mt_udp_tx_framer is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;
    src_o : out t_mt_stream_source_out;

    p_src_port_i    : in std_logic_vector(15 downto 0);
    p_dst_port_i    : in std_logic_vector(15 downto 0);
    p_src_ip_i      : in std_logic_vector(31 downto 0);
    p_dst_ip_i      : in std_logic_vector(31 downto 0);
    p_payload_len_i : in std_logic_vector(15 downto 0)

    );

end entity;

architecture rtl of mt_udp_tx_framer is
  type t_state is (IDLE, IP_TLEN, IP_ID, IP_FLAGS, IP_TTL_PROTO, IP_CKSUM, IP_SRC0, IP_SRC1, IP_DST0, IP_DST1, UDP_PAYLOAD, UDP_SPORT, UDP_DPORT, UDP_LEN, UDP_CKSUM, UDP_FIRST, FINISH);
  signal state    : t_state;
  signal checksum : unsigned(19 downto 0);

  procedure f_send_hdr(data : std_logic_vector(15 downto 0); next_state : t_state; signal checksum : inout unsigned; signal src_o : inout t_mt_stream_source_out; signal state : inout t_state) is
  begin
    src_o.valid <= '1';
    if src_i.ready = '1' then
      checksum                <= checksum + unsigned(data);
      src_o.data(15 downto 0) <= data;
      state                   <= next_state;
    end if;
  end procedure;

  signal d_prev : std_logic_vector(15 downto 0);
  
begin

  p_comb : process(state, snk_i, src_i)
  begin
    if state = IDLE then
      snk_o.ready <= '0';
    elsif state = UDP_PAYLOAD or state = UDP_FIRST then
      snk_o.ready <= src_i.ready;
    else
      snk_o.ready <= '0';
    end if;
  end process;


  p_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state       <= IDLE;
        src_o.valid <= '0';
        checksum    <= (others => '0');
      else
        case state is
          when FINISH =>
            if src_i.ready = '1' then
              src_o.valid <= '0';
              state       <= IDLE;
            end if;
            
          when IDLE =>

            if snk_i.valid = '1' then
              src_o.valid             <= '1';
              src_o.last              <= '0';
              src_o.data(15 downto 0) <= x"4500";
              state                   <= IP_TLEN;
            end if;
            

          when IP_TLEN =>
            f_send_hdr(
              std_logic_vector((unsigned(p_payload_len_i) sll 1) + to_unsigned(20 + 8, 16)), IP_ID, checksum, src_o, state); 

          when IP_ID =>
            f_send_hdr(x"0000", IP_FLAGS, checksum, src_o, state);

          when IP_FLAGS =>
            f_send_hdr(x"4000", IP_TTL_PROTO, checksum, src_o, state);  -- don't fragment

          when IP_TTL_PROTO =>
            f_send_hdr(x"3c11", IP_CKSUM, checksum, src_o, state);  -- ttl = 60, proto = UDP

          when IP_CKSUM =>
            f_send_hdr(std_logic_vector(not (checksum(15 downto 0) + checksum(19 downto 16))), IP_SRC0, checksum, src_o, state);

          when IP_SRC0 =>
            f_send_hdr(p_src_ip_i(31 downto 16), IP_SRC1, checksum, src_o, state);

          when IP_SRC1=>
            f_send_hdr(p_src_ip_i(15 downto 0), IP_DST0, checksum, src_o, state);

          when IP_DST0=>
            f_send_hdr(p_dst_ip_i(31 downto 16), IP_DST1, checksum, src_o, state);

          when IP_DST1=>
            f_send_hdr(p_dst_ip_i(15 downto 0), UDP_SPORT, checksum, src_o, state);
            
          when UDP_SPORT =>
            f_send_hdr(p_src_port_i, UDP_DPORT, checksum, src_o, state);

          when UDP_DPORT =>
            f_send_hdr(p_dst_port_i, UDP_LEN, checksum, src_o, state);

          when UDP_LEN =>
            f_send_hdr(std_logic_vector(unsigned(p_payload_len_i sll 1) + 8), UDP_CKSUM, checksum, src_o, state);

          when UDP_CKSUM =>
            f_send_hdr(x"0000", UDP_FIRST, checksum, src_o, state);

          when UDP_FIRST =>
            f_send_hdr(snk_i.data(15 downto 0), UDP_PAYLOAD, checksum, src_o, state);
            
            
            
          when UDP_PAYLOAD =>
            if(src_i.ready = '1') then
              src_o.data(15 downto 0) <= snk_i.data(15 downto 0);
              src_o.valid             <= snk_i.valid;
              src_o.last              <= snk_i.last;
            end if;

            if(snk_i.last = '1' and snk_i.valid = '1' and src_i.ready = '1') then
              checksum <= (others => '0');
              state    <= FINISH;
            end if;
            
            
        end case;
      end if;
    end if;
  end process;
  
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;


entity mt_stream_stage is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;    -- 32-bit data
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;  -- 16-bit data
    src_o : out t_mt_stream_source_out
    );

end entity;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;

entity mt_rmq_stream_register is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;    -- 32-bit data
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;  -- 16-bit data
    src_o : out t_mt_stream_source_out
    );

end entity;

architecture rtl of mt_rmq_stream_register is

  signal tmp_src_out : t_mt_stream_source_out;
  signal tmp_src_in  : t_mt_stream_source_in;

  signal src_out : t_mt_stream_source_out;
  signal src_in  : t_mt_stream_source_in;

  signal src_valid_next : std_logic;
  signal tmp_valid_next : std_logic;
  signal ready_early    : std_logic;

  signal input_to_output : std_logic;
  signal input_to_temp   : std_logic;
  signal temp_to_output  : std_logic;

  signal ready_reg : std_logic;

begin
  
  ready_early <= src_i.ready or (not tmp_src_out.valid and (not src_out.valid or not snk_i.valid));

  process (src_out, tmp_src_out, ready_reg, snk_i, src_i)
  begin
    src_valid_next <= src_out.valid;
    tmp_valid_next <= tmp_src_out.valid;

    input_to_output <= '0';
    input_to_temp   <= '0';
    temp_to_output  <= '0';

    if (ready_reg = '1') then
      if (src_i.ready = '1' or src_out.valid = '0') then
        src_valid_next  <= snk_i.valid;
        input_to_output <= '1';
      else
        tmp_valid_next <= snk_i.valid;
        input_to_temp  <= '1';
      end if;
    elsif (src_i.ready = '1') then
      src_valid_next <= tmp_src_out.valid;
      tmp_valid_next <= '0';
      temp_to_output <= '1';
    end if;
  end process;

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ready_reg         <= '0';
        src_out.valid     <= '0';
        tmp_src_out.valid <= '0';
      else
        ready_reg         <= ready_early;
        src_out.valid     <= src_valid_next;
        tmp_src_out.valid <= tmp_valid_next;

        if (input_to_output = '1') then
          src_out.data <= snk_i.data;
          src_out.last <= snk_i.last;
        elsif (temp_to_output = '1') then
          src_out.data <= tmp_src_out.data;
          src_out.last <= tmp_src_out.last;
        end if;

        if (input_to_temp = '1') then
          tmp_src_out.data <= snk_i.data;
          tmp_src_out.last <= snk_i.last;
        end if;
      end if;
    end if;
  end process;

  src_o       <= src_out;
  snk_o.ready <= ready_reg;
  
end rtl;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;

entity mt_rmq_tx_packer is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;    -- 32-bit data
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;  -- 16-bit data
    src_o : out t_mt_stream_source_out
    );

end entity;

architecture rtl of mt_rmq_tx_packer is

  component mt_rmq_stream_register is
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      snk_i   : in  t_mt_stream_sink_in;
      snk_o   : out t_mt_stream_sink_out;
      src_i   : in  t_mt_stream_source_in;
      src_o   : out t_mt_stream_source_out);
  end component mt_rmq_stream_register;


  type t_state is (HI_WORD, LO_WORD);

  signal tmp_out : t_mt_stream_source_out;
  signal tmp_in  : t_mt_stream_source_in;
  signal state   : t_state;
  
begin
  mt_rmq_stream_register_1 : mt_rmq_stream_register
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      snk_i   => tmp_out,
      snk_o   => tmp_in,
      src_i   => src_i,
      src_o   => src_o);

  p_comb : process(state, snk_i, tmp_out, tmp_in)
  begin
    if state = HI_WORD then
      tmp_out.valid             <= snk_i.valid;
      tmp_out.data(15 downto 0) <= snk_i.data(31 downto 16);
      tmp_out.last              <= '0';
      snk_o.ready               <= '0';
    else
      tmp_out.valid             <= snk_i.valid;
      tmp_out.data(15 downto 0) <= snk_i.data(15 downto 0);
      tmp_out.last              <= snk_i.last;
      snk_o.ready               <= tmp_in.ready;
    end if;
  end process;

  p_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state <= HI_WORD;
      else
        case state is
          when HI_WORD =>
            if tmp_in.ready = '1' and snk_i.valid = '1' then
              state <= LO_WORD;
            end if;
          when LO_WORD =>
            if tmp_in.ready = '1' then
              state <= HI_WORD;
            end if;
            
        end case;
      end if;
    end if;
  end process;
  

end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;


entity mt_rmq_tx_path is
  port (

    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;
    src_o : out t_mt_stream_source_out;

    p_use_udp_i       :    std_logic;
    p_dst_mac_i       : in std_logic_vector(47 downto 0);
    p_ethertype_i     : in std_logic_vector(15 downto 0);
    p_src_port_i      : in std_logic_vector(15 downto 0);
    p_dst_port_i      : in std_logic_vector(15 downto 0);
    p_src_ip_i        : in std_logic_vector(31 downto 0);
    p_dst_ip_i        : in std_logic_vector(31 downto 0);
    p_payload_words_i : in std_logic_vector(15 downto 0)
    );

end mt_rmq_tx_path;

architecture rtl of mt_rmq_tx_path is

  type t_mt_stream_source_out_array is array(integer range<>) of t_mt_stream_source_out;
  type t_mt_stream_source_in_array is array(integer range<>) of t_mt_stream_source_in;

  signal fwd_pipe : t_mt_stream_source_out_array(0 to 2);
  signal rev_pipe : t_mt_stream_source_in_array(0 to 2);

  component mt_rmq_tx_packer is
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      snk_i   : in  t_mt_stream_sink_in;
      snk_o   : out t_mt_stream_sink_out;
      src_i   : in  t_mt_stream_source_in;
      src_o   : out t_mt_stream_source_out);
  end component mt_rmq_tx_packer;

  component mt_udp_tx_framer is
    port (
      clk_i           : in  std_logic;
      rst_n_i         : in  std_logic;
      snk_i           : in  t_mt_stream_sink_in;
      snk_o           : out t_mt_stream_sink_out;
      src_i           : in  t_mt_stream_source_in;
      src_o           : out t_mt_stream_source_out;
      p_src_port_i    : in  std_logic_vector(15 downto 0);
      p_dst_port_i    : in  std_logic_vector(15 downto 0);
      p_src_ip_i      : in  std_logic_vector(31 downto 0);
      p_dst_ip_i      : in  std_logic_vector(31 downto 0);
      p_payload_len_i : in  std_logic_vector(15 downto 0));
  end component mt_udp_tx_framer;

  component mt_ethernet_tx_framer is
    port (
      clk_i         : in  std_logic;
      rst_n_i       : in  std_logic;
      snk_i         : in  t_mt_stream_sink_in;
      snk_o         : out t_mt_stream_sink_out;
      src_i         : in  t_mt_stream_source_in;
      src_o         : out t_mt_stream_source_out;
      p_dst_mac_i   : in  std_logic_vector(47 downto 0);
      p_ethertype_i : in  std_logic_vector(15 downto 0));
  end component mt_ethernet_tx_framer;

begin


  U_Packer : mt_rmq_tx_packer
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      snk_i   => snk_i,
      snk_o   => snk_o,
      src_i   => rev_pipe(0),
      src_o   => fwd_pipe(0));

  U_UDPFramer : mt_udp_tx_framer
    port map (
      clk_i           => clk_i,
      rst_n_i         => rst_n_i,
      snk_i           => fwd_pipe(0),
      snk_o           => rev_pipe(0),
      src_i           => rev_pipe(1),
      src_o           => fwd_pipe(1),
      p_src_port_i    => p_src_port_i,
      p_dst_port_i    => p_dst_port_i,
      p_src_ip_i      => p_src_ip_i,
      p_dst_ip_i      => p_dst_ip_i,
      p_payload_len_i => std_logic_vector(unsigned(p_payload_words_i) sll 1));

  U_EthernetFramer : mt_ethernet_tx_framer
    port map (
      clk_i         => clk_i,
      rst_n_i       => rst_n_i,
      snk_i         => fwd_pipe(1),
      snk_o         => rev_pipe(1),
      src_i         => rev_pipe(2),
      src_o         => fwd_pipe(2),
      p_dst_mac_i   => p_dst_mac_i,
      p_ethertype_i => p_ethertype_i);

  src_o       <= fwd_pipe(2);
  rev_pipe(2) <= src_i;
  
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_fabric_pkg.all;

entity mt_rmq_rx_deframer is
  port(
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    src_i : in  t_mt_stream_source_in;
    src_o : out t_mt_stream_source_out;

    p_header_valid_o : out std_logic;
    p_is_udp_o       : out std_logic;
    p_is_raw_o       : out std_logic;
    p_is_tlv_o       : out std_logic;
    p_src_mac_o      : out std_logic_vector(47 downto 0);
    p_dst_mac_o      : out std_logic_vector(47 downto 0);
    p_ethertype_o    : out std_logic_vector(15 downto 0);
    p_src_port_o     : out std_logic_vector(15 downto 0);
    p_dst_port_o     : out std_logic_vector(15 downto 0);
    p_src_ip_o       : out std_logic_vector(31 downto 0);
    p_dst_ip_o       : out std_logic_vector(31 downto 0);
    p_udp_length_o : out std_logic_vector(15 downto 0);
    p_tlv_type_o     : out std_logic_vector(31 downto 0);
    p_tlv_size_o     : out std_logic_vector(15 downto 0)
    );

end mt_rmq_rx_deframer;

architecture rtl of mt_rmq_rx_deframer is
  type t_state is (IDLE, DMAC0, DMAC1, SMAC0, SMAC1, SMAC2, ETHERTYPE, IP_HDR0, IP_HDR1, IP_HDR2, IP_HDR3, IP_HDR4, IP_HDR5, IP_SRC_IP_MSB, IP_SRC_IP_LSB, IP_DST_IP_MSB, IP_DST_IP_LSB, UDP_SRC_PORT, UDP_DST_PORT, UDP_CHECKSUM, UDP_LENGTH, PAYLOAD );
 
  function f_pick(cond : boolean; if_true : t_state; if_false : t_state) return t_state is
  begin
    if(cond) then
      return if_true;
    else
      return if_false;
    end if;
  end f_pick;

  procedure f_rx(signal state : inout t_state; next_state : t_state; signal target : out std_logic_vector) is
  begin
    if (snk_i.valid = '1') then
      if (snk_i.error = '1') then
--        src_o.error <= '1';
        state       <= IDLE;
      elsif (snk_i.last = '1') then
--        src_o.last <= '1';
        state      <= IDLE;
      else
        target <= snk_i.data;
        state  <= next_state;
      end if;
    end if;
  end f_rx;

  signal dummy : std_logic_vector(15 downto 0);
  signal state : t_state;

  
begin

  p_fsm : process(clk_i)
    variable next_state : t_state;
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state            <= IDLE;
        p_header_valid_o <= '0';
      else
        
        case state is
          when IDLE =>
            p_header_valid_o <= '0';
            p_is_raw_o <= '0';
            p_is_udp_o <= '0';
            
            f_rx(state, DMAC0, p_dst_mac_o(47 downto 32));
          when DMAC0 =>
            f_rx(state, DMAC1, p_dst_mac_o(31 downto 16));
          when DMAC1 =>
            f_rx(state, SMAC0, p_dst_mac_o(15 downto 0));
          when SMAC0 =>
            f_rx(state, SMAC1, p_src_mac_o(47 downto 32));
          when SMAC1 =>
            f_rx(state, SMAC2, p_src_mac_o(31 downto 16));
          when SMAC2 =>
            f_rx(state, ETHERTYPE, p_src_mac_o(15 downto 0));
          when ETHERTYPE =>

            if (snk_i.data = x"0800") then
              next_state := IP_HDR0;
  --          elsif (snk_i.data = x"dead") then
--              next_state := TLV_HDR0;
            else
              p_is_raw_o <= '1';
              next_state       := PAYLOAD;
            end if;

            f_rx(state, next_state, p_ethertype_o(15 downto 0));

          when IP_HDR0 =>               -- version/IHL
            -- not IPV4? reject
            next_state := f_pick(snk_i.data(15 downto 8) = x"45", IP_HDR1, IDLE);
            f_rx(state, next_state, dummy);

          when IP_HDR1 =>               -- total length
            f_rx(state, IP_HDR2, dummy);

          when IP_HDR2 =>               -- identification
            f_rx(state, IP_HDR3, dummy);
          when IP_HDR3 =>               -- flags/fragment offset
            f_rx(state, IP_HDR4, dummy);
          when IP_HDR4 =>               -- ttl/protocol
            -- not UDP? reject
            next_state := f_pick(snk_i.data(7 downto 0) = x"11", IP_HDR5, IDLE);
            f_rx(state, next_state, dummy);
          when IP_HDR5 =>               -- checksum
            p_is_udp_o <= '1';
            f_rx(state, IP_SRC_IP_MSB, dummy);
          when IP_SRC_IP_MSB =>
            f_rx(state, IP_SRC_IP_LSB, p_src_ip_o(31 downto 16));
          when IP_SRC_IP_LSB =>
            f_rx(state, IP_DST_IP_MSB, p_src_ip_o(15 downto 0));
          when IP_DST_IP_MSB =>
            f_rx(state, IP_DST_IP_LSB, p_dst_ip_o(31 downto 16));
          when IP_DST_IP_LSB =>
            f_rx(state, UDP_SRC_PORT, p_dst_ip_o(15 downto 0));

          when UDP_SRC_PORT =>
            f_rx(state, UDP_DST_PORT, p_src_port_o(15 downto 0));
            
          when UDP_DST_PORT =>
            f_rx(state, UDP_LENGTH, p_dst_port_o(15 downto 0));
          when UDP_LENGTH =>
            f_rx(state, UDP_CHECKSUM, dummy);
            
          when UDP_CHECKSUM =>
            f_rx(state, PAYLOAD, dummy);

          when PAYLOAD =>
            p_header_valid_o <= '1';
            
--            f_rx(
        end case;


      end if;
    end if;

  end process;

p_is_tlv_o <= '0';
  
  
end rtl;

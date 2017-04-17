-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_mqueue_etherbone_output.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-03-24
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Glue between MQ's outgoing slots and the Etherbone master core. Takes
-- data from a READY slot and passes it in a form digestible for EBM.
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
use work.wr_node_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.genram_pkg.all;


entity mt_rmq_packet_output is
  
  generic (
    g_config : t_wrn_mqueue_config);

  port (
    clk_i       : in std_logic;
    rst_n_i     : in std_logic;
    rmq_swrst_i : in std_logic;

    slots_i : in  t_slot_bus_out_array(0 to g_config.out_slot_count-1);
    slots_o : out t_slot_bus_in_array(0 to g_config.out_slot_count-1);

    stat_i    : in  t_slot_status_out_array(0 to g_config.out_slot_count-1);
    discard_o : out std_logic_vector(g_config.out_slot_count-1 downto 0);



    debug_o : out std_logic_vector(31 downto 0)
    );

end mt_rmq_packet_output;

architecture rtl of mt_rmq_packet_output is

  function f_prio_encode (x : std_logic_vector) return std_logic_vector is
    variable rv : std_logic_vector(f_log2_size(x'length) -1 downto 0);
  begin
    rv := (others => '0');
    for i in 0 to x'length-1 loop
      if x(i) = '1' then
        rv := std_logic_vector(to_unsigned(i, f_log2_size(x'length)));
        return rv;
      end if;
    end loop;  -- i 
    return rv;
  end function;

  type t_arb_state is (ARB_IDLE, ARB_SEND);

  constant c_slot_index_size : integer := f_log2_size(g_config.out_slot_count);


  signal arb_state : t_arb_state;

  signal slot_ready : std_logic;
  signal slot_sel   : std_logic_vector(c_slot_index_size-1 downto 0);
  signal slot_done  : std_logic;

  signal slot_req : std_logic_vector(g_config.out_slot_count-1 downto 0);


  signal slot_in      : t_slot_bus_out;
  signal slot_stat    : t_slot_status_out;
  signal slot_out     : t_slot_bus_in;
  signal slot_discard : std_logic;

  type t_state is (WAIT_SLOT);

  signal eb_state : t_eb_state;

  signal eb_write_addr           : unsigned(23 downto 0);
  signal eb_write_start          : unsigned(23 downto 0);
  signal msg_size, msg_remaining : unsigned(7 downto 0);

  signal ack_count : unsigned(7 downto 0);


  signal slot_addr : unsigned(9 downto 0);

  signal rq_adr    : std_logic_vector(31 downto 0);
  signal rq_dat_wr : std_logic_vector(31 downto 0);
  signal rq_wr     : std_logic;
  signal rq_rd     : std_logic;
  signal rq_done   : std_logic;
  signal rq_dat_rd : std_logic_vector(31 downto 0);
  signal rq_ready  : std_logic;

  signal rst_n_int : std_logic;
  
begin  -- rtl

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      rst_n_int <= rst_n_i and not rmq_swrst_i;
    end if;
  end process;

  gen_slot_status : for i in 0 to g_config.out_slot_count-1 generate
    slot_req(i) <= stat_i(i).ready;
  end generate gen_slot_status;

  p_arbitrate_slots : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_int = '0' then
        arb_state  <= ARB_IDLE;
        slot_ready <= '0';
        slot_sel   <= (others => '0');
      else
        case arb_state is
          when ARB_IDLE =>
            if unsigned(slot_req) /= 0 then
              slot_sel   <= f_prio_encode(slot_req);
              slot_ready <= '1';
              arb_state  <= ARB_SEND;
            end if;

          when ARB_SEND =>
            if(slot_done = '1') then
              slot_ready <= '0';
              arb_state  <= ARB_IDLE;
            end if;
        end case;
      end if;
    end if;
  end process;

  debug_o(0)          <= slot_ready;
  debug_o(1)          <= slot_done;
  debug_o(2 downto 2) <= slot_sel;
  debug_o(8)          <= stat_i(0).ready;

  p_pick_slot : process(slots_i, stat_i, slot_out, slot_sel, slot_ready, slot_discard)
    variable idx : integer;
    variable tmp : std_logic_vector(g_config.out_slot_count-1 downto 0);
    
  begin
    idx := to_integer(unsigned(slot_sel));
    if(slot_ready = '1') then
      slot_in   <= slots_i(idx);
      slot_stat <= stat_i(idx);
    else
      slot_in   <= c_dummy_slot_bus_in;
      slot_stat <= c_dummy_status_out;
    end if;

    tmp := (others => '0');
    if (slot_ready = '1') then
      tmp (idx) := slot_discard;
    end if;
    discard_o <= tmp;

    for i in 0 to g_config.out_slot_count-1 loop
      slots_o(i) <= slot_out;
    end loop;  -- i
    
  end process;


  p_packet_source_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_int = '0' then
        eb_state            <= EB_WAIT_SLOT;
        slot_discard        <= '0';
        slot_done           <= '0';
        rq_wr               <= '0';
        rq_rd               <= '0';
        debug_o(7 downto 4) <= "0000";
      else
        case eb_state is
          when EB_WAIT_SLOT =>
            debug_o(7 downto 4) <= "0001";
            slot_done           <= '0';
            slot_discard        <= '0';
            slot_addr           <= to_unsigned(4, 10);

            rq_rd <= '0';
            rq_wr <= '0';

            if(slot_ready = '1') then
              eb_state      <= EB_SET_TARGET_IP;
              msg_size      <= unsigned(slot_stat.current_size) - 2;  -- fixme
              msg_remaining <= unsigned(slot_stat.current_size) - 3;
              rq_dat_wr     <= slot_in.dat;
              rq_wr         <= '0';
            end if;
            
          when EB_SET_TARGET_IP =>
            debug_o(7 downto 4) <= "0010";
            rq_adr              <= std_logic_vector(to_unsigned(c_DST_IPV4, 32));
            rq_wr               <= '1';
            slot_addr           <= slot_addr + 4;
            eb_state            <= EB_SET_TARGET_PORT;

          when EB_SET_TARGET_PORT =>
            debug_o(7 downto 4) <= "0011";
            if(rq_done = '1') then
              rq_adr    <= std_logic_vector(to_unsigned(c_DST_UDP_PORT, 32));
              rq_dat_wr <= slot_in.dat;
              rq_wr     <= '1';
              eb_state  <= EB_SET_MAX_OPS;
              slot_addr <= slot_addr + 4;

            end if;

          when EB_SET_MAX_OPS =>
            debug_o(7 downto 4) <= "0100";
            if(rq_done = '1') then

              rq_adr    <= std_logic_vector(to_unsigned(c_OPS_MAX, 32));
              rq_dat_wr <= std_logic_vector (resize(msg_size + 2, 32));
              rq_wr     <= '1';

              eb_state <= EB_SET_TARGET_BASE;
            end if;

            
          when EB_SET_TARGET_BASE =>
            debug_o(7 downto 4) <= "0101";
            rq_wr               <= '0';

            eb_write_addr  <= unsigned(slot_in.dat(23 downto 0)) + 8;
            eb_write_start <= unsigned(slot_in.dat(23 downto 0));
            eb_state       <= EB_SET_XFER_SIZE;

          when EB_SET_XFER_SIZE =>
            debug_o(7 downto 4) <= "0110";
            if(rq_done = '1') then

              rq_adr    <= std_logic_vector(to_unsigned(c_PAC_LEN, 32));
              rq_dat_wr <= x"00000200";
              rq_wr     <= '1';

              eb_state <= EB_SEND_CLAIM;
            end if;


          when EB_SEND_CLAIM =>
            debug_o(7 downto 4) <= "0111";
            if(rq_done = '1') then
              rq_adr    <= std_logic_vector(resize(eb_write_start, 32)) or x"03000000";
              rq_dat_wr <= x"01000000";
              rq_wr     <= '1';


              slot_addr <= slot_addr + 4;
              eb_state  <= EB_WRITE_DATA;
            end if;
            

          when EB_WRITE_DATA =>
            debug_o(7 downto 4) <= "1000";
            if(rq_done = '1') then
              if(msg_remaining = 0) then
                rq_adr    <= std_logic_vector(resize(eb_write_start, 32)) or x"03000000";
                rq_dat_wr <= x"04000000";
                rq_wr     <= '1';


                eb_state <= EB_SEND_READY;
              else

                rq_adr    <= std_logic_vector(resize(eb_write_addr, 32)) or x"03000000";
                rq_dat_wr <= slot_in.dat;
                rq_wr     <= '1';

                msg_remaining <= msg_remaining - 1;
                eb_write_addr <= eb_write_addr + 4;
                eb_state      <= EB_DUMMY_WAIT;

              end if;
            end if;

          when EB_DUMMY_WAIT =>
            debug_o(7 downto 4) <= "1001";
            rq_wr               <= '0';
            rq_rd               <= '0';

            eb_state  <= EB_WRITE_DATA;
            slot_addr <= slot_addr + 4;
            
            
          when EB_SEND_READY =>
            debug_o(7 downto 4) <= "1010";
            if(rq_done = '1') then
              rq_adr    <= std_logic_vector(to_unsigned(c_FLUSH, 32));
              rq_dat_wr <= x"00000001";
              rq_wr     <= '1';
              eb_state  <= EB_FLUSH_XFER;
            end if;
            
          when EB_FLUSH_XFER =>
            debug_o(7 downto 4) <= "1011";
            rq_wr               <= '0';
            if(rq_done = '1') then
--  slot_discard <= '1';
              eb_state <= EB_READ_STATUS;
            end if;

          when EB_READ_STATUS =>
            debug_o(7 downto 4) <= "1100";
            eb_state            <= EB_WAIT_XFER_DONE;
            rq_rd               <= '1';
            rq_adr              <= std_logic_vector(to_unsigned(c_STATUS, 32));


            
          when EB_WAIT_XFER_DONE =>
            debug_o(7 downto 4) <= "1101";
            rq_rd               <= '0';
            if (rq_done = '1') then
              if(rq_dat_rd(31 downto 16) = x"0000") then
                slot_done    <= '1';
                slot_discard <= '1';
                eb_state     <= EB_FINISH_TRANSFER;
              else
                
                eb_state <= EB_READ_STATUS;
              end if;
            end if;

          when EB_FINISH_TRANSFER =>
            debug_o(7 downto 4) <= "1110";
            slot_discard        <= '0';
            slot_done           <= '0';
            eb_state            <= EB_WAIT_SLOT;
            
        end case;

      end if;
      
    end if;
  end process;



  p_slot_output_address : process(eb_state, ebm_i, slot_addr)
  begin
    slot_out.adr <= std_logic_vector(slot_addr + 4);
  end process;
  
end rtl;

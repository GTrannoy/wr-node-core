-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_urv_wrapper.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2017-03-22
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- A small wrapper for the URV encompassing the internal RAM and
-- access to the RAM through CPU CSR register block.
-------------------------------------------------------------------------------
--
-- Copyright (c) 2014-2015 CERN
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
use work.wrn_cpu_csr_wbgen2_pkg.all;
use work.wrn_private_pkg.all;

entity wrn_urv_wrapper is
  generic(
    g_iram_size         : integer;
    g_cpu_id            : integer;
    g_double_core_clock : boolean
    );

  port(
    clk_cpu_i : in std_logic;
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;
    irq_i     : in std_logic_vector(31 downto 0) := x"00000000";

    dwb_o : out t_wishbone_master_out;
    dwb_i : in  t_wishbone_master_in;

    pc_o: out std_logic_vector(c_mt_pc_bits-1 downto 0);
    pc_valid_o : out std_logic;


    cpu_csr_i : in  t_wrn_cpu_csr_out_registers;
    cpu_csr_o : out t_wrn_cpu_csr_in_registers
    );
end wrn_urv_wrapper;

architecture wrapper of wrn_urv_wrapper is

  component urv_cpu is
    port(
      clk_i : in std_logic;
      rst_i : in std_logic;

      irq_i : in std_logic;

      im_addr_o  : out std_logic_vector(31 downto 0);
      im_data_i  : in  std_logic_vector(31 downto 0);
      im_valid_i : in  std_logic;

      dm_addr_o        : out std_logic_vector(31 downto 0);
      dm_data_s_o      : out std_logic_vector(31 downto 0);
      dm_data_l_i      : in  std_logic_vector(31 downto 0);
      dm_data_select_o : out std_logic_vector(3 downto 0);
      dm_ready_i       : in  std_logic;
      dm_store_o       : out std_logic;
      dm_load_o        : out std_logic;
      dm_load_done_i   : in  std_logic;
      dm_store_done_i  : in  std_logic;
      trace_pc_o : out std_logic_vector(31 downto 0);
      trace_pc_valid_o : out std_logic
      );
  end component;

  component urv_iram
    generic (
      g_size       : integer;
      g_init_file  : string;
      g_simulation : boolean
      ); 
    port (
      clk_i : in std_logic;

      ena_i  : in  std_logic;
      wea_i  : in  std_logic;
      aa_i   : in  std_logic_vector(31 downto 0);
      bwea_i : in  std_logic_vector(3 downto 0);
      da_i   : in  std_logic_vector(31 downto 0);
      qa_o   : out std_logic_vector(31 downto 0);
      enb_i  : in  std_logic;
      web_i  : in  std_logic;
      ab_i   : in  std_logic_vector(31 downto 0);
      bweb_i : in  std_logic_vector(3 downto 0);
      db_i   : in  std_logic_vector(31 downto 0);
      qb_o   : out std_logic_vector(31 downto 0)
      );
  end component;

  function f_x_to_zero (x : std_logic_vector) return std_logic_vector is
    variable tmp : std_logic_vector(x'length-1 downto 0);
  begin
-- synthesis translate_off
    for i in 0 to x'length-1 loop
      if(x(i + x'left) = 'X' or x(i + x'left) = 'U') then
        tmp(i) := '0';
      else
        tmp(i) := x(i + x'left);
      end if;
    end loop;
    return tmp;
-- synthesis translate_on
    return x;
  end function;

  function f_swap_endian_32(x : std_logic_vector) return std_logic_vector is
    begin
      return x(7 downto 0) & x(15 downto 8) & x(23 downto 16) & x(31 downto 24);
    end f_swap_endian_32;
        
  
  -- reserved for simulation purposes. firmware name
  -- will be passed through a generic
  impure function f_pick_init_file return string is
  begin
    if g_cpu_id = 0 then
--      return "rt-tdc.ram";
      return "none";
    else
      return "none";
    end if;
  end function;

  signal cpu_rst, cpu_rst_d       : std_logic;
  signal core_sel_match : std_logic;

  signal im_addr            : std_logic_vector(31 downto 0);
  signal im_data            : std_logic_vector(31 downto 0);
  signal im_valid           : std_logic;

  signal ha_im_addr                                : std_logic_vector(31 downto 0);
  signal ha_im_wdata, ha_im_rdata                  : std_logic_vector(31 downto 0);
  signal ha_im_access, ha_im_access_d, ha_im_write : std_logic;

  signal im_addr_muxed : std_logic_vector(31 downto 0);

  signal dm_addr, dm_data_s, dm_data_l                            : std_logic_vector(31 downto 0);
  signal dm_data_select                                           : std_logic_vector(3 downto 0);
  signal dm_load, dm_store, dm_load_done, dm_store_done, dm_ready : std_logic;

  signal dm_cycle_in_progress, dm_is_wishbone : std_logic;

  signal dm_mem_rdata, dm_wb_rdata : std_logic_vector(31 downto 0);
  signal dm_wb_write, dm_select_wb : std_logic;
  signal dm_data_write             : std_logic;

    component chipscope_ila
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      CLK     : in    std_logic;
      TRIG0   : in    std_logic_vector(31 downto 0);
      TRIG1   : in    std_logic_vector(31 downto 0);
      TRIG2   : in    std_logic_vector(31 downto 0);
      TRIG3   : in    std_logic_vector(31 downto 0));
  end component;

  component chipscope_icon
    port (
      CONTROL0 : inout std_logic_vector (35 downto 0));
  end component;

  signal CONTROL : std_logic_vector(35 downto 0);
  signal CLK     : std_logic;
  signal TRIG0   : std_logic_vector(31 downto 0);
  signal TRIG1   : std_logic_vector(31 downto 0);
  signal TRIG2   : std_logic_vector(31 downto 0);
  signal TRIG3   : std_logic_vector(31 downto 0);

  signal trace_pc_valid : std_logic;
  signal trace_pc : std_logic_vector(31 downto 0);

  signal dwb_out : t_wishbone_master_out;
  signal bus_timeout_hit : std_logic;
  signal bus_timeout_cnt : unsigned(7 downto 0);
begin

  dwb_o <= dwb_out;
  
  pc_valid_o <= '0';

  gen_cc: if (g_cpu_id = 0) generate
    chipscope_ila_1 : chipscope_ila
      port map (
        CONTROL => CONTROL,
        CLK     => clk_sys_i,
        TRIG0   => TRIG0,
        TRIG1   => TRIG1,
        TRIG2   => TRIG2,
        TRIG3   => TRIG3);

    chipscope_icon_1 : chipscope_icon
      port map (
        CONTROL0 => CONTROL);


    trig0(0) <= trace_pc_valid;
    trig0(1) <= dwb_out.cyc;
    trig0(2) <= dwb_out.stb;
    trig0(3) <= dwb_out.we;
    trig0(4) <= dwb_i.ack;
    trig0(5) <= dwb_i.err;
    trig0(6) <= dwb_i.stall;
    trig0(7) <= ha_im_write;
    trig0(8) <= cpu_rst;
    
    trig0(31 downto 16) <= ha_im_wdata(31 downto 16);
    
    
    trig1 <= trace_pc;
    trig2 <= dwb_out.adr;
    trig3(15 downto 0) <= im_addr_muxed(15 downto 0);
    trig3(31 downto 16) <= im_data(15 downto 0);

    
  end generate gen_cc;
  

  gen_with_double_core_clock : if g_double_core_clock generate
    assert false report "Double core clock option not supported for uRV" severity failure;
  end generate gen_with_double_core_clock;

  U_cpu_core : urv_cpu
    port map (
      clk_i            => clk_sys_i,
      rst_i            => cpu_rst,
      irq_i            => '0',
      im_addr_o        => im_addr,
      im_data_i        => im_data,
      im_valid_i       => im_valid,
      dm_addr_o        => dm_addr,
      dm_data_s_o      => dm_data_s,
      dm_data_l_i      => dm_data_l,
      dm_data_select_o => dm_data_select,
      dm_ready_i       => dm_ready,
      dm_store_o       => dm_store,
      dm_load_o        => dm_load,
      dm_load_done_i   => dm_load_done,
      dm_store_done_i  => dm_store_done,
      trace_pc_o => trace_pc,
      trace_pc_valid_o => trace_pc_valid);

  dm_data_write <= not dm_is_wishbone and dm_store;

  U_iram : urv_iram
    generic map (
      g_size       => g_iram_size,
      g_init_file  => "",
      g_simulation => false)
    port map (
      clk_i => clk_sys_i,

      ena_i  => '1',
      wea_i  => ha_im_write,
      bwea_i => "1111",
      aa_i   => im_addr_muxed,
      da_i   => ha_im_wdata,
      qa_o   => im_data,

      enb_i  => '1',
      bweb_i => dm_data_select,
      web_i  => dm_data_write,
      ab_i   => dm_addr,
      db_i   => dm_data_s,
      qb_o   => dm_mem_rdata
      );

 --  Host access to the CPU memory (through instruction port)
  p_iram_host_access: process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if(rst_n_i = '0') then
        ha_im_write    <= '0';
      else
        if ( cpu_csr_i.udata_load_o = '1' and core_sel_match = '1') then

          ha_im_wdata <= f_swap_endian_32(cpu_csr_i.udata_o);
          ha_im_write   <= '1';
        else
          ha_im_write <= '0';
        end if;

        if (core_sel_match = '1') then
          ha_im_addr(21 downto 0) <= cpu_csr_i.uaddr_addr_o & "00";
          ha_im_addr(31 downto 22) <= (others => '0');

          cpu_csr_o.udata_i <= f_swap_endian_32(im_data);
          else
          cpu_csr_o.udata_i <= (others => '0');
        end if;
        
        
      end if;
    end if;
  end process;
  
  dm_is_wishbone <= '1' when dm_addr(31 downto 20) /= x"000" else '0'; -- 1st MByte of the mem is
                                                     -- the IRAM

  -- Wishbone bus arbitration / internal RAM access
  p_wishbone_master: process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if(rst_n_i = '0' or cpu_rst = '1') then
        dwb_out.cyc            <= '0';
        dm_cycle_in_progress <= '0';
        dm_load_done         <= '0';
        dm_store_done        <= '0';
        dm_select_wb         <= '0';
      else
        
        if(dm_cycle_in_progress = '0') then  -- access to internal memory
          if(dm_is_wishbone = '0') then
            if(dm_store = '1') then
              dm_load_done  <= '0';
              dm_store_done <= '1';
              dm_select_wb  <= '0';
            elsif (dm_load = '1') then
              dm_load_done  <= '1';
              dm_store_done <= '0';
              dm_select_wb  <= '0';
            else
              dm_store_done <= '0';
              dm_load_done  <= '0';
              dm_select_wb  <= '0';
            end if;
          else
            if(dm_load = '1' or dm_store = '1') then
              dwb_out.cyc   <= '1';
              dwb_out.stb   <= '1';
              dwb_out.we    <= dm_store;
              dm_wb_write <= dm_store;

              dwb_out.adr <= dm_addr;
              dwb_out.dat <= dm_data_s;
              dwb_out.sel <= dm_data_select;


              dm_load_done         <= '0';
              dm_store_done        <= '0';
              dm_cycle_in_progress <= '1';
              bus_timeout_cnt <= (others => '0');
            else
              dm_store_done        <= '0';
              dm_load_done         <= '0';
              dm_cycle_in_progress <= '0';
            end if;
          end if;
        else
          if(dwb_i.stall = '0') then
            dwb_out.stb <= '0';
          end if;

          bus_timeout_cnt <= bus_timeout_cnt + 1;

          if(dwb_i.ack = '1' or bus_timeout_cnt = 100) then
            if(dm_wb_write = '0') then
              dm_wb_rdata  <= dwb_i.dat;
              dm_select_wb <= '1';
              dm_load_done <= '1';
            else
              dm_store_done <= '1';
              dm_select_wb  <= '0';
            end if;

            dm_cycle_in_progress <= '0';
            dwb_out.cyc            <= '0';
          end if;
        end if;
      end if;
    end if;
  end process;
  
  dm_data_write <= not dm_is_wishbone and dm_store;
  dm_data_l     <= dm_wb_rdata when dm_select_wb = '1' else dm_mem_rdata;
  im_addr_muxed <= ha_im_addr  when cpu_rst = '1' else im_addr;
  dm_ready      <= '1';

  process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if(cpu_rst = '1') then
        im_valid  <= '0';
        cpu_rst_d <= '1';
      else
        cpu_rst_d <= cpu_rst;
        im_valid  <= (not cpu_rst_d);
      end if;
    end if;
  end process;

  core_sel_match <= '1' when unsigned(cpu_csr_i.core_sel_o) = g_cpu_id else '0';
  cpu_rst   <= not rst_n_i or cpu_csr_i.reset_o(g_cpu_id);



end wrapper;

-------------------------------------------------------------------------------
-- Title      : Revolution tick generator  
-- Project    : RF DDS Distribution over WR
-------------------------------------------------------------------------------
-- File       : Trev_Gen_Module.vhd
-- Author     : E. Calvo
-- Company    : CERN BE-CO-HT
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- This block derives Revolution ticks from the  Bunch clock ticks.
-- Revolution ticks are time stamped in the WR Master node with a resolution
-- of 1ns and sent in frames to the WR slave. The following GW is implemented 
-- at the slave node. It is assumed also that the Bunch clock has been 
-- obtained using a DDS technique, and that it has been compensated for 
-- the Beam time of flight effect already. It is also assuming that the time
-- stamp for the next Trev tick has been cacluated (taking into account the WR
-- link latency in the LM32 CPU), and send through the WB registers to this 
-- modules several WR cycles before. in order to open a gate that will let 
-- pass 1 and only 1 Bunch clock tick.
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
-- Revisions  :
-- Date        Version  Author          Description
-- 2016-06-15  0.1      ecalvo          First version, creation.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.TrevGen_wbgen2_pkg.all;

entity TrevGen_Module is
    port(
        -- System signals
        rst_n_i    :  in std_logic;
        clk_sys_i  :  in std_logic;     -- 62.5MHz
        clk_125m_i : in std_logic;  -- 125MHz
        -- Trev module signals
        B_clk_i    :  in std_logic; 
        WRcyc_i    :  in unsigned(27 downto 0); 
        Rev_clk_o  :  out std_logic ;
        -- Wishbone interface
        wb_adr_i   :  in std_logic_vector(31 downto 0);
        wb_data_i  :  in std_logic_vector(31 downto 0);
        wb_data_o  :  out std_logic_vector(31 downto 0);
        wb_cyc_i   :  in std_logic;
        wb_sel_i   :  in std_logic_vector(3 downto 0);
        wb_stb_i   :  in std_logic;
        wb_we_i    :  in std_logic;
        wb_ack_o   :  out std_logic;
        wb_stall_o :  out std_logic );
end entity TrevGen_Module;

architecture rtl of TrevGen_Module is

  component TrevGen_wb_slave is
       port (
    rst_n_i        : in     std_logic;
    clk_sys_i      : in     std_logic;
    wb_adr_i       : in     std_logic_vector(2 downto 0);
    wb_dat_i       : in     std_logic_vector(31 downto 0);
    wb_dat_o       : out    std_logic_vector(31 downto 0);
    wb_cyc_i       : in     std_logic;
    wb_sel_i       : in     std_logic_vector(3 downto 0);
    wb_stb_i       : in     std_logic;
    wb_we_i        : in     std_logic;
    wb_ack_o       : out    std_logic;
    wb_stall_o     : out    std_logic;
    regs_i         : in     t_TrevGen_in_registers;
    regs_o         : out    t_TrevGen_out_registers );
  end component;
 
  type t_state is (Init, Update, Wait_Target, Gate_Opened, Wait_Update);
  signal s_state : t_state ;     -- current state
 
  signal s_BclkGate, s_Rev_clk: std_logic;
  signal s_phase   : unsigned(2 downto 0);
  signal s_WRcycTarget: unsigned(27 downto 0);
  signal s_regs_i  : t_TrevGen_in_registers;
  signal s_regs_o  : t_TrevGen_out_registers;
    
  begin
  -- instantiate the wb interface generated with wbgen2
    cmp_TrevGen_wb_slave: TrevGen_wb_slave port map(
        rst_n_i     =>  rst_n_i,
        clk_sys_i   =>  clk_sys_i,
        wb_adr_i    =>  wb_adr_i(4 downto 2),
        wb_dat_i    =>  wb_data_i,
        wb_dat_o    =>  wb_data_o,
        wb_cyc_i    =>  wb_cyc_i,
        wb_sel_i    =>  wb_sel_i,
        wb_stb_i    =>  wb_stb_i,
        wb_we_i     =>  wb_we_i,
        wb_ack_o    =>  wb_ack_o,
        wb_stall_o  =>  wb_stall_o,
        regs_i      =>  s_regs_i,
        regs_o      =>  s_regs_o); 

  -- --------------------------------------------
  --    FSM 
  -- --------------------------------------------

  p_FSM_State: process (clk_125m_i)
  begin
  
    if rising_edge(clk_125m_i) then
        if (rst_n_i = '0') then
            s_state  <= Init;
        else
           case s_state is

              when Init =>
                  
                 if (s_regs_o.trevgen_strobe_p_o = '1') then
                    s_state <= Update; 
                 end if;

              when Update => 
                 s_state <= Wait_Target; 
               
              when Wait_Target => 
                 if (WRcyc_i = s_WRcycTarget -1) and (s_phase < 4) then
                    s_state <= Gate_opened; 
                 elsif (WRcyc_i = s_WRcycTarget ) and (s_phase > 4) then
                    s_state <= Gate_opened; 
                 end if;

              when Gate_opened =>
                 if (WRcyc_i = s_WRcycTarget +3) then
                    s_state <= Wait_Update;
                 end if;

              when Wait_Update =>
                 if (s_regs_o.trevgen_strobe_p_o = '1') then
                    s_state <= Update; 
                 end if;

              when others => 
                 s_state  <= Init;
           end case;
        end if;
    end if;
  end process;

  p_FSM_Comb_Outputs: process (s_state, s_phase, WRcyc_i, s_WRcycTarget )
  begin
  
     case s_state is
        when Init =>
             s_BclkGate <= '0';
        when Update => 
             s_BclkGate <= '0';
        when Wait_Target => 
           if (WRcyc_i = s_WRcycTarget -1) and (s_phase < 4) then
              s_BclkGate <= '1';              
           elsif (WRcyc_i = s_WRcycTarget ) and (s_phase > 4) then
             s_BclkGate <= '1';
           else
               s_BclkGate <= '0';
           end if;

        when Gate_opened =>
           if (WRcyc_i <= s_WRcycTarget +3) then
              s_BclkGate <= '1';
           else
              s_BclkGate <= '0';
           end if;
        when Wait_Update =>
           s_BclkGate <= '0';
        when others =>
           s_BclkGate <= '0';         
     end case;
  end process;

  p_FSM_Seq_Outputs: process (rst_n_i, clk_125m_i)
  begin
  -- I want this outputs to be registered
     if rising_edge(clk_125m_i) then 
        if (rst_n_i = '0') then
           s_phase <= (s_phase'range => '0');
           s_WRcycTarget <= (s_WRcycTarget'range => '0');
        else
           if (s_state = Init) then 
                 s_phase <= (s_phase'range => '0');
                 s_WRcycTarget <= (s_WRcycTarget'range => '0');
           elsif (s_state = Update ) then 
                 s_phase <= unsigned(s_regs_o.trevgen_rm_next_tick_o(2 downto 0));
                 s_WRcycTarget <= unsigned(s_regs_o.trevgen_rm_next_tick_o(30 downto 3));   
           end if;
        end if;
     end if;
  end process;

  p_monitoring: process (rst_n_i, clk_sys_i )
  begin
     if rising_edge(clk_sys_i) then 
        if (rst_n_i = '0') then 
           s_regs_i.trevgen_lc_next_tick_i <= (s_regs_i.trevgen_lc_next_tick_i'range => '0');
        else
           s_regs_i.trevgen_lc_next_tick_i <= '0' & std_logic_vector(s_WRcycTarget) & std_logic_vector(s_phase);
        end if;
     end if;
  end process;

  s_Rev_clk <= s_BclkGate and B_clk_i;
  Rev_clk_o <= s_Rev_clk;

  end architecture;



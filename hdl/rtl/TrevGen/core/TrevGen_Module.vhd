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

-- The following lines are intended for doxygen documentation:
-------------------------------------------------------------------------------
--! Description: 
--!
--! This block derives Revolution ticks from the  Bunch clock ticks.
--! Revolution ticks are time stamped in the WR Master node with a resolution
--! of 1ns and sent in frames to the WR slave. The following GW is implemented 
--! at the slave node. It is assumed also that the Bunch clock has been 
--! obtained using a DDS technique, and that it has been compensated for 
--! the Beam time of flight effect already. It is also assumed that the time
--! stamp for the next Trev tick has been calcuated (taking into account the WR
--! link latency in the LM32 CPU), and send through the WB registers to this 
--! modules several WR cycles before. in order to open a gate that will let 
--! pass 1 and only 1 Bunch clock tick.
-------------------------------------------------------------------------------
entity TrevGen_Module is
    port(
        -- System signals
        rst_n_sys_i : in std_logic;     --! Reset 
        clk_sys_i   : in std_logic;     --! 62.5MHz
        clk_125m_i  : in std_logic;     --! 125MHz
        -- Trev module signals
        enable_i         : in  std_logic;
        tm_time_valid_i  : in  std_logic;                      --! Flag indicating time signals are valid
        tm_tai_i         : in std_logic_vector(39 downto 0);   --! Current WR TAI
        tm_cycles_i      : in unsigned(27 downto 0);           --! Current WR cycle
        bunch_tick_i     : in std_logic;                       --! 40MHz signal generated by the DDS (beam sync)
        Trev_tick_o       : out std_logic ;  --! Revolution tick derived from the 40Mhz signal      
        --  WB bus interface
        wb_adr_i         : in     std_logic_vector(31 downto 0);
        wb_dat_i         : in     std_logic_vector(31 downto 0);
        wb_dat_o         : out    std_logic_vector(31 downto 0);
        wb_cyc_i         : in     std_logic;
        wb_sel_i         : in     std_logic_vector(3 downto 0);
        wb_stb_i         : in     std_logic;
        wb_we_i          : in     std_logic;
        wb_ack_o         : out    std_logic;
        wb_stall_o       : out    std_logic);
end entity TrevGen_Module;

architecture rtl of TrevGen_Module is

  -----------------------------------------
  --        COMPONENTs DECLARATION  
  -----------------------------------------

  component TrevGen_wb_slave is
    port (
      rst_n_i     : in     std_logic;
      clk_sys_i   : in     std_logic;
      wb_adr_i    : in     std_logic_vector(1 downto 0);
      wb_dat_i    : in     std_logic_vector(31 downto 0);
      wb_dat_o    : out    std_logic_vector(31 downto 0);
      wb_cyc_i    : in     std_logic;
      wb_sel_i    : in     std_logic_vector(3 downto 0);
      wb_stb_i    : in     std_logic;
      wb_we_i     : in     std_logic;
      wb_ack_o    : out    std_logic;
      wb_stall_o  : out    std_logic;
      regs_i      : in     t_TrevGen_in_registers;
      regs_o      : out    t_TrevGen_out_registers);  
  end component;
 
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
  
  ------------------------------------------
  --        SIGNALS DECLARATION  
  ------------------------------------------

  type t_state is (Init, Update, Wait_Target, Gate_Opened);
  signal s_state : t_state ;     -- current state
 
  signal s_BclkGate, s_Trev_tick: std_logic;
  signal s_phase   : unsigned(2 downto 0);
  signal s_WRcycTarget: unsigned(27 downto 0);
  
  signal s_regs_i: t_TrevGen_in_registers;
  signal s_regs_o: t_TrevGen_out_registers;

  --  Signals for Chip Scope  -----------------
  signal CONTROL : std_logic_vector(35 downto 0);
  signal CLK     : std_logic;
  signal TRIG0   : std_logic_vector(31 downto 0);
  signal TRIG1   : std_logic_vector(31 downto 0);
  signal TRIG2   : std_logic_vector(31 downto 0);
  signal TRIG3   : std_logic_vector(31 downto 0);
  ---------------------------------------------
  
  begin

  ----------------------------------------------
  --    TrevGen WB slave Interface 
  ---------------------------------------------- 
    cmp_TrevGen_wb_slave: TrevGen_wb_slave port map(
        rst_n_i     =>  rst_n_sys_i,
        clk_sys_i   =>  clk_sys_i,  
        wb_adr_i    =>  wb_adr_i(3 downto 2),
        wb_dat_i    =>  wb_dat_i,
        wb_dat_o    =>  wb_dat_o,
        wb_cyc_i    =>  wb_cyc_i,
        wb_sel_i    =>  wb_sel_i,
        wb_stb_i    =>  wb_stb_i,
        wb_we_i     =>  wb_we_i,
        wb_ack_o    =>  wb_ack_o,
        wb_stall_o  =>  wb_stall_o,
        regs_i      =>  s_regs_i,
        regs_o      =>  s_regs_o ); 

  
  ----------------------------------------------
  --    FSM 
  ----------------------------------------------

  p_FSM_State: process (clk_125m_i)
  begin
  
    if rising_edge(clk_125m_i) then
        if (rst_n_sys_i = '0') then
            s_state  <= Init;
        else
           case s_state is

              when Init =>
                 if (enable_i = '1') then
                    s_state <= Update; 
                 end if;

              when Update => 
                 if (enable_i = '0') then
                    s_state  <= Init;
                 else
                    s_state <= Wait_Target; 
                 end if;

              when Wait_Target => 
                 if (enable_i = '0') then
                    s_state  <= Init;
                 elsif (tm_cycles_i = s_WRcycTarget -1) and (s_phase <= 4) then
                    s_state <= Gate_opened; 
                 elsif (tm_cycles_i = s_WRcycTarget ) and (s_phase > 4) then
                    s_state <= Gate_opened; 
                 end if;

              when Gate_opened =>
                 if (tm_cycles_i = s_WRcycTarget + 2) and (s_phase <= 4) then
                    s_state <= Init;
                 elsif
                    (tm_cycles_i = s_WRcycTarget + 3) and (s_phase > 4) then
                    s_state <= Init;
                 end if;

              when others => 
                 s_state  <= Init;

           end case;
        end if;
    end if;
  end process;

  p_FSM_Comb_Outputs: process (s_state, s_phase, tm_cycles_i, s_WRcycTarget )
  begin
  
     case s_state is
        
        when Wait_Target => 
           if (tm_cycles_i = s_WRcycTarget -1) and (s_phase < 4) then
              s_BclkGate <= '1';              
           elsif (tm_cycles_i = s_WRcycTarget ) and (s_phase > 4) then
              s_BclkGate <= '1';
           else
               s_BclkGate <= '0';
           end if;

        when Gate_opened =>
           if (tm_cycles_i <= s_WRcycTarget +3) then
              s_BclkGate <= '1';
           else
              s_BclkGate <= '0';
           end if;
        
        when others =>
           s_BclkGate <= '0';     
    
     end case;
  end process;

  p_FSM_Seq_Outputs: process (clk_125m_i)
  begin
     if rising_edge(clk_125m_i) then 
        if (rst_n_sys_i = '0') then
           s_phase <= (s_phase'range => '0');
           s_WRcycTarget <= (s_WRcycTarget'range => '0');
        else
           if (s_state = Init) then 
               s_phase <= (s_phase'range => '0');
               s_WRcycTarget <= (s_WRcycTarget'range => '0');
           elsif (s_regs_o.trevgen_strobe_p_o = '1') then
                  s_phase <= unsigned(s_regs_o.trevgen_rm_next_tick_o(2 downto 0));
                  s_WRcycTarget <= unsigned(s_regs_o.trevgen_rm_next_tick_o(30 downto 3));   
           end if;
        end if;
     end if;
  end process;

  s_Trev_tick <= s_BclkGate and bunch_tick_i;
  Trev_tick_o <= s_Trev_tick;

  --------------------------------------------
  --         Chip Scope
  --------------------------------------------
--  chipscope_icon_1: chipscope_icon
--    port map (
--      CONTROL0 => CONTROL);

--  chipscope_ila_1: chipscope_ila
--    port map (
--      CONTROL => CONTROL,
--      CLK     => clk_125m_i,
--      TRIG0   => TRIG0,
--      TRIG1   => TRIG1,
--      TRIG2   => TRIG2,
--      TRIG3   => TRIG3);
--  
--  TRIG0(27 downto 0)  <= std_logic_vector(tm_cycles_i);  
--  TRIG0(29 downto 28) <= std_logic_vector(to_unsigned(t_state'pos(s_state), 2));

--  TRIG1(27 downto 0)  <= std_logic_vector(s_WRcycTarget);
--  TRIG1(30 downto 28) <= std_logic_vector(s_phase); 
--  TRIG1(31) <= s_regs_o.trevgen_strobe_p_o;
--  
--  TRIG2(31 downto 0) <= wb_dat_i;
--  
--  TRIG3(10 downto 0) <= wb_adr_i(12 downto 2);
--  TRIG3(11) <= wb_cyc_i   ;
--  TRIG3(15 downto 12) <= wb_sel_i;
--  TRIG3(16) <= wb_stb_i;
--  TRIG3(17) <= wb_we_i;
--  TRIG3(18) <= s_BclkGate;
--  TRIG3(19) <= bunch_tick_i;	 
--  TRIG3(20) <= s_Trev_tick;
--  TRIG3(21) <= enable_i;

  end architecture;


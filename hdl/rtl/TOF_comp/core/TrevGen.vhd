-------------------------------------------------------------------------------
-- Title      : Revolution tick generator  
-- Project    : RF DDS Distribution over WR
-------------------------------------------------------------------------------
-- File       : Trev_Gen.vhd
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
-- at the slave node. It is assumend that data contained in these frames
-- has been recovered and they are feed into these module (Tstamp2_i and Tstamp1_i).
-- It is assumed also that the Bunch clock has been obtained using a 
-- DDS technique, and that it has been compensated for the Beam time of 
-- flight effect already.
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
use work.TrevGen_wb_slave_pkg.vhd   -- needed for t_TOF_out_registers definition

entity Trev_Gen is
    port ( 
       sys_clk_i  :  in std_logic;   
       rst_n_i    :  in std_logic;
       -- Tstamp1 and Tstamp2 are 2 consecutive revolution time stamp ticks
       -- that were time stamped by the master and received by the slave.
       -- There are 2 because we need : Rev. period and the instant to start
       -- They are coded as <27b MSB WRcyc>.<3b LSB offset[in ns] within the WRcyc>
       Tstamp2_i  :  in std_logic(30 downto 0);    
       Tstamp1_i  :  in std_logic(30 downto 0);  
       -- strobe to validate Tstamps 
       strobe_i_p :  in std_logic;
       -- WR link latency (expressed in ns), Max value ~ 500us
       Tlatency_i  :  in std_logic(19 downto 0);  
       -- 40 MHz. Assumed to be already synchronous to the beam
       B_clk_i    :  in std_logic;
       -- current WR cycle at the slave node
       WRcyc_i    :  in std_logic(27 downto 0);  
       -- Revolution clock thar should be generated
       Rev_clk_o  :  out std_logic 
       ctr_regs_i :  in t_TOF_out_registers);            

end Trev_Gen;

Architecture RTL of Trev_Gen is
  
  -- MAX value of WRcyc
  constant MAX_WRcyc_c : unsigned(27 downto 0) := to_unsigned(124999999, 28); 
  
  type State_type IS (Idle, Check_Trev, Calculate_Target, Wait_target, Gate_opened);
  signal State : State_Type;      
  
  signal s_Tstamp2_u_reg, s_Tstamp1_u_reg : unsigned(30 downto 0) ;
  signal s_Trev, s_Trev_tmp, s_Trev_prev: unsigned(30 downto 0) ;
  signal s_Ttarget : unsigned(30 downto 0);
  signal s_Tacc: unsigned(31 downto 0) ;
  
  begin 

  proc_FSM_TrevGen: process (clk)
    begin
  
    if rising_edge(clk) then
        if (rst_n_i = 0) then
            State <= Idle;
        else
            case State is
                when Idle =>
                    if (strobe = 1) then
                        State <= Calculate_Target;
                    end if;
                when Check_Trev =>
                    if (s_Trev = (others => '0')) then
                    -- If Trev has a wrong value, discard these Tstamps
                        State <= Idle;
                when Calculate_Target =>
                    if (s_Ttarget /= (others => '0')) then
                        State <= Wait_target; 
                    end if;
                when Wait_target =>
                    if (WRcyc_i >= s_Ttarget - ctr_regs_i.tof_ctrl_gmargin_o) then
                        State <= Gate_opened;
                    end if;
                when Gate_opened =>
                    if (WRcyc_i > s_Ttarget - ctr_regs_i.tof_ctrl_gwidth_o) then
                        State <= Idle;
                    end if;
                when others =>
                    State <= Idle;
            end case;
        end if;
    end if;
  end process;

  proc_Out_TrevGen: process (clk)
    begin
  
    if rising_edge(clk) then
  
        if (rst_n == 0) then
            BclkGate        <= '0';
            s_Tacc          <= (others => '0');
            s_Ttarget       <= (others => '0');
            s_Tstamp2_u_reg <= (others => '0');
            s_Tstamp1_u_reg <= (others => '0');
            s_Trev          <= (others => '0');
            s_Trev_tmp      <= (others => '0');
            s_Trev_prev     <= (others => '0');
        else
            case State is
                when Idle =>
                    BclkGate <= '0';  -- Gate closed
                    s_Tacc   <= (others => '0');  -- Init Tacc
                    s_Ttarget<= (others => '0');  -- Init Ttarget
                    if (strobe_i_p = 1) then 
                    --Register input data
                        s_Tstamp2_u_reg <= unsigned(s_Tstamp2_i);
                        s_Tstamp1_u_reg <= unsigned(s_Tstamp1_i);
                        -- Calculate Trev with new Tstamps
                        if (s_Tstamp2_u_reg > s_Tstamp1_u_reg) then
                          s_Trev_tmp <= unsigned(s_Tstamp2_i)-unsigned(s_Tstamp1_i);
                        else
                        -- WRcyc was reinitialised between Tstamp2 and Tstamp1
                          s_Trev_tmp <= unsigned(s_Tstamp2_i)-unsigned(s_Tstamp1_i) 
                                    + (MAX_WRcyc_c<3);
                        end if;
                    end if;
                    
                when Check_Trev =>
                    if (s_Trev_tmp < ctr_regs_i.tof_mintrev_o) or (s_Trev_tmp > ctr_regs_i.tof_maxtrev_o) then
                    -- If current Trev contains a wrong value, take previous measure
                        s_Trev <= s_Trev_prev;
                    else
                    -- Use current measure
                        s_Trev <= s_Trev_tmp;
                        s_Trev_prev <= s_Trev_tmp;
                     end if;
                     
                when Calculate_Target =>
                -- since expected latency ~ Trev*4 (for SPS), FSM should not be 
                -- in this state much longer than 4 wr_clk
                    BclkGate <= '0';  -- Gate closed
                    if (s_Tacc = (others => '0')) then
                        s_Tacc <= s_Tstamp2_u_reg + S_Trev;
                    elsif (s_Tacc  <= s_Tstamp2_u_reg + ctr_regs_i.tof_ctrl_wrltcy_o ) then
                    -- I should add Trev till Tacc> Tstamp2+latency
                        s_Tacc <= s_Tacc + s_Trev;
                    elsif  (s_Tacc > (MAX_WRcyc_c<3)) then
                    -- Correct overflow, if it happened
                        s_Tacc <= s_Tacc - (MAX_WRcyc_c<3);
                    elsif (s_Tacc > ((WRcyc_i - ctr_regs_i.tof_ctrl_gmargin_o)<3)) then
                    -- If we are not too late already
                        s_Ttarget <= s_Tacc;
                    else 
                    -- If we are late, let's try with the following tick
                        s_Tacc <= s_Tacc + s_Trev;
                    end if;

            when Wait_target =>	   
                BclkGate <= '0';
                
            when Gate_opened =>
                BclkGate <= '1';

Rev_clk_o <= BclkGate and B_clk_i;

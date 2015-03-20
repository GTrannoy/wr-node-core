-------------------------------------------------------------------------------
-- Title      : White Rabbit Node Core
-- Project    : White Rabbit
-------------------------------------------------------------------------------
-- File       : wrn_private_pkg.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2014-12-01
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- Private definitions for the WR node core.
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

package wrn_private_pkg is
  function f_pick (
    cond : boolean;
    if_1 : std_logic;
    if_0 : std_logic)
    return std_logic;

  function f_pick (
    cond : boolean;
    if_1 : std_logic_vector;
    if_0 : std_logic_vector)
    return std_logic_vector;
  
  function f_pick (
    cond : std_logic;
    if_1 : std_logic;
    if_0 : std_logic)
    return std_logic;

  function f_pick (
    cond : std_logic;
    if_1 : std_logic_vector;
    if_0 : std_logic_vector)
    return std_logic_vector;
  
end package;

package body wrn_private_pkg is

  function f_pick (
    cond : boolean;
    if_1 : std_logic;
    if_0 : std_logic) return std_logic is
  begin
    if(cond) then
      return if_1;
    else
      return if_0;
    end if;
  end f_pick;

  function f_pick (

    cond : boolean;
    if_1 : std_logic_vector;
    if_0 : std_logic_vector) return std_logic_vector is
  begin
    if(cond) then
      return if_1;
    else
      return if_0;
    end if;
  end f_pick;

  function f_pick (
    cond : std_logic;
    if_1 : std_logic;
    if_0 : std_logic) return std_logic is
  begin
    if(cond = '1') then
      return if_1;
    else
      return if_0;
    end if;
  end f_pick;

  function f_pick (
    cond : std_logic;
    if_1 : std_logic_vector;
    if_0 : std_logic_vector) return std_logic_vector is
  begin
    if(cond = '1') then
      return if_1;
    else
      return if_0;
    end if;
  end f_pick;


end package body;



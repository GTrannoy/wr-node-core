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



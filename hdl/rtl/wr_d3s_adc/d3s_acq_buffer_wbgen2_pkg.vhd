---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for D3S Acquisition buffer
---------------------------------------------------------------------------------------
-- File           : d3s_acq_buffer_wbgen2_pkg.vhd
-- Author         : auto-generated by wbgen2 from d3s_acq_buffer_wb.wb
-- Created        : Wed Oct  5 11:51:28 2016
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE d3s_acq_buffer_wb.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package acq_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_acq_in_registers is record
    cr_ready_i                               : std_logic;
    data_i                                   : std_logic_vector(31 downto 0);
    end record;
  
  constant c_acq_in_registers_init_value: t_acq_in_registers := (
    cr_ready_i => '0',
    data_i => (others => '0')
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_acq_out_registers is record
      cr_start_o                               : std_logic;
      addr_o                                   : std_logic_vector(31 downto 0);
      end record;
    
    constant c_acq_out_registers_init_value: t_acq_out_registers := (
      cr_start_o => '0',
      addr_o => (others => '0')
      );
    function "or" (left, right: t_acq_in_registers) return t_acq_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body acq_wbgen2_pkg is
function f_x_to_zero (x:std_logic) return std_logic is
begin
if x = '1' then
return '1';
else
return '0';
end if;
end function;
function f_x_to_zero (x:std_logic_vector) return std_logic_vector is
variable tmp: std_logic_vector(x'length-1 downto 0);
begin
for i in 0 to x'length-1 loop
if(x(i) = 'X' or x(i) = 'U') then
tmp(i):= '0';
else
tmp(i):=x(i);
end if; 
end loop; 
return tmp;
end function;
function "or" (left, right: t_acq_in_registers) return t_acq_in_registers is
variable tmp: t_acq_in_registers;
begin
tmp.cr_ready_i := f_x_to_zero(left.cr_ready_i) or f_x_to_zero(right.cr_ready_i);
tmp.data_i := f_x_to_zero(left.data_i) or f_x_to_zero(right.data_i);
return tmp;
end function;
end package body;

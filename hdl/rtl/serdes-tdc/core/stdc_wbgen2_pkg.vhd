---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for TDC serializer
---------------------------------------------------------------------------------------
-- File           : stdc_wbgen2_pkg.vhd
-- Author         : auto-generated by wbgen2 from stdc_wb_slave.wb
-- Created        : Fri Feb  3 20:44:40 2017
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE stdc_wb_slave.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package stdc_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_stdc_in_registers is record
    status_empty_i                           : std_logic;
    status_ovf_i                             : std_logic;
    tdc_ts_tai_h_i                           : std_logic_vector(31 downto 0);
    tdc_ts_tai_l_i                           : std_logic_vector(31 downto 0);
    tdc_ts_ns_i                              : std_logic_vector(31 downto 0);
    tdc_polarity_i                           : std_logic;
    end record;
  
  constant c_stdc_in_registers_init_value: t_stdc_in_registers := (
    status_empty_i => '0',
    status_ovf_i => '0',
    tdc_ts_tai_h_i => (others => '0'),
    tdc_ts_tai_l_i => (others => '0'),
    tdc_ts_ns_i => (others => '0'),
    tdc_polarity_i => '0'
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_stdc_out_registers is record
      ctrl_clr_o                               : std_logic;
      ctrl_clr_ovf_o                           : std_logic;
      ctrl_next_o                              : std_logic;
      ctrl_filter_o                            : std_logic_vector(1 downto 0);
      end record;
    
    constant c_stdc_out_registers_init_value: t_stdc_out_registers := (
      ctrl_clr_o => '0',
      ctrl_clr_ovf_o => '0',
      ctrl_next_o => '0',
      ctrl_filter_o => (others => '0')
      );
    function "or" (left, right: t_stdc_in_registers) return t_stdc_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body stdc_wbgen2_pkg is
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
function "or" (left, right: t_stdc_in_registers) return t_stdc_in_registers is
variable tmp: t_stdc_in_registers;
begin
tmp.status_empty_i := f_x_to_zero(left.status_empty_i) or f_x_to_zero(right.status_empty_i);
tmp.status_ovf_i := f_x_to_zero(left.status_ovf_i) or f_x_to_zero(right.status_ovf_i);
tmp.tdc_ts_tai_h_i := f_x_to_zero(left.tdc_ts_tai_h_i) or f_x_to_zero(right.tdc_ts_tai_h_i);
tmp.tdc_ts_tai_l_i := f_x_to_zero(left.tdc_ts_tai_l_i) or f_x_to_zero(right.tdc_ts_tai_l_i);
tmp.tdc_ts_ns_i := f_x_to_zero(left.tdc_ts_ns_i) or f_x_to_zero(right.tdc_ts_ns_i);
tmp.tdc_polarity_i := f_x_to_zero(left.tdc_polarity_i) or f_x_to_zero(right.tdc_polarity_i);
return tmp;
end function;
end package body;
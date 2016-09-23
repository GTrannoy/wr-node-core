---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for WR D3S WB (master)
---------------------------------------------------------------------------------------
-- File           : wr_d3s_adc_wbgen2_pkg.vhd
-- Author         : auto-generated by wbgen2 from wr_d3s_adc.wb
-- Created        : Fri Sep 23 15:17:38 2016
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE wr_d3s_adc.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wbgen2_pkg.all;

package d3s_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_d3s_in_registers is record
    tcr_wr_locked_i                          : std_logic;
    tcr_wr time valid_i                      : std_logic;
    tcr_wr_link_i                            : std_logic;
    gpior_si57x_scl_i                        : std_logic;
    gpior_si57x_sda_i                        : std_logic;
    gpior_spi_miso_i                         : std_logic;
    adc_wr_req_i                             : std_logic;
    adc_tstamp_i                             : std_logic_vector(27 downto 0);
    adc_is_rl_i                              : std_logic;
    adc_rl_length_i                          : std_logic_vector(15 downto 0);
    adc_rl_phase_i                           : std_logic_vector(31 downto 0);
    end record;
  
  constant c_d3s_in_registers_init_value: t_d3s_in_registers := (
    tcr_wr_locked_i => '0',
    tcr_wr time valid_i => '0',
    tcr_wr_link_i => '0',
    gpior_si57x_scl_i => '0',
    gpior_si57x_sda_i => '0',
    gpior_spi_miso_i => '0',
    adc_wr_req_i => '0',
    adc_tstamp_i => (others => '0'),
    adc_is_rl_i => '0',
    adc_rl_length_i => (others => '0'),
    adc_rl_phase_i => (others => '0')
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_d3s_out_registers is record
      tcr_wr_lock_en_o                         : std_logic;
      gpior_si57x_scl_o                        : std_logic;
      gpior_si57x_scl_load_o                   : std_logic;
      gpior_si57x_sda_o                        : std_logic;
      gpior_si57x_sda_load_o                   : std_logic;
      gpior_spi_cs_adc_o                       : std_logic;
      gpior_spi_sck_o                          : std_logic;
      gpior_spi_mosi_o                         : std_logic;
      adc_wr_full_o                            : std_logic;
      adc_wr_empty_o                           : std_logic;
      ssr_o                                    : std_logic_vector(31 downto 0);
      cr_enable_o                              : std_logic;
      rl_err_min_o                             : std_logic_vector(31 downto 0);
      rl_err_max_o                             : std_logic_vector(31 downto 0);
      rl_length_max_o                          : std_logic_vector(15 downto 0);
      end record;
    
    constant c_d3s_out_registers_init_value: t_d3s_out_registers := (
      tcr_wr_lock_en_o => '0',
      gpior_si57x_scl_o => '0',
      gpior_si57x_scl_load_o => '0',
      gpior_si57x_sda_o => '0',
      gpior_si57x_sda_load_o => '0',
      gpior_spi_cs_adc_o => '0',
      gpior_spi_sck_o => '0',
      gpior_spi_mosi_o => '0',
      adc_wr_full_o => '0',
      adc_wr_empty_o => '0',
      ssr_o => (others => '0'),
      cr_enable_o => '0',
      rl_err_min_o => (others => '0'),
      rl_err_max_o => (others => '0'),
      rl_length_max_o => (others => '0')
      );
    function "or" (left, right: t_d3s_in_registers) return t_d3s_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body d3s_wbgen2_pkg is
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
function "or" (left, right: t_d3s_in_registers) return t_d3s_in_registers is
variable tmp: t_d3s_in_registers;
begin
tmp.tcr_wr_locked_i := f_x_to_zero(left.tcr_wr_locked_i) or f_x_to_zero(right.tcr_wr_locked_i);
tmp.tcr_wr time valid_i := f_x_to_zero(left.tcr_wr time valid_i) or f_x_to_zero(right.tcr_wr time valid_i);
tmp.tcr_wr_link_i := f_x_to_zero(left.tcr_wr_link_i) or f_x_to_zero(right.tcr_wr_link_i);
tmp.gpior_si57x_scl_i := f_x_to_zero(left.gpior_si57x_scl_i) or f_x_to_zero(right.gpior_si57x_scl_i);
tmp.gpior_si57x_sda_i := f_x_to_zero(left.gpior_si57x_sda_i) or f_x_to_zero(right.gpior_si57x_sda_i);
tmp.gpior_spi_miso_i := f_x_to_zero(left.gpior_spi_miso_i) or f_x_to_zero(right.gpior_spi_miso_i);
tmp.adc_wr_req_i := f_x_to_zero(left.adc_wr_req_i) or f_x_to_zero(right.adc_wr_req_i);
tmp.adc_tstamp_i := f_x_to_zero(left.adc_tstamp_i) or f_x_to_zero(right.adc_tstamp_i);
tmp.adc_is_rl_i := f_x_to_zero(left.adc_is_rl_i) or f_x_to_zero(right.adc_is_rl_i);
tmp.adc_rl_length_i := f_x_to_zero(left.adc_rl_length_i) or f_x_to_zero(right.adc_rl_length_i);
tmp.adc_rl_phase_i := f_x_to_zero(left.adc_rl_phase_i) or f_x_to_zero(right.adc_rl_phase_i);
return tmp;
end function;
end package body;

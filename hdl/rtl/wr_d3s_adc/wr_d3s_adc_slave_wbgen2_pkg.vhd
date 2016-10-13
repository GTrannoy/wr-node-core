---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for WR D3S WB (slave)
---------------------------------------------------------------------------------------
-- File           : wr_d3s_adc_slave_wbgen2_pkg.vhd
-- Author         : auto-generated by wbgen2 from wr_d3s_adc_slave.wb
-- Created        : Thu Oct 13 14:26:30 2016
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE wr_d3s_adc_slave.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wbgen2_pkg.all;

package d3ss_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_d3ss_in_registers is record
    tcr_wr_locked_i                          : std_logic;
    tcr_wr_time_valid_i                      : std_logic;
    tcr_wr_link_i                            : std_logic;
    gpior_pll_sdio_i                         : std_logic;
    gpior_pll_vcxo_sdo_i                     : std_logic;
    gpior_serdes_pll_locked_i                : std_logic;
    phfifo_rd_req_i                          : std_logic;
    frev_cr_ready_i                          : std_logic;
    end record;
  
  constant c_d3ss_in_registers_init_value: t_d3ss_in_registers := (
    tcr_wr_locked_i => '0',
    tcr_wr_time_valid_i => '0',
    tcr_wr_link_i => '0',
    gpior_pll_sdio_i => '0',
    gpior_pll_vcxo_sdo_i => '0',
    gpior_serdes_pll_locked_i => '0',
    phfifo_rd_req_i => '0',
    frev_cr_ready_i => '0'
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_d3ss_out_registers is record
      rstr_pll_rst_o                           : std_logic;
      tcr_wr_lock_en_o                         : std_logic;
      gpior_pll_sys_cs_n_o                     : std_logic;
      gpior_pll_sys_reset_n_o                  : std_logic;
      gpior_pll_sclk_o                         : std_logic;
      gpior_pll_sdio_o                         : std_logic;
      gpior_pll_sdio_load_o                    : std_logic;
      gpior_pll_sdio_dir_o                     : std_logic;
      gpior_pll_vcxo_reset_n_o                 : std_logic;
      gpior_pll_vcxo_cs_n_o                    : std_logic;
      gpior_adf_ce_o                           : std_logic;
      gpior_adf_clk_o                          : std_logic;
      gpior_adf_le_o                           : std_logic;
      gpior_adf_data_o                         : std_logic;
      phfifo_rd_full_o                         : std_logic;
      phfifo_rd_empty_o                        : std_logic;
      phfifo_payload_o                         : std_logic_vector(31 downto 0);
      cr_enable_o                              : std_logic;
      rec_delay_coarse_o                       : std_logic_vector(15 downto 0);
      frev_ts_sec_o                            : std_logic_vector(31 downto 0);
      frev_ts_ns_o                             : std_logic_vector(31 downto 0);
      frev_cr_valid_o                          : std_logic;
      end record;
    
    constant c_d3ss_out_registers_init_value: t_d3ss_out_registers := (
      rstr_pll_rst_o => '0',
      tcr_wr_lock_en_o => '0',
      gpior_pll_sys_cs_n_o => '0',
      gpior_pll_sys_reset_n_o => '0',
      gpior_pll_sclk_o => '0',
      gpior_pll_sdio_o => '0',
      gpior_pll_sdio_load_o => '0',
      gpior_pll_sdio_dir_o => '0',
      gpior_pll_vcxo_reset_n_o => '0',
      gpior_pll_vcxo_cs_n_o => '0',
      gpior_adf_ce_o => '0',
      gpior_adf_clk_o => '0',
      gpior_adf_le_o => '0',
      gpior_adf_data_o => '0',
      phfifo_rd_full_o => '0',
      phfifo_rd_empty_o => '0',
      phfifo_payload_o => (others => '0'),
      cr_enable_o => '0',
      rec_delay_coarse_o => (others => '0'),
      frev_ts_sec_o => (others => '0'),
      frev_ts_ns_o => (others => '0'),
      frev_cr_valid_o => '0'
      );
    function "or" (left, right: t_d3ss_in_registers) return t_d3ss_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body d3ss_wbgen2_pkg is
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
function "or" (left, right: t_d3ss_in_registers) return t_d3ss_in_registers is
variable tmp: t_d3ss_in_registers;
begin
tmp.tcr_wr_locked_i := f_x_to_zero(left.tcr_wr_locked_i) or f_x_to_zero(right.tcr_wr_locked_i);
tmp.tcr_wr_time_valid_i := f_x_to_zero(left.tcr_wr_time_valid_i) or f_x_to_zero(right.tcr_wr_time_valid_i);
tmp.tcr_wr_link_i := f_x_to_zero(left.tcr_wr_link_i) or f_x_to_zero(right.tcr_wr_link_i);
tmp.gpior_pll_sdio_i := f_x_to_zero(left.gpior_pll_sdio_i) or f_x_to_zero(right.gpior_pll_sdio_i);
tmp.gpior_pll_vcxo_sdo_i := f_x_to_zero(left.gpior_pll_vcxo_sdo_i) or f_x_to_zero(right.gpior_pll_vcxo_sdo_i);
tmp.gpior_serdes_pll_locked_i := f_x_to_zero(left.gpior_serdes_pll_locked_i) or f_x_to_zero(right.gpior_serdes_pll_locked_i);
tmp.phfifo_rd_req_i := f_x_to_zero(left.phfifo_rd_req_i) or f_x_to_zero(right.phfifo_rd_req_i);
tmp.frev_cr_ready_i := f_x_to_zero(left.frev_cr_ready_i) or f_x_to_zero(right.frev_cr_ready_i);
return tmp;
end function;
end package body;

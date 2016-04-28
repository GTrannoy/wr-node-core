-------------------------------------------------------------------------------
-- Title      : WR RF DDS Distribution Node (SVEC)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : svec_top.vhd
-- Author     : Tomasz Włostowski
--				Eva Calvo
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-04-27
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
-- RF DDS distribution Node for the the Adc FmC card.
-- fill me
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

library work;
use work.wishbone_pkg.all;
use work.svec_node_pkg.all;
use work.xvme64x_core_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_node_pkg.all;

library unisim;
use unisim.vcomponents.all;

entity svec_top is
  generic (
    g_simulation : boolean := false
    );

  port (
    rst_n_a_i : in std_logic;

    clk_20m_vcxo_i : in std_logic;      -- 20MHz VCXO clock

    clk_125m_pllref_p_i : in std_logic;  -- 125 MHz PLL reference
    clk_125m_pllref_n_i : in std_logic;

    clk_125m_gtp_p_i : in std_logic;    -- 125 MHz PLL reference
    clk_125m_gtp_n_i : in std_logic;

	-------------------------------------------------------------------------    
	-- SVEC Front panel LEDs
	-------------------------------------------------------------------------

    fp_led_line_oen_o : out std_logic_vector(1 downto 0);
    fp_led_line_o     : out std_logic_vector(1 downto 0);
    fp_led_column_o   : out std_logic_vector(3 downto 0);

    fp_gpio1_a2b_o  : out std_logic;
    fp_gpio2_a2b_o  : out std_logic;
    fp_gpio34_a2b_o : out std_logic;

    fp_gpio1_b : inout std_logic;
    fp_gpio2_b : inout std_logic;
    fp_gpio3_b : inout std_logic;
    fp_gpio4_b : inout std_logic;

    dbg_led0_o : out std_logic;
    dbg_led1_o : out std_logic;
    dbg_led2_o : out std_logic;
    dbg_led3_o : out std_logic;

    carrier_scl_b : inout std_logic;
    carrier_sda_b : inout std_logic;
    fmc0_prsntm2c_n_i : in    std_logic;  -- Mezzanine present (active low)
    fmc1_prsntm2c_n_i : in    std_logic;  -- Mezzanine present (active low)
    

    -------------------------------------------------------------------------
    -- VME Interface pins
    -------------------------------------------------------------------------

    VME_AS_n_i     : in    std_logic;
    VME_RST_n_i    : in    std_logic;
    VME_WRITE_n_i  : in    std_logic;
    VME_AM_i       : in    std_logic_vector(5 downto 0);
    VME_DS_n_i     : in    std_logic_vector(1 downto 0);
    VME_GA_i       : in    std_logic_vector(5 downto 0);
    VME_BERR_o     : inout std_logic;
    VME_DTACK_n_o  : inout std_logic;
    VME_RETRY_n_o  : out   std_logic;
    VME_RETRY_OE_o : out   std_logic;

    VME_LWORD_n_b   : inout std_logic;
    VME_ADDR_b      : inout std_logic_vector(31 downto 1);
    VME_DATA_b      : inout std_logic_vector(31 downto 0);
    VME_BBSY_n_i    : in    std_logic;
    VME_IRQ_n_o     : out   std_logic_vector(6 downto 0);
    VME_IACK_n_i    : in    std_logic;
    VME_IACKIN_n_i  : in    std_logic;
    VME_IACKOUT_n_o : out   std_logic;
    VME_DTACK_OE_o  : inout std_logic;
    VME_DATA_DIR_o  : inout std_logic;
    VME_DATA_OE_N_o : inout std_logic;
    VME_ADDR_DIR_o  : inout std_logic;
    VME_ADDR_OE_N_o : inout std_logic;

    -------------------------------------------------------------------------
    -- SFP pins
    -------------------------------------------------------------------------

    sfp_txp_o : out std_logic;
    sfp_txn_o : out std_logic;

    sfp_rxp_i : in std_logic := '0';
    sfp_rxn_i : in std_logic := '1';

    sfp_mod_def0_b    : in    std_logic;  -- detect pin
    sfp_mod_def1_b    : inout std_logic;  -- scl
    sfp_mod_def2_b    : inout std_logic;  -- sda
    sfp_rate_select_b : inout std_logic := '0';
    sfp_tx_fault_i    : in    std_logic := '0';
    sfp_tx_disable_o  : out   std_logic;
    sfp_los_i         : in    std_logic := '0';

    pll20dac_din_o    : out std_logic;
    pll20dac_sclk_o   : out std_logic;
    pll20dac_sync_n_o : out std_logic;
    pll25dac_din_o    : out std_logic;
    pll25dac_sclk_o   : out std_logic;
    pll25dac_sync_n_o : out std_logic;


    adc0_dco_p_i  : in std_logic;       -- ADC data clock
    adc0_dco_n_i  : in std_logic;
    adc0_fr_p_i   : in std_logic;       -- ADC frame start
    adc0_fr_n_i   : in std_logic;
    adc0_outa_p_i : in std_logic_vector(3 downto 0);  -- ADC serial data (odd bits)
    adc0_outa_n_i : in std_logic_vector(3 downto 0);
    adc0_outb_p_i : in std_logic_vector(3 downto 0);  -- ADC serial data (even bits)
    adc0_outb_n_i : in std_logic_vector(3 downto 0);

    adc0_spi_din_i       : in  std_logic;  -- SPI data from FMC
    adc0_spi_dout_o      : out std_logic;  -- SPI data to FMC
    adc0_spi_sck_o       : out std_logic;  -- SPI clock
    adc0_spi_cs_adc_n_o  : out std_logic;  -- SPI ADC chip select (active low)
    adc0_spi_cs_dac1_n_o : out std_logic;  -- SPI channel 1 offset DAC chip select (active low)
    adc0_spi_cs_dac2_n_o : out std_logic;  -- SPI channel 2 offset DAC chip select (active low)
    adc0_spi_cs_dac3_n_o : out std_logic;  -- SPI channel 3 offset DAC chip select (active low)
    adc0_spi_cs_dac4_n_o : out std_logic;  -- SPI channel 4 offset DAC chip select (active low)

    adc0_gpio_dac_clr_n_o : out std_logic;  -- offset DACs clear (active low)
    adc0_gpio_led_acq_o   : out std_logic;  -- Mezzanine front panel power LED (PWR)
    adc0_gpio_led_trig_o  : out std_logic;  -- Mezzanine front panel trigger LED (TRIG)
    adc0_gpio_ssr_ch1_o   : out std_logic_vector(6 downto 0);  -- Channel 1 solid state relays control
    adc0_gpio_ssr_ch2_o   : out std_logic_vector(6 downto 0);  -- Channel 2 solid state relays control
    adc0_gpio_ssr_ch3_o   : out std_logic_vector(6 downto 0);  -- Channel 3 solid state relays control
    adc0_gpio_ssr_ch4_o   : out std_logic_vector(6 downto 0);  -- Channel 4 solid state relays control
    adc0_gpio_si570_oe_o  : out std_logic;  -- Si570 (programmable oscillator) output enable

    adc0_si570_scl_b : inout std_logic;  -- I2C bus clock (Si570)
    adc0_si570_sda_b : inout std_logic;  -- I2C bus data (Si570)

    adc0_one_wire_b : inout std_logic;  -- Mezzanine 1-wire interface (DS18B20 thermometer + unique ID)

    tempid_dq_b : inout std_logic;

    uart_rxd_i : in  std_logic := '1';
    uart_txd_o : out std_logic

   -- put the FMC I/Os here
    );
end svec_top;

architecture rtl of svec_top is


  component wr_d3s_adc is
    port (
      clk_sys_i        : in    std_logic;
      clk_wr_o : out std_logic;
	   rst_n_sys_i      : in    std_logic;
      tm_cycles_i      : in    std_logic_vector(27 downto 0);
          
		tm_time_valid_i : in std_logic;
		tm_clk_aux_lock_en_o : out std_logic;
		tm_clk_aux_locked_i: in std_logic;


		spi_din_i        : in    std_logic;
      spi_dout_o       : out   std_logic;
      spi_sck_o        : out   std_logic;
      spi_cs_adc_n_o   : out   std_logic;
      spi_cs_dac1_n_o  : out   std_logic;
      spi_cs_dac2_n_o  : out   std_logic;
      spi_cs_dac3_n_o  : out   std_logic;
      spi_cs_dac4_n_o  : out   std_logic;
      si570_scl_b      : inout std_logic;
      si570_sda_b      : inout std_logic;
      adc_dco_p_i      : in    std_logic;
      adc_dco_n_i      : in    std_logic;
      adc_fr_p_i       : in    std_logic;
      adc_fr_n_i       : in    std_logic;
      adc_outa_p_i     : in    std_logic_vector(3 downto 0);
      adc_outa_n_i     : in    std_logic_vector(3 downto 0);
      adc_outb_p_i     : in    std_logic_vector(3 downto 0);
      adc_outb_n_i     : in    std_logic_vector(3 downto 0);
      gpio_dac_clr_n_o : out   std_logic;
      gpio_si570_oe_o  : out   std_logic;
      slave_i          : in    t_wishbone_slave_in;
      slave_o          : out   t_wishbone_slave_out;
      debug_o : out std_logic_vector(3 downto 0)

      );
  end component wr_d3s_adc;

  component xwr_si57x_interface is
    generic (
      g_simulation : integer);
    port (
      clk_sys_i         : in  std_logic;
      rst_n_i           : in  std_logic;
      tm_dac_value_i    : in  std_logic_vector(23 downto 0) := x"000000";
      tm_dac_value_wr_i : in  std_logic                     := '0';
      scl_pad_oen_o     : out std_logic;
      sda_pad_oen_o     : out std_logic;
      scl_pad_i         : in  std_logic;
      sda_pad_i         : in  std_logic;
      slave_i           : in  t_wishbone_slave_in;
      slave_o           : out t_wishbone_slave_out);
  end component xwr_si57x_interface;

  
  function f_int_to_bool (x : integer) return boolean is
  begin
    if (x = 0) then
      return false;
    else
      return true;
    end if;
  end function;


  
  constant c_D3S_ADC_SDB_DEVICE : t_sdb_device := (
    abi_class     => x"0000",              -- undocumented device
    abi_ver_major => x"01",
    abi_ver_minor => x"00",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"7",                 -- 8/16/32-bit port granularity
    sdb_component => (
      addr_first  => x"0000000000000000",
      addr_last   => x"0000000000001fff",
      product     => (
        vendor_id => x"000000000000CE42",  -- CERN
        device_id => x"dd334410",
        version   => x"00000001",
        date      => x"20160427",
        name      => "WR-D3S-ADC_Core    ")));

  constant c_hmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 4,
      out_slot_config => (
        0             => (width => 128, entries => 8),  -- control CPU 0 (to host)
        1             => (width => 128, entries => 8),  -- control CPU 1 (to host)
        2             => (width => 16, entries => 128),  -- log CPU 0
        3             => (width => 16, entries => 128),  -- log CPU 1
        others        => (0, 0)),

      in_slot_count  => 2,
      in_slot_config => (
        0            => (width => 32, entries => 8),  -- control CPU 0 (from host)
        1            => (width => 32, entries => 8),  -- control CPU 1 (from host)
        others       => (0, 0)
        )
      );

  
  constant c_rmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 2,
      out_slot_config => (
        0             => (width => 128, entries => 16),  -- RF stream (CPU0)
        1             => (width => 128, entries => 16),  -- Events (CPU1)
        others        => (0, 0)),

      in_slot_count  => 2,
      in_slot_config => (
        0            => (width => 128, entries => 16),  -- RF stream (CPU0)
        1            => (width => 128, entries => 16),  -- Events (CPU1)
        others       => (0, 0)
        )
      );

  
  constant c_node_config : t_wr_node_config :=
    (
      app_id          => x"dd3f3c02",
      cpu_count       => 2,
      cpu_memsizes    => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config      => c_hmq_config,
      rmq_config      => c_rmq_config,
      shared_mem_size => 8192
      );

  signal clk_sys : std_logic;
  signal rst_n   : std_logic;

  signal fmc_host_wb_out, fmc_dp_wb_out : t_wishbone_master_out_array(0 to 1);
  signal fmc_host_wb_in, fmc_dp_wb_in   : t_wishbone_master_in_array(0 to 1);
  signal fmc_host_irq                   : std_logic_vector(1 downto 0);

  constant c_d3s0_sdb_record : t_sdb_record       := f_sdb_embed_device(c_D3S_ADC_SDB_DEVICE, x"00010000");
  constant c_d3s1_sdb_record : t_sdb_record       := f_sdb_embed_device(c_D3S_ADC_SDB_DEVICE, x"00012000");
  constant c_d3s_vector      : t_wishbone_address := x"ffffffff";

  signal tm_link_up         : std_logic;
  signal tm_dac_value       : std_logic_vector(23 downto 0);
  signal tm_dac_wr          : std_logic_vector(1 downto 0);
  signal tm_clk_aux_lock_en : std_logic_vector(1 downto 0) := (others => '0');
  signal tm_clk_aux_locked  : std_logic_vector(1 downto 0);
  signal tm_time_valid      : std_logic;
  signal tm_tai             : std_logic_vector(39 downto 0);
  signal tm_cycles          : std_logic_vector(27 downto 0);

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

  signal CONTROL     : std_logic_vector(35 downto 0);
  signal TRIG        : std_logic_vector(127 downto 0);
  signal fmc0_clk_wr : std_logic;

  signal debug : std_logic_vector(3 downto 0);

  constant c_slave_addr : t_wishbone_address_array(1 downto 0) :=
    (0 => x"00000000",
     1 => x"00001000");
  constant c_slave_mask : t_wishbone_address_array(1 downto 0) :=
    (0 => x"00001000",
     1 => x"00001000");

  signal fmc_wb_muxed_out : t_wishbone_master_out_array(1 downto 0);
  signal fmc_wb_muxed_in  : t_wishbone_master_in_array(1 downto 0);

  signal scl_pad_oen, sda_pad_oen : std_logic;
begin

  --chipscope_icon_1: chipscope_icon
  --  port map (
  --    CONTROL0 => CONTROL);

  --chipscope_ila_1: chipscope_ila
  --  port map (
  --    CONTROL => CONTROL,
  --    CLK     => clk_sys,
  --    TRIG0   => TRIG(31 downto 0),
  --    TRIG1   => TRIG(63 downto 32),
  --    TRIG2   => TRIG(95 downto 64),
  --    TRIG3   => TRIG(127 downto 96));

 
  U_Node_Template : svec_node_template
    generic map (
      g_fmc0_sdb                 => c_d3s0_sdb_record,
      g_fmc0_vic_vector          => c_d3s_vector,
      g_fmc1_sdb                 => c_d3s1_sdb_record,
      g_fmc1_vic_vector          => c_d3s_vector,
      g_simulation               => g_simulation,
      g_with_wr_phy              => true,
      g_double_wrnode_core_clock => false,
      g_wr_node_config           => c_node_config)
    port map (
      rst_n_a_i           => rst_n_a_i,
      rst_n_sys_o         => rst_n,
      clk_sys_o           => clk_sys,
      clk_20m_vcxo_i      => clk_20m_vcxo_i,
      clk_125m_pllref_p_i => clk_125m_pllref_p_i,
      clk_125m_pllref_n_i => clk_125m_pllref_n_i,
      clk_125m_gtp_p_i    => clk_125m_gtp_p_i,
      clk_125m_gtp_n_i    => clk_125m_gtp_n_i,
      fp_led_line_oen_o   => fp_led_line_oen_o,
      fp_led_line_o       => fp_led_line_o,
      fp_led_column_o     => fp_led_column_o,
      --fp_gpio1_a2b_o      => fp_gpio1_a2b_o,
      --fp_gpio2_a2b_o      => fp_gpio2_a2b_o,
      --fp_gpio34_a2b_o     => fp_gpio34_a2b_o,
      --fp_gpio1_b          => fp_gpio1_b,
      --fp_gpio2_b          => fp_gpio2_b,
      --fp_gpio3_b          => fp_gpio3_b,
      --fp_gpio4_b          => fp_gpio4_b,
      VME_AS_n_i          => VME_AS_n_i,
      VME_RST_n_i         => VME_RST_n_i,
      VME_WRITE_n_i       => VME_WRITE_n_i,
      VME_AM_i            => VME_AM_i,
      VME_DS_n_i          => VME_DS_n_i,
      VME_GA_i            => VME_GA_i,
      VME_BERR_o          => VME_BERR_o,
      VME_DTACK_n_o       => VME_DTACK_n_o,
      VME_RETRY_n_o       => VME_RETRY_n_o,
      VME_RETRY_OE_o      => VME_RETRY_OE_o,
      VME_LWORD_n_b       => VME_LWORD_n_b,
      VME_ADDR_b          => VME_ADDR_b,
      VME_DATA_b          => VME_DATA_b,
      VME_BBSY_n_i        => VME_BBSY_n_i,
      VME_IRQ_n_o         => VME_IRQ_n_o,
      VME_IACK_n_i        => VME_IACK_n_i,
      VME_IACKIN_n_i      => VME_IACKIN_n_i,
      VME_IACKOUT_n_o     => VME_IACKOUT_n_o,
      VME_DTACK_OE_o      => VME_DTACK_OE_o,
      VME_DATA_DIR_o      => VME_DATA_DIR_o,
      VME_DATA_OE_N_o     => VME_DATA_OE_N_o,
      VME_ADDR_DIR_o      => VME_ADDR_DIR_o,
      VME_ADDR_OE_N_o     => VME_ADDR_OE_N_o,
      sfp_txp_o           => sfp_txp_o,
      sfp_txn_o           => sfp_txn_o,
      sfp_rxp_i           => sfp_rxp_i,
      sfp_rxn_i           => sfp_rxn_i,
      sfp_mod_def0_b      => sfp_mod_def0_b,
      sfp_mod_def1_b      => sfp_mod_def1_b,
      sfp_mod_def2_b      => sfp_mod_def2_b,
      sfp_rate_select_b   => sfp_rate_select_b,
      sfp_tx_fault_i      => sfp_tx_fault_i,
      sfp_tx_disable_o    => sfp_tx_disable_o,
      sfp_los_i           => sfp_los_i,
      pll20dac_din_o      => pll20dac_din_o,
      pll20dac_sclk_o     => pll20dac_sclk_o,
      pll20dac_sync_n_o   => pll20dac_sync_n_o,
      pll25dac_din_o      => pll25dac_din_o,
      pll25dac_sclk_o     => pll25dac_sclk_o,
      pll25dac_sync_n_o   => pll25dac_sync_n_o,

      fmc0_prsntm2c_n_i => fmc0_prsntm2c_n_i,
      fmc1_prsntm2c_n_i => fmc1_prsntm2c_n_i,

      tempid_dq_b          => tempid_dq_b,
      uart_rxd_i           => uart_rxd_i,
      uart_txd_o           => uart_txd_o,
      fmc0_clk_aux_i       => fmc0_clk_wr,
      fmc0_host_wb_o       => fmc_host_wb_out(0),
      fmc0_host_wb_i       => fmc_host_wb_in(0),
      fmc0_host_irq_i      => fmc_host_irq(0),
      fmc0_dp_wb_o         => fmc_dp_wb_out(0),
      fmc0_dp_wb_i         => fmc_dp_wb_in(0),
      fmc1_clk_aux_i       => '0',
      fmc1_host_wb_o       => fmc_host_wb_out(1),
      fmc1_host_wb_i       => fmc_host_wb_in(1),
      fmc1_host_irq_i      => fmc_host_irq(1),
      fmc1_dp_wb_o         => fmc_dp_wb_out(1),
      fmc1_dp_wb_i         => fmc_dp_wb_in(1),
      tm_link_up_o         => tm_link_up,
      tm_dac_value_o       => tm_dac_value,
      tm_dac_wr_o          => tm_dac_wr,
      tm_clk_aux_lock_en_i => tm_clk_aux_lock_en,
      tm_clk_aux_locked_o  => tm_clk_aux_locked,
      tm_time_valid_o      => tm_time_valid,
      tm_tai_o             => tm_tai,
      tm_cycles_o          => tm_cycles,
      carrier_scl_b        => carrier_scl_b,
      carrier_sda_b        => carrier_sda_b);


 xwb_crossbar_1 : xwb_crossbar
    generic map (
      g_num_masters => 2,
      g_num_slaves  => 2,
      g_registered  => true,
      g_address     => c_slave_addr,
      g_mask        => c_slave_mask)
    port map (
      clk_sys_i   => clk_sys,
      rst_n_i     => rst_n,
      slave_i(0)  => fmc_dp_wb_out(0),
      slave_i(1)  => fmc_host_wb_out(0),
      slave_o(0)  => fmc_dp_wb_in(0),
      slave_o(1)  => fmc_host_wb_in(0),
      master_o => fmc_wb_muxed_out,
      master_i => fmc_wb_muxed_in
      );

  fmc_host_wb_in(1).ack   <= '0';
  fmc_host_wb_in(1).err   <= '0';
  fmc_host_wb_in(1).rty   <= '0';
  fmc_host_wb_in(1).stall <= '0';

  fmc_dp_wb_in(1).ack   <= '0';
  fmc_dp_wb_in(1).err   <= '0';
  fmc_dp_wb_in(1).rty   <= '0';
  fmc_dp_wb_in(1).stall <= '0';


 U_D3S_ADC_Core : wr_d3s_adc
    port map (
      clk_sys_i        => clk_sys,
      clk_wr_o => fmc0_clk_wr,
      rst_n_sys_i      => rst_n,
      tm_time_valid_i  => tm_time_valid,
      tm_clk_aux_lock_en_o => tm_clk_aux_lock_en(0),
      tm_clk_aux_locked_i => tm_clk_aux_locked(0),
      tm_cycles_i      => tm_cycles,
      spi_din_i        => adc0_spi_din_i,
      spi_dout_o       => adc0_spi_dout_o,
      spi_sck_o        => adc0_spi_sck_o,
      spi_cs_adc_n_o   => adc0_spi_cs_adc_n_o,
      spi_cs_dac1_n_o  => adc0_spi_cs_dac1_n_o,
      spi_cs_dac2_n_o  => adc0_spi_cs_dac2_n_o,
      spi_cs_dac3_n_o  => adc0_spi_cs_dac3_n_o,
      spi_cs_dac4_n_o  => adc0_spi_cs_dac4_n_o,
      adc_dco_p_i      => adc0_dco_p_i,
      adc_dco_n_i      => adc0_dco_n_i,
      adc_fr_p_i       => adc0_fr_p_i,
      adc_fr_n_i       => adc0_fr_n_i,
      adc_outa_p_i     => adc0_outa_p_i,
      adc_outa_n_i     => adc0_outa_n_i,
      adc_outb_p_i     => adc0_outb_p_i,
      adc_outb_n_i     => adc0_outb_n_i,
      slave_i          => fmc_wb_muxed_out(0),
      slave_o          => fmc_wb_muxed_in(0),
      debug_o => debug
      );

  U_Silabs_IF: xwr_si57x_interface
    generic map (
      g_simulation => 0)
    port map (
      clk_sys_i         => clk_sys,
      rst_n_i           => rst_n,
      tm_dac_value_i    => tm_dac_value,
      tm_dac_value_wr_i => tm_dac_wr(0),
      scl_pad_oen_o     => scl_pad_oen,
      sda_pad_oen_o     => sda_pad_oen,
      scl_pad_i         => adc0_si570_scl_b,
      sda_pad_i         => adc0_si570_sda_b,
      slave_i           => fmc_wb_muxed_out(1),
      slave_o           => fmc_wb_muxed_in(1));

  adc0_si570_sda_b <= '0' when sda_pad_oen = '0' else 'Z';
  adc0_si570_scl_b <= '0' when scl_pad_oen = '0' else 'Z';


  fp_gpio1_b <= debug(0);
  fp_gpio2_b <= tm_dac_wr(0);

  adc0_gpio_dac_clr_n_o <= '1';
  adc0_gpio_si570_oe_o <= '1';

  fp_gpio1_a2b_o <= '1';
  fp_gpio2_a2b_o <= '1';
  fp_gpio34_a2b_o <= '1';
  
end rtl;




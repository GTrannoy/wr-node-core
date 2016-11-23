-------------------------------------------------------------------------------
-- Title      : WR RF DDS Distribution Node (SVEC)
-- Project    : 
-------------------------------------------------------------------------------
-- File       : svec_top.vhd
-- Author     : Tomasz Włostowski
-- Company    : CERN BE-CO-HT
-- Created    : 2014-04-01
-- Last update: 2016-10-21
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
--
-- WR RF DDS distribution Node. It was designed to be implemented in a SVEC 
-- card (VME carrier card) with two Fmc cards: a Fmc-adc-subsamp-125m14b4ch card
-- which works as WR master node at the fmc slot 0 and a Fmc-dac-600m12b1cha-DDS 
-- card working as WR node at the fmc slot 1. 
-- The master node samples an RF signal, calculates its phase, and compresses and 
-- sends this information through a WR network. The slave node receives this
-- information, uncompresses it, and uses a DDS to reproduce the initial Rf signal.
--
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
    rst_n_a_i           : in  std_logic;
    ----------------------------------------
    --  Clock controls
    ----------------------------------------
    clk_20m_vcxo_i      : in  std_logic;  -- 20MHz VCXO clock
    clk_125m_pllref_p_i : in  std_logic;  -- 125 MHz PLL reference
    clk_125m_pllref_n_i : in  std_logic;
    clk_125m_gtp_p_i    : in  std_logic;  -- 125 MHz PLL reference
    clk_125m_gtp_n_i    : in  std_logic;
    ----------------------------------------
    -- SVEC Front panel LEDs
    ----------------------------------------
    fp_led_line_oen_o   : out std_logic_vector(1 downto 0);
    fp_led_line_o       : out std_logic_vector(1 downto 0);
    fp_led_column_o     : out std_logic_vector(3 downto 0);
    dbg_led0_o          : out std_logic;  -- FIXME : Not connected
    dbg_led1_o          : out std_logic;  -- FIXME : Not connected
    dbg_led2_o          : out std_logic;  -- FIXME : Not connected
    dbg_led3_o          : out std_logic;  -- FIXME : Not connected

    ----------------------------------------    
    -- SVEC GPIO
    ----------------------------------------  
    fp_gpio1_a2b_o  : out   std_logic;
    fp_gpio2_a2b_o  : out   std_logic;
    fp_gpio34_a2b_o : out   std_logic;
    fp_gpio1_b      : inout std_logic;
    fp_gpio2_b      : inout std_logic;
    fp_gpio3_b      : inout std_logic;
    fp_gpio4_b      : inout std_logic;

    ----------------------------------------
    -- VME Interface pins
    ----------------------------------------
    VME_AS_n_i        : in    std_logic;
    VME_RST_n_i       : in    std_logic;
    VME_WRITE_n_i     : in    std_logic;
    VME_AM_i          : in    std_logic_vector(5 downto 0);
    VME_DS_n_i        : in    std_logic_vector(1 downto 0);
    VME_GA_i          : in    std_logic_vector(5 downto 0);
    VME_BERR_o        : inout std_logic;
    VME_DTACK_n_o     : inout std_logic;
    VME_RETRY_n_o     : out   std_logic;
    VME_RETRY_OE_o    : out   std_logic;
    VME_LWORD_n_b     : inout std_logic;
    VME_ADDR_b        : inout std_logic_vector(31 downto 1);
    VME_DATA_b        : inout std_logic_vector(31 downto 0);
    VME_BBSY_n_i      : in    std_logic;
    VME_IRQ_n_o       : out   std_logic_vector(6 downto 0);
    VME_IACK_n_i      : in    std_logic;
    VME_IACKIN_n_i    : in    std_logic;
    VME_IACKOUT_n_o   : out   std_logic;
    VME_DTACK_OE_o    : inout std_logic;
    VME_DATA_DIR_o    : inout std_logic;
    VME_DATA_OE_N_o   : inout std_logic;
    VME_ADDR_DIR_o    : inout std_logic;
    VME_ADDR_OE_N_o   : inout std_logic;
    ----------------------------------------
    --  SFP pins
    ----------------------------------------
    sfp_txp_o         : out   std_logic;
    sfp_txn_o         : out   std_logic;
    sfp_rxp_i         : in    std_logic := '0';
    sfp_rxn_i         : in    std_logic := '1';
    sfp_mod_def0_b    : in    std_logic;  -- detect 
    sfp_mod_def1_b    : inout std_logic;  -- scl
    sfp_mod_def2_b    : inout std_logic;  -- sda
    sfp_rate_select_b : inout std_logic := '0';
    sfp_tx_fault_i    : in    std_logic := '0';
    sfp_tx_disable_o  : out   std_logic;
    sfp_los_i         : in    std_logic := '0';
    ----------------------------------------
    --  Clock controls
    ----------------------------------------
    pll20dac_din_o    : out   std_logic;
    pll20dac_sclk_o   : out   std_logic;
    pll20dac_sync_n_o : out   std_logic;
    pll25dac_din_o    : out   std_logic;
    pll25dac_sclk_o   : out   std_logic;
    pll25dac_sync_n_o : out   std_logic;
    ----------------------------------------
    -- 1-wire thermometer + unique ID
    ----------------------------------------
    tempid_dq_b       : inout std_logic;
    ----------------------------------------
    --  UART
    ----------------------------------------
    uart_rxd_i        : in    std_logic := '1';
    uart_txd_o        : out   std_logic;
    ----------------------------------------
    --  SVEC carrier EEPROM
    ----------------------------------------
    scl_afpga_b       : inout std_logic;
    sda_afpga_b       : inout std_logic;
    ----------------------------------------   
    -- Fmc Management 
    ----------------------------------------
    fmc0_prsntm2c_n_i : in    std_logic;  -- Mezzanine present (active low)
    fmc1_prsntm2c_n_i : in    std_logic;  -- Mezzanine present (active low)

    ----------------------------------------
    -- Put the FMC I/Os here
    ----------------------------------------

    ----    FMC 0: Adc-fmc type    ---------
	 
    adc0_ext_trigger_p_i : in std_logic;
    adc0_ext_trigger_n_i : in std_logic;

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

    adc0_gpio_si570_oe_o : out std_logic;  -- Si570 (programmable oscillator) output enable

    adc0_si570_scl_b : inout std_logic;  -- I2C bus clock (Si570)
    adc0_si570_sda_b : inout std_logic;  -- I2C bus data (Si570)

--    adc0_one_wire_b       : inout std_logic;  -- Mezzanine 1-wire interface (DS18B20 thermometer + unique ID)

--    fmc0_scl_b            : inout std_logic;
--    fmc0_sda_b            : inout std_logic;

    ----    FMC 1 : Dds-fmc type   ---------

    -- DDS Dac I/F (Maxim)
    fmc1_dac_p_o           : out    std_logic_vector(13 downto 0);  --DDS 14b DAC
    fmc1_dac_n_o           : out    std_logic_vector(13 downto 0);
    -- SPI bus to both PLL chips
    fmc1_pll_sclk_o        : buffer std_logic;
    fmc1_pll_sdio_b        : inout  std_logic;
    fmc1_pll_sdo_i         : in     std_logic;
    -- System/WR PLL dedicated lines
    -- AD9516 PLL generating DDS DAC clk
    fmc1_pll_sys_ld_i      : in     std_logic;
    fmc1_pll_sys_reset_n_o : buffer std_logic;
    fmc1_pll_sys_cs_n_o    : buffer std_logic;
    fmc1_pll_sys_sync_n_o  : buffer std_logic;
    -- VCXO PLL dedicated lines
    -- AD9510 distribution clock IC, which generates the
    -- RF input signal that feeds the phase detector
    fmc1_pll_vcxo_cs_n_o   : buffer std_logic;
    fmc1_pll_vcxo_sync_n_o : buffer std_logic;
    fmc1_pll_vcxo_status_i : in     std_logic;
    -- Serial interface signals for
    -- the ADC after the phase detector
--         fmc1_adc_sdo_i           : in std_logic;
--    fmc1_adc_sck_o           : out std_logic;
--    fmc1_adc_cnv_o           : out std_logic;
--    fmc1_adc_sdi_o           : out std_logic;
    -- Phase Detector signals
--         fmc1_pd_lockdet_i        : in std_logic;
--    fmc1_pd_clk_o            : out std_logic; 
--    fmc1_pd_data_b           : inout std_logic;
--    fmc1_pd_le_o             : out std_logic;
    -- WR reference clock from FMC's PLL (AD9516)
      fmc1_wr_ref_clk_n_i    : in     std_logic;
      fmc1_wr_ref_clk_p_i    : in     std_logic;

      fmc1_synth_clk_n_i       : in std_logic;
      fmc1_synth_clk_p_i       : in std_logic;

--    fmc1_rf_clk_n_i          : in std_logic;
--    fmc1_rf_clk_p_i          : in std_logic;

    -- Delay generator
--    fmc1_delay_d_o           : out std_logic_vector(9 downto 0);
--    fmc1_delay_fb_i          : in std_logic;
--    fmc1_delay_len_o         : out std_logic;
--    fmc1_delay_pulse_o       : out std_logic;

    -- Trigger input
--    fmc1_trig_p_i            : in std_logic;
--    fmc1_trig_n_i            : in std_logic;

    -- OneWire (ID & temp sensor)
--    fmc1_onewire_b           : inout std_logic;

    -- WR mezzanine DAC
    -- Control signals of the nanoDAC (AD5662) 
    -- which controls the VCO feeding the AD9516 PLL 
    fmc1_wr_dac_sclk_o   : out std_logic;
    fmc1_wr_dac_din_o    : out std_logic;
    fmc1_wr_dac_sync_n_o : out std_logic

--    fmc1_scl_b        : inout std_logic;
--    fmc1_sda_b        : inout std_logic
    );
end svec_top;

architecture rtl of svec_top is

------------------------------------------
--        FUNCTIONS DECLARATION 
------------------------------------------
  -- FIXME: this function is not used in this file
  function f_int_to_bool (x : integer) return boolean is
  begin
    if (x = 0) then
      return false;
    else
      return true;
    end if;
  end function;
  
------------------------------------------
--        COMPONENTs DECLARATION  
------------------------------------------
  component wr_d3s_adc is
    port (
      rst_n_sys_i       : in  std_logic;
      clk_sys_i         : in  std_logic;
      clk_wr_o          : out std_logic;

      tm_link_up_i         : in  std_logic;
      tm_time_valid_i      : in  std_logic;
      tm_tai_i             : in  std_logic_vector(39 downto 0);
      tm_cycles_i          : in  std_logic_vector(27 downto 0);
      tm_clk_aux_lock_en_o : out std_logic;
      tm_clk_aux_locked_i  : in  std_logic;
      wr_pps_i             : in  std_logic;
		
      spi_din_i            : in    std_logic;
      spi_dout_o           : out   std_logic;
      spi_sck_o            : out   std_logic;
      spi_cs_adc_n_o       : out   std_logic;
      spi_cs_dac1_n_o      : out   std_logic;
      spi_cs_dac2_n_o      : out   std_logic;
      spi_cs_dac3_n_o      : out   std_logic;
      spi_cs_dac4_n_o      : out   std_logic;
      si570_scl_b          : inout std_logic;
      si570_sda_b          : inout std_logic;
      adc_dco_p_i          : in    std_logic;
      adc_dco_n_i          : in    std_logic;
      adc_fr_p_i           : in    std_logic;
      adc_fr_n_i           : in    std_logic;
      adc_outa_p_i         : in    std_logic_vector(3 downto 0);
      adc_outa_n_i         : in    std_logic_vector(3 downto 0);
      adc_outb_p_i         : in    std_logic_vector(3 downto 0);
      adc_outb_n_i         : in    std_logic_vector(3 downto 0);
      adc_ext_trigger_p_i : in    std_logic;
      adc_ext_trigger_n_i : in    std_logic;
--      gpio_dac_clr_n_o : out   std_logic;
--      gpio_si570_oe_o  : out   std_logic;
      slave_i              : in    t_wishbone_slave_in;
      slave_o              : out   t_wishbone_slave_out
--      debug_o              : out   std_logic_vector(3 downto 0)

      -- ChipScope Signals
--      TRIG_O : out std_logic_vector(127 downto 0)
      );
  end component wr_d3s_adc;

  component wr_d3s_adc_slave is
    port (
      rst_n_sys_i          : in  std_logic;
      clk_sys_i            : in  std_logic;
--               clk_125m_pllref_i : in std_logic;
      clk_wr_o             : out std_logic;
      tm_link_up_i         : in  std_logic;
      tm_time_valid_i      : in  std_logic;
      tm_tai_i             : in  std_logic_vector(39 downto 0);
      tm_cycles_i          : in  std_logic_vector(27 downto 0);
      tm_clk_aux_lock_en_o : out std_logic;
      tm_clk_aux_locked_i  : in  std_logic;
      tm_dac_value_i       : in  std_logic_vector(23 downto 0);
      tm_dac_wr_i          : in  std_logic;
		
      -- WR reference clock from FMC's PLL (AD9516)
      wr_ref_clk_n_i    : in    std_logic;
      wr_ref_clk_p_i    : in    std_logic;
      -- Slave synthesized signal
      synth_n_i 	      : in    std_logic; 
      synth_p_i 	      : in    std_logic; 
	   -- System/WR PLL dedicated lines
      pll_sys_cs_n_o    : out   std_logic;
      pll_sys_ld_i      : in    std_logic;
      pll_sys_reset_n_o : out   std_logic;
      pll_sys_sync_n_o  : out   std_logic;
      -- VCXO PLL dedicated lines
      pll_vcxo_cs_n_o   : out   std_logic;
      pll_vcxo_sync_n_o : out   std_logic;
      pll_vcxo_status_i : in    std_logic;
      -- SPI bus to both PLL chips
      pll_sclk_o        : out   std_logic;
      pll_sdio_b        : inout std_logic;
      pll_sdo_i         : in    std_logic;
      -- DDS Dac I/F (Maxim)
      dac_n_o           : out   std_logic_vector(13 downto 0);
      dac_p_o           : out   std_logic_vector(13 downto 0);
      -- WR mezzanine DAC
      wr_dac_sclk_o     : out   std_logic;
      wr_dac_din_o      : out   std_logic;
      wr_dac_sync_n_o   : out   std_logic;
      -- WB interface
      slave_i           : in    t_wishbone_slave_in;
      slave_o           : out   t_wishbone_slave_out;
      rev_clk_o         : out std_logic  -- Revolution clock signal
      );
  end component wr_d3s_adc_slave;

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

--  component chipscope_ila
--    port (
--      CONTROL : inout std_logic_vector(35 downto 0);
--      CLK     : in    std_logic;
--      TRIG0   : in    std_logic_vector(31 downto 0);
--      TRIG1   : in    std_logic_vector(31 downto 0);
--      TRIG2   : in    std_logic_vector(31 downto 0);
--      TRIG3   : in    std_logic_vector(31 downto 0));
--  end component;
--
--  component chipscope_icon
--    port (
--      CONTROL0 : inout std_logic_vector (35 downto 0));
--  end component;

------------------------------------------
--        CONSTANTS DECLARATION  
------------------------------------------

  -- Number of master port(s) on the wishbone crossbar
  constant c_NUM_WB_MASTERS : integer := 3;

  -- Number of slave port(s) on the wishbone crossbar
  constant c_NUM_WB_SLAVES : integer := 3;

  -- Device SDB description
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

  constant c_slave_addr : t_wishbone_address_array(c_NUM_WB_SLAVES-1 downto 0) :=
    (0 => x"00000000",
     1 => x"00001000",
     2 => x"00002000");
  constant c_slave_mask : t_wishbone_address_array(c_NUM_WB_SLAVES-1 downto 0) :=
    (0 => x"00003000",
     1 => x"00003000",
     2 => x"00003000");

  -- Wishbone slave(s)
  constant c_FMC_0 : integer := 0;      -- Fmc0: fmc-adc (d3s_adc core)
  constant c_FMC_1 : integer := 2;      -- Fmc1: fmc-d3s (d3s_adc_slave core)
  constant c_SI57x : integer := 1;      -- Si570 VCXO Silicon Labs WB interface

  constant c_d3s0_sdb_record : t_sdb_record       := f_sdb_embed_device(c_D3S_ADC_SDB_DEVICE, x"00010000");
  constant c_d3s1_sdb_record : t_sdb_record       := f_sdb_embed_device(c_D3S_ADC_SDB_DEVICE, x"00012000");
  constant c_d3s_vector      : t_wishbone_address := x"ffffffff";

------------------------------------------
--        SIGNALS DECLARATION  
------------------------------------------

  signal clk_sys : std_logic;
  signal rst_n   : std_logic;

  signal fmc_host_wb_out, fmc_dp_wb_out : t_wishbone_master_out_array(0 to c_NUM_WB_MASTERS-1);
  signal fmc_host_wb_in, fmc_dp_wb_in   : t_wishbone_master_in_array(0 to c_NUM_WB_MASTERS-1);
  signal fmc_host_irq                   : std_logic_vector(c_NUM_WB_MASTERS downto 0);

  signal tm_link_up         : std_logic;
  signal tm_dac_value       : std_logic_vector(23 downto 0);
  signal tm_dac_wr          : std_logic_vector(1 downto 0);
  signal tm_clk_aux_lock_en : std_logic_vector(1 downto 0) := (others => '0');
  signal tm_clk_aux_locked  : std_logic_vector(1 downto 0);
  signal tm_time_valid      : std_logic;
  signal tm_tai             : std_logic_vector(39 downto 0);
  signal tm_cycles          : std_logic_vector(27 downto 0);
  signal wr_pps             : std_logic;

  signal fmc0_clk_wr, fmc1_clk_wr : std_logic;

  signal debug : std_logic_vector(3 downto 0);

  signal fmc_wb_muxed_out : t_wishbone_master_out_array(c_NUM_WB_SLAVES-1 downto 0);
  signal fmc_wb_muxed_in  : t_wishbone_master_in_array(c_NUM_WB_SLAVES-1 downto 0);

  signal scl_pad_oen, sda_pad_oen : std_logic;
  signal clk_125m_pllref          : std_logic;

  signal rev_clk_o : std_logic;  -- Revolution clock signal
  
  -- Chip scope signals
  signal CONTROL : std_logic_vector(35 downto 0);
  signal CLK     : std_logic;
  signal TRIG0   : std_logic_vector(31 downto 0);
  signal TRIG1   : std_logic_vector(31 downto 0);
  signal TRIG2   : std_logic_vector(31 downto 0);
  signal TRIG3   : std_logic_vector(31 downto 0);

begin

--  chipscope_icon_1: chipscope_icon
--    port map (
--      CONTROL0 => CONTROL);
--
--  chipscope_ila_1: chipscope_ila
--    port map (
--      CONTROL => CONTROL,
--      CLK     => clk_sys,
--      TRIG0   => TRIG0,
--      TRIG1   => TRIG1,
--      TRIG2   => TRIG2,
--      TRIG3   => TRIG3);
  
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
      clk_sys_o           => clk_sys,  -- system clock output for user design, 62.5 MHz
      clk_20m_vcxo_i      => clk_20m_vcxo_i,
      clk_125m_pllref_p_i => clk_125m_pllref_p_i,
      clk_125m_pllref_n_i => clk_125m_pllref_n_i,
      clk_125m_gtp_p_i    => clk_125m_gtp_p_i,
      clk_125m_gtp_n_i    => clk_125m_gtp_n_i,
      clk_125m_pllref_o   => clk_125m_pllref,  -- Not used by the FMCs... (?)
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

      scl_afpga_b => scl_afpga_b,
      sda_afpga_b => sda_afpga_b,

      fmc0_prsntm2c_n_i => fmc0_prsntm2c_n_i,
      fmc1_prsntm2c_n_i => fmc1_prsntm2c_n_i,

      tempid_dq_b => tempid_dq_b,
      uart_rxd_i  => uart_rxd_i,
      uart_txd_o  => uart_txd_o,

      fmc0_clk_aux_i  => fmc0_clk_wr,
      fmc0_host_wb_o  => fmc_host_wb_out(0),
      fmc0_host_wb_i  => fmc_host_wb_in(0),
      fmc0_host_irq_i => fmc_host_irq(0),
      fmc0_dp_wb_o    => fmc_dp_wb_out(0),
      fmc0_dp_wb_i    => fmc_dp_wb_in(0),

      fmc1_clk_aux_i  => fmc1_clk_wr,
      fmc1_host_wb_o  => fmc_host_wb_out(1),
      fmc1_host_wb_i  => fmc_host_wb_in(1),
      fmc1_host_irq_i => fmc_host_irq(1),
      fmc1_dp_wb_o    => fmc_dp_wb_out(1),
      fmc1_dp_wb_i    => fmc_dp_wb_in(1),

      tm_link_up_o         => tm_link_up,
      tm_dac_value_o       => tm_dac_value,
      tm_dac_wr_o          => tm_dac_wr,
      tm_clk_aux_lock_en_i => tm_clk_aux_lock_en,
      tm_clk_aux_locked_o  => tm_clk_aux_locked,
      tm_time_valid_o      => tm_time_valid,
      tm_tai_o             => tm_tai,
      tm_cycles_o          => tm_cycles,
		
		pps_o                => wr_pps
      );


  xwb_crossbar_1 : xwb_crossbar
    generic map (
      g_num_masters => c_NUM_WB_MASTERS,
      g_num_slaves  => c_NUM_WB_SLAVES,
      g_registered  => true,
      g_address     => c_slave_addr,
      g_mask        => c_slave_mask)
    port map (
      clk_sys_i  => clk_sys,
      rst_n_i    => rst_n,
      slave_i(0) => fmc_dp_wb_out(0),
      slave_i(1) => fmc_dp_wb_out(1),
      slave_i(2) => fmc_host_wb_out(0),
      slave_o(0) => fmc_dp_wb_in(0),
      slave_o(1) => fmc_dp_wb_in(1),
      slave_o(2) => fmc_host_wb_in(0),
      master_o   => fmc_wb_muxed_out,
      master_i   => fmc_wb_muxed_in
      );

--  fmc_host_wb_in(1).err   <= '0';
--  fmc_host_wb_in(1).rty   <= '0';
--  fmc_host_wb_in(1).stall <= '0';

--  fmc_dp_wb_in(1).err   <= '0';
--  fmc_dp_wb_in(1).rty   <= '0';
--  fmc_dp_wb_in(1).stall <= '0';


  U_D3S_ADC_Core : wr_d3s_adc
    port map (
      rst_n_sys_i       => rst_n,
      clk_sys_i         => clk_sys,
      clk_wr_o          => fmc0_clk_wr,

      tm_link_up_i         => tm_link_up,
      tm_time_valid_i      => tm_time_valid,
      tm_tai_i             => tm_tai,
      tm_cycles_i          => tm_cycles,
      tm_clk_aux_lock_en_o => tm_clk_aux_lock_en(0),
      tm_clk_aux_locked_i  => tm_clk_aux_locked(0),
      wr_pps_i             => wr_pps,
		
      spi_din_i       => adc0_spi_din_i,
      spi_dout_o      => adc0_spi_dout_o,
      spi_sck_o       => adc0_spi_sck_o,
      spi_cs_adc_n_o  => adc0_spi_cs_adc_n_o,
      spi_cs_dac1_n_o => adc0_spi_cs_dac1_n_o,
      spi_cs_dac2_n_o => adc0_spi_cs_dac2_n_o,
      spi_cs_dac3_n_o => adc0_spi_cs_dac3_n_o,
      spi_cs_dac4_n_o => adc0_spi_cs_dac4_n_o,

      adc_dco_p_i          => adc0_dco_p_i,
      adc_dco_n_i          => adc0_dco_n_i,
      adc_fr_p_i           => adc0_fr_p_i,
      adc_fr_n_i           => adc0_fr_n_i,
      adc_outa_p_i         => adc0_outa_p_i,
      adc_outa_n_i         => adc0_outa_n_i,
      adc_outb_p_i         => adc0_outb_p_i,
      adc_outb_n_i         => adc0_outb_n_i,
      adc_ext_trigger_p_i  => adc0_ext_trigger_p_i,
      adc_ext_trigger_n_i  => adc0_ext_trigger_n_i,
      slave_i              => fmc_wb_muxed_out(c_FMC_0),
      slave_o              => fmc_wb_muxed_in(c_FMC_0)
--      debug_o              => debug
      -- ChipScope Signals
--      TRIG_O               => TRIG
      );

  U_D3S_ADC_slave_core : wr_d3s_adc_slave
    port map (
      rst_n_sys_i => rst_n,
      clk_sys_i   => clk_sys,
      clk_wr_o    => fmc1_clk_wr,
--               clk_125m_pllref_i   => clk_125m_pllref,

      tm_link_up_i         => tm_link_up,
      tm_tai_i             => tm_tai,
      tm_cycles_i          => tm_cycles,
      tm_time_valid_i      => tm_time_valid,
      tm_clk_aux_lock_en_o => tm_clk_aux_lock_en(1),
      tm_clk_aux_locked_i  => tm_clk_aux_locked(1),

      tm_dac_value_i => tm_dac_value,
      tm_dac_wr_i    => tm_dac_wr(1),

      -- WR mezzanine DAC
      wr_dac_sclk_o   => fmc1_wr_dac_sclk_o,
      wr_dac_din_o    => fmc1_wr_dac_din_o,
      wr_dac_sync_n_o => fmc1_wr_dac_sync_n_o,

      wr_ref_clk_n_i => fmc1_wr_ref_clk_n_i,
      wr_ref_clk_p_i => fmc1_wr_ref_clk_p_i,
      -- Slave synthesized signal
      synth_n_i 	   => fmc1_synth_clk_n_i,
      synth_p_i 	   => fmc1_synth_clk_n_i, 
      -- System/WR PLL dedicated lines
      pll_sys_cs_n_o    => fmc1_pll_sys_cs_n_o,
      pll_sys_ld_i      => fmc1_pll_sys_ld_i,
      pll_sys_reset_n_o => fmc1_pll_sys_reset_n_o,
      pll_sys_sync_n_o  => fmc1_pll_sys_sync_n_o,
      -- VCXO PLL dedicated lines
      pll_vcxo_cs_n_o   => fmc1_pll_vcxo_cs_n_o,
      pll_vcxo_sync_n_o => fmc1_pll_vcxo_sync_n_o,
      pll_vcxo_status_i => fmc1_pll_vcxo_status_i,
      -- SPI bus to both PLL chips
      pll_sclk_o        => fmc1_pll_sclk_o,
      pll_sdio_b        => fmc1_pll_sdio_b,
      pll_sdo_i         => fmc1_pll_sdo_i,
      -- DDS Dac I/F (Maxim)
      dac_n_o           => fmc1_dac_n_o,
      dac_p_o           => fmc1_dac_p_o,
      -- WB interface
      slave_i           => fmc_wb_muxed_out(c_FMC_1),
      slave_o           => fmc_wb_muxed_in(c_FMC_1),
      rev_clk_o         => rev_clk_o
      );  

  U_Silabs_IF : xwr_si57x_interface
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
      slave_i           => fmc_wb_muxed_out(c_SI57x),
      slave_o           => fmc_wb_muxed_in(c_SI57x));

  adc0_si570_sda_b <= '0' when sda_pad_oen = '0' else 'Z';
  adc0_si570_scl_b <= '0' when scl_pad_oen = '0' else 'Z';

--  fp_gpio1_b <= debug(0);
--  fp_gpio2_b <= tm_dac_wr(0);

  adc0_gpio_dac_clr_n_o <= '1';
  adc0_gpio_si570_oe_o  <= '1';

  fp_gpio1_a2b_o  <= '1';  -- svec front panel LEMO L2 set as output
  fp_gpio2_a2b_o  <= '1';  -- svec front panel LEMO L1 set as output
  fp_gpio34_a2b_o <= '1';  -- svec front panel LEMOs L3 and L4 set as output
  
  dbg_led0_o  <= '0';
  dbg_led1_o  <= '0'; 
  dbg_led2_o  <= '0';
  dbg_led3_o  <= '0';
  
  adc0_gpio_led_trig_o <= '0';
  adc0_gpio_led_acq_o <= '0';
  
end rtl;




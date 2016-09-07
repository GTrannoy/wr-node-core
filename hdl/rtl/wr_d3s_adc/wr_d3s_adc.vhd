library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gencores_pkg.all;
use work.genram_pkg.all;
use work.wishbone_pkg.all;
use work.d3s_wbgen2_pkg.all;

use work.stdc_wbgen2_pkg.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity wr_d3s_adc is
  generic (
    g_use_fake_data : boolean := false);
  port (
    rst_n_sys_i       : in  std_logic;
    clk_sys_i         : in  std_logic;
    clk_125m_pllref_i : in  std_logic;
    clk_wr_o          : out std_logic;

    tm_link_up_i         : in  std_logic;
    tm_time_valid_i      : in  std_logic;
    tm_cycles_i          : in  std_logic_vector(27 downto 0);
    tm_clk_aux_lock_en_o : out std_logic;
    tm_clk_aux_locked_i  : in  std_logic;

    fake_data_i : in std_logic_vector(13 downto 0) := "00000000000000";

-- ADC Mezzanine I/F
    spi_din_i       : in  std_logic;    -- SPI data from FMC
    spi_dout_o      : out std_logic;    -- SPI data to FMC
    spi_sck_o       : out std_logic;    -- SPI clock
    spi_cs_adc_n_o  : out std_logic;    -- SPI ADC chip select (active low)
    spi_cs_dac1_n_o : out std_logic;  -- SPI channel 1 offset DAC chip select (active low)
    spi_cs_dac2_n_o : out std_logic;  -- SPI channel 2 offset DAC chip select (active low)
    spi_cs_dac3_n_o : out std_logic;  -- SPI channel 3 offset DAC chip select (active low)
    spi_cs_dac4_n_o : out std_logic;  -- SPI channel 4 offset DAC chip select (active low)

    si570_scl_b : inout std_logic;      -- I2C bus clock (Si570)
    si570_sda_b : inout std_logic;      -- I2C bus data (Si570)

    adc_dco_p_i  : in std_logic;        -- ADC data clock
    adc_dco_n_i  : in std_logic;
    adc_fr_p_i   : in std_logic;        -- ADC frame start
    adc_fr_n_i   : in std_logic;
    adc_outa_p_i : in std_logic_vector(3 downto 0);  -- ADC serial data (odd bits)
    adc_outa_n_i : in std_logic_vector(3 downto 0);
    adc_outb_p_i : in std_logic_vector(3 downto 0);  -- ADC serial data (even bits)
    adc_outb_n_i : in std_logic_vector(3 downto 0);

    adc0_ext_trigger_p_i : in std_logic;
    adc0_ext_trigger_n_i : in std_logic;

--    gpio_dac_clr_n_o : out std_logic;   -- offset DACs clear (active low)
--    gpio_si570_oe_o  : out std_logic;  -- Si570 (programmable oscillator) output enable

    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out;

    debug_o : out std_logic_vector(3 downto 0);

    -- ChipScope Signals
    TRIG_O : out std_logic_vector(127 downto 0)
    );

end wr_d3s_adc;

architecture rtl of wr_d3s_adc is

------------------------------------------
--        COMPONENTs DECLARATION  
------------------------------------------  

  component d3s_adc_wb is
    port (
      rst_n_i    : in  std_logic;
      clk_sys_i  : in  std_logic;
      wb_adr_i   : in  std_logic_vector(3 downto 0);
      wb_dat_i   : in  std_logic_vector(31 downto 0);
      wb_dat_o   : out std_logic_vector(31 downto 0);
      wb_cyc_i   : in  std_logic;
      wb_sel_i   : in  std_logic_vector(3 downto 0);
      wb_stb_i   : in  std_logic;
      wb_we_i    : in  std_logic;
      wb_ack_o   : out std_logic;
      wb_stall_o : out std_logic;
      clk_wr_i   : in  std_logic;
      regs_i     : in  t_d3s_in_registers;
      regs_o     : out t_d3s_out_registers);
  end component d3s_adc_wb;

  component d3s_phase_encoder is
    port (
      clk_i           : in  std_logic;
      rst_n_i         : in  std_logic;
      adc_data_i      : in  std_logic_vector(13 downto 0);
      r_max_run_len_i : in  std_logic_vector(15 downto 0);
      r_max_error_i   : in  std_logic_vector(22 downto 0);
      r_min_error_i   : in  std_logic_vector(22 downto 0);
      raw_phase_o     : out std_logic_vector(15 downto 0);
      raw_hp_data_o   : out std_logic_vector(15 downto 0);

      fifo_en_i     : in  std_logic;
      fifo_full_i   : in  std_logic;
      fifo_lost_o   : out std_logic;
      fifo_rl_o     : out std_logic_vector(15 downto 0);
      fifo_phase_o  : out std_logic_vector(31 downto 0);
      fifo_tstamp_o : out std_logic_vector(27 downto 0);
      fifo_is_rl_o  : out std_logic;
      fifo_we_o     : out std_logic;
      tm_cycles_i   : in  std_logic_vector(27 downto 0));
  end component d3s_phase_encoder;

  component d3s_acq_buffer is
    generic (
      g_data_width : integer;
      g_size       : integer);
    port (
      rst_n_sys_i : in  std_logic;
      clk_sys_i   : in  std_logic;
      clk_acq_i   : in  std_logic;
      data_i      : in  std_logic_vector(g_data_width-1 downto 0);
      slave_i     : in  t_wishbone_slave_in;
      slave_o     : out t_wishbone_slave_out);
  end component d3s_acq_buffer;

  component adc_serdes
    generic
      (
        sys_w : integer := 9;           -- width of the data for the system
        dev_w : integer := 72           -- width of the data for the device
        );
    port
      (
        -- Datapath
        DATA_IN_FROM_PINS_P : in  std_logic_vector(sys_w-1 downto 0);
        DATA_IN_FROM_PINS_N : in  std_logic_vector(sys_w-1 downto 0);
        DATA_IN_TO_DEVICE   : out std_logic_vector(dev_w-1 downto 0);
        -- Data control
        BITSLIP             : in  std_logic;
        -- Clock and reset signals
        CLK_IN              : in  std_logic;  -- Fast clock from PLL/MMCM
        CLK_OUT             : out std_logic;
        CLK_DIV_IN          : in  std_logic;  -- Slow clock from PLL/MMCM
        LOCKED_IN           : in  std_logic;
        LOCKED_OUT          : out std_logic;
        CLK_RESET           : in  std_logic;  -- Reset signal for Clock circuit
        IO_RESET            : in  std_logic;  -- Reset signal for IO circuit
        SERDES_STROBE_O     : out std_logic

        );
  end component adc_serdes;

  component stdc_hostif is
    generic(
      D_DEPTH : positive
      );
    port(
      sys_rst_n_i : in std_logic;
      clk_sys_i   : in std_logic;
      clk_125m_i  : in std_logic;

      serdes_clk_i    : in std_logic;
      serdes_strobe_i : in std_logic;

      wb_addr_i  : in  std_logic_vector(31 downto 0);
      wb_data_i  : in  std_logic_vector(31 downto 0);
      wb_data_o  : out std_logic_vector(31 downto 0);
      wb_cyc_i   : in  std_logic;
      wb_sel_i   : in  std_logic_vector(3 downto 0);
      wb_stb_i   : in  std_logic;
      wb_we_i    : in  std_logic;
      wb_ack_o   : out std_logic;
      wb_stall_o : out std_logic;

      stdc_input_i : in std_logic;

      cycles_i : in std_logic_vector(27 downto 0);

      -- TDC outputs                    
      strobe_o    : out std_logic;
      stdc_data_o : out std_logic_vector(31 downto 0);

      -- ChipScope Signals
      TRIG_O : out std_logic_vector(127 downto 0)
      );
  end component;

------------------------------------------
--        CONSTANTS DECLARATION  
------------------------------------------
  constant c_CNX_MASTER_COUNT : integer := 5;

  constant c_cnx_base_addr : t_wishbone_address_array(c_CNX_MASTER_COUNT-1 downto 0) :=
    (x"00000000",                       -- Base regs
     x"00000100",                       -- AcqBuf1
     x"00000200",                       -- AcqBuf2
     x"00000300",                       -- AcqBuf3
     x"00000400"                        -- Serdes TDC
     );

  constant c_cnx_base_mask : t_wishbone_address_array(c_CNX_MASTER_COUNT-1 downto 0) :=
    (x"00000700",
     x"00000700",
     x"00000700",
     x"00000700",
     x"00000700"
     );

------------------------------------------
--        SIGNALS DECLARATION  
------------------------------------------
  signal rst_n_wr : std_logic;

  signal regs_in  : t_d3s_in_registers;
  signal regs_out : t_d3s_out_registers;

  signal adc_data  : std_logic_vector(13 downto 0);
  signal adc_data2 : std_logic_vector(13 downto 0);

  signal serdes_in_p         : std_logic_vector(8 downto 0);
  signal serdes_in_n         : std_logic_vector(8 downto 0);
  signal serdes_out_raw      : std_logic_vector(71 downto 0);
  signal serdes_out_data     : std_logic_vector(63 downto 0);
  signal serdes_out_fr       : std_logic_vector(7 downto 0);
  signal serdes_auto_bitslip : std_logic;
  signal serdes_man_bitslip  : std_logic;
  signal serdes_bitslip      : std_logic;
  signal serdes_synced       : std_logic;
  signal bitslip_sreg        : std_logic_vector(7 downto 0);

  --  Signals for SERDES-TDC  -----------------



  signal stdc_data   : std_logic_vector(31 downto 0);
  signal ext_trigger : std_logic;
  ----------------------------------------------

  signal dco_clk, dco_clk_buf : std_logic;
  signal clk_wr               : std_logic;
  signal clk_fb               : std_logic;
  signal clk_fb_buf           : std_logic;
  signal locked_in            : std_logic;
  signal locked_out           : std_logic;
  signal serdes_clk           : std_logic;
  signal serdes_strobe        : std_logic;
  signal fs_clk_buf           : std_logic;
  signal sys_rst              : std_logic;
  signal pllout_serdes_clk : std_logic;
  signal clk_wr_div2 : std_logic;

  signal scl_out, sda_out : std_logic;

  signal raw_hp_data, raw_phase : std_logic_vector(15 downto 0);

  signal cnx_out : t_wishbone_master_out_array(0 to c_CNX_MASTER_COUNT-1);
  signal cnx_in  : t_wishbone_master_in_array(0 to c_CNX_MASTER_COUNT-1);

  
begin
  
  U_Intercon : xwb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => c_CNX_MASTER_COUNT,
      g_registered  => true,
      g_address     => c_cnx_base_addr,
      g_mask        => c_cnx_base_mask)
    port map (
      clk_sys_i  => clk_sys_i,
      rst_n_i    => rst_n_sys_i,
      slave_i(0) => slave_i,
      slave_o(0) => slave_o,
      master_i   => cnx_in,
      master_o   => cnx_out);

  regs_in.gpior_tm_link_i       <= tm_link_up_i;
  regs_in.gpior_tm_time_valid_i <= tm_time_valid_i;
  regs_in.gpior_tm_locked_i     <= tm_clk_aux_locked_i;

  tm_clk_aux_lock_en_o <= regs_out.gpior_tm_lock_en_o;

  regs_in.gpior_si57x_scl_i <= si570_scl_b;
  regs_in.gpior_si57x_sda_i <= si570_sda_b;

  process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_sys_i = '0' then
        scl_out <= '1';
        sda_out <= '1';
      else
        if(regs_out.gpior_si57x_sda_load_o = '1') then
          sda_out <= regs_out.gpior_si57x_sda_o;
        end if;
        if(regs_out.gpior_si57x_scl_load_o = '1') then
          scl_out <= regs_out.gpior_si57x_scl_o;
        end if;
      end if;
    end if;
  end process;

  si570_sda_b <= '0' when sda_out = '0' else 'Z';
  si570_scl_b <= '0' when scl_out = '0' else 'Z';

  spi_cs_adc_n_o           <= regs_out.gpior_spi_cs_adc_o;
  spi_dout_o               <= regs_out.gpior_spi_mosi_o;
  spi_sck_o                <= regs_out.gpior_spi_sck_o;
  regs_in.gpior_spi_miso_i <= spi_din_i;

  sys_rst <= not rst_n_sys_i;

  spi_cs_dac1_n_o <= '1';
  spi_cs_dac2_n_o <= '1';
  spi_cs_dac3_n_o <= '1';
  spi_cs_dac4_n_o <= '1';

  --- ADC Mezzanine stuff
  cmp_dco_buf : IBUFGDS
    generic map (
      DIFF_TERM  => true,               -- Differential termination
      IOSTANDARD => "LVDS_25")
    port map (
      I  => adc_dco_p_i,
      IB => adc_dco_n_i,
      O  => dco_clk_buf
      );

-- Serializer TDC data input buffer:

--        1st attempt
   cmp_trig_buf : IBUFDS
    generic map (
      DIFF_TERM  => true,               -- Differential termination
      IOSTANDARD => "LVDS_25")
    port map (
      I  => adc0_ext_trigger_p_i,
      IB => adc0_ext_trigger_n_i,
      O  => ext_trigger
      );

  cmp_serdes_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKOUT0",
      COMPENSATION       => "SYSTEM_SYNCHRONOUS",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 2,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 1,
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 8,
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 2.0,
      REF_JITTER         => 0.010)
    port map (
      -- Output clocks
      CLKFBOUT => clk_fb,
      CLKOUT0  => pllout_serdes_clk,           -- 1GHz
      CLKOUT1  => fs_clk_buf,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      -- Status and control signals
      LOCKED   => locked_in,
      RST      => sys_rst,
      -- Input clock control
      CLKFBIN  => clk_fb,
      CLKIN    => dco_clk_buf);

  cmp_wr_ref_buf : BUFG
    port map (
      O => clk_wr,
      I => fs_clk_buf);

  cmp_adc_serdes : adc_serdes
    port map(
      DATA_IN_FROM_PINS_P => serdes_in_p,
      DATA_IN_FROM_PINS_N => serdes_in_n,
      DATA_IN_TO_DEVICE   => serdes_out_raw,
      BITSLIP             => serdes_auto_bitslip,
      CLK_IN              => pllout_serdes_clk,
      CLK_DIV_IN          => clk_wr,
      CLK_OUT             => serdes_clk,
      SERDES_STROBE_O     => serdes_strobe,
      LOCKED_IN           => locked_in,
      LOCKED_OUT          => locked_out,
      CLK_RESET           => '0',       -- unused
      IO_RESET            => sys_rst
      );


  -- serdes bitslip generation
  p_auto_bitslip : process (clk_wr, rst_n_sys_i)
  begin
    if rst_n_sys_i = '0' then
      bitslip_sreg        <= std_logic_vector(to_unsigned(1, bitslip_sreg'length));
      serdes_auto_bitslip <= '0';
      serdes_synced       <= '0';
    elsif rising_edge(clk_wr) then

      -- Shift register to generate bitslip enable (serdes_clk/8)
      bitslip_sreg <= bitslip_sreg(0) & bitslip_sreg(bitslip_sreg'length-1 downto 1);

      -- Generate bitslip and synced signal
      if(bitslip_sreg(bitslip_sreg'left) = '1') then
        if(serdes_out_fr /= "00001111") then  -- use fr_n pattern (fr_p and fr_n are swapped on the adc mezzanine)
          serdes_auto_bitslip <= '1';
          serdes_synced       <= '0';
        else
          serdes_auto_bitslip <= '0';
          serdes_synced       <= '1';
        end if;
      else
        serdes_auto_bitslip <= '0';
      end if;

    end if;
  end process;


  --============================================================================
  -- Sampling clock domain
  --============================================================================

  -- serdes inputs forming
  serdes_in_p <= adc_fr_p_i
                 & adc_outa_p_i(3) & adc_outb_p_i(3)
                 & adc_outa_p_i(2) & adc_outb_p_i(2)
                 & adc_outa_p_i(1) & adc_outb_p_i(1)
                 & adc_outa_p_i(0) & adc_outb_p_i(0);
  serdes_in_n <= adc_fr_n_i
                 & adc_outa_n_i(3) & adc_outb_n_i(3)
                 & adc_outa_n_i(2) & adc_outb_n_i(2)
                 & adc_outa_n_i(1) & adc_outb_n_i(1)
                 & adc_outa_n_i(0) & adc_outb_n_i(0);

  -- serdes outputs re-ordering (time slices -> channel)
  --    out_raw :(71:63)(62:54)(53:45)(44:36)(35:27)(26:18)(17:9)(8:0)
  --                |      |      |      |      |      |      |    |
  --                V      V      V      V      V      V      V    V
  --              CH1D12 CH1D10 CH1D8  CH1D6  CH1D4  CH1D2  CH1D0  0   = CH1_B
  --              CH1D13 CH1D11 CH1D9  CH1D7  CH1D5  CH1D3  CH1D1  0   = CH1_A
  --              CH2D12 CH2D10 CH2D8  CH2D6  CH2D4  CH2D2  CH2D0  0   = CH2_B
  --              CH2D13 CH2D11 CH2D9  CH2D7  CH2D5  CH2D3  CH2D1  0   = CH2_A
  --              CH3D12 CH3D10 CH3D8  CH3D6  CH3D4  CH3D2  CH3D0  0   = CH3_B
  --              CH3D13 CH3D11 CH3D9  CH3D7  CH3D5  CH3D3  CH3D1  0   = CH3_A
  --              CH4D12 CH4D10 CH4D8  CH4D6  CH4D4  CH4D2  CH4D0  0   = CH4_B
  --              CH4D13 CH4D11 CH4D9  CH4D7  CH4D5  CH4D3  CH4D1  0   = CH4_A
  --              FR7    FR6    FR5    FR4    FR3    FR2    FR1    FR0 = FR
  --
  --    out_data(15:0)  = CH1
  --    out_data(31:16) = CH2
  --    out_data(47:32) = CH3
  --    out_data(63:48) = CH4
  --    Note: The two LSBs of each channel are always '0' => 14-bit ADC
  gen_serdes_dout_reorder : for I in 0 to 7 generate
    serdes_out_data(0*16 + 2*i)   <= serdes_out_raw(0 + i*9);  -- CH1 even bits
    serdes_out_data(0*16 + 2*i+1) <= serdes_out_raw(1 + i*9);  -- CH1 odd bits
    serdes_out_data(1*16 + 2*i)   <= serdes_out_raw(2 + i*9);  -- CH2 even bits
    serdes_out_data(1*16 + 2*i+1) <= serdes_out_raw(3 + i*9);  -- CH2 odd bits
    serdes_out_data(2*16 + 2*i)   <= serdes_out_raw(4 + i*9);  -- CH3 even bits
    serdes_out_data(2*16 + 2*i+1) <= serdes_out_raw(5 + i*9);  -- CH3 odd bits
    serdes_out_data(3*16 + 2*i)   <= serdes_out_raw(6 + i*9);  -- CH4 even bits
    serdes_out_data(3*16 + 2*i+1) <= serdes_out_raw(7 + i*9);  -- CH4 odd bits
    serdes_out_fr(i)              <= serdes_out_raw(8 + i*9);  -- FR
  end generate gen_serdes_dout_reorder;

  adc_data <= serdes_out_data(15 downto 2) when g_use_fake_data = false else fake_data_i;
--  adc_data2 <= serdes_out_data(16+15 downto 2);

  U_Sync_Reset : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr,
      rst_n_i  => '1',
      data_i   => rst_n_sys_i and locked_out,
      synced_o => rst_n_wr);

  U_CSR : d3s_adc_wb
    port map (
      rst_n_i    => rst_n_sys_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => cnx_out(0).adr(5 downto 2),
      wb_dat_i   => cnx_out(0).dat,
      wb_dat_o   => cnx_in(0).dat,
      wb_cyc_i   => cnx_out(0).cyc,
      wb_sel_i   => cnx_out(0).sel,
      wb_stb_i   => cnx_out(0).stb,
      wb_we_i    => cnx_out(0).we,
      wb_ack_o   => cnx_in(0).ack,
      wb_stall_o => cnx_in(0).stall,
      clk_wr_i   => clk_wr,
      regs_i     => regs_in,
      regs_o     => regs_out);

  cnx_in(0).err <= '0';
  cnx_in(0).rty <= '0';

  U_Acq : d3s_acq_buffer
    generic map (
      g_data_width => 14,
      g_size       => 16384)
    port map (
      rst_n_sys_i => rst_n_sys_i,
      clk_sys_i   => clk_sys_i,
      clk_acq_i   => clk_wr,
      data_i      => adc_data,
      slave_i     => cnx_out(1),
      slave_o     => cnx_in(1));

  U_Acq2 : d3s_acq_buffer
    generic map (
      g_data_width => 16,
      g_size       => 2048)
    port map (
      rst_n_sys_i => rst_n_sys_i,
      clk_sys_i   => clk_sys_i,
      clk_acq_i   => clk_wr,
      data_i      => raw_hp_data,
      slave_i     => cnx_out(2),
      slave_o     => cnx_in(2));

  U_Acq3 : d3s_acq_buffer
    generic map (
      g_data_width => 16,
      g_size       => 2048)
    port map (
      rst_n_sys_i => rst_n_sys_i,
      clk_sys_i   => clk_sys_i,
      clk_acq_i   => clk_wr,
      data_i      => raw_phase,
      slave_i     => cnx_out(3),
      slave_o     => cnx_in(3));

  U_Phase_Enc : d3s_phase_encoder
    port map (
      clk_i           => clk_wr,
      rst_n_i         => rst_n_wr,
      adc_data_i      => adc_data,
      r_max_run_len_i => regs_out.rl_length_max_o(15 downto 0),
      r_max_error_i   => regs_out.rl_err_max_o(22 downto 0),
      r_min_error_i   => regs_out.rl_err_min_o(22 downto 0),
      raw_hp_data_o   => raw_hp_data,
      raw_phase_o     => raw_phase,
      fifo_en_i       => regs_out.cr_enable_o,
      fifo_full_i     => regs_out.adc_wr_full_o,
      fifo_lost_o     => open,
      fifo_rl_o       => regs_in.adc_rl_length_i(15 downto 0),
      fifo_phase_o    => regs_in.adc_rl_phase_i(31 downto 0),
      fifo_tstamp_o   => regs_in.adc_tstamp_i,
      fifo_is_rl_o    => regs_in.adc_is_rl_i,
      fifo_we_o       => regs_in.adc_wr_req_i,
      tm_cycles_i     => tm_cycles_i);

  u_mon_adc_clock : process(clk_wr)
  begin
    if rising_edge(clk_wr) then
      clk_wr_div2 <= not clk_wr_div2;
    end if;
    
  end process;

  debug_o(0) <= clk_wr_div2;
  clk_wr_o   <= clk_wr;

  ----- Adding the new component: stdc_hostif  ----
  cmp_stdc : stdc_hostif
    generic map (
      D_DEPTH => 4)  -- Length of the fifo storing the event time stamps
    port map(
      sys_rst_n_i     => rst_n_sys_i,
      clk_sys_i       => clk_sys_i,     -- 62.5 MHz
      clk_125m_i      => clk_wr,        -- 125 MHz
      serdes_clk_i    => serdes_clk,    -- 1000 MHz
      serdes_strobe_i => serdes_strobe,
      wb_addr_i       => cnx_out(4).adr,
      wb_data_i       => cnx_out(4).dat,
      wb_data_o       => cnx_in(4).dat,
      wb_cyc_i        => cnx_out(4).cyc,
      wb_sel_i        => cnx_out(4).sel,
      wb_stb_i        => cnx_out(4).stb,
      wb_we_i         => cnx_out(4).we,
      wb_ack_o        => cnx_in(4).ack,
      wb_stall_o      => cnx_in(4).stall,
      stdc_input_i    => ext_trigger,
      cycles_i        => tm_cycles_i,
      stdc_data_o     => stdc_data,
      -- ChipScope Signals
      TRIG_O          => TRIG_O
      );    

  cnx_in(4).err <= '0';
  cnx_in(4).rty <= '0';

  --cmp_stdc_clk_pll : PLL_BASE
  --  generic map (
  --    BANDWIDTH          => "OPTIMIZED",
  --    CLK_FEEDBACK       => "CLKFBOUT",
  --    COMPENSATION       => "INTERNAL",
  --    DIVCLK_DIVIDE      => 1,
  --    CLKFBOUT_MULT      => 8,
  --    CLKFBOUT_PHASE     => 0.000,
  --    CLKOUT0_DIVIDE     => 1,          -- 1000 MHz
  --    CLKOUT0_PHASE      => 0.000,
  --    CLKOUT0_DUTY_CYCLE => 0.500,
  --    CLKOUT1_DIVIDE     => 8, --1,     -- 125 MHz
  --    CLKOUT1_PHASE      => 0.000,
  --    CLKOUT1_DUTY_CYCLE => 0.500,
  --    CLKIN_PERIOD       => 8.0,
  --    REF_JITTER         => 0.016)
  --  port map (
  --    CLKFBOUT => pllout_stdc_fb,
  --    CLKOUT0  => pllout_stdc_clk,
  --    CLKOUT1  => pllout_stdc_clkdiv8,
  --    CLKOUT2  => open,
  --    CLKOUT3  => open,
  --    CLKOUT4  => open,
  --    CLKOUT5  => open,
  --    LOCKED   => pllout_stdc_locked,
  --    RST      => sys_rst,
  --    CLKFBIN  => pllout_stdc_fb,
  --    CLKIN    => clk_125m_pllref_i);

--  cmp_dds_ref_buf : BUFG
--    port map (
--      O => stdc_clkdiv8,
--      I => pllout_stdc_clkdiv8);

--  cmp_serdes_clk_buf : BUFPLL
--    generic map (
--      DIVIDE => 8)
--    port map (
--      PLLIN        => pllout_stdc_clk,  --  from PLL (CLKOUT0, CLKOUT1) 
--      GCLK         => stdc_clkdiv8,     --  from BUFG or GCLK
--      IOCLK        => stdc_serdes_clk,  --  Connects to IOSERDES2(CLK0),BUFIO2FB(I),or IODELAY2 IOCLK0, IOCLK1)
--      LOCK         => open,
--      LOCKED       => pllout_stdc_locked,   -- LOCKED signal from PLL
--      SERDESSTROBE => stdc_serdes_strobe);  --  used to drive IOSERDES2(IOCE)-
  end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.dds_wbgen2_pkg.all;
use work.gencores_pkg.all;
use work.genram_pkg.all;

library unisim;
use unisim.vcomponents.all;

entity wr_d3s_core is
  generic
    ( g_simulation : boolean := false;
      g_sim_pps_period: integer := 1000
    );
  
  port (

    -- Clocks & resets
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    clk_ref_i : in std_logic;
    clk_wr_o: out std_logic;

    -- Timing (WRC)
    tm_link_up_i         : in  std_logic := '1';
    tm_time_valid_i      : in  std_logic;
    tm_tai_i             : in  std_logic_vector(39 downto 0);
    tm_cycles_i          : in  std_logic_vector(27 downto 0);
    tm_clk_aux_lock_en_o : out std_logic;
    tm_clk_aux_locked_i  : in  std_logic;
    tm_dac_value_i       : in  std_logic_vector(23 downto 0);
    tm_dac_wr_i          : in  std_logic;

    -- DDS Dac I/F (Maxim)
    dac_n_o : out std_logic_vector(13 downto 0);
    dac_p_o : out std_logic_vector(13 downto 0);

    -- WR reference clock from FMC's PLL (AD9516)
    wr_ref_clk_n_i : in std_logic;
    wr_ref_clk_p_i : in std_logic;

    -- VCXO PLL clock output (cleaned DDS clock)
    pll_vcxo_clk_n_i : in std_logic;
    pll_vcxo_clk_p_i : in std_logic;

    -- System/WR PLL dedicated lines
    pll_sys_cs_n_o    : out std_logic;
    pll_sys_ld_i      : in  std_logic;
    pll_sys_reset_n_o : out std_logic;
    pll_sys_sync_n_o  : out std_logic;

    -- VCXO PLL dedicated lines
    pll_vcxo_cs_n_o   : out std_logic;
    pll_vcxo_sync_n_o : out std_logic;
    pll_vcxo_status_i : in  std_logic;

    -- SPI bus to both PLL chips
    pll_sclk_o : out   std_logic;
    pll_sdio_b : inout std_logic;
    pll_sdo_i  : in    std_logic;

    -- Phase Detector & ADC
    pd_lockdet_i : in    std_logic;
    pd_clk_o     : out   std_logic;
    pd_data_b    : inout std_logic;
    pd_le_o      : out   std_logic;

    adc_sdo_i : in  std_logic;
    adc_sck_o : out std_logic;
    adc_cnv_o : out std_logic;
    adc_sdi_o : out std_logic;

    -- Delay generator
    delay_d_o     : out std_logic_vector(9 downto 0);
    delay_fb_i    : in  std_logic;
    delay_len_o   : out std_logic;
    delay_pulse_o : out std_logic;

    -- Trigger input
    trig_p_i : in std_logic;
    trig_n_i : in std_logic;

    -- OneWire (ID & temp sensor)
    onewire_b : inout std_logic;

    -- WR mezzanine DAC
    wr_dac_sclk_o : out std_logic;
    wr_dac_din_o : out std_logic;
    wr_dac_sync_n_o : out std_logic;


    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out
    );

end wr_d3s_core;

architecture behavioral of wr_d3s_core is

  component dds_wb_slave is
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
      clk_ref_i  : in  std_logic;
      regs_i     : in  t_dds_in_registers;
      regs_o     : out t_dds_out_registers);
  end component dds_wb_slave;

  function resize(x : std_logic_vector; new_size : integer)
    return std_logic_vector is
    variable tmp : std_logic_vector(new_size-1 downto 0);
  begin
    
    if(new_size <= x'length) then
      tmp := x(new_size-1 downto 0);
    else
      tmp := std_logic_vector(to_unsigned(0, x'length-new_size)) & x;
    end if;

    return tmp;
  end function;


  component ad7980_if
    port (
      clk_i     : in  std_logic;
      rst_n_i   : in  std_logic;
      trig_i    : in  std_logic;
      d_o       : out std_logic_vector(15 downto 0);
      d_valid_o : out std_logic;
      adc_sdo_i : in  std_logic;
      adc_sck_o : out std_logic;
      adc_cnv_o : out std_logic;
      adc_sdi_o : out std_logic);
  end component;

  component max5870_serializer
    generic (
      sys_w : integer := 14;
      dev_w : integer := 56);
    port (
      DATA_OUT_FROM_DEVICE : in  std_logic_vector(dev_w-1 downto 0);
      DATA_OUT_TO_PINS_P   : out std_logic_vector(sys_w-1 downto 0);
      DATA_OUT_TO_PINS_N   : out std_logic_vector(sys_w-1 downto 0);
      CLK_IN               : in  std_logic;
      CLK_DIV_IN           : in  std_logic;
      LOCKED_IN            : in  std_logic;
      LOCKED_OUT           : out std_logic;
      CLK_RESET            : in  std_logic;
      IO_RESET             : in  std_logic);
  end component;

  component dds_quad_channel
    generic(
      g_acc_frac_bits : integer := 32;
      g_lut_size_log2 : integer := 10;
      g_output_bits   : integer := 14);
    port (
      clk_i       : in  std_logic;
      rst_n_i     : in  std_logic;
      acc_i       : in  std_logic_vector(g_lut_size_log2 + g_acc_frac_bits downto 0);
      acc_o       : out std_logic_vector(g_lut_size_log2 + g_acc_frac_bits downto 0);
      dreq_i      : in  std_logic;
      tune_i      : in  std_logic_vector(g_lut_size_log2 + g_acc_frac_bits downto 0);
      tune_load_i : in  std_logic;
      acc_load_i  : in  std_logic;

      y0_o : out std_logic_vector(g_output_bits-1 downto 0);
      y1_o : out std_logic_vector(g_output_bits-1 downto 0);
      y2_o : out std_logic_vector(g_output_bits-1 downto 0);
      y3_o : out std_logic_vector(g_output_bits-1 downto 0)
      );
  end component;

  component cic_1024x
    port (
      clk_i    : in  std_logic;
      en_i     : in  std_logic;
      rst_i    : in  std_logic;
      x_i      : in  std_logic_vector(17 downto 0);
      y_o      : out std_logic_vector(77 downto 0);
      ce_out_o : out std_logic);
  end component;

  signal dac_data_par : std_logic_vector(14 * 4 - 1 downto 0);


  signal synth_tune, synth_tune_d0, synth_tune_d1, synth_tune_bias, synth_acc_in, synth_acc_out : std_logic_vector(42 downto 0);
  signal synth_tune_load, synth_acc_load                                                        : std_logic;
  signal synth_y0, synth_y1, synth_y2, synth_y3                                                 : std_logic_vector(13 downto 0);

  signal regs_in : t_dds_in_registers;
  signal regs_out                                       : t_dds_out_registers;

  signal swrst, swrst_n, rst_n_ref, rst_ref : std_logic;

  signal slave_cic_rst                     : std_logic;
  signal cic_out                           : std_logic_vector(77 downto 0);
  signal slave_tune, cic_in, cic_out_clamp : std_logic_vector(17 downto 0);
  signal cic_ce                            : std_logic;

  function f_signed_multiply(a : std_logic_vector; b : std_logic_vector; shift : integer; output_length : integer)
    return std_logic_vector is
    variable mul    : signed(a'length + b'length downto 0);
    variable result : std_logic_vector(output_length-1 downto 0);
  begin
    mul    := signed(a) * signed('0' & b);
    result := std_logic_vector(resize(mul(mul'length-1 downto shift), output_length));
    return result;
  end f_signed_multiply;


  signal tune_empty_d0 : std_logic;

  signal adc_data   : std_logic_vector(15 downto 0);
  signal adc_dvalid : std_logic;

  signal mdsp_out : std_logic_vector(23 downto 0);
  signal pi_out   : std_logic_vector(15 downto 0);
  signal mdsp_in  : std_logic_vector(23 downto 0);

  function f_sign_extend(x : std_logic_vector; output_length : integer) return std_logic_vector is
    variable tmp : std_logic_vector(output_length-1 downto 0);
  begin
    tmp(x'length-1 downto 0)             := x;
    tmp(output_length-1 downto x'length) := (others => x(x'length-1));
    return tmp;
  end f_sign_extend;

  impure function f_pps_period return integer is
  begin
    if g_simulation then
      return g_sim_pps_period;
    else
      return 125000000;
    end if;
  end f_pps_period;

  -- 125 MHz WR Reference (from mezzanine's PLL)
  signal clk_wr_ref, clk_wr_ref_pllin            : std_logic;
  -- Cleaned up VCXO PLL output
  signal clk_dds_vcxo                            : std_logic;
  signal pllout_clk_fb_pllref, pllout_clk_wr_ref : std_logic;
  -- 500 MHz PHY serial clock for the DAC
  signal clk_dds_phy                             : std_logic;
  signal sample_p                                : std_logic;
  signal presc_counter                           : unsigned(7 downto 0);
  signal presc_tick                              : std_logic;

  signal sampling_div : unsigned(15 downto 0);

  signal wr_tai    : unsigned(31 downto 0);
  signal wr_cycles : unsigned(27 downto 0);

  -- PPS pre-delay line (5 - PPS-5 cycles, 0 = the actual PPS pulse)
  signal wr_pps_prepulse : std_logic_vector(5 downto 0);

  signal clk_dds_locked, fpll_reset : std_logic;
  signal trig_p_a: std_logic;
  
begin  -- behavioral

  U_Buf_CLK_WR_Ref : IBUFGDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_wr_ref_pllin,           -- Buffer output
      I  => wr_ref_clk_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => wr_ref_clk_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  U_Buf_CLK_VCXO : IBUFGDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_dds_vcxo,               -- Buffer output
      I  => pll_vcxo_clk_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => pll_vcxo_clk_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

    U_Buf_TRIG : IBUFDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => trig_p_a,               -- Buffer output
      I  => trig_p_i,
      IB => trig_n_i
      );

  cmp_dds_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 8,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 2,          -- 500 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 8,          -- 125 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKOUT2_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT2_PHASE      => 0.000,
      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 8.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_pllref,
      CLKOUT1  => pllout_clk_wr_ref,
      CLKOUT0  => clk_dds_phy,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => clk_dds_locked,
      RST      => fpll_reset,
      CLKFBIN  => pllout_clk_fb_pllref,
      CLKIN    => clk_wr_ref_pllin);

  cmp_dds_ref_buf : BUFG
    port map (
      O => clk_wr_ref,
      I => pllout_clk_wr_ref);

  clk_wr_o <= clk_wr_ref;
  
  U_Ref_Reset_SC : gc_sync_ffs
    port map (
      clk_i    => clk_wr_ref,
      rst_n_i  => '1',
      data_i   => swrst_n,
      synced_o => rst_n_ref);

  U_WB_Slave : dds_wb_slave
    port map (
      rst_n_i    => rst_n_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => slave_i.adr(5 downto 2),
      wb_dat_i   => slave_i.dat,
      wb_dat_o   => slave_o.dat,
      wb_cyc_i   => slave_i.cyc,
      wb_sel_i   => slave_i.sel,
      wb_stb_i   => slave_i.stb,
      wb_we_i    => slave_i.we,
      wb_ack_o   => slave_o.ack,
      wb_stall_o => slave_o.stall,
      clk_ref_i  => clk_wr_ref,
      regs_i     => regs_in,
      regs_o     => regs_out);

  slave_o.err <= '0';
  slave_o.rty <= '0';
  
  p_copy_wr_timing : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' then
        wr_cycles <= (others => '0');
        wr_tai <= (others => '0');
        wr_pps_prepulse <= (others => '0');
      else
        wr_cycles <= unsigned(tm_cycles_i);
        wr_tai    <= unsigned(tm_tai_i(31 downto 0));

        if(wr_cycles = f_pps_period - 4) then
          wr_pps_prepulse <= "100000";
        else
          wr_pps_prepulse <= '0' & wr_pps_prepulse(5 downto 1);
        end if;
      end if;
    end if;
  end process;


  p_sampling_prescaler : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' then
        presc_counter <= (others => '0');
        presc_tick    <= '0';
      else
        if(wr_pps_prepulse(2) = '1' or presc_counter = x"ff") then
          presc_counter <= (others => '0');
          presc_tick    <= '1';
        else
          presc_counter <= presc_counter + 1;
          presc_tick    <= '0';
        end if;
      end if;
    end if;
  end process;

  p_sampling_divider : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' or regs_out.cr_samp_en_o = '0' then
        sampling_div <= (others => '0');
        sample_p     <= '0';
      else
        if sampling_div = unsigned(regs_out.cr_samp_div_o) then
          sample_p     <= '1';
          sampling_div <= (others => '0');
        else
          sample_p     <= '0';
          sampling_div <= sampling_div + 1;
        end if;
      end if;
    end if;
  end process;

  U_ADC_Interface : ad7980_if
    port map (
      clk_i     => clk_wr_ref,
      trig_i    => sample_p,
      rst_n_i   => rst_n_ref,
      d_o       => adc_data,
      d_valid_o => adc_dvalid,
      adc_sdo_i => adc_sdo_i,
      adc_sck_o => adc_sck_o,
      adc_cnv_o => adc_cnv_o,
      adc_sdi_o => adc_sdi_o);

  p_latch_adc_data :process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref  = '0' then
        regs_in.pd_data_valid_i <= '0';
        regs_in.pd_data_data_i <= (others => '0');
      else
        if adc_dvalid = '1' then
          regs_in.pd_data_data_i <= adc_data;
          regs_in.pd_data_valid_i <= '1';
        elsif regs_out.pd_data_valid_o = '0' and regs_out.pd_data_valid_load_o = '1' then
          regs_in.pd_data_valid_i <= '0';
        end if;
      end if;
    end if;
  end process;

  U_DAC_Serializer : max5870_serializer
    port map (
      DATA_OUT_FROM_DEVICE => dac_data_par,
      DATA_OUT_TO_PINS_P   => dac_p_o,
      DATA_OUT_TO_PINS_N   => dac_n_o,
      CLK_IN               => clk_dds_phy,
      CLK_DIV_IN           => clk_wr_ref,
      LOCKED_IN            => clk_dds_locked,
      LOCKED_OUT           => open,
      CLK_RESET            => rst_ref,
      IO_RESET             => rst_ref);


  U_DDS_Synthesizer : dds_quad_channel
    generic map (
      g_acc_frac_bits => 32,
      g_lut_size_log2 => 10,
      g_output_bits   => 14)
    port map (
      clk_i       => clk_wr_ref,
      rst_n_i     => rst_n_ref,
      acc_i       => synth_acc_in,
      acc_o       => synth_acc_out,
      dreq_i      => '1',
      tune_i      => synth_tune,
      tune_load_i => synth_tune_load,
      acc_load_i  => synth_acc_load,
      y0_o        => synth_y0,
      y1_o        => synth_y1,
      y2_o        => synth_y2,
      y3_o        => synth_y3);

  
  U_Cic : cic_1024x
    port map (
      clk_i    => clk_wr_ref,
      en_i     => '1',
      rst_i    => slave_cic_rst,
      x_i      => cic_in,
      y_o      => cic_out,
      ce_out_o => cic_ce);


  U_WR_DAC: gc_serial_dac
    generic map (
      g_num_data_bits  => 16,
      g_num_extra_bits => 8,
      g_num_cs_select  => 1,
      g_sclk_polarity  => 0)
    port map (
      clk_i         => clk_sys_i,
      rst_n_i       => rst_n_i,
      value_i       => tm_dac_value_i(15 downto 0),
      cs_sel_i      => "1",
      load_i        => tm_dac_wr_i,
      sclk_divsel_i => "010",
      dac_cs_n_o(0)    => wr_dac_sync_n_o,
      dac_sclk_o    => wr_dac_sclk_o,
      dac_sdata_o   => wr_dac_din_o);
  
  slave_cic_rst <= rst_ref or sample_p;
  
  cic_in <= (others => '0');
  cic_out_clamp <= cic_out(cic_out'length-1 downto cic_out'length - cic_out_clamp'length);

  p_gen_tune : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if(rst_n_ref = '0') then
        synth_tune      <= (others => '0');
        synth_tune_d0   <= (others => '0');
        synth_tune_d1   <= (others => '0');
        synth_tune_bias <= (others => '0');
        synth_tune_load <= '0';
      else
        
        synth_tune_bias(31 downto 0)  <= regs_out.freq_lo_o;
        synth_tune_bias(42 downto 32) <= regs_out.freq_hi_o(10 downto 0);

        synth_tune    <= std_logic_vector(unsigned(synth_tune_bias) + unsigned(f_signed_multiply(cic_out_clamp, regs_out.gain_o, 0, synth_tune_bias'length)));
        synth_tune_d0 <= synth_tune;
        synth_tune_d1 <= synth_tune_d0;

        synth_tune_load <= '1';
        synth_acc_load  <= '0';
        dac_data_par    <= synth_y3 & synth_y2 & synth_y1 & synth_y0;
      end if;
    end if;
  end process;



  swrst        <= regs_out.rstr_sw_rst_o or (not rst_n_i);
--  swrst_o      <= swrst;
  swrst_n      <= not swrst;
  fpll_reset <= regs_out.rstr_pll_rst_o or (not rst_n_i);
  rst_ref      <= not rst_n_ref;


  pll_vcxo_cs_n_o     <= regs_out.gpior_pll_vcxo_cs_n_o;
  pll_vcxo_sync_n_o <= '1';

  pll_sys_cs_n_o    <= regs_out.gpior_pll_sys_cs_n_o;
  pll_sys_reset_n_o <= regs_out.gpior_pll_sys_reset_n_o;
  pll_sys_sync_n_o  <= '1';

  pll_sclk_o <= regs_out.gpior_pll_sclk_o;

  process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if regs_out.gpior_pll_sdio_load_o = '1' then
        pll_sdio_b <= regs_out.gpior_pll_sdio_o;
      end if;
    end if;
  end process;

  regs_in.gpior_pll_sdio_i <= pll_sdo_i;

--  pd_ce_o   <= regs_out.gpior_adf_ce_o;
  pd_clk_o  <= regs_out.gpior_adf_clk_o;
  pd_data_b <= regs_out.gpior_adf_data_o;
  pd_le_o   <= regs_out.gpior_adf_le_o;

  regs_in.tcr_wr_locked_i <= tm_clk_aux_locked_i;
  tm_clk_aux_lock_en_o <= regs_out.tcr_wr_lock_en_o;
  regs_in.tcr_wr_link_i <= tm_link_up_i;
  regs_in.tcr_wr_time_valid_i <= tm_time_valid_i;
  
end behavioral;

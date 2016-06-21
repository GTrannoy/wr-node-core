library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

use work.wishbone_pkg.all;
use work.dds_wbgen2_pkg.all;
use work.gencores_pkg.all;
use work.genram_pkg.all;

use work.stdc_wbgen2_pkg.all;

entity wr_d3s_core is
  generic
    (g_simulation     : boolean := false;
     g_sim_pps_period : integer := 125000
     );

  port (

    -- Clocks & resets
    clk_sys_i : in std_logic;           -- 62.5 MHz
    rst_n_i   : in std_logic;

    clk_125m_pllref_i : in  std_logic;
    clk_wr_o  : out std_logic;          -- aux clock for WR disciplining

    -- Timing (WRC)
    tm_link_up_i         : in  std_logic := '1';
    tm_time_valid_i      : in  std_logic;
    tm_tai_i             : in  std_logic_vector(39 downto 0);
    tm_cycles_i          : in  std_logic_vector(27 downto 0);
    tm_clk_aux_lock_en_o : out std_logic;
    tm_clk_aux_locked_i  : in  std_logic;
    tm_dac_value_i       : in  std_logic_vector(23 downto 0);
    tm_dac_wr_i          : in  std_logic;

-------------------------------------------------
-- Mezzanine I/F
-------------------------------------------------

    -- DDS Dac I/F (Maxim)
    dac_n_o : out std_logic_vector(13 downto 0);
    dac_p_o : out std_logic_vector(13 downto 0);

    -- WR reference clock from FMC's PLL (AD9516)
    wr_ref_clk_n_i : in std_logic;
    wr_ref_clk_p_i : in std_logic;

    -- DDS synthesizer output clock
    synth_clk_n_i : in std_logic;
    synth_clk_p_i : in std_logic;

    -- RF reference input clock (master side) or cleaned-up recovered
    -- clock (slave side, from AD9510)
    rf_clk_n_i : in std_logic;
    rf_clk_p_i : in std_logic;

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
    wr_dac_sclk_o   : out std_logic;
    wr_dac_din_o    : out std_logic;
    wr_dac_sync_n_o : out std_logic;


-------------------------------------------------
-- RF Counter I/F
-------------------------------------------------

    rf_counter_valid_o      : out std_logic;
    rf_counter_o            : out std_logic_vector(31 downto 0);
    rf_counter_overflow_p_o : out std_logic;

-------------------------------------------------
-- Core control
-------------------------------------------------


    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out;

    debug_o : out std_logic_vector(3 downto 0)
    );

end wr_d3s_core;

architecture behavioral of wr_d3s_core is

------------------------------------------
--        FUNCTIONS  
------------------------------------------

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
  
    function f_signed_multiply(a : std_logic_vector; b : std_logic_vector; shift : integer; output_length : integer)
    return std_logic_vector is
    variable mul    : signed(a'length + b'length downto 0);
    variable result : std_logic_vector(output_length-1 downto 0);
  begin
    mul    := signed(a) * signed('0' & b);
    result := std_logic_vector(resize(mul(mul'length-1 downto shift), output_length));
    return result;
  end f_signed_multiply;
  
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
------------------------------------------
--        COMPONENTS DECLARATION  
------------------------------------------

  component dds_wb_slave is
    port (
      rst_n_i    : in  std_logic;
      clk_sys_i  : in  std_logic;
      wb_adr_i   : in  std_logic_vector(4 downto 0);
      wb_dat_i   : in  std_logic_vector(31 downto 0);
      wb_dat_o   : out std_logic_vector(31 downto 0);
      wb_cyc_i   : in  std_logic;
      wb_sel_i   : in  std_logic_vector(3 downto 0);
      wb_stb_i   : in  std_logic;
      wb_we_i    : in  std_logic;
      wb_ack_o   : out std_logic;
      wb_stall_o : out std_logic;
      clk_dds_i  : in  std_logic;
      clk_ref_i  : in  std_logic;
      regs_i     : in  t_dds_in_registers;
      regs_o     : out t_dds_out_registers);
  end component dds_wb_slave;

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
      phase_adj_i : in  std_logic_vector(g_lut_size_log2 + g_acc_frac_bits downto 0);
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

  component stdc_hostif is
	 generic(D_DEPTH: positive);
	 port(
		-- system signals
		sys_rst_n_i: in std_logic;
		clk_sys_i  : in std_logic;
		clk_125m_i : in std_logic;
		
		-- SERDES
		serdes_clk_i   : in std_logic;
		serdes_strobe_i: in std_logic;
		
		-- Wishbone
		wb_addr_i: in std_logic_vector(31 downto 0);
		wb_data_i: in std_logic_vector(31 downto 0);
		wb_data_o: out std_logic_vector(31 downto 0);
		wb_cyc_i : in std_logic;
		wb_sel_i : in std_logic_vector(3 downto 0);
		wb_stb_i : in std_logic;
		wb_we_i  : in std_logic;
		wb_ack_o : out std_logic;
		wb_stall_o : out std_logic;
		
		-- TDC input
		signal_i: in std_logic;
		
		-- 125Mhz tick
		cycles_i: in std_logic_vector(27 downto 0);
		
		-- TDC outputs			
		strobe_o         : out    std_logic;
		stdc_data_o       : out    std_logic_vector(31 downto 0);
		
		-- ChipScope Signals
		TRIG_O			: out std_logic_vector(127 downto 0) );
  end component;

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
  
------------------------------------------
--        SIGNALS DECLARATIONS  
------------------------------------------
  signal dac_data_par : std_logic_vector(14 * 4 - 1 downto 0);

  signal synth_tune, synth_tune_d0, synth_tune_d1, synth_tune_bias, synth_acc_in, synth_acc_out, synth_phase_adj : std_logic_vector(42 downto 0);
  signal synth_tune_load, synth_acc_load                                                                         : std_logic;
  signal synth_y0, synth_y1, synth_y2, synth_y3                                                                  : std_logic_vector(13 downto 0);

  signal regs_in  : t_dds_in_registers;
  signal regs_out : t_dds_out_registers;

  signal swrst, swrst_n, rst_n_ref, rst_ref : std_logic;

  signal synth_acc_out_msb : std_logic_vector(7 downto 0);

  signal tune_empty_d0 : std_logic;

  signal adc_data   : std_logic_vector(15 downto 0);
  signal adc_dvalid : std_logic;

  -- 125 MHz WR Reference (from mezzanine's PLL)
  signal clk_wr_ref : std_logic;
  signal clk_wr_ref_pllin : std_logic;
  -- Cleaned up VCXO PLL output
  signal clk_dds_synth                : std_logic;
  signal clk_rf_in                    : std_logic;

  signal pllout_clk_fb_pllref : std_logic;
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
  signal trig_p_a                   : std_logic;
  signal pll_sdio_val               : std_logic;
  signal cic_out_clamp              : std_logic_vector(17 downto 0);

  signal clk_cc, clk_pll_cc : std_logic;

  --  Signals for stdc
  signal pllout_stdc_clk, stdc_serdes_clk, pllout_stdc_fb  : std_logic;    -- CLK for stdc serdes (1GHz)
  signal pllout_stdc_clkdiv8, stdc_clkdiv8, stdc_serdes_strobe : std_logic;	 -- SERDES strobe
  signal stdc_strobe: std_logic;
  signal stdc_data: std_logic_vector(31 downto 0);	
  signal clk_stdc_locked: std_logic; 
  
  signal CONTROL : std_logic_vector(35 downto 0);
  signal CLK     : std_logic;
  signal TRIG0   : std_logic_vector(31 downto 0);
  signal TRIG1   : std_logic_vector(31 downto 0);
  signal TRIG2   : std_logic_vector(31 downto 0);
  signal TRIG3   : std_logic_vector(31 downto 0);

  signal freq_gate_cntr : unsigned(31 downto 0);
  signal freq_gate      : std_logic;

  signal sample_idx         : unsigned(23 downto 0);
  signal load_acc_scheduled : std_logic;

  signal rf_counter                                  : unsigned(31 downto 0);
  signal rf_counter_load_dds, rf_counter_load_dds_d0 : std_logic;
  signal rf_counter_load_ref, rf_counter_load_ref_fb : std_logic;
  signal rf_cnt_trigger_cycles                       : std_logic_vector(27 downto 0);
  signal cnt_phase_safe                              : std_logic;

  type t_rf_counter_load_fsm_state is (IDLE, ARMED, TRIGGERED);
  type t_rf_counter_snap_fsm_state is (IDLE, WAIT_SAFE_PHASE);
  type t_rf_counter_snap_fsm_state2 is (IDLE, WAIT_SAMPLE);

  signal rf_counter_load_state : t_rf_counter_load_fsm_state;
  signal rf_counter_snap_state : t_rf_counter_snap_fsm_state;
  signal rf_counter_snap_state2 : t_rf_counter_snap_fsm_state2;

  signal trig_armed, trig_p : std_logic;
  signal dds_tmp            : std_logic;
  signal pulse_armed        : std_logic;
  signal wr_snapshot        : std_logic_vector(27 downto 0);
  signal rf_snapshot_tmp    : std_logic_vector(31 downto 0);
  
  signal wb_dds_i : t_wishbone_slave_in;
  signal wb_dds_o : t_wishbone_slave_out;
	 
  signal wb_stdc_i : t_wishbone_slave_in;
  signal wb_stdc_o : t_wishbone_slave_out;
	 
  constant c_slave_addr : t_wishbone_address_array(1 downto 0) :=
	( 	0 =>    x"00000000",
		1 =>    x"00001000"
	);
	 
  constant c_slave_mask : t_wishbone_address_array(1 downto 0) :=
	( 	0 =>    x"00001000",
		1 =>    x"00001000"	 );

begin  -- behavioral

  U_Buf_CLK_WR_Ref : IBUFDS -- IBUFGDS -- attempt E. calvo 16/6/2016
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_wr_ref_pllin,           -- Buffer output
      I  => wr_ref_clk_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => wr_ref_clk_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  U_Buf_CLK_RF : IBUFGDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_rf_in,                  -- Buffer output
      I  => rf_clk_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => rf_clk_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  U_Buf_CLK_DDS : IBUFGDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_dds_synth,              -- Buffer output
      I  => synth_clk_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => synth_clk_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  U_Buf_TRIG : IBUFDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => trig_p_a,                   -- Buffer output
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
--      CLKOUT0_DIVIDE     => 1,          -- 1000 MHz
--      CLKOUT0_PHASE      => 0.000,
--      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT0_DIVIDE     => 2,          -- 500 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
--      CLKOUT2_DIVIDE     => 8,          -- 125 MHz
--      CLKOUT2_PHASE      => 0.000,
--      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 6,          -- 166.67 MHz  --200 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 8.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_pllref,
--      CLKOUT0  => pllout_stdc_clk,
      CLKOUT0  => clk_dds_phy,
--      CLKOUT2  => pllout_stdc_clkdiv8,
      CLKOUT1  => clk_pll_cc,
      CLKOUT2  => open,
      CLKOUT3  => open,
		CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => clk_dds_locked,
      RST      => fpll_reset,
      CLKFBIN  => pllout_clk_fb_pllref,
      CLKIN    => clk_125m_pllref_i); -- clk_wr_ref_pllin);

  cmp_stdc_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 8,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 1,          -- 1000 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
--      CLKOUT1_DIVIDE     => 2,          -- 500 MHz
--      CLKOUT1_PHASE      => 0.000,
--      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 8,          -- 125 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
--      CLKOUT3_DIVIDE     => 6,          -- 166.67 MHz  --200 MHz
--      CLKOUT3_PHASE      => 0.000,
--      CLKOUT3_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 8.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_stdc_fb,
      CLKOUT0  => pllout_stdc_clk,
--      CLKOUT1  => clk_dds_phy,
      CLKOUT1  => pllout_stdc_clkdiv8,
--      CLKOUT3  => clk_pll_cc,
      CLKOUT2  => open,
      CLKOUT3  => open,
		CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => clk_stdc_locked,
      RST      => fpll_reset,
      CLKFBIN  => pllout_stdc_fb,
      CLKIN    => clk_125m_pllref_i); -- clk_wr_ref_pllin);

cmp_dds_ref_buf : BUFG
    port map (
      O => stdc_clkdiv8,
      I => pllout_stdc_clkdiv8); 
  
  cmp_serdes_clk_buf : BUFPLL
     generic map (
	   DIVIDE	=> 8)
	 port map (
      PLLIN			 => pllout_stdc_clk,     --  from PLL (CLKOUT0, CLKOUT1) 
      GCLK  		 => stdc_clkdiv8,        --  from BUFG or GCLK
      IOCLK 		 => stdc_serdes_clk,		 --  Connects to IOSERDES2(CLK0),BUFIO2FB(I),or IODELAY2 IOCLK0, IOCLK1)
      LOCK 			 => open,
	   LOCKED 		 => clk_stdc_locked,      -- LOCKED signal from PLL
	   SERDESSTROBE => stdc_serdes_strobe);  --  used to drive IOSERDES2(IOCE)
		
  --cmp_pulse_output_pll : PLL_BASE
  --  generic map (
  --    BANDWIDTH          => "OPTIMIZED",
  --    CLK_FEEDBACK       => "CLKFBOUT",
  --    COMPENSATION       => "INTERNAL",
  --    DIVCLK_DIVIDE      => 1,
  --    CLKFBOUT_MULT      => 16,
  --    CLKFBOUT_PHASE     => 0.000,
  --    CLKOUT0_DIVIDE     => 2,          -- 352 MHz -> PHY
  --    CLKOUT0_PHASE      => 0.000,
  --    CLKOUT0_DUTY_CYCLE => 0.500,
  --    CLKOUT1_DIVIDE     => 16,          -- 44 MHz
  --    CLKOUT1_PHASE      => 0.000,
  --    CLKOUT1_DUTY_CYCLE => 0.500,
  --    CLKOUT2_DIVIDE     => 16,         -- 62.5 MHz
  --    CLKOUT2_PHASE      => 0.000,
  --    CLKOUT2_DUTY_CYCLE => 0.500,
  --    CLKIN_PERIOD       => 20.0,
  --    REF_JITTER         => 0.016)
  --  port map (
  --    CLKFBOUT => pllout_clk_fb_ddsclk,
  --    CLKOUT0  => clk_dds_x8,
  --    CLKOUT1  => pllout_clk_dds,
  --    CLKOUT2  => open,
  --    CLKOUT3  => open,
  --    CLKOUT4  => open,
  --    CLKOUT5  => open,
  --    LOCKED   => clk_dds_locked,
  --    RST      => fpll_reset,
  --    CLKFBIN  => pllout_clk_fb_pllref,
  --    CLKIN    => clk_wr_ref_pllin);

  
  p_freq_meas_gating : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if swrst_n = '0' then
        freq_gate_cntr <= (others => '0');
        freq_gate      <= '0';
      else
        if(freq_gate_cntr = 0) then
          freq_gate_cntr <= unsigned(regs_out.freq_meas_gate_o);
          freq_gate      <= '1';
        else
          freq_gate_cntr <= freq_gate_cntr - 1;
          freq_gate      <= '0';
        end if;
      end if;
    end if;
  end process;


  U_Meas_RFInClk : gc_frequency_meter
    generic map (
      g_with_internal_timebase => false,
      g_clk_sys_freq           => 62500000,
      g_counter_bits           => 32)
    port map (
      clk_sys_i    => clk_sys_i,
      clk_in_i     => clk_rf_in,
      rst_n_i      => rst_n_i,
      pps_p1_i     => freq_gate,
      freq_o       => regs_in.freq_meas_rf_in_i,
      freq_valid_o => open);

  U_MeasDDSClk : gc_frequency_meter
    generic map (
      g_with_internal_timebase => false,
      g_clk_sys_freq           => 62500000,
      g_counter_bits           => 32)
    port map (
      clk_sys_i    => clk_sys_i,
      clk_in_i     => clk_dds_synth,
      rst_n_i      => rst_n_i,
      pps_p1_i     => freq_gate,
      freq_o       => regs_in.freq_meas_dds_i,
      freq_valid_o => open);


  regs_in.gpior_serdes_pll_locked_i <= clk_dds_locked;

  cmp_cc_buf : BUFG
    port map (
      O => clk_cc,
      I => clk_pll_cc);

  clk_wr_o <= clk_125m_pllref_i; -- clk_wr_ref;  -- Eva 2016/06/20

  U_Ref_Reset_SC : gc_sync_ffs
    port map (
      clk_i    => clk_125m_pllref_i, -- clk_wr_ref,  -- Eva 2016/06/20
      rst_n_i  => '1',
      data_i   => swrst_n,
      synced_o => rst_n_ref);

  U_WB_Slave : dds_wb_slave
    port map (
      rst_n_i    => rst_n_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => wb_dds_i.adr(6 downto 2),
      wb_dat_i   => wb_dds_i.dat,
      wb_dat_o   => wb_dds_o.dat,
      wb_cyc_i   => wb_dds_i.cyc,
      wb_sel_i   => wb_dds_i.sel,
      wb_stb_i   => wb_dds_i.stb,
      wb_we_i    => wb_dds_i.we,
      wb_ack_o   => wb_dds_o.ack,
      wb_stall_o => wb_dds_o.stall,
      clk_ref_i  => clk_125m_pllref_i, -- clk_wr_ref,  -- Eva 2016/06/20
      clk_dds_i  => clk_dds_synth,
      regs_i     => regs_in,
      regs_o     => regs_out);

  wb_dds_o.err <= '0';
  wb_dds_o.rty <= '0';

  	xwb_crossbar_1 : xwb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => 2,
      g_registered  => true,
      g_address     => c_slave_addr,
      g_mask        => c_slave_mask)
    port map (
      clk_sys_i   => clk_sys_i,
      rst_n_i     => rst_n_i,
      slave_i(0)  => slave_i,
      slave_o(0)  => slave_o,
      master_o(0) => wb_dds_i, 
      master_o(1) => wb_stdc_i,
		master_i(0) => wb_dds_o, 
		master_i(1) => wb_stdc_o  
		);
		
  cmp_stdc : stdc_hostif 
	 generic map (
		D_DEPTH   => 4)    -- Length of the fifo storing the event time stamps
	 port map(
		sys_rst_n_i			=>	rst_n_i,
		clk_sys_i			=>	clk_sys_i,       -- 62.5 MHz
		clk_125m_i			=> clk_125m_pllref_i, --clk_wr_ref,  -- Eva 2016/06/20
		serdes_clk_i		=>	stdc_serdes_clk,
		serdes_strobe_i	=>	stdc_serdes_strobe,
		wb_addr_i			=>	wb_stdc_i.adr,
		wb_data_i			=>	wb_stdc_i.dat,
		wb_data_o			=>	wb_stdc_o.dat,
		wb_cyc_i				=>	wb_stdc_i.cyc,
		wb_sel_i				=>	wb_stdc_i.sel,
		wb_stb_i				=>	wb_stdc_i.stb,
		wb_we_i				=>	wb_stdc_i.we,
		wb_ack_o				=>	wb_stdc_o.ack,
		wb_stall_o			=>	wb_stdc_o.stall,
		signal_i				=>	trig_p_a,
		cycles_i				=> tm_cycles_i,
		strobe_o          => stdc_strobe  ,
		stdc_data_o       => stdc_data  );	

  wb_stdc_o.err <= '0';
  wb_stdc_o.rty <= '0';
  
  p_copy_wr_timing : process(clk_wr_ref)  
  begin
	 if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' then
        wr_cycles       <= (others => '0');
        wr_tai          <= (others => '0');
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
        if(wr_pps_prepulse(5) = '1' or presc_counter = x"7c") then  -- divide by
                                                                    -- 125
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
        if(wr_pps_prepulse(4) = '1') then
          sample_p     <= '1';
          sampling_div <= (others => '0');
        elsif(presc_tick = '1') then
          if sampling_div = unsigned(regs_out.cr_samp_div_o) then
            sample_p     <= '1';
            sampling_div <= (others => '0');
          else
            sample_p     <= '0';
            sampling_div <= sampling_div + 1;
          end if;
        else
          sample_p <= '0';
        end if;
      end if;
      
    end if;
  end process;

  p_sample_counter : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' or regs_out.cr_samp_en_o = '0' then
        sample_idx <= (others => '0');
      else
        if wr_pps_prepulse(3) = '1' then
          sample_idx <= (others => '0');
        elsif sample_p = '1' then
          sample_idx <= sample_idx + 1;
        end if;
      end if;
    end if;
  end process;

  regs_in.sample_idx_i <= std_logic_vector(sample_idx);

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

  p_latch_adc_data : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' then
        regs_in.pd_data_valid_i <= '0';
        regs_in.pd_data_data_i  <= (others => '0');
      else
        if adc_dvalid = '1' then
          regs_in.pd_data_data_i  <= adc_data;
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
      phase_adj_i => synth_phase_adj,
      acc_o       => synth_acc_out,
      dreq_i      => '1',
      tune_i      => synth_tune,
      tune_load_i => synth_tune_load,
      acc_load_i  => synth_acc_load,
      y0_o        => synth_y0,
      y1_o        => synth_y1,
      y2_o        => synth_y2,
      y3_o        => synth_y3);

  U_WR_DAC : gc_serial_dac
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
      dac_cs_n_o(0) => wr_dac_sync_n_o,
      dac_sclk_o    => wr_dac_sclk_o,
      dac_sdata_o   => wr_dac_din_o);

  cic_out_clamp <= regs_out.tune_val_tune_o(17 downto 0);

  p_load_acc : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if(rst_n_ref = '0' or regs_out.cr_samp_en_o = '0') then
        load_acc_scheduled <= '0';
        synth_acc_load     <= '0';
      else
        if(regs_out.tune_val_load_acc_load_o = '1' and regs_out.tune_val_load_acc_o = '1') then
          load_acc_scheduled <= '1';
          synth_acc_load     <= '0';
        elsif (sample_p = '1' and load_acc_scheduled = '1')then
          load_acc_scheduled <= '0';
          synth_acc_load     <= '1';
          synth_acc_in       <= regs_out.acc_load_hi_o(10 downto 0) & regs_out.acc_load_lo_o;
        else
          synth_acc_load <= '0';
        end if;
      end if;
    end if;
  end process;
  regs_in.tune_val_load_acc_i <= load_acc_scheduled;

  p_gen_tune : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if(rst_n_ref = '0') then
        synth_tune      <= (others => '0');
        synth_tune_bias <= (others => '0');
        synth_tune_load <= '0';
      else
        
        synth_tune_bias(31 downto 0)  <= regs_out.freq_lo_o;
        synth_tune_bias(42 downto 32) <= regs_out.freq_hi_o(10 downto 0);

        synth_tune <= std_logic_vector(unsigned(synth_tune_bias) + unsigned(f_signed_multiply(cic_out_clamp, regs_out.gain_o, 0, synth_tune_bias'length)));

        synth_tune_load <= sample_p;
        dac_data_par    <= synth_y3 & synth_y2 & synth_y1 & synth_y0;

      end if;
    end if;
  end process;

  p_dds_adjust_phase : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' then
        synth_phase_adj <= (others => '0');
      else
        if (regs_out.phase_hi_update_o = '1') then
          synth_phase_adj(31 downto 0)  <= regs_out.phase_lo_o;
          synth_phase_adj(42 downto 32) <= regs_out.phase_hi_phase_hi_o;
        end if;
      end if;
    end if;
  end process;

  -- synth accumulator 'safe phase' comparator
  p_check_accu_phase : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      synth_acc_out_msb <= synth_acc_out (42 downto 35);
      if unsigned(regs_out.rf_rst_phase_lo_o) > unsigned(regs_out.rf_rst_phase_hi_o) then
        if unsigned (synth_acc_out_msb) >= unsigned(regs_out.rf_rst_phase_lo_o) or
          unsigned (synth_acc_out_msb) <= unsigned(regs_out.rf_rst_phase_hi_o) then
          cnt_phase_safe               <= '1';
        else
          cnt_phase_safe <= '0';
        end if;
      else
        if unsigned (synth_acc_out_msb) >= unsigned(regs_out.rf_rst_phase_lo_o) and
          unsigned (synth_acc_out_msb) <= unsigned(regs_out.rf_rst_phase_hi_o) then
          cnt_phase_safe               <= '1';
        else
          cnt_phase_safe <= '0';
        end if;
      end if;
    end if;
  end process;

  p_rf_trigger_reg : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if(cnt_phase_safe = '1') then
        rf_snapshot_tmp <= std_logic_vector(rf_counter);
      end if;


      if (regs_out.rf_cnt_trigger_cycles_load_o = '1') then
        rf_cnt_trigger_cycles <= regs_out.rf_cnt_trigger_cycles_o;
      end if;
    end if;
  end process;

  p_rf_counter_load : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' then
        rf_counter_load_state <= IDLE;
        rf_counter_load_ref   <= '0';
      else

        case (rf_counter_load_state) is
          when IDLE =>
            if(regs_out.rf_cnt_trigger_arm_load_o = '1') then
              rf_counter_load_state         <= ARMED;
              regs_in.rf_cnt_trigger_done_i <= '0';
              rf_counter_load_ref           <= '0';
            end if;

          when ARMED =>

            if(tm_cycles_i = rf_cnt_trigger_cycles) then
              rf_counter_load_ref   <= '1';
              rf_counter_load_state <= TRIGGERED;
            end if;

          when TRIGGERED =>
            if(rf_counter_load_ref_fb = '1') then
              regs_in.rf_cnt_trigger_done_i <= '1';
              rf_counter_load_ref           <= '0';
              rf_counter_load_state         <= IDLE;
            end if;
        end case;
        
      end if;
      
    end if;
  end process;

  p_rf_counter_snapshot : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' then
        rf_counter_snap_state <= IDLE;
      else

        case (rf_counter_snap_state) is
          when IDLE =>
            if(sample_p = '1') then
              rf_counter_snap_state <= WAIT_SAFE_PHASE;
            end if;

          when WAIT_SAFE_PHASE =>
            if(cnt_phase_safe = '1') then
              wr_snapshot                      <= std_logic_vector(wr_cycles);
              regs_in.rf_cnt_cycles_snapshot_i <= std_logic_vector(wr_cycles);
-- asynchronous, but safe (due to phase check)
              regs_in.rf_cnt_rf_snapshot_i     <= std_logic_vector(rf_counter);
              rf_counter_snap_state            <= IDLE;
            end if;
        end case;
      end if;
      
    end if;
  end process;

  p_rf_counter_snapshot2 : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if rst_n_ref = '0' then
        rf_counter_snap_state2 <= IDLE;
      else

        case (rf_counter_snap_state2) is
          when IDLE =>
            
            if(regs_out.rf_cnt_trigger_arm_sample_o = '1') then
              rf_counter_snap_state2               <= WAIT_SAMPLE;
              regs_in.rf_cnt_trigger_done_sample_i <= '0';
            end if;

          when WAIT_SAMPLE =>
            if(unsigned(wr_cycles) = unsigned(rf_cnt_trigger_cycles)) then
              regs_in.rf_cnt_trigger_done_sample_i <= '1';
              regs_in.rf_cnt_raw_i                 <= std_logic_vector(rf_counter);
              rf_counter_snap_state2                <= IDLE;
            end if;
        end case;
      end if;
      
    end if;
  end process;


  U_Sync_RFLoadFeedback : gc_sync_ffs
    port map (
      clk_i    => clk_wr_ref,
      rst_n_i  => '1',
      data_i   => rf_counter_load_dds_d0,
      ppulse_o => rf_counter_load_ref_fb);


  p_rf_counter : process(clk_dds_synth)
  begin
    if rising_edge(clk_dds_synth) then

      if(regs_out.cr_rf_cnt_enable_o = '0') then
        rf_counter <= (others => '0');
      else
        rf_counter_load_dds    <= rf_counter_load_ref;
        rf_counter_load_dds_d0 <= rf_counter_load_dds;
        if (rf_counter_load_dds = '1' and rf_counter_load_dds_d0 = '0') then
          rf_counter_overflow_p_o <= '0';
          debug_o(3)              <= '0';
          delay_pulse_o           <= '0';
          rf_counter              <= unsigned(regs_out.rf_cnt_sync_value_o);
        elsif (rf_counter = unsigned(regs_out.rf_cnt_period_o)) then
          rf_counter_overflow_p_o <= '1';
          debug_o(3)              <= '1';
          delay_pulse_o           <= '1';
          rf_counter              <= (others => '0');
        else
          rf_counter_overflow_p_o <= '0';
          debug_o(3)              <= '0';
          delay_pulse_o           <= '0';
          rf_counter              <= rf_counter + 1;
        end if;
      end if;
    end if;
  end process;

  trig0     <= std_logic_vector(rf_counter);
  trig1(0)  <= cnt_phase_safe;
  trig1(8)  <= rf_counter_load_ref;
  trig1(9)  <= rf_counter_load_dds;
  trig1(10) <= rf_counter_load_dds_d0;

  trig2(27 downto 0) <= wr_snapshot;
  trig3(31 downto 0) <= rf_snapshot_tmp;
  trig1(6 downto 1)  <= wr_pps_prepulse;


  p_latch_dds_accu : process(clk_wr_ref)
  begin
    if rising_edge(clk_wr_ref) then
      if(rst_n_ref = '0' or regs_out.cr_samp_en_o = '0') then
        regs_in.acc_snap_hi_i <= (others => '0');
        regs_in.acc_snap_lo_i <= (others => '0');
      else
        if(sample_p = '1') then
          regs_in.acc_snap_hi_i(10 downto 0) <= synth_acc_out(42 downto 32);
          regs_in.acc_snap_lo_i              <= synth_acc_out(31 downto 0);
        end if;
      end if;
    end if;
  end process;

  U_Sync_Trigger : gc_sync_ffs
    port map (
      clk_i    => clk_dds_synth,
      rst_n_i  => '1',
      data_i   => trig_p_a,
      ppulse_o => trig_p);

  p_trigger_snapshot : process(clk_dds_synth)
  begin
    if rising_edge(clk_dds_synth) then
      if(regs_out.trig_in_csr_arm_o = '1') then
        trig_armed                 <= '1';
        regs_in.trig_in_csr_done_i <= '0';
      elsif (trig_p = '1' and trig_armed = '1') then
        trig_armed                 <= '0';
        regs_in.trig_in_snapshot_i <= std_logic_vector(rf_counter);
        regs_in.trig_in_csr_done_i <= '1';
      end if;
      
    end if;
  end process;

  swrst      <= regs_out.rstr_sw_rst_o or (not rst_n_i);
--  swrst_o      <= swrst;
  swrst_n    <= not swrst;
  fpll_reset <= regs_out.rstr_pll_rst_o or (not rst_n_i);
  rst_ref    <= not rst_n_ref;


  pll_vcxo_cs_n_o   <= regs_out.gpior_pll_vcxo_cs_n_o;
  pll_vcxo_sync_n_o <= '1';

  pll_sys_cs_n_o    <= regs_out.gpior_pll_sys_cs_n_o;
  pll_sys_reset_n_o <= regs_out.gpior_pll_sys_reset_n_o;
  pll_sys_sync_n_o  <= '1';

  pll_sclk_o <= regs_out.gpior_pll_sclk_o;

  process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if regs_out.gpior_pll_sdio_load_o = '1' then
        pll_sdio_val             <= regs_out.gpior_pll_sdio_o;
        regs_in.gpior_pll_sdio_i <= pll_sdio_b;

      end if;
    end if;
  end process;

  pll_sdio_b <= pll_sdio_val when regs_out.gpior_pll_sdio_dir_o = '1' else 'Z';

--  pd_ce_o   <= regs_out.gpior_adf_ce_o;
  pd_clk_o  <= regs_out.gpior_adf_clk_o;
  pd_data_b <= regs_out.gpior_adf_data_o;
  pd_le_o   <= regs_out.gpior_adf_le_o;

  regs_in.tcr_wr_locked_i     <= tm_clk_aux_locked_i;
  tm_clk_aux_lock_en_o        <= regs_out.tcr_wr_lock_en_o;
  regs_in.tcr_wr_link_i       <= tm_link_up_i;
  regs_in.tcr_wr_time_valid_i <= tm_time_valid_i;


  --chipscope_ila_1 : chipscope_ila
  --  port map (
  --    CONTROL => CONTROL,
  --    CLK     => clk_cc,
  --    TRIG0   => TRIG0,
  --    TRIG1   => TRIG1,
  --    TRIG2   => TRIG2,
  --    TRIG3   => TRIG3);

  --chipscope_icon_1 : chipscope_icon
  --  port map (
  --    CONTROL0 => CONTROL);


  --trig0(27 downto 0) <= std_logic_vector(wr_cycles);
  --trig1(5 downto 0)  <= wr_pps_prepulse;
  --trig1(6)           <= sample_p;
  --trig1(7)           <= presc_tick;
  --trig2(23 downto 0) <= std_logic_vector(sample_idx);

  --debug_o(0) <= cnt_phase_safe;
  --debug_o(1) <= rf_counter_load_ref;
  --debug_o(2) <= rf_counter_load_dds;
--  debug_o(3) <= '0';

  rf_counter_o <= std_logic_vector(rf_counter);


  --gc_extend_pulse_1: gc_extend_pulse
  --  generic map (
  --    g_width => 10000)
  --  port map (
  --    clk_i      => clk_wr_ref,
  --    rst_n_i    => rst_n_ref,
  --    pulse_i    => sample_p,
  --    extended_o => debug_o(0));

  --gc_extend_pulse_2: gc_extend_pulse
  --  generic map (
  --    g_width => 10000)
  --  port map (
  --    clk_i      => clk_wr_ref,
  --    rst_n_i    => rst_n_ref,
  --    pulse_i    => rf_counter_load_ref,
  --    extended_o => debug_o(1));

  --gc_extend_pulse_3 : gc_extend_pulse
  --  generic map (
  --    g_width => 10000)
  --  port map (
  --    clk_i      => clk_wr_ref,
  --    rst_n_i    => rst_n_ref,
  --    pulse_i    => wr_pps_prepulse(5),
  --    extended_o => debug_o(2));

  --process(clk_dds_synth)
  --begin
  --  if rising_edge(clk_dds_synth) then
  --    dds_tmp <= not dds_tmp;
  --  end if;
  --end process;


  --debug_o(1)           <= dds_tmp;
--  regs_in.rf_cnt_raw_i <= std_logic_vector(rf_counter);

  delay_d_o   <= (others => '0');
  delay_len_o <= '1';


  p_pulse_gen : process(clk_dds_synth)
  begin
    if rising_edge(clk_dds_synth) then
      if(regs_out.pulse_out_csr_arm_o = '1') then
        pulse_armed                  <= '1';
        regs_in.pulse_out_csr_done_i <= '0';
        debug_o(0)                   <= '0';
      elsif (pulse_armed = '1' and unsigned(regs_out.pulse_out_cycles_o) = rf_counter) then
        pulse_armed                  <= '0';
        regs_in.pulse_out_csr_done_i <= '1';
        debug_o(0)                   <= '1';
      else
        debug_o(0) <= '0';
      end if;
      
    end if;
  end process;

  
end behavioral;

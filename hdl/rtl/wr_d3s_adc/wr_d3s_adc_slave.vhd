library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gencores_pkg.all;
use work.genram_pkg.all;
use work.wishbone_pkg.all;
use work.d3ss_wbgen2_pkg.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity wr_d3s_adc_slave is
  generic (
    g_clock_freq : integer := 125000000);
  port (
    rst_n_sys_i : in  std_logic;
    clk_sys_i   : in  std_logic;
    clk_wr_o    : out std_logic;
--    clk_125m_pllref_i : in std_logic;

    -- Timing (WRC)
    tm_link_up_i         : in  std_logic;
    tm_time_valid_i      : in  std_logic;
    tm_tai_i             : in  std_logic_vector(39 downto 0);
    tm_cycles_i          : in  std_logic_vector(27 downto 0);
    tm_clk_aux_lock_en_o : out std_logic;
    tm_clk_aux_locked_i  : in  std_logic;
    tm_dac_value_i       : in  std_logic_vector(23 downto 0);
    tm_dac_wr_i          : in  std_logic;

    -- WR reference clock from FMC's PLL (AD9516)
    wr_ref_clk_n_i : in std_logic;
    wr_ref_clk_p_i : in std_logic;

    -- Slave synthesized signal
    synth_n_i 	: in    std_logic; 
    synth_p_i 	: in    std_logic; 
		
    -- System/WR PLL dedicated lines
    pll_sys_cs_n_o    : out std_logic;
    pll_sys_ld_i      : in  std_logic;
    pll_sys_reset_n_o : out std_logic;
    pll_sys_sync_n_o  : out std_logic;

    -- VCXO PLL dedicated lines
    pll_vcxo_cs_n_o   : out std_logic;
    pll_vcxo_sync_n_o : out std_logic;
    pll_vcxo_status_i : in  std_logic;  --FIXME! : not connected

    -- SPI bus to both PLL chips
    pll_sclk_o : out   std_logic;
    pll_sdio_b : inout std_logic;
    pll_sdo_i  : in    std_logic;       --FIXME! : not connected

    -- DDS Dac I/F (Maxim)
    dac_n_o : out std_logic_vector(13 downto 0);
    dac_p_o : out std_logic_vector(13 downto 0);

    -- WR mezzanine DAC
    wr_dac_sclk_o   : out std_logic;
    wr_dac_din_o    : out std_logic;
    wr_dac_sync_n_o : out std_logic;

    -- WB interface
    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out;

    rev_clk_o : out std_logic  -- Revolution clock signal
    );
end wr_d3s_adc_slave;

architecture rtl of wr_d3s_adc_slave is

-----------------------------------------
--        COMPONENTs DECLARATION  
------------------------------------------ 
  component d3ss_adc_slave_wb is
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
      regs_i     : in  t_d3ss_in_registers;
      regs_o     : out t_d3ss_out_registers);
  end component d3ss_adc_slave_wb;

  component d3s_upsample_divide is
    port (

      clk_i   : in std_logic;
      rst_n_i : in std_logic;

      phase_i       : in std_logic_vector(13 downto 0);
      phase_valid_i : in std_logic;

      phase_divided_o       : out std_logic_vector(4*14-1 downto 0);
      phase_divided_valid_o : out std_logic;

      frev_ts_tai_i   : in  std_logic_vector(31 downto 0);
      frev_ts_nsec_i  : in  std_logic_vector(31 downto 0);
      frev_ts_valid_i : in  std_logic;
      frev_ts_ready_o : out std_logic;
      tm_time_valid_i : in  std_logic;
      tm_tai_i        : in  std_logic_vector(31 downto 0);
      tm_cycles_i     : in  std_logic_vector(27 downto 0)
      );

  end component d3s_upsample_divide;

  component d3s_phase_decoder is
    generic (
      g_clock_freq : integer := 125000000);
    port (
      clk_wr_i         : in  std_logic;
      rst_n_wr_i       : in  std_logic;
      r_enable_i       : in  std_logic;
      r_delay_coarse_i : in  std_logic_vector(15 downto 0);
      tm_time_valid_i  : in  std_logic;
      tm_tai_i         : in  std_logic_vector(39 downto 0);
      tm_cycles_i      : in  std_logic_vector(27 downto 0);
      fifo_payload_i   : in  std_logic_vector(31 downto 0);
      fifo_empty_i     : in  std_logic;
      fifo_rd_o        : out std_logic;
      phase_o          : out std_logic_vector(13 downto 0);
      phase_valid_o    : out std_logic);
  end component d3s_phase_decoder;

  component d3s_lut is
    port (

      clk_i   : in std_logic;
      rst_n_i : in std_logic;

      phase_divided_i : in std_logic_vector(4*14-1 downto 0);
      phase_valid_i   : in std_logic;

      dac_data_par_o : out std_logic_vector(4*14-1 downto 0)
      );
  end component d3s_lut;


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

  -- Trev generator component
  component TrevGen_Module 
    port(
        -- System signals
        rst_n_i    :  in std_logic;
        clk_sys_i  :  in std_logic;     -- 62.5MHz
        clk_125m_i : in std_logic;  -- 125MHz
        -- Trev module signals
        B_clk_i    :  in std_logic; 
        WRcyc_i    :  in unsigned(27 downto 0); 
        Rev_clk_o  :  out std_logic ;
        -- Wishbone interface
        wb_adr_i   :  in std_logic_vector(31 downto 0);
        wb_dat_i  :  in std_logic_vector(31 downto 0);
        wb_dat_o  :  out std_logic_vector(31 downto 0);
        wb_cyc_i   :  in std_logic;
        wb_sel_i   :  in std_logic_vector(3 downto 0);
        wb_stb_i   :  in std_logic;
        wb_we_i    :  in std_logic;
        wb_ack_o   :  out std_logic;
        wb_stall_o :  out std_logic );
  end component;
  
  
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

  constant c_CNX_MASTER_COUNT : integer := 2;

  constant c_cnx_base_addr : t_wishbone_address_array(c_CNX_MASTER_COUNT-1 downto 0) :=
    (0 => x"00000000",                       -- Base regs
     1 => x"00000100"                        -- Trev Generataor
	  );

  constant c_cnx_base_mask : t_wishbone_address_array(c_CNX_MASTER_COUNT-1 downto 0) :=
    (0 => x"00000700",
     1 => x"00000700"
	  );

  -- Wishbone slave(s)
   constant c_ADC_slave    	   : integer := 0;  -- d3s_adc_slave core
   constant c_SLAVE_TREVGEN    : integer := 1;  -- Trev generator
	
------------------------------------------
--        SIGNALS DECLARATION  
------------------------------------------

  signal clk_wr_ref, clk_wr_ref_pllin            : std_logic;
  signal pllout_clk_fb_pllref, pllout_clk_wr_ref : std_logic;
  signal clk_dds_phy                             : std_logic;
  signal synth_i				 : std_logic;

  signal regs_in  : t_d3ss_in_registers;
  signal regs_out : t_d3ss_out_registers;

  signal cnx_out       : t_wishbone_master_out_array(0 to c_CNX_MASTER_COUNT-1);
  signal cnx_in        : t_wishbone_master_in_array(0 to c_CNX_MASTER_COUNT-1);

  signal clk_wr           : std_logic;
  signal rst_n_wr, rst_wr : std_logic;
  signal fpll_reset       : std_logic;
  signal clk_dds_locked   : std_logic;

  subtype t_phase_vec is std_logic_vector(13 downto 0);
--  type t_phase_array is array(0 to 3) of t_phase_vec;

  signal phase_divided       : std_logic_vector(4*14-1 downto 0);
  signal phase_divided_valid : std_logic;

  signal phase_dec       : t_phase_vec;
  signal phase_dec_valid : std_logic;

  signal dac_data_par : std_logic_vector(4 * 14 - 1 downto 0);

  signal pll_sdio_val : std_logic;

begin

  fpll_reset <= regs_out.rstr_pll_rst_o or (not rst_n_sys_i);


  U_Buf_CLK_WR_Ref : IBUFGDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_wr_ref_pllin,           -- Buffer output
      I  => wr_ref_clk_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => wr_ref_clk_n_i   -- Diff_n buffer input (connect directly to top-level port)
      );
		
  U_Buf_Synth_clk : IBUFDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => synth_i,           -- Buffer output
      I  => synth_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => synth_n_i   -- Diff_n buffer input (connect directly to top-level port)
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
      CLKOUT2_DIVIDE     => 6,          -- 166 MHz
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

  regs_in.gpior_serdes_pll_locked_i <= clk_dds_locked;
  
  cmp_dds_ref_buf : BUFG
    port map (
      O => clk_wr,
      I => pllout_clk_wr_ref);

  U_Sync_Reset : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr,
      rst_n_i  => '1',
      data_i   => (not regs_out.rstr_pll_rst_o) and rst_n_sys_i and clk_dds_locked,
      synced_o => rst_n_wr);

  rst_wr <= not rst_n_wr;

--  U_Intercon : xwb_crossbar
--    generic map (
--      g_num_masters => 1,
--      g_num_slaves  => c_CNX_MASTER_COUNT,
--      g_registered  => true,
--      g_address     => c_cnx_base_addr,
--      g_mask        => c_cnx_base_mask)
--    port map (
--      clk_sys_i  => clk_sys_i,
--      rst_n_i    => rst_n_sys_i,
--      slave_i(0) => slave_i,
--      slave_o(0) => slave_o,
--      master_i   => cnx_in,
--      master_o   => cnx_out);


  U_CSR : d3ss_adc_slave_wb
    port map (
      rst_n_i    => rst_n_sys_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => slave_i.adr(5 downto 2),  -- cnx_out(c_ADC_slave).adr(4 downto 2),
      wb_dat_i   => slave_i.dat,        --cnx_out(c_ADC_slave).dat,
      wb_dat_o   => slave_o.dat,        --cnx_in(c_ADC_slave).dat,
      wb_cyc_i   => slave_i.cyc,        --cnx_out(c_ADC_slave).cyc,
      wb_sel_i   => slave_i.sel,        --cnx_out(c_ADC_slave).sel,
      wb_stb_i   => slave_i.stb,        --cnx_out(c_ADC_slave).stb,
      wb_we_i    => slave_i.we,         --cnx_out(c_ADC_slave).we,
      wb_ack_o   => slave_o.ack,        --cnx_in(c_ADC_slave).ack,
      wb_stall_o => slave_o.stall,      --cnx_in(c_ADC_slave).stall,
      clk_wr_i   => clk_wr,
      regs_i     => regs_in,
      regs_o     => regs_out);

  slave_o.err <= '0';
  slave_o.rty <= '0';
--  cnx_in(0).err <= '0';
--  cnx_in(0).rty <= '0';

  U_Phase_Dec : d3s_phase_decoder
    generic map (
      g_clock_freq => g_clock_freq)
    port map (
      clk_wr_i         => clk_wr,
      rst_n_wr_i       => rst_n_wr,
      r_enable_i       => regs_out.cr_enable_o,
      r_delay_coarse_i => regs_out.rec_delay_coarse_o,
      tm_time_valid_i  => tm_time_valid_i,
      tm_tai_i         => tm_tai_i,
      tm_cycles_i      => tm_cycles_i,
      fifo_payload_i   => regs_out.phfifo_payload_o,
      fifo_empty_i     => regs_out.phfifo_rd_empty_o,
      fifo_rd_o        => regs_in.phfifo_rd_req_i,
      phase_o          => phase_dec,
      phase_valid_o    => phase_dec_valid);

  U_Upsampler : d3s_upsample_divide
    port map (
      clk_i                 => clk_wr,
      rst_n_i               => rst_n_wr,
      phase_i               => phase_dec,
      phase_valid_i         => phase_dec_valid,
      phase_divided_o       => phase_divided,
      phase_divided_valid_o => phase_divided_valid,
      frev_ts_tai_i         => regs_out.frev_ts_sec_o,
      frev_ts_nsec_i        => regs_out.frev_ts_ns_o,
      frev_ts_valid_i       => regs_out.frev_cr_valid_o,
      frev_ts_ready_o       => regs_in.frev_cr_ready_i,
      tm_time_valid_i       => tm_time_valid_i,
      tm_tai_i              => tm_tai_i(31 downto 0),
      tm_cycles_i           => tm_cycles_i);

  -- todo: add fine delay stage

  
  U_LUT : d3s_lut
    port map (
      clk_i           => clk_wr,
      rst_n_i         => rst_n_wr,
      phase_divided_i => phase_divided,
      phase_valid_i   => phase_divided_valid,
      dac_data_par_o  => dac_data_par);


  U_DAC_Serializer : max5870_serializer
    port map (
      DATA_OUT_FROM_DEVICE => dac_data_par,
      DATA_OUT_TO_PINS_P   => dac_p_o,
      DATA_OUT_TO_PINS_N   => dac_n_o,
      CLK_IN               => clk_dds_phy,
      CLK_DIV_IN           => clk_wr,
      LOCKED_IN            => clk_dds_locked,
      LOCKED_OUT           => open,
      CLK_RESET            => rst_wr,
      IO_RESET             => rst_wr);

  -- Do I need this for DAC AD5662?
  U_WR_DAC : gc_serial_dac
    generic map (
      g_num_data_bits  => 16,
      g_num_extra_bits => 8,
      g_num_cs_select  => 1,
      g_sclk_polarity  => 0)
    port map (
      clk_i         => clk_sys_i,
      rst_n_i       => rst_n_wr,
      value_i       => tm_dac_value_i(15 downto 0),
      cs_sel_i      => "1",
      load_i        => tm_dac_wr_i,
      sclk_divsel_i => "010",
      dac_cs_n_o(0) => wr_dac_sync_n_o,
      dac_sclk_o    => wr_dac_sclk_o,
      dac_sdata_o   => wr_dac_din_o);

  -- PLL SYS signals were not connected... 
  pll_sys_cs_n_o    <= regs_out.gpior_pll_sys_cs_n_o;
  pll_sys_reset_n_o <= regs_out.gpior_pll_sys_reset_n_o;
  pll_sys_sync_n_o  <= '1';

  pll_sclk_o <= regs_out.gpior_pll_sclk_o;

  pll_vcxo_cs_n_o   <= regs_out.gpior_pll_vcxo_cs_n_o;
  pll_vcxo_sync_n_o <= '1';

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

  -- Driving timing signals
  regs_in.tcr_wr_link_i       <= tm_link_up_i;
  regs_in.tcr_wr_time_valid_i <= tm_time_valid_i;
  regs_in.tcr_wr_locked_i     <= tm_clk_aux_locked_i;

  tm_clk_aux_lock_en_o <= regs_out.tcr_wr_lock_en_o;

  clk_wr_o <= clk_wr;

  ----------------------------------------------
  --         T_REV GENERATOR MODULE
  -----------------------------------------------	

rev_clk_o <= '0';  -- To remove later

--  cmp_TrevGen: TrevGen_Module 
--    port map( rst_n_i    => rst_n_wr,
--              clk_sys_i  => clk_sys_i,          -- 62.5 MHz
--              clk_125m_i => clk_wr,
--              B_clk_i    => synth_i,
--              WRcyc_i    => unsigned(tm_cycles_i),
--              Rev_clk_o  => rev_clk_o,
--				  wb_adr_i   => cnx_out(c_SLAVE_TREVGEN).adr,  
--				  wb_dat_i   => cnx_out(c_SLAVE_TREVGEN).dat,
--				  wb_dat_o   => cnx_in(c_SLAVE_TREVGEN).dat,
--				  wb_cyc_i   => cnx_out(c_SLAVE_TREVGEN).cyc,
--				  wb_sel_i   => cnx_out(c_SLAVE_TREVGEN).sel,
--				  wb_stb_i   => cnx_out(c_SLAVE_TREVGEN).stb,
--				  wb_we_i    => cnx_out(c_SLAVE_TREVGEN).we,
--				  wb_ack_o   => cnx_in(c_SLAVE_TREVGEN).ack,
---				  wb_stall_o => cnx_in(c_SLAVE_TREVGEN).stall);
--		 
   --cnx_in(c_SLAVE_TREVGEN).err <= '0';
   --cnx_in(c_SLAVE_TREVGEN).rty <= '0';
  
end rtl;

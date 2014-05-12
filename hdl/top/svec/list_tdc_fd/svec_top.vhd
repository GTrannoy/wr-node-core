library ieee;
use ieee.std_logic_1164.all;

library work;
use work.wishbone_pkg.all;
use work.list_node_pkg.all;
use work.xvme64x_core_pkg.all;
use work.fine_delay_pkg.all;
use work.wrn_mqueue_pkg.all;
use work.wr_node_pkg.all;


entity svec_top is
  generic (
    g_simulation : integer := 0
    );

  port (
    rst_n_a_i : in std_logic;

    clk_20m_vcxo_i : in std_logic;      -- 20MHz VCXO clock

    clk_125m_pllref_p_i : in std_logic;  -- 125 MHz PLL reference
    clk_125m_pllref_n_i : in std_logic;

    clk_125m_gtp_p_i : in std_logic;    -- 125 MHz PLL reference
    clk_125m_gtp_n_i : in std_logic;

    -- SVEC Front panel LEDs

    fp_led_line_oen_o : out std_logic_vector(1 downto 0);
    fp_led_line_o     : out std_logic_vector(1 downto 0);
    fp_led_column_o   : out std_logic_vector(3 downto 0);

    fp_gpio1_a2b_o  : out std_logic;
    fp_gpio2_a2b_o  : out std_logic;
    fp_gpio34_a2b_o : out std_logic;

    fp_gpio1_b : out std_logic;
    fp_gpio2_b : out std_logic;
    fp_gpio3_b : out std_logic;
    fp_gpio4_b : out std_logic;

    dbg_led0_o : out std_logic;
    dbg_led1_o : out std_logic;
    dbg_led2_o : out std_logic;
    dbg_led3_o : out std_logic;

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





    fmc0_prsntm2c_n_i : in std_logic;
    fmc1_prsntm2c_n_i : in std_logic;

    fmc0_scl_b : inout std_logic;
    fmc0_sda_b : inout std_logic;

    fmc1_scl_b : inout std_logic;
    fmc1_sda_b : inout std_logic;

    tempid_dq_b : inout std_logic;

    uart_rxd_i : in  std_logic := '1';
    uart_txd_o : out std_logic
   -- put the FMC I/Os here
    );
end svec_top;

architecture rtl of svec_top is

  signal clk_sys : std_logic;
  signal rst_n   : std_logic;

  signal fmc0_wb_out, fmc1_wb_out : t_wishbone_master_out;
  signal fmc0_wb_in, fmc1_wb_in   : t_wishbone_master_in;


  constant c_hmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 4,
      out_slot_config => (
        0             => (16, 128),
        1             => (16, 128),
        2             => (16, 128),
        3             => (16, 128),
        others        => (0, 0)),

      in_slot_count  => 2,
      in_slot_config => (
        0            => (16, 128),
        1            => (16, 128),
        others       => (0, 0)
        )
      );

  
  constant c_rmq_config : t_wrn_mqueue_config :=
    (
      out_slot_count  => 1,
      out_slot_config => (
        0             => (16, 128),
        others        => (0, 0)),

      in_slot_count  => 1,
      in_slot_config => (
        0            => (16, 128),
        others       => (0, 0)
        )
      );

  constant c_node_config : t_wr_node_config :=
    (
      app_id       => x"115790de",
      cpu_count    => 2,
      cpu_memsizes => (32768, 32768, 0, 0, 0, 0, 0, 0),
      hmq_config   => c_hmq_config,
      rmq_config   => c_rmq_config
      );

begin




  U_Node_Template : svec_list_node_template
    generic map (
      g_fmc0_sdb       => c_FD_SDB_DEVICE,
      g_fmc1_sdb       => c_FD_SDB_DEVICE,
      g_simulation     => g_simulation,
      g_with_wr_phy    => 1,
      g_wr_node_config => c_node_config)
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
      fp_gpio1_a2b_o      => fp_gpio1_a2b_o,
      fp_gpio2_a2b_o      => fp_gpio2_a2b_o,
      fp_gpio34_a2b_o     => fp_gpio34_a2b_o,
      fp_gpio1_b          => fp_gpio1_b,
      fp_gpio2_b          => fp_gpio2_b,
      fp_gpio3_b          => fp_gpio3_b,
      fp_gpio4_b          => fp_gpio4_b,
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

      fmc0_prsntm2c_n_i      => fmc0_prsntm2c_n_i,
      fmc1_prsntm2c_n_i      => fmc1_prsntm2c_n_i,
      fmc0_scl_b             => fmc0_scl_b,
      fmc0_sda_b             => fmc0_sda_b,
      fmc1_scl_b             => fmc1_scl_b,
      fmc1_sda_b             => fmc1_sda_b,
      tempid_dq_b            => tempid_dq_b,
      uart_rxd_i             => uart_rxd_i,
      uart_txd_o             => uart_txd_o,
      fmc0_clk_aux_i         => '0',
      fmc0_clk_aux_lock_en_i => '0',
      fmc0_clk_aux_locked_o  => open,
      fmc0_wb_o              => fmc0_wb_out,
      fmc0_wb_i              => fmc0_wb_in,
      fmc0_irq_i             => '0',
      fmc1_clk_aux_i         => '0',
      fmc1_clk_aux_lock_en_i => '0',
      fmc1_clk_aux_locked_o  => open,
      fmc1_wb_o              => fmc1_wb_out,
      fmc1_wb_i              => fmc1_wb_in,
      fmc1_irq_i             => '0');

  fmc1_wb_in <= cc_dummy_master_in;
  --fmc0_wb_in <= cc_dummy_master_in;

  p_test_reg : process(clk_sys)
  begin
    if rising_edge(clk_sys) then
      if rst_n = '0' then
        dbg_led0_o <= '0';
      else
        fmc0_wb_in.ack <= fmc0_wb_out.stb and fmc0_wb_out.cyc;
        if(fmc0_wb_out.stb = '1' and fmc0_wb_out.cyc = '1') then
          dbg_led0_o     <= fmc0_wb_out.dat(0);
          dbg_led1_o     <= fmc0_wb_out.dat(1);
          dbg_led2_o     <= fmc0_wb_out.dat(2);
          dbg_led3_o     <= fmc0_wb_out.dat(3);
        end if;
      end if;
    end if;
  end process;

  fmc0_wb_in.err   <= '0';
  fmc0_wb_in.rty   <= '0';
  fmc0_wb_in.stall <= '0';


end rtl;




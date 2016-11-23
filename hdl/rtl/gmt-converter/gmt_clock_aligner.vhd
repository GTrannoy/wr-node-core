library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gmt_clock_aligner is
  generic (
    g_gmt_freq : integer := 40000000
    );

  port (
    clk_sys_i : in std_logic;
    clk_wr_i  : in std_logic;
    clk_gmt_i : in std_logic;

    rst_n_sys_i : in std_logic;

    tm_time_valid_i : in std_logic;
    locked_i        : in std_logic;

    tm_cycles_i : in std_logic_vector(27 downto 0);


    clk_gmt_aligned_o   : out std_logic; t
    tm_cycles_aligned_o : out std_logic_vector(27 downto 0);

    -- sys clock domain
    aligned_o : out std_logic
    );

end gmt_clock_aligner;

architecture rtl of gmt_clock_aligner is

  constant c_WR_CLOCK_FREQ : integer := 125000000;

  signal PSINCDEC, PSEN, PSDONE : std_logic;
  signal rst                    : std_logic;
  signal rst_n_wr, rst_n_gmt    : std_logic;
  signal clkfx                  : std_logic;

  signal pps_wr : std_logic;

  signal tm_cycles_gmt               : unsigned(27 downto 0);
  signal tm_cycles_gmt_reset_gmt     : std_logic;
  signal tm_cycles_gmt_reset_wr      : std_logic;
  signal locked_wr, tm_time_valid_wr : std_logic;
  signal aligned_wr                  : std_logic;
  type t_state is (UNALIGNED, LOAD_COUNTER, COMPARE_PHASE, WAIT_SHIFT, ALIGN_DONE);

  signal state : t_state;
  
begin


  U_Sync1 : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr_i,
      rst_n_i  => '1',
      data_i   => rst_n_sys_i,
      synced_o => rst_n_wr);

  U_Sync2 : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr_i,
      rst_n_i  => '1',
      data_i   => rst_n_sys_i,
      synced_o => rst_n_gmt);

  U_Sync3 : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr_i,
      rst_n_i  => rst_n_wr,
      data_i   => tm_time_valid_i,
      synced_o => tm_time_valid_wr);

  U_Sync4 : gc_sync_ffs
    generic map (
      g_sync_edge => "positive")
    port map (
      clk_i    => clk_wr_i,
      rst_n_i  => rst_n_wr,
      data_i   => locked_i,
      synced_o => locked_wr);

  U_DCM : DCM_SP
    generic map
    (CLKDV_DIVIDE       => 2.000,
     CLKFX_DIVIDE       => 2,
     CLKFX_MULTIPLY     => 2,
     CLKIN_DIVIDE_BY_2  => false,
     CLKIN_PERIOD       => 25.0,
     CLKOUT_PHASE_SHIFT => "VARIABLE",
     CLK_FEEDBACK       => "NONE",
     DESKEW_ADJUST      => "SYSTEM_SYNCHRONOUS",
     PHASE_SHIFT        => 0,
     STARTUP_WAIT       => false)
    port map
    -- Input clock
    (CLKIN    => clk_40m_i,
     CLKFB    => '0',
     -- Output clocks
     CLK0     => open,
     CLK90    => open,
     CLK180   => open,
     CLK270   => open,
     CLK2X    => open,
     CLK2X180 => open,
     CLKFX    => clkfx,
     CLKFX180 => open,
     CLKDV    => open,
     -- Ports for dynamic phase shift
     PSCLK    => clk_sys_i,
     PSEN     => psen,
     PSINCDEC => psincdec,
     PSDONE   => psdone,
-- Other control and status signals
     LOCKED   => locked_internal,
     STATUS   => open,
     RST      => rst,
     -- Unused pin, tie low
     DSSEN    => '0');

  locked_o <= locked_internal;



  -- Output buffering
  -------------------------------------
  -- no phase alignment active, connect to ground
  clkfb <= '0';


  clkout1_buf : BUFG
    port map
    (O => clk_gmt_aligned,
     I => clkfx);

  clk_gmt_aligned_o <= clk_gmt_aligned;


  U_Pulse_Sync : gc_pulse_synchronizer2
    port map (
      clk_in_i    => clk_wr_i,
      rst_in_n_i  => rst_n_wr,
      clk_out_i   => clk_gmt_aligned,
      rst_out_n_i => rst_n_gmt,
      d_ready_o   => tm_cycles_gmt_reset_done_wr,
      d_p_i       => tm_cycles_gmt_reset_wr,
      q_p_o       => tm_cycles_gmt_reset_gmt);

  
  p_time_counter_gmt : process(clk_gmt_aligned)
  begin
    if rising_edge(clk_gmt_aligned) then
      if rst_n_gmt = '0' then
        tm_cycles_gmt <= (others => '0');
      else
        if (tm_cycles_gmt_reset_gmt = '1') then
          tm_cycles_gmt <= (others => '0');
        elsif(tm_cycles_gmt = g_gmt_freq - 1) then
          tm_cycles_gmt <= (others => '0');
        else
          tm_cycles_gmt <= tm_cycles_gmt + 1;
        end if;
      end if;
    end if;
  end process;


  p_fsm : process(clk_wr_i)
  begin
    if rising_edge(clk_wr_i) then
      if rst_n_wr = '0' or locked_wr = '0' or tm_time_valid_wr = '0' then
        state      <= UNALIGNED;
        aligned_wr <= '0';
      else

        case state is
          when UNALIGNED =>
            if (locked_wr = '1' and tm_time_valid_wr = '1' and tm_cycles_wr = 0) then
              tm_cycles_gmt_reset_wr <= '1';
              state                  <= LOAD_COUNTER;
            end if;

          when LOAD_COUNTER =>
            tm_cycles_gmt_reset_wr <= '0';

            if (tm_cycles_gmt_reset_done_wr = '1') then
              state <= SAMPLE_PPS1;
            end if;
            

          when SAMPLE_PPS1 =>
            state <= SAMPLE_PPS2;
          when SAMPLE_PPS2 =>
            state <= SAMPLE_PPS3;
          when SAMPLE_PPS3 =>
            state <= SAMPLE_PPS4;
          when SAMPLE_PPS4 =>
            state <= COMPARE_PHASE;

          when COMPARE_PHASE =>
            
        end case;
        
      end if;
    end if;
  end process;
  
end rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gencores_pkg.all;
use work.genram_pkg.all;

entity d3s_phase_encoder is
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    adc_data_i : in std_logic_vector(13 downto 0);

    raw_phase_o : out std_logic_vector(15 downto 0);
    raw_hp_data_o : out std_logic_vector(15 downto 0);
    
    r_max_run_len_i : in std_logic_vector(15 downto 0);
    r_max_error_i : in std_logic_vector(22 downto 0);
    r_min_error_i : in std_logic_vector(22 downto 0);
    r_record_count_o : out std_logic_vector(31 downto 0);
    

    fifo_en_i : in std_logic;
    fifo_full_i  : in  std_logic;
    fifo_lost_o  : out std_logic;
    fifo_rl_o    : out std_logic_vector(15 downto 0);
    fifo_phase_o : out std_logic_vector(31 downto 0);
    fifo_tstamp_o : out std_logic_vector(27 downto 0);
    fifo_is_rl_o : out std_logic;
    fifo_we_o : out std_logic;
    
    tm_cycles_i : in std_logic_vector(27 downto 0)
    );

end d3s_phase_encoder;

architecture rtl of d3s_phase_encoder is

  component fir_compiler_v5_0 is
    port (
      clk  : in  std_logic;
      nd   : in  std_logic;
      rfd  : out std_logic;
      rdy  : out std_logic;
      din  : in  std_logic_vector(15 downto 0);
      dout : out std_logic_vector(15 downto 0));
  end component fir_compiler_v5_0;

  component cordic_v4_0 is
    port (
      x_in      : in  std_logic_vector(15 downto 0);
      y_in      : in  std_logic_vector(15 downto 0);
      nd        : in  std_logic;
      phase_out : out std_logic_vector(15 downto 0);
      rdy       : out std_logic;
      clk       : in  std_logic);
  end component cordic_v4_0;

  component gc_delay_line is
    generic (
      g_delay : integer;
      g_width : integer);
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      d_i     : in  std_logic_vector(g_width -1 downto 0);
      q_o     : out std_logic_vector(g_width -1 downto 0));
  end component gc_delay_line;

  component DcBlock is
    generic (
      data_width : integer;
      data_depth : integer);
    port (
      clk_i     : in  std_logic;
      rst_n_i   : in  std_logic;
      x_valid_i : in  std_logic;
      x_i       : in  std_logic_vector(data_width-1 downto 0);
      y_valid_o : out std_logic;
      y_o       : out std_logic_vector(data_width-1 downto 0));
  end component DcBlock;

  component gc_moving_average is
    generic (
      g_data_width : natural;
      g_avg_log2   : natural range 1 to 8);
    port (
      rst_n_i    : in  std_logic;
      clk_i      : in  std_logic;
      din_i      : in  std_logic_vector(g_data_width-1 downto 0);
      din_stb_i  : in  std_logic;
      dout_o     : out std_logic_vector(g_data_width+g_avg_log2-1 downto 0);
      dout_stb_o : out std_logic);
  end component gc_moving_average;

  component d3s_highpass_filter is
    generic (
      g_data_bits : integer;
      g_coef      : integer);
    port (
      clk_i   : in  std_logic;
      rst_n_i : in  std_logic;
      x_i     : in  std_logic_vector(g_data_bits-1 downto 0);
      y_o     : out std_logic_vector(g_data_bits-1 downto 0));
  end component d3s_highpass_filter;
  
  constant c_HILBERT_GROUP_DELAY : integer := 71 + 64;

  signal adc_i, adc_i_pre : std_logic_vector(15 downto 0);
  signal adc_q, adc_q_pre : std_logic_vector(15 downto 0);
  signal adc_phase        : std_logic_vector(15 downto 0);
  signal dummy            : std_logic_vector(7 downto 0);
  signal adc_dphase       : unsigned(15 downto 0);
  signal adc_phase_d0     : std_logic_vector(15 downto 0);
  signal flag             : std_logic;

  signal avg_lt, avg_lt_predelay, avg_lt_d                  : std_logic_vector(15+7 downto 0);
  signal avg_lt_valid            : std_logic;
  signal avg_st_predelay, avg_st, avg_st_d : std_logic_vector(15+3 downto 0);
  signal avg_st_valid            : std_logic;

  --signal avg_lt_trunc, avg_st_trunc : std_logic_vector(15 downto 0);

  type t_state is (STARTUP, IDLE, RL_SHORT, RL_LONG);

  signal rl_phase               : std_logic_vector(15 downto 0);
  signal rl_integ, rl_phase_ext : unsigned(22 downto 0);
  signal rl_length              : unsigned(15 downto 0);
  signal rl_state               : t_state;
  signal rl_cycles_start : std_logic_vector(27 downto 0);
  signal err_st : signed(22 downto 0);
  signal err_lt : signed(22 downto 0);
  signal err_lt_bound, err_st_bound : std_logic;

  signal adc_hp_out : std_logic_vector(15 downto 0);
  signal adc_data_reg : std_logic_vector(13 downto 0);
begin

  process(clk_i)
    begin
      if rising_edge(clk_i) then
        adc_data_reg <= adc_data_i;
      end if;
    end process;
  
  --U_DC_Cut: d3s_highpass_filter
  --  generic map (
  --    g_data_bits => 16,
  --    g_coef      => 255520)
  --  port map (
  --    clk_i   => clk_i,
  --    rst_n_i => rst_n_i,
  --    x_i     => (adc_data_reg & "00"),
  --    y_o     => adc_hp_out);

    DcBlock_1: DcBlock
      generic map (
        data_width => 16,
        data_depth => 256)
      port map (
        clk_i     => clk_i,
        rst_n_i   => rst_n_i,
        x_valid_i => '1',
        x_i     => (adc_data_reg(13) & adc_data_reg(13) & adc_data_reg ),
        y_valid_o => open,
        y_o     => adc_hp_out);
    
    raw_hp_data_o <= adc_hp_out;
    
  U_Hilbert_transformer : fir_compiler_v5_0
    port map (
      clk               => clk_i,
      nd                => '1',
      rfd               => open,
      rdy               => open,
      din               => adc_hp_out,
      dout(15 downto 0) => adc_q_pre
      );

  adc_q <= adc_q_pre;

  U_I_Delay : gc_delay_line
    generic map (
      g_delay => c_HILBERT_GROUP_DELAY,
      g_width => 16)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      d_i     => adc_hp_out,
      q_o     => adc_i_pre);

  adc_i <= adc_i_pre(15) & adc_i_pre(15) & adc_i_pre(15 downto 2);

  U_ArcTangent : cordic_v4_0
    port map (
      x_in      => adc_i,
      y_in      => adc_q,
      nd        => '1',
      phase_out => adc_phase,
      rdy       => open,
      clk       => clk_i);

raw_phase_o <= adc_phase;
  
  p_derivative : process(clk_i)
  begin
    if rising_edge(clk_i) then
      adc_phase_d0 <= adc_phase;

      if(signed(adc_phase_d0) < signed(adc_phase)) then
        adc_dphase <= unsigned(adc_phase) - unsigned(adc_phase_d0);
      else
        adc_dphase <= unsigned(adc_phase) - unsigned(adc_phase_d0) + to_unsigned (16384, 16);
      end if;
    end if;
  end process;

  U_Avg_LT : gc_moving_average          -- 128 taps LT average
    generic map (
      g_data_width => 16,
      g_avg_log2   => 7)
    port map (
      rst_n_i    => rst_n_i,
      clk_i      => clk_i,
      din_i      => std_logic_vector(adc_dphase),
      din_stb_i  => '1',
      dout_o     => avg_lt_predelay,
      dout_stb_o => avg_lt_valid);

  U_LT_Holdoff_Delay : gc_delay_line
    generic map (
      g_delay => 100,
      g_width => avg_lt'length)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      d_i     => avg_lt_predelay,
      q_o     => avg_lt);

  
  U_Avg_ST : gc_moving_average          -- 8 taps ST average
    generic map (
      g_data_width => 16,
      g_avg_log2   => 3)
    port map (
      rst_n_i    => rst_n_i,
      clk_i      => clk_i,
      din_i      => std_logic_vector(adc_dphase),
      din_stb_i  => '1',
      dout_o     => avg_st_predelay,
      dout_stb_o => avg_st_valid);

  U_ST_Delay : gc_delay_line
    generic map (
      g_delay => 128 - 8,
      g_width => avg_st'length)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      d_i     => avg_st_predelay,
      q_o     => avg_st);

  --avg_lt_trunc <= avg_lt (avg_lt'length-1 downto avg_lt'length-16);
  --avg_st_trunc <= avg_st (avg_st'length-1 downto avg_st'length-16);

  U_RunLen_Delay : gc_delay_line
    generic map (
      g_delay => 128,
      g_width => adc_phase'length)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      d_i     => adc_phase,
      q_o     => rl_phase);

  rl_phase_ext <= unsigned(rl_phase(13 downto 0) & "000000000");

  err_st <= signed(rl_phase_ext - rl_integ - unsigned(avg_st_d(avg_st'length-3 downto 0) & "000000"));
  err_lt <= signed(rl_phase_ext - rl_integ - unsigned(avg_lt_d(avg_lt'length-3 downto 0) & "00"));

  err_lt_bound <= '1' when err_lt > signed(r_min_error_i) and err_lt < signed(r_max_error_i) else '0';
  err_st_bound <= '1' when err_st > signed(r_min_error_i) and err_st < signed(r_max_error_i) else '0';
  
  
  p_compress_fsm : process (clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rl_state <= STARTUP;
        fifo_we_o <= '0';
      else

        
        case (rl_state) is
          when STARTUP =>
            rl_length <= (others => '0');
            rl_integ  <= rl_phase_ext;
            if(fifo_en_i = '1') then
              rl_state  <= IDLE;
            end if;
          when IDLE =>
            
--            fifo_we_o <= '0';
            fifo_tstamp_o <= tm_cycles_i;
            rl_cycles_start <= std_logic_vector(unsigned(tm_cycles_i) + 1);
            fifo_we_o <= fifo_en_i;
            fifo_is_rl_o <= '0';
            fifo_phase_o <= std_logic_vector(resize(rl_phase_ext,32));
            avg_st_d <= avg_st;
            avg_lt_d <= avg_lt;

            if (err_st_bound = '1') then
              rl_length <= rl_length + 1;
              rl_state  <= RL_SHORT;
              rl_integ  <= rl_integ + unsigned(avg_st_d(avg_st'length-3 downto 0) & "000000");
            elsif (err_lt_bound = '1') then
              rl_length <= rl_length + 1;
              rl_state  <= RL_LONG;
              rl_integ  <= rl_integ + unsigned(avg_lt_d(avg_lt'length-3 downto 0) & "00");
            else
              rl_length <= (others => '0');
              rl_state  <= IDLE;
              rl_integ  <= rl_phase_ext;
            end if;
            
          when RL_SHORT =>
            fifo_we_o <= '0';

            if (err_st_bound = '1' and rl_length < unsigned(r_max_run_len_i)) then
              rl_length <= rl_length + 1;
              rl_state  <= RL_SHORT;
              rl_integ  <= rl_integ + unsigned(avg_st_d(avg_st'length-3 downto 0) & "000000");
            else
              fifo_we_o <= fifo_en_i;
              fifo_is_rl_o <= '1';
              fifo_phase_o <= std_logic_vector(resize(unsigned(avg_st_d(avg_st'length-3 downto 0) & "000000"),32));
              fifo_rl_o <= std_logic_vector(rl_length);
              fifo_tstamp_o <= rl_cycles_start;
              
              rl_length <= (others => '0');
              rl_state  <= IDLE;
              rl_integ  <= rl_phase_ext;
              
            end if;

          when RL_LONG =>
            fifo_we_o <= '0';

            if (err_lt_bound = '1' and rl_length < unsigned(r_max_run_len_i)) then
              rl_length <= rl_length + 1;
              rl_state  <= RL_LONG;
              rl_integ  <= rl_integ + unsigned(avg_lt_d(avg_lt'length-3 downto 0) & "00");
            else
              fifo_we_o <= fifo_en_i;
              fifo_is_rl_o <= '1';
              fifo_phase_o <= std_logic_vector(resize(unsigned(avg_lt_d(avg_lt'length-3 downto 0) & "00"),32));
              fifo_rl_o <= std_logic_vector(rl_length);
              fifo_tstamp_o <= rl_cycles_start;

              rl_state  <= IDLE;
              rl_length <= (others => '0');
              rl_integ  <= rl_phase_ext;
            end if
;
        end case;
      end if;
    end if;
  end process;



end rtl;

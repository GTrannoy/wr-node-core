library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.genram_pkg.all;
use work.wishbone_pkg.all;

entity d3s_phase_decoder is
  generic (
    g_clock_freq : integer := 125000000
    );
  port (
    clk_wr_i : in std_logic;

    rst_n_wr_i : in std_logic;

    -- Control regs (clk_wr domain)
    r_enable_i       : in std_logic;
    r_delay_coarse_i : in std_logic_vector(15 downto 0);

    tm_time_valid_i : in std_logic;
    tm_tai_i        : in std_logic_vector(39 downto 0);
    tm_cycles_i     : in std_logic_vector(27 downto 0);

    -- FIFO I/F (clk_wr domain)
    fifo_phase_i  : in  std_logic_vector(31 downto 0);
    fifo_rl_i     : in  std_logic_vector(15 downto 0);
    fifo_is_rl_i  : in  std_logic;
    fifo_tstamp_i : in  std_logic_vector(27 downto 0);
    fifo_empty_i  : in  std_logic;
    fifo_rd_o     : out std_logic;

    -- Decompressed phase (clk_wr domain)
    phase_o       : out std_logic_vector(13 downto 0);
    phase_valid_o : out std_logic
    );


end d3s_phase_decoder;

architecture behavioral of d3s_phase_decoder is
  type t_state is (WAIT_FIXUP, IDLE, RUN_LENGTH);

  signal phase_integ : unsigned(22 downto 0);
  signal dphase      : unsigned(22 downto 0);
  signal rl_count    : unsigned(15 downto 0);

  signal cyc_adjusted : unsigned(27 downto 0);



  signal s2_valid_comb : std_logic;
  signal s2_valid      : std_logic;
  signal s2_phase      : unsigned(31 downto 0);
  signal s2_is_rl      : std_logic;
  signal s2_tstamp     : unsigned(27 downto 0);
  signal s2_rl         : unsigned(15 downto 0);
  signal s3_ts_match   : std_logic;



  signal s3_valid  : std_logic;
  signal s3_phase  : unsigned(31 downto 0);
  signal s3_dphase : unsigned(31 downto 0);
  signal s3_count  : unsigned(15 downto 0);

  signal s3_state : t_state;

  signal s1_phase           : unsigned(31 downto 0);
  signal s1_is_rl           : std_logic;
  signal s1_valid           : std_logic;
  signal s1_tstamp          : unsigned(27 downto 0);
  signal s1_rl              : unsigned(15 downto 0);
  signal fifo_rd, fifo_rd_d : std_logic;
  signal stall              : std_logic;

  function f_time_in_advance(t1 : unsigned; t2 : unsigned) return boolean is
  begin
    if t1 >= t2 then
      return true;
    elsif t2 > g_clock_freq * 7/8 and t1 < g_clock_freq / 8 then
      return true;
    else
      return false;
    end if;
  end function;

  function f_normalize_timestamp (t : unsigned) return unsigned is
  begin
    if (t >= g_clock_freq) then
      return t - g_clock_freq;
    else
      return t;
    end if;
    
  end function;
  

  
begin


  p_stage1 : process(clk_wr_i)
  begin
    if rising_edge(clk_wr_i) then
      if rst_n_wr_i = '0' then
        s1_valid <= '0';
      else

        fifo_rd_d <= fifo_rd;

        if (fifo_rd_d = '1') then
          s1_phase <= unsigned(fifo_phase_i);

          s1_tstamp <= f_normalize_timestamp(unsigned(fifo_tstamp_i) + unsigned(r_delay_coarse_i));
          s1_is_rl  <= fifo_is_rl_i;
          s1_rl     <= unsigned(fifo_rl_i);
          s1_valid  <= '1';
        elsif (stall = '0') then
          s1_valid <= '0';
        end if;
        

      end if;
    end if;
  end process;

  s2_valid_comb <= '1' when f_time_in_advance(s1_tstamp, unsigned(tm_cycles_i)) else '0';

  p_stage2 : process(clk_wr_i)
  begin
    if rising_edge(clk_wr_i) then
      if rst_n_wr_i = '0' then
        s2_valid <= '0';
      else
        if stall = '0' then
          if s1_valid = '1' then
            -- fixme: condition for overflow
            
            s2_is_rl  <= s1_is_rl;
            s2_rl     <= s1_rl;
            s2_phase  <= s1_phase;
            s2_tstamp <= s1_tstamp;
            s2_valid  <= s2_valid_comb;
          else
            s2_valid <= '0';
          end if;
        end if;
      end if;
    end if;
  end process;

  s3_ts_match <= '1' when s2_tstamp = unsigned(tm_cycles_i) else '0';

  p_stage3 : process(clk_wr_i)
  begin
    if rising_edge(clk_wr_i) then
      if rst_n_wr_i = '0' or r_enable_i = '0' then
        s3_state <= WAIT_FIXUP;
      elsif s2_valid = '1' then
        case s3_state is
          when WAIT_FIXUP =>
            if s2_valid = '1' and s2_is_rl = '0' then
              s3_phase <= s2_phase;
              s3_state <= IDLE;
            end if;

          when IDLE =>
            if s2_valid = '1' and s3_ts_match = '1' then
              if s2_is_rl = '0' then
                s3_phase <= s2_phase;
              else
                s3_phase <= s3_phase + s2_phase;
                s3_count <= s2_rl;
                s3_state <= RUN_LENGTH;
              end if;
            end if;

          when RUN_LENGTH =>
            if s3_count = 1 then
              s3_state <= IDLE;
              s3_phase <= s3_phase + s2_phase;
              s3_count <= s3_count - 1;
            end if;
        end case;
      end if;
    end if;
  end process;

  p_stall : process(s3_state, s1_valid, s2_valid, s2_valid_comb)
  begin
    if s1_valid = '1' and s2_valid_comb = '0' then
      stall <= '0';
    else
      case s3_state is
        when WAIT_FIXUP =>
          stall <= '0';
        when IDLE =>
          if (s2_is_rl = '1' and s2_valid = '1') then
            stall <= '1';
          else
            stall <= '0';
          end if;
        when RUN_LENGTH =>
          if s3_count = 1 then
            stall <= '0';
          else
            stall <= '1';
          end if;
      end case;
    end if;
    
  end process;

  fifo_rd   <= r_enable_i and (not fifo_empty_i) and (not stall);
  fifo_rd_o <= fifo_rd;


end behavioral;




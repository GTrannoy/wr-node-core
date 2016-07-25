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




  signal s2_valid_comb           : std_logic;
  signal s2_valid                : std_logic;
  signal s2_phase                : unsigned(31 downto 0);
  signal s2_is_rl                : std_logic;
  signal s2_tstamp               : unsigned(27 downto 0);
  signal s2_rl                   : unsigned(15 downto 0);
  signal s3_ts_match, s3_ts_miss : std_logic;

  
  signal s3_valid  : std_logic;
  signal s3_phase  : unsigned(22 downto 0);
  signal s3_dphase : unsigned(22 downto 0);
  signal s3_count  : unsigned(15 downto 0);

  signal s3_state : t_state;

  signal s1_phase               : unsigned(31 downto 0);
  signal s1_is_rl               : std_logic;
  signal s1_valid               : std_logic;
  signal s1_tstamp              : unsigned(27 downto 0);
  signal s1_rl                  : unsigned(15 downto 0);
  signal fifo_rd, fifo_rd_d     : std_logic;
  signal stall                  : std_logic;
  signal got_fixup              : std_logic;
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


  signal tm_cycles_adj0, tm_cycles_adj1 : unsigned(27 downto 0);
  
begin

  

  p_stage1 : process(clk_wr_i)
  begin
    if rising_edge(clk_wr_i) then
      if rst_n_wr_i = '0' then
      --s1_valid <= '0';
      else
        
        tm_cycles_adj0 <= unsigned(tm_cycles_i) - unsigned(r_delay_coarse_i);

        if(tm_cycles_adj0(27) = '1') then
          tm_cycles_adj1 <= tm_cycles_adj0 + to_unsigned(g_clock_freq, 28);
        else
          tm_cycles_adj1 <= tm_cycles_adj0;
        end if;


        if(stall = '0') then
          fifo_rd_d <= '1';

          if (fifo_rd_d = '1') then
            --s1_phase <= unsigned(fifo_phase_i);

          --s1_tstamp <= f_normalize_timestamp(unsigned(fifo_tstamp_i) + unsigned(r_delay_coarse_i));
          --s1_is_rl  <= fifo_is_rl_i;
          --s1_rl     <= unsigned(fifo_rl_i);
          --s1_valid  <= '1';
          end if;
        end if;

      end if;
    end if;
  end process;



  process(fifo_tstamp_i, tm_cycles_adj1)
  begin
    if unsigned(fifo_tstamp_i) < tm_cycles_adj1 and not (unsigned(fifo_tstamp_i) < g_clock_freq*1/8 and tm_cycles_adj1 > g_clock_freq*7/8) then
      s3_ts_miss <= '1';
    else
      s3_ts_miss <= '0';
    end if;
    if unsigned(fifo_tstamp_i) = tm_cycles_adj1 then
      s3_ts_match <= '1';
    else
      s3_ts_match <= '0';
    end if;
  end process;

  p_stage3 : process(clk_wr_i)
  begin
    if rising_edge(clk_wr_i) then
      if rst_n_wr_i = '0' or r_enable_i = '0' then
        s3_state  <= IDLE;
        s3_phase <= (others => '0');
        s3_valid <= '0';
        got_fixup <= '0';
      else
        case s3_state is

          when IDLE =>
            if(fifo_rd_d = '1') then
              if (s3_ts_miss = '1') then
                s3_state <= IDLE;
              elsif (s3_ts_match = '1') then

                if fifo_is_rl_i = '0' then
                  s3_phase  <= unsigned(fifo_phase_i(22 downto 0));
                  s3_valid <= '1';
--                  got_fixup <= '1';
                else
  --                if (got_fixup = '1') then
                    s3_phase <= s3_phase + unsigned(fifo_phase_i(22 downto 0));
                    s3_dphase <= unsigned(fifo_phase_i(22 downto 0));
                    s3_count <= unsigned(fifo_rl_i);
                    if unsigned(fifo_rl_i) /= 1 then
                      s3_state <= RUN_LENGTH;
                    end if;
    --              end if;
                end if;
              end if;
            end if;


          when RUN_LENGTH =>
            if s3_count = 2 then
              s3_state <= IDLE;
            end if;
            s3_phase <= s3_phase + s3_dphase;
            s3_count <= s3_count - 1;

          when WAIT_FIXUP => null;

        end case;
      end if;
    end if;
  end process;

  p_stall : process(got_fixup, s3_ts_match, s3_ts_miss, fifo_rd_d, fifo_is_rl_i, s3_state, s1_valid, s2_valid, s2_valid_comb, s3_count)
  begin
    if s1_valid = '1' and s2_valid_comb = '0' then
      stall <= '0';
    else
      case s3_state is
        when WAIT_FIXUP =>
          stall <= '0';
        when IDLE =>
          if (s3_ts_miss = '0' and s3_ts_match = '0' and fifo_rd_d = '1') then
            stall <= '1';
          elsif (fifo_is_rl_i = '1' and s3_ts_match = '1' and unsigned(fifo_rl_i) /= 1 )  then
            stall <= '1';
          else
            stall <= '0';
          end if;
        when RUN_LENGTH =>
          if s3_count = 2 then
            stall <= '0';
          else
            stall <= '1';
          end if;
      end case;
    end if;
    
  end process;

  fifo_rd   <= r_enable_i and (not fifo_empty_i) and (not stall);
  fifo_rd_o <= fifo_rd;


  phase_o <= std_logic_vector(s3_phase(22 downto 22 - 13));
  phase_valid_o <= s3_valid;
  
end behavioral;




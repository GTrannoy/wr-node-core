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

    raw_phase_o   : out std_logic_vector(15 downto 0);
    raw_hp_data_o : out std_logic_vector(15 downto 0);

    r_max_run_len_i  : in  std_logic_vector(15 downto 0);
    lt_max_error_i   : in  std_logic_vector(22 downto 0);
    lt_min_error_i   : in  std_logic_vector(22 downto 0);
    st_max_error_i   : in  std_logic_vector(22 downto 0);
    st_min_error_i   : in  std_logic_vector(22 downto 0);
    r_record_count_o : out std_logic_vector(31 downto 0);


    fifo_en_i   : in  std_logic;
    fifo_full_i : in  std_logic;  
    fifo_lost_o : out std_logic;  

    fifo_payload_o : out std_logic_vector(31 downto 0);

    fifo_we_o : out std_logic;

    tm_cycles_i : in std_logic_vector(27 downto 0);

    cnt_fixed_o : out std_logic_vector(31 downto 0);
    lt_cnt_rl_o : out std_logic_vector(31 downto 0);
    st_cnt_rl_o : out std_logic_vector(31 downto 0);
    cnt_ts_o    : out std_logic_vector(31 downto 0)
    );

end d3s_phase_encoder;

architecture rtl of d3s_phase_encoder is

------------------------------------------
--        COMPONENTs DECLARATION  
------------------------------------------ 

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
  --        CONSTANTS DECLARATION  
  ------------------------------------------
  constant c_HILBERT_GROUP_DELAY     : integer := 71 + 64;
  constant c_TIMESTAMP_REPORT_PERIOD : integer := 10000;

  ------------------------------------------
  --        SIGNALS DECLARATION  
  ------------------------------------------
  
  type t_state is (STARTUP, IDLE, RL_SHORT, RL_LONG);
  
  type t_comp_record is record
    valid   : std_logic;
    payload : std_logic_vector(31 downto 0);
  end record;
  
  signal adc_i, adc_i_pre : std_logic_vector(15 downto 0);
  signal adc_q, adc_q_pre : std_logic_vector(15 downto 0);
  signal adc_phase        : std_logic_vector(15 downto 0);
  signal dummy            : std_logic_vector(7 downto 0);
  signal adc_dphase       : unsigned(15 downto 0);
  signal adc_phase_d0     : std_logic_vector(15 downto 0);
  signal flag             : std_logic;

  signal avg_lt_predelay                    : std_logic_vector(22 downto 0);
  signal avg_st_predelay                    : std_logic_vector(18 downto 0);
  signal avg_lt_out                         : std_logic_vector(22 downto 0);
  signal avg_st_out                         : std_logic_vector(18 downto 0);
  signal avg_st, avg_lt, avg_st_d, avg_lt_d : unsigned(22 downto 0);

  --signal avg_lt_trunc, avg_st_trunc : std_logic_vector(15 downto 0);

  signal rl_phase : std_logic_vector(15 downto 0);

  signal err_bound_st_lo : unsigned (22 downto 0);
  signal err_bound_st_hi : unsigned (22 downto 0);
  signal err_bound_lt_lo : unsigned (22 downto 0);
  signal err_bound_lt_hi : unsigned (22 downto 0);

  signal rl_state                              : t_state;
  signal rl_integ, rl_integ_next, rl_phase_ext : unsigned(22 downto 0);
  signal rl_length                             : unsigned(15 downto 0);
  signal rl_cycles_start                       : std_logic_vector(27 downto 0);
  signal err_st                                : signed(22 downto 0);  -- FIXME: not used
  signal err_lt                                : signed(22 downto 0);  -- FIXME: not used
  signal err_lt_bound, err_st_bound            : std_logic;

  signal adc_hp_out   : std_logic_vector(15 downto 0);
  signal adc_data_reg : std_logic_vector(13 downto 0);

  signal c1, c2, c1_d, c2_d, c_out                  : t_comp_record;
  signal c2_pending                                 : std_logic;
  signal ts_report_cnt                              : unsigned(15 downto 0);
  signal err_st_lo, err_st_hi, err_lt_lo, err_lt_hi : signed(22 downto 0);

  signal cnt_fix, lt_cnt_rl, st_cnt_rl, cnt_ts : unsigned(31 downto 0);

  constant c_ACC_SHIFT : integer := 4;
  
  --  Signals for chip Scope  -----------------
  signal CONTROL : std_logic_vector(35 downto 0);
  signal CLK     : std_logic;
  signal TRIG0   : std_logic_vector(31 downto 0);
  signal TRIG1   : std_logic_vector(31 downto 0);
  signal TRIG2   : std_logic_vector(31 downto 0);
  signal TRIG3   : std_logic_vector(31 downto 0);
  ---------------------------------------------
  
begin

  p_input_reg: process(clk_i)
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

  DcBlock_1 : DcBlock
    generic map (
      data_width => 16,
      data_depth => 256)
    port map (
      clk_i     => clk_i,
      rst_n_i   => rst_n_i,
      x_valid_i => '1',  
      x_i       => (adc_data_reg(13) & adc_data_reg(13) & adc_data_reg),
      y_valid_o => open,
      y_o       => adc_hp_out);

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

  -------------------------------------------------------------------
  --  This module calculates the phase as arc_tan(y_in/x_in)
  --  x_in and y_in should be between -1 and 1.
  --  adc_phase is expressed as normalized radians (value between -1 and 1)
  --  that is : -1=-PI, +1=PI
  --  x_in and y_in: are fixed-point 2's complement number with 1QN format
  --       1 sign bit + 1 bit for interger part + 14 bits for fractional part.
  --  adc_pahse is a fixed-point 2's complement with 2QN format
  --       1 bit sign + 2 bits for integer part + 13 bits for fractional part.
  -------------------------------------------------------------------
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
      dout_stb_o => open);

  U_LT_Holdoff_Delay : gc_delay_line
    generic map (
      g_delay => 100,
      g_width => avg_lt_predelay'length)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      d_i     => avg_lt_predelay,
      q_o     => avg_lt_out);

  
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
      dout_stb_o => open);

  U_ST_Delay : gc_delay_line
    generic map (
      g_delay => 128 - 8,
      g_width => avg_st_predelay'length)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      d_i     => avg_st_predelay,
      q_o     => avg_st_out);

  U_RunLen_Delay : gc_delay_line
    generic map (
      g_delay => 127,
      g_width => adc_phase'length)
    port map (
      clk_i   => clk_i,
      rst_n_i => rst_n_i,
      d_i     => adc_phase,
      q_o     => rl_phase);

  avg_st <= unsigned(avg_st_out(avg_st_out'length-3 downto 0) & "000000");
  avg_lt <= unsigned(avg_lt_out(avg_lt_out'length-3 downto 2) & "0000");

  process (clk_i)
  begin
    if rising_edge(clk_i) then
      rl_phase_ext <= unsigned(rl_phase(13 downto 0) & "000000000");
    end if;
  end process;

  err_st_lo <= signed(rl_phase_ext - rl_integ - err_bound_st_lo);
  err_st_hi <= signed(rl_phase_ext - rl_integ - err_bound_st_hi);
  err_lt_lo <= signed(rl_phase_ext - rl_integ - err_bound_lt_lo);
  err_lt_hi <= signed(rl_phase_ext - rl_integ - err_bound_lt_hi);

  err_lt_bound <= not std_logic(err_lt_lo(err_lt_lo'length-1)) and std_logic(err_lt_hi(err_lt_hi'length-1));
  err_st_bound <= not std_logic(err_st_lo(err_st_lo'length-1)) and std_logic(err_st_hi(err_st_hi'length-1));


  p_compress_fsm : process (clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rl_state      <= STARTUP;
        c1.valid      <= '0';
        c2.valid      <= '0';
        ts_report_cnt <= to_unsigned(c_TIMESTAMP_REPORT_PERIOD, ts_report_cnt'length);
      else
        
        
        case (rl_state) is

          when STARTUP =>

            rl_length <= (others => '0');
            rl_integ  <= rl_phase_ext;
            if(fifo_en_i = '1') then
              rl_state <= IDLE;
            end if;

          when IDLE =>

            rl_cycles_start <= std_logic_vector(unsigned(tm_cycles_i) + 1);
            rl_length       <= (others => '0');

            avg_st_d <= avg_st;
            avg_lt_d <= avg_lt;

            err_bound_st_lo <= avg_st + unsigned(st_min_error_i);  
            err_bound_st_hi <= avg_st + unsigned(st_max_error_i);
            err_bound_lt_lo <= avg_lt + unsigned(lt_min_error_i);
            err_bound_lt_hi <= avg_lt + unsigned(lt_max_error_i);


            c1.payload(31)          <= '0';
            c1.payload(30)          <= '0';
            c1.payload(29 downto 0) <= std_logic_vector(resize(rl_phase_ext, 30));
            c1.valid                <= '1';
            c2.valid                <= '0';

            if (fifo_en_i = '0') then 
              rl_state      <= STARTUP;
            elsif (err_lt_bound = '1') then
              rl_state      <= RL_LONG;
              rl_integ      <= rl_phase_ext;
              rl_integ_next <= rl_phase_ext + avg_lt;
            elsif (err_st_bound = '1') then
              rl_state      <= RL_SHORT;
              rl_integ      <= rl_phase_ext;
              rl_integ_next <= rl_phase_ext + avg_st;
            else
              rl_state <= IDLE;
              rl_integ <= rl_phase_ext;
            end if;

            ts_report_cnt <= ts_report_cnt + 1;
            
          when RL_SHORT =>

            c1.valid <= '0';
            c2.valid <= '0';


            rl_integ_next <= rl_integ_next + avg_st_d;

            if (fifo_en_i = '0') then 
              rl_state      <= STARTUP;
            
            elsif (err_st_bound = '1' and rl_length < unsigned(r_max_run_len_i)) then
              rl_length <= rl_length + 1;
              rl_integ  <= rl_integ_next;
              rl_state  <= RL_SHORT;

              if(ts_report_cnt > c_TIMESTAMP_REPORT_PERIOD) then
                ts_report_cnt           <= (others => '0');
                c1.payload(31)          <= '0';
                c1.payload(30)          <= '1';
                c1.payload(29 downto 0) <= "00" & rl_cycles_start;
                c1.valid                <= '1';
              else
                ts_report_cnt <= ts_report_cnt + 1;
              end if;

            else

              c2.payload(31)           <= '1';
              c2.payload(18 downto 0)  <= std_logic_vector(avg_st_d(18+4 downto 4));
              c2.payload(30 downto 19) <= std_logic_vector(rl_length(11 downto 0));

              if (rl_length /= 0) then
                c2.valid <= '1';
              end if;

              c1.payload(31)          <= '0';
              c1.payload(30)          <= '0';
              c1.payload(29 downto 0) <= std_logic_vector(resize(rl_phase_ext, 30));
              c1.valid                <= '1';


              rl_length <= (others => '0');
              rl_state  <= IDLE;
              rl_integ  <= rl_phase_ext;
              
            end if;

          when RL_LONG =>

            c1.valid <= '0';
            c2.valid <= '0';

            rl_integ_next <= rl_integ_next + avg_lt_d;


            if (fifo_en_i = '0') then 
              rl_state      <= STARTUP;
           
            elsif (err_lt_bound = '1' and rl_length < unsigned(r_max_run_len_i)) then
              rl_length <= rl_length + 1;
              rl_state  <= RL_LONG;
              rl_integ  <= rl_integ_next;

              if(ts_report_cnt > c_TIMESTAMP_REPORT_PERIOD) then
                ts_report_cnt           <= (others => '0');
                c1.payload(31)          <= '0';
                c1.payload(30)          <= '1';
                c1.payload(29 downto 0) <= "00" & rl_cycles_start;
                c1.valid                <= '1';
              else
                ts_report_cnt <= ts_report_cnt + 1;
              end if;

            else

              c2.payload(31)           <= '1';
              c2.payload(18 downto 0)  <= std_logic_vector(avg_lt_d(18+4 downto 4));
              c2.payload(30 downto 19) <= std_logic_vector(rl_length(11 downto 0));

--              report integer'image(to_integer(unsigned(avg_lt_d(avg_lt'length-3 downto 0))));
              --            report integer'image(to_integer(unsigned(avg_lt_d)));

              if (rl_length /= 0) then
                c2.valid <= '1';
              end if;

              c1.payload(31)          <= '0';
              c1.payload(30)          <= '0';
              c1.payload(29 downto 0) <= std_logic_vector(resize(rl_phase_ext, 30));
              c1.valid                <= '1';

              rl_state  <= IDLE;
              rl_length <= (others => '0');
              rl_integ  <= rl_phase_ext;
            end if
;
        end case;
      end if;
    end if;
  end process;


  p_write_fifo : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        c2_pending <= '0';
      else
        c1_d <= c1;

        if(c2.valid = '1') then
          c_out <= c2;
        elsif (c1_d.valid = '1') then
          c_out <= c1_d;
        else
          c_out.valid <= '0';
        end if;

        c2_pending <= c2.valid and c1_d.valid;   --c2_pending is read nowhere. Is it for debugging?
        
      end if;
    end if;
  end process;

  p_statistics : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' or fifo_en_i = '0' then
        cnt_ts     <= (others => '0');
        cnt_fix    <= (others => '0');
        lt_cnt_rl  <= (others => '0');
        st_cnt_rl  <= (others => '0');
      else
        if(c_out.valid = '1') then
          if (c_out.payload(31) = '1') and (rl_state/=RL_LONG) then
            st_cnt_rl <= st_cnt_rl + 1;
          elsif (c_out.payload(31) = '1') and (rl_state/=RL_SHORT) then
            lt_cnt_rl <= lt_cnt_rl + 1;
          elsif (c_out.payload(31) = '0' and c_out.payload(30) = '1') then
            cnt_ts <= cnt_ts + 1;
          else
            cnt_fix <= cnt_fix + 1;
          end if;
        end if;
      end if;
    end if;
  end process;

  cnt_fixed_o     <= std_logic_vector(cnt_fix);
  st_cnt_rl_o     <= std_logic_vector(st_cnt_rl);
  lt_cnt_rl_o     <= std_logic_vector(lt_cnt_rl);
  cnt_ts_o        <= std_logic_vector(cnt_ts);


  fifo_we_o      <=  c_out.valid and fifo_en_i;
  fifo_payload_o <=  c_out.payload;

  --------------------------------------------
  --         Chip Scope
  --------------------------------------------

  chipscope_icon_1: chipscope_icon
    port map (
      CONTROL0 => CONTROL);

  chipscope_ila_1: chipscope_ila
    port map (
      CONTROL => CONTROL,
      CLK     => clk_i,
      TRIG0   => TRIG0,
      TRIG1   => TRIG1,
      TRIG2   => TRIG2,
      TRIG3   => TRIG3);
	
	 TRIG0(22 downto 0)  <= std_logic_vector(rl_phase_ext);  -- 22 downto 0
	 TRIG0(31 downto 23) <= std_logic_vector(rl_integ(8 downto 0));  -- rl_integ range (22 downto 0)

    TRIG1(13 downto 0)  <= std_logic_vector(rl_integ(22 downto 9));
    TRIG1(29 downto 14) <= std_logic_vector(rl_length);  -- (15 downto 0)
    TRIG1(30)    <= c1.valid;
    TRIG1(31)    <= c2.valid;
	 
    TRIG2(22 downto 0)  <= std_logic_vector(avg_st); -- (22 downto 0)
    TRIG2(31 downto 23) <= std_logic_vector(rl_integ_next(8 downto 0)); -- 22 downto 0
    
    TRIG3(27 downto 23) <= std_logic_vector(rl_integ_next(13 downto 9)); -- 22 downto 0  -- TRUNCATED TO 14 bits!
    TRIG3(22 downto 0)  <= std_logic_vector(avg_lt); -- (22 downto 0); 
    
	 TRIG3(31) <= err_lt_bound;
	 TRIG3(30) <= err_st_bound;
    TRIG3(29 downto 28) <= std_logic_vector(to_unsigned(t_state'pos(rl_state),2)); -- 4 states


	
	
   
	
	
	
end rtl;

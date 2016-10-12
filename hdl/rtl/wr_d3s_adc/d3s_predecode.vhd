library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.genram_pkg.all;
use work.wishbone_pkg.all;

entity d3s_predecode is
  port (
    clk_wr_i : in std_logic;

    rst_n_wr_i : in std_logic;

    -- Control regs (clk_wr domain)
    r_enable_i : in std_logic;

    -- FIFO I/F (clk_wr domain)
    ififo_payload_i : in  std_logic_vector(31 downto 0);
    ififo_empty_i   : in  std_logic;
    ififo_rd_o      : out std_logic;

    ofifo_empty_o : out std_logic;
    ofifo_rd_i    : in  std_logic;

    ofifo_is_rl_o  : out std_logic;
    ofifo_rl_o     : out std_logic_vector(11 downto 0);
    ofifo_phase_o  : out std_logic_vector(22 downto 0);
    ofifo_tstamp_o : out std_logic_vector(27 downto 0)

    );
end d3s_predecode;

architecture rtl of d3s_predecode is
  
  type t_compr_record is record
    ts    : unsigned(27 downto 0);
    phase : unsigned(22 downto 0);
    is_rl : std_logic;
    rl    : unsigned(11 downto 0);
  end record;

  function f_pack (r : t_compr_record) return std_logic_vector is
  begin
    return std_logic_vector(r.ts) & std_logic_vector(r.phase) & r.is_rl & std_logic_vector(r.rl);
  end f_pack;

  function f_unpack (v : std_logic_vector) return t_compr_record is
    variable r : t_compr_record;
  begin
    r.rl    := unsigned(v(11 downto 0));
    r.is_rl := v(12);
    r.phase := unsigned(v(13 + 22 downto 13));
    r.ts    := unsigned(v(13+22+1+27 downto 13+22+1));
    return r;
  end f_unpack;

  signal q_in_packed, q_out_packed : std_logic_vector(28 + 23 + 1 + 12 - 1 downto 0);
  signal q_wr, q_almost_full                      : std_logic;
  signal q_in, q_out               : t_compr_record;
  signal ififo_rd_d, ififo_rd      : std_logic;
  signal got_ts, got_fix                    : std_logic;
  signal ts                        : unsigned(27 downto 0);
  function f_clamp_add (x          : unsigned; y : unsigned; clamp_to : integer) return unsigned is
  begin
    if (x + y >= clamp_to) then
      return x + y - clamp_to;
    else
      return x + y;
    end if;
  end f_clamp_add;

begin

  process(clk_wr_i)
  begin
    if rising_edge(clk_wr_i) then
      if rst_n_wr_i = '0' or r_enable_i = '0' then
        q_wr   <= '0';
        got_ts <= '0';
        got_fix <= '0';
      else
        ififo_rd_d <= ififo_rd;
        q_wr <= '0';
        
        if (ififo_rd_d = '1') then
          case ififo_payload_i(31 downto 30) is
            when "00" =>                -- fixed phase
              q_in.phase <= unsigned(ififo_payload_i(22 downto 0));
--              report "fix phase: " & integer'image(to_integer(unsigned(ififo_payload_i(22 downto 0))));
              q_in.is_rl <= '0';
              q_in.ts    <= ts;
              ts          <= f_clamp_add (ts, to_unsigned(1, 10), 125000000);
              q_wr        <= got_ts;
              got_fix <= got_ts;
            when "01" =>                -- timestamp
              ts     <= unsigned(ififo_payload_i(27 downto 0));
              got_ts <= '1';
              q_wr   <= '0';
             
            when "10" | "11" =>
              q_in.ts    <= ts;
              q_in.rl    <= unsigned(ififo_payload_i(30 downto 19));
              q_in.phase <= unsigned(ififo_payload_i(18 downto 0)) & "0000";
              q_in.is_rl <= '1';
              q_wr        <= got_ts and got_fix;
              ts          <= f_clamp_add (ts, unsigned(ififo_payload_i(30 downto 19)), 125000000);
            when others => null;
          end case;
        end if;
        
      end if;
    end if;
  end process;

  ififo_rd   <= not ififo_empty_i and not q_almost_full;
  ififo_rd_o <= ififo_rd;

  q_in_packed <= f_pack(q_in);

  U_Out_Queue : generic_sync_fifo
    generic map (
      g_data_width            => q_in_packed'length,
      g_size                  => 256,
      g_show_ahead            => false,
      g_with_almost_full      => true,
      g_almost_full_threshold => 250)
    port map (
      rst_n_i       => rst_n_wr_i,
      clk_i         => clk_wr_i,
      d_i           => q_in_packed,
      we_i          => q_wr,
      q_o           => q_out_packed,
      rd_i          => ofifo_rd_i,
      empty_o       => ofifo_empty_o,
      almost_full_o => q_almost_full);

  q_out <= f_unpack(q_out_packed);

  ofifo_rl_o    <= std_logic_vector(q_out.rl);
  ofifo_is_rl_o <= q_out.is_rl;
  ofifo_phase_o <= std_logic_vector(q_out.phase);
  ofifo_tstamp_o    <= std_logic_vector(q_out.ts);



end rtl;

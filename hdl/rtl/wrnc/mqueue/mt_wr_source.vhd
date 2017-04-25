library ieee;
use ieee.std_logic_1164.all;

use work.genram_pkg.all;
use work.wr_fabric_pkg.all;
use work.mt_mqueue_pkg.all;

entity mt_wr_source is
  
  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    snk_i : in  t_mt_stream_sink_in;
    snk_o : out t_mt_stream_sink_out;

    -- Wishbone Fabric Interface I/O
    src_i : in  t_wrf_source_in;
    src_o : out t_wrf_source_out
    );

end mt_wr_source;

architecture rtl of mt_wr_source is

  constant c_fifo_width : integer := 16 + 2 + 4;

  signal q_valid, full, we, rd, rd_d0 : std_logic;
  signal fin, fout                    : std_logic_vector(c_fifo_width-1 downto 0);

  signal pre_dvalid : std_logic;
  signal pre_eof    : std_logic;
  signal pre_data   : std_logic_vector(15 downto 0);
  signal pre_addr   : std_logic_vector(1 downto 0);

  signal post_dvalid, post_eof, post_bytesel, post_sof : std_logic;

  signal err_status        : t_wrf_status_reg;
  signal cyc_int, cyc_next : std_logic;

  signal status_sent : std_logic;

begin  -- rtl

  err_status.error <= '1';

  snk_o.ready <= not full;

  rd <= (not src_i.stall) and status_sent;
  we <= snk_i.valid or snk_i.error;

  pre_dvalid <= snk_i.valid or snk_i.error;
  pre_data   <= snk_i.data(15 downto 0) when (snk_i.error = '0') else f_marshall_wrf_status(err_status);
  pre_addr   <= snk_i.tag               when (snk_i.error = '0') else c_WRF_STATUS;
  pre_eof    <= snk_i.valid and snk_i.last;


  fin(15 downto 0)  <= pre_data;
  fin(17 downto 16) <= "00";
  fin(20)           <= pre_eof;


  U_FIFO : generic_shiftreg_fifo
    generic map (
      g_data_width => c_fifo_width,
      g_size       => 16)
    port map (
      rst_n_i       => rst_n_i,
      clk_i         => clk_i,
      d_i           => fin,
      we_i          => we,
      q_o           => fout,
      rd_i          => rd,
      almost_full_o => full,
      q_valid_o     => q_valid);

  post_eof <= fout(20);

  p_gen_cyc : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        cyc_int  <= '0';
        cyc_next <= '0';
        status_sent <= '0';
      else
        if cyc_next = '0' then
          status_sent <= '0';
        elsif cyc_int = '1' or q_valid = '1' then
          status_sent <= not src_i.stall;
        end if;
        
        if(q_valid = '1') then
          cyc_next <= not post_eof;
          cyc_int  <= '1';
        else
          cyc_next <= '0';
          cyc_int  <= cyc_next;
        end if;
      end if;
    end if;
  end process;

  src_o.cyc <= cyc_int or q_valid;
  src_o.we  <= '1';
  src_o.stb <= q_valid;
  src_o.sel <= "11";

  process(status_sent, fout)
  begin
    if status_sent = '0' then
      src_o.dat <= (others => '0');
      src_o.adr <= c_WRF_STATUS;
    else
      src_o.dat <= fout(15 downto 0);
      src_o.adr <= fout(17 downto 16);
    end if;
  end process;

end rtl;


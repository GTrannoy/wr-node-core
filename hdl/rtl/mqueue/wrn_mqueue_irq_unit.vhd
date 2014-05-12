library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wrn_mqueue_pkg.all;
use work.genram_pkg.all;

entity wrn_mqueue_irq_unit is
  
  generic (
    g_config : t_wrn_mqueue_config);

  port (
    clk_i   : in std_logic;
    rst_n_i : in std_logic;

    incoming_status_i : t_slot_status_out_array(0 to g_config.in_slot_count-1);
    outgoing_status_i : t_slot_status_out_array(0 to g_config.out_slot_count-1);

    irq_config_i : t_wrn_irq_config;

    irq_o : out std_logic
    );

end wrn_mqueue_irq_unit;

architecture rtl of wrn_mqueue_irq_unit is

  constant c_wrn_clk_freq : integer := 62500000;


  signal tmr_div     : unsigned(f_log2_size(c_wrn_clk_freq/1000+1)-1 downto 0);
  signal tmr_tick    : std_logic;
  signal tmr_timeout : unsigned(9 downto 0);

  signal threshold_hit : std_logic_vector(15 downto 0);
  signal raw_irqs      : std_logic_vector(31 downto 0);
  
  
begin  -- rtl


  p_check_thresholds : process(clk_i)
  begin
    if rising_edge(clk_i) then
      threshold_hit <= (others => '0');

      for i in 0 to g_config.in_slot_count-1 loop
        if(incoming_status_i(i).empty = '0' and unsigned(incoming_status_i(i).count) >= unsigned(irq_config_i.threshold)) then
          threshold_hit(i) <= '1';
        else
          threshold_hit(i) <= '0';
        end if;
      end loop;  -- i
    end if;
  end process;

  raw_irqs(15 downto 0) <= threshold_hit and irq_config_i.mask_in;

  p_coalesce_tick : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        tmr_div  <= (others => '0');
        tmr_tick <= '0';
      else
        if(tmr_div /= c_wrn_clk_freq/1000-1) then
          tmr_div  <= tmr_div + 1;
          tmr_tick <= '1';
        else
          tmr_div  <= (others => '0');
          tmr_tick <= '0';
        end if;
      end if;
    end if;
  end process;

  --p_coalesce_irq : process(clk_sys_i)
  --begin
  --  if rising_edge(clk_sys_i) then
  --    if rst_n_sys_i = '0' then
  --      buf_irq_int <= '0';
  --    else
  --      if(buf_count = 0) then
  --        buf_irq_int <= '0';
  --        tmr_timeout <= (others => '0');
  --      else
  --        -- Simple interrupt coalescing :

  --        -- Case 1: There is some data in the buffer 
  --        -- (but not exceeding the threshold) - assert the IRQ line after a
  --        -- certain timeout.
  --        if(buf_irq_int = '0') then
  --          if(tmr_timeout = unsigned(regs_i.tsbir_timeout_o)) then
  --            buf_irq_int <= '1';
  --            tmr_timeout <= (others => '0');
  --          elsif(tmr_tick = '1') then
  --            tmr_timeout <= tmr_timeout + 1;
  --          end if;
  --        end if;

  --        -- Case 2: amount of data exceeded the threshold - assert the IRQ
  --        -- line immediately.
  --        if(buf_count > unsigned(regs_i.tsbir_threshold_o)) then
  --          buf_irq_int <= '1';
  --        end if;
  --      end if;
  --    end if;
  --  end if;
  --end process;



end rtl;

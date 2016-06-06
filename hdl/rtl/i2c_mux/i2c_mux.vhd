library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity i2c_mux is
  port (
    --MUX signals
    i2c_sel_i : in  std_logic_vector(1 downto 0);
    i2c_lck_o : out std_logic;

    --I2C signals
    sda_mux_i : in  std_logic;
    sda_mux_o : out std_logic;
    scl_mux_i : in  std_logic;
    scl_mux_o : out std_logic;

    wrc_sda_i : out std_logic;
    wrc_sda_o : in  std_logic;
    wrc_scl_i : out std_logic;
    wrc_scl_o : in  std_logic;
    
    wrn_sda_i : out std_logic;
    wrn_sda_o : in  std_logic;
    wrn_scl_i : out std_logic;
    wrn_scl_o : in  std_logic
    );
end i2c_mux;


architecture behavorial of i2c_mux is

  signal mux_sel : std_logic;

begin

  i2c_lck_o <= '0' when i2c_sel_i = "00" else '1';
  mux_sel <= not(i2c_sel_i(0)) and i2c_sel_i(1);

  --MUX output
  sda_mux_o <= wrc_sda_o when mux_sel = '0' else wrn_sda_o;
  scl_mux_o <= wrc_scl_o when mux_sel = '0' else wrn_scl_o;

  --MUX input
  wrc_sda_i <= sda_mux_i when mux_sel = '0' else '0';
  wrc_scl_i <= scl_mux_i when mux_sel = '0' else '0';
  wrn_sda_i <= sda_mux_i when mux_sel = '1' else '0';
  wrn_scl_i <= scl_mux_i when mux_sel = '1' else '0';

end architecture;

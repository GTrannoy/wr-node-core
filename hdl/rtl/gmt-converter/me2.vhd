-- **********************************************
-- * Manchester encoder - PN le 13 Fevrier 2002 *
-- **********************************************

-- Author : Philippe Nouchi - SL/CO/TIM

-- Version 1.0 : All synthetisable from the Pablo's version and Xilinx Manchester encoder function

-- Version 1.1 : with 1 Mhz Clock from the TS100 GPS card
--             : Philippe Nouchi le 04 Mars 2002

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;



entity me2 is
port(
   reset : in std_logic;
	Clk40 : in std_logic; 
   BitRate: in std_logic;
   mesin_vec : in std_logic_vector(31 downto 0);
   start : in std_logic;
   mdo   : out std_logic;
	Stuffing: in std_logic;
   done  : out std_logic
);
end me2;

architecture beh of me2 is 
constant PL : integer := 16;
constant SBL : integer := 2;
constant QL : integer := 8;
constant BML : integer := 20; -- manchester byte length (includes Parity and sync)
constant FML : integer := BML * 4;
constant NOISEL : integer := 40;
constant TotalL : integer := PL + FML + QL;
constant sync : std_logic := '1';

subtype bytem_type is std_logic_vector(BML-1 downto 0);
subtype fm_type is std_logic_vector(FML-1 downto 0);
subtype f_type is std_logic_vector(TotalL -1 downto 0); 
constant preambule : std_logic_vector(PL-1 downto 0) := "1110001010101010";
constant sb : std_logic := '1';
constant one : std_logic_vector(1 downto 0) := "10";
constant zero : std_logic_vector(1 downto 0) := "01";
constant queue : std_logic_vector(QL -1 downto 0) := "00011101";

--constant PONOL : integer := 40; 
signal fm : fm_type;
signal f, freg: f_type;
signal byte0, byte1, byte2, byte3 : std_logic_vector(7 downto 0); 
signal bytem0, bytem1, bytem2, bytem3 : bytem_type;
signal doner : f_type;
signal istart, stuffBit1, mdoAux, messageDone, startF: std_logic; 

--Converts NRZ to Manchester
function ByteToManchester(byterz : std_logic_vector(7 downto 0)) return bytem_type is
  variable vbyterz : std_logic_vector(9 downto 0);
  variable vbytem : bytem_type;	
  variable p : std_logic;
  begin
  p := NOT(byterz(0) xor byterz(1) xor byterz(2) xor byterz(3) xor byterz(4) xor byterz(5) xor byterz(6) xor byterz(7));
  vbyterz := p & byterz & sync;
   for I in 0 to 9 loop 
      if vbyterz(I) = '1' then 
      vbytem((2*I + 1) downto 2*I) := one; 
      else 
      vbytem((2*I + 1) downto 2*I) := zero;
      end if;
   end loop;
   return vbytem; 
end;

begin
byte0 <= mesin_vec(31 downto 24); 
byte1 <= mesin_vec(23 downto 16); 
byte2 <= mesin_vec(15 downto 8); 
byte3 <= mesin_vec(7 downto 0); 
bytem0 <= ByteToManchester(byte0); 
bytem1 <= ByteToManchester(byte1); 
bytem2 <= ByteToManchester(byte2); 
bytem3 <= ByteToManchester(byte3);
fm <= bytem3 & bytem2 & bytem1 & bytem0;
f <= queue & fm & preambule;

mdo <= mdoAux;


-- generates the serial output; 
process(Clk40)
begin
if rising_edge(Clk40) then
if reset = '1' then 
   freg <= (others => '0');
   mdoAux <= '0';
   doner <= (TotalL - 1 => '1', others => '0');
   done <= '0';
	stuffBit1 <= '0';
	messageDone <= '1';
	startF <= '0';
else
   if start = '1' then
	 startF <= '1';
	elsif BitRate = '1' then
	 startF <= '0';
	end if;
	if startF = '1' and BitRate = '1' then
      freg <= f;
      doner <= (TotalL - 1 => '1', others => '0');
		mdoAux <= not mdoAux;
      done <= '0';	
		messageDone <= '0';
--	   stuffBit1 <= '0';
   elsif BitRate='1' then
      freg <= '0' & freg(TotalL - 1 downto 1); 
      doner <= '0' & doner(TotalL - 1 downto 1); 
		if messageDone='1' then
		 mdoAux <= not mdoAux;
		else
		 mdoAux <= freg(0);
      end if;
		if doner(0) = '1' then
		 messageDone <= '1';
		end if;
      done <= doner(0);
--	   stuffBit1 <= not stuffBit1;
	end if;
end if;
end if;
end process;

end beh;

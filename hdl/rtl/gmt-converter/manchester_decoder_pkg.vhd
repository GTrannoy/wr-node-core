library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package manchester_decoder_pkg is

-- USER'S PARAMENTERS
-- Modify this parameters at your will

  constant QUARTZPERIOD : integer := 25;  -- Define here the period of your clock in ns
  constant C14INT       : integer := 500;  -- The lenght of a forth of cell in ns
  constant JITTERWIDTH  : time    := 0 ns;  -- JITTERWIDTH = Maximum C14TIME - Minimum C14TIME
                                          -- It is used to model the timing signal jitter

  constant MILLISECOND : std_logic_vector(8 downto 0)  := "000000001";
  constant SUPERCYCLE  : std_logic_vector (8 downto 0) := "000100000";

-- END OF USER'S PARAMETERS

-- INTERNAL PARAMETERS
-- DON'T MODIFY THIS PART OF THE PACKAGE


--Manchester Decoder TYPES
  type message_TYPE is array (3 downto 0) of std_logic_vector(7 downto 0);
  subtype ErrorReg_TYPE is std_logic_vector(4 downto 0);
  constant CLOCKLENGTH : integer := 9;  -- log2((C14INT/QUARTZPERIOD * 7) );
  subtype clock_type is unsigned(CLOCKLENGTH downto 0);


  constant LF : integer range 0 to 63 := 40;  -- length of a frame

---------------------------------------------
-- Position of the errors bit in the bit error reg
---------------------------------------------
  constant TOTALERRORPOS : integer := 0;
  constant CVPOS         : integer := 1;
  constant PERRPOS       : integer := 2;
  constant SERRPOS       : integer := 3;
  constant QERRPOS       : integer := 4;

--///////////////////////////////////////////
---------------------------------------------
--Manchester Decoder CONSTANTS
---------------------------------------------
--///////////////////////////////////////////

---------------------------------------------
-- Identification of the frame bits
---------------------------------------------
  constant ZER : integer range 0 to 63 := 0;       -- zero bit
  constant FIS : integer range 0 to 63 := 1;       -- first synch bit
  constant SES : integer range 0 to 63 := FIS+10;  -- second synch bit
  constant THS : integer range 0 to 63 := SES+10;  -- third synch bit
  constant FOS : integer range 0 to 63 := THS+10;  -- forth synch bit
  constant FOE : integer range 0 to 63 := FOS+10;  -- 
  constant FIP : integer range 0 to 63 := 10;      -- first parity bit
  constant SEP : integer range 0 to 63 := FIP+10;  -- second parity bit
  constant THP : integer range 0 to 63 := SEP+10;  -- third parity bit
  constant FOP : integer range 0 to 63 := THP+10;  -- forth parity bit


---------------------------------------------
-- Constants to sample at the right time.
-- C14 equeals to 1.956us/4, this is one forth of cell
-- C34 equeals to 1.956us*3/4 and so
----------------------------------------------
  constant C44 : clock_type := to_unsigned(C14INT/QUARTZPERIOD * 4, clock_type'left+1);  -- 
  constant C14 : clock_type := to_unsigned(C14INT/QUARTZPERIOD * 1, clock_type'left+1);  -- 
  constant C34 : clock_type := to_unsigned(C14INT/QUARTZPERIOD * 3, clock_type'left+1);  -- 
  constant C54 : clock_type := to_unsigned(C14INT/QUARTZPERIOD * 5, clock_type'left+1);  -- 
  constant C74 : clock_type := to_unsigned(C14INT/QUARTZPERIOD * 7, clock_type'left+1);  -- 

  constant C17_40 : clock_type := to_unsigned(C14INT/QUARTZPERIOD *2*36/40, clock_type'left+1);  -- 


  constant ONE   : clock_type := (0 => '1', others => '0');
  constant RSRUP : integer    := LF-1;

end manchester_decoder_pkg;


library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.manchester_decoder_pkg.all;

entity manchester_decoder is
  port (
    rst_n_i      : in  std_logic;
    clk_i        : in  std_logic;
    md_i         : in  std_logic;       -- Manchestere data in
    data_o       : out std_logic_vector (31 downto 0);  -- Data out register
    data_ready_o : out std_logic;       -- Data ready pulse
    mil_pulse_o  : out std_logic;
    sc_pulse_o   : out std_logic;       -- Milisecond and Super Cycle pulse
    error_o      : out ErrorReg_type    -- Error register
    ) ;
end manchester_decoder;

architecture synMilReg of manchester_decoder is



  type mdst_type is (
    wStup,                              -- wait start up 
    dFrame,                             -- decods frame
    vQueu,                              -- verifies queu
    fRec,                               -- Frame received 
    fError);             
  type stupst_type is (
    fiOnes,                             -- first one detected
    seOnes,                             -- second one detected
    thOnes,                             -- third one detected
    loVios,                             -- low violation detected
    oneVios,                            -- one between violations
    hiVios,                             -- high violation detected
    Oks,
    Waits);

  type queust_type is (
    idleq,
    zeroq,                              -- zero detected
    hiVioq,                             -- high violation detected
    Okq,
    wrongq);



  signal mdst, next_mdst            : mdst_type;
  signal stupst, next_stupst        : stupst_type;
  signal queust, next_queust        : queust_type;
-- signal clk1x_enable : std_logic ;
  signal mdi1                       : std_logic;
  signal mdi2                       : std_logic;
  signal mdire, mdife               : std_logic;  -- Manchester data in rising edge/
  --                     falling edge
  signal oned, zerod                : std_logic;
  signal istup                      : std_logic;  -- init Start up.
  signal stupf                      : std_logic;  -- Start up found.
  signal frend                      : std_logic;  -- Frame end.
                                                  -- For this I need receiving all the data.
  signal iqueue                     : std_logic;  -- init queu search.
  signal queuef                     : std_logic;  -- queu found receiving a cero, and receving a violation
                                                  -- code at high level.  
  signal qerr                       : std_logic;  -- queue error                                          
  signal lfr                        : std_logic;  -- Load frame. 
--signal errd : std_logic;              -- Error detected.
  signal perrd                      : std_logic;  -- Parity Error detected.
  signal rstpar                     : std_logic;
  signal preg                       : std_logic;  -- Parity register.
  signal sberrd                     : std_logic;  --  Start Byte bit error detected. 
  signal hcvd, lcvd, cvd            : std_logic;  -- Codes violation detected.
  signal nrz34                      : std_logic;  -- mdi sampled at 3/4.
--signal nrz14 : std_logic;             -- mdi sampled at 1/4.             
  signal rsr                        : std_logic_vector (RSRUP downto 0);  -- to store temporary the data
                                        -- i use rsr.
                                        -- the parity bits 
                                        -- are included.            
--signal dout_i : std_logic_vector (31 downto 0) ;
  signal no_bits_rcvd               : integer range 0 to 63;
  signal clkdiv, glitchDetecCounter : clock_type;
  signal clkreset                   : std_logic;

  signal unexpectedEdge               : std_logic;
  signal s34, s14, next_s34, next_s14 : std_logic;  -- Sample at 3/4 (data)
  -- Sample at 1/4 (error detection) 
--signal byte3, byte2 : std_logic_vector(7 downto 0);
  signal ready                        : std_logic;  -- data ready (not registered). 

  signal sscrec      : std_logic;       -- supercycle header detected.
  signal tssc, tsscr : std_logic;

  signal milrec      : std_logic;       -- milisecon header detected.
  signal tmil, tmilr : std_logic;       -- triger milisecond.
  signal gC34, gC54  : std_logic;
begin

--///////////////////////////////////////////////////////////////////////////
--***************************************************************************
--* Decoder state machine. 
--***************************************************************************
  Mdst_reg : process (clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        mdst <= wStup;
      else
        mdst <= next_mdst;
      end if;
    end if;
  end process;
------------------------------------------------------------------------
--State assingment Decoder
------------------------------------------------------------------------
  Mdst_asig : process (mdst, stupf, cvd, perrd, queuef, qerr, frend, sberrd)
    variable vnext_mdst : mdst_type;
  begin
    vnext_mdst := wStup;

    case mdst is
      when wStup =>
        if stupf = '1' then
          vnext_mdst := dFrame;
        else
          vnext_mdst := mdst;
        end if;

      when dFrame =>
        if cvd = '1' or perrd = '1' or sberrd = '1' then
          vnext_mdst := fError;
        elsif frend = '1' then
          vnext_mdst := vQueu;
        else
          vnext_mdst := mdst;
        end if;

      when vQueu =>
        if queuef = '1' then
          vnext_mdst := fRec;
        elsif qerr = '1' then
          vnext_mdst := fError;
        else
          vnext_mdst := mdst;
        end if;

      when fRec | fError =>
        vnext_mdst := wStup;

      when others => vnext_mdst := wStup;
    end case;
    next_mdst <= vnext_mdst;
  end process;
------------------------------------------------------------------------
--Output assingment Decoder
------------------------------------------------------------------------
  Mdst_out : process(mdst, mdife, mdire, clkdiv, frend, gC34, gC54)
--variable vlstup : std_logic;
    variable vlfr      : std_logic;
    variable vclkreset : std_logic;
    variable vistup    : std_logic;
    variable viqueue   : std_logic;
    variable vready    : std_logic;
--variable vError : std_logic;

  begin
    vistup    := '0';
    vlfr      := '0';
    vclkreset := '0';
    viqueue   := '0';
    vready    := '0';
    case mdst is
      when wStup =>
        vclkreset := mdire;             -- or mdife;

      when dFrame =>
        vlfr := '1';
        if (gC34 = '1') and (gC54 = '0') then
          vclkreset := mdire or mdife;
        elsif (gC54 = '1') then
          vclkreset := mdire;
        end if;
        viqueue := frend;               -- I start the queue state machine
      -- when the end of frame is founded. 
      when vQueu =>
        if clkdiv > C34 then
          vclkreset := mdire or mdife;
        end if;
      when fRec =>                      -- vlfr  :=  '1';
        vready := '1';
        vistup := '1';
      when fError =>                    -- vlfr  :=  '1';
        vistup := '1';
      when others => null;
    end case;
    istup    <= vistup;
    lfr      <= vlfr;
    ready    <= vready;
    clkreset <= vclkreset;
    iqueue   <= viqueue;
--Error <= vError; 
  end process;
  gC34 <= '1' when clkdiv > C34 else '0';
  gC54 <= '1' when clkdiv > C54 else '0';

--***************************************************************************
--* Start Up state machine. 
--***************************************************************************
  Stupst_reg : process (clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        stupst <= fiOnes;

      else
        stupst <= next_stupst;
      end if;
    end if;
  end process;
------------------------------------------------------------------------
--State assingment Start Up
------------------------------------------------------------------------
  Stupst_asig : process (stupst, cvd, zerod, oned, istup, lcvd, hcvd)
    variable vnext_stupst : stupst_type;
  begin
    vnext_stupst := fiOnes;
    case stupst is
      when fiOnes =>
        if cvd = '1' then
          vnext_stupst := fiOnes;  -- Code violation --> start again
        elsif zerod = '1' then
          vnext_stupst := fiOnes;
        elsif oned = '1' then
          vnext_stupst := seOnes;  -- One detected --> next st
        else
          vnext_stupst := stupst;
        end if;
      when seOnes =>
        if cvd = '1' then
          vnext_stupst := fiOnes;  -- Code violation --> start again
        elsif zerod = '1' then
          vnext_stupst := fiOnes;
        elsif oned = '1' then
          vnext_stupst := thOnes;  -- One detected --> next st
        else
          vnext_stupst := stupst;
        end if;

      when thOnes =>
        if cvd = '1' then
          vnext_stupst := fiOnes;  -- Code violation --> start again
        elsif zerod = '1' then
          vnext_stupst := fiOnes;
        elsif oned = '1' then
          vnext_stupst := loVios;  -- One detected --> next st
        else
          vnext_stupst := stupst;
        end if;
      when loVios =>

        if lcvd = '1' then
          vnext_stupst := oneVios;
        elsif zerod = '1' or hcvd = '1' then
          vnext_stupst := fiOnes;
        else
          vnext_stupst := stupst;
        end if;
        
      when oneVios =>
        if zerod = '1' or hcvd = '1' then
          vnext_stupst := fiOnes;
        elsif lcvd = '1' then
          vnext_stupst := stupst;
        elsif oned = '1' then
          vnext_stupst := hiVios;
        else
          vnext_stupst := stupst;
        end if;
        
      when hiVios =>
        if hcvd = '1' then
          vnext_stupst := Oks;
        elsif oned = '1' or zerod = '1' or hcvd = '1' then
          vnext_stupst := fiOnes;
        else
          vnext_stupst := stupst;
        end if;

      when Oks =>
        vnext_stupst := Waits;
        
      when Waits =>
        if istup = '1' then
          vnext_stupst := fiOnes;
        else
          vnext_stupst := stupst;
        end if;

      when others =>
        vnext_stupst := fiOnes;
    end case;
    next_stupst <= vnext_stupst;
  end process;

------------------------------------------------------------------------
--Output assingment Start Up
------------------------------------------------------------------------
  Stupst_out : process (stupst)
    variable vstupf : std_logic;
  begin
    vstupf := '0';
    case stupst is
      when fiOnes => null;
      when seOnes => null;
      when thOnes => null;
--      when foOnes => null;
      when loVios => null;
      when hiVios => null;
      when Oks    => vstupf := '1';
      when waits  => null;
      when others => null;
    end case;
    stupf <= vstupf;
  end process;

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--***************************************************************************
--* Start Up state machine. 
--***************************************************************************
  Queust_reg : process (clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        queust <= idleq;

      else
        queust <= next_queust;
      end if;
    end if;
  end process;
------------------------------------------------------------------------
--State assingment queue
------------------------------------------------------------------------
  Queust_asig : process (queust, iqueue, cvd, hcvd, zerod, lcvd, oned)
    variable vnext_queust : queust_type;
  begin
    vnext_queust := idleq;
    case queust is
      when idleq =>
        if iqueue = '1' then
          vnext_queust := zeroq;
        else
          vnext_queust := queust;
        end if;

      when zeroq =>
        if ((cvd = '1') or (oned = '1')) then
          vnext_queust := wrongq;
        elsif zerod = '1' then
          vnext_queust := hiVioq;
        else
          vnext_queust := queust;
        end if;

      when hiVioq =>
        if hcvd = '1' then
          vnext_queust := okq;
        elsif oned = '1' or zerod = '1' or lcvd = '1' then
          vnext_queust := wrongq;
        else
          vnext_queust := queust;
        end if;

      when okq =>
        vnext_queust := idleq;
      when wrongq =>
        vnext_queust := idleq;
      when others =>
        vnext_queust := idleq;
    end case;

    next_queust <= vnext_queust;
  end process;

------------------------------------------------------------------------
--Output assingment queue
------------------------------------------------------------------------
  Queust_out : process (queust)
    variable vqerr   : std_logic;
    variable vqueuef : std_logic;
  begin
    vqerr   := '0';
    vqueuef := '0';
    case queust is
      when idleq  => null;
      when zeroq  => null;
      when hiVioq => null;
      when okq    => vqueuef := '1';
      when wrongq => vqerr   := '1';
      when others => null;
    end case;
    qerr   <= vqerr;
    queuef <= vqueuef;
  end process;

--***************************************************************************
--* Detects rising and falling edge. 
--***************************************************************************
  Mdi_reg : process (clk_i)
  begin
    if rising_edge(clk_i) then
      mdi2 <= mdi1;
      mdi1 <= md_i;
    end if;
  end process;

--***************************************************************************
--* Detects rising and falling edge. 
--***************************************************************************

  Mdi_edge : process(mdi1, mdi2)
  begin
    mdire <= mdi1 and not(mdi2);
    mdife <= not(mdi1) and mdi2;
  end process;

--***************************************************************************
--* Order to sample the data at 1/4 and 3/4 points in data cell
--***************************************************************************
  Sample : process (rst_n_i, clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        s34 <= '0';
        s14 <= '0';
      else
        s34 <= next_s34;
        s14 <= next_s14;
      end if;
    end if;

  end process;

------------------------------
  Next_sample : process(clkdiv)
    variable vnext_s34 : std_logic;
    variable vnext_s14 : std_logic;
  begin
    vnext_s34 := '0';
    vnext_s14 := '0';
--if clkdiv(4 downto 0) =  C34(4 downto 0) then 
    if clkdiv = C34 or clkdiv = C74 then
      vnext_s34 := '1';
    end if;

    if clkdiv = C14 or clkdiv = C54 then
--if clkdiv =  C14 then 
      vnext_s14 := '1';
    end if;
    next_s34 <= vnext_s34;
    next_s14 <= vnext_s14;
  end process;
--***************************************************************************
--* Load  rsr (Frame)
--***************************************************************************
  Load_rsr : process (clk_i)
  begin
    if rising_edge(clk_i) then
--if rst = '0' then
--rsr <= (others =>'0' ) ;
--else
      if (lfr = '1' and s14 = '1') then
        rsr <= mdi2 & rsr(RSRUP downto 1);
      end if;
--end if ;
    end if;
  end process;
--***************************************************************************
--* Number of bits received
--***************************************************************************
  NoBitsRcvd : process (clk_i)
  begin
    if rising_edge(clk_i) then
--      if rst = '0' then
--      no_bits_rcvd <= 0 ;
--      else
      if lfr = '0' then
        no_bits_rcvd <= 0;
      elsif (s14 = '1') then
        no_bits_rcvd <= no_bits_rcvd + 1;
      end if;
--      end if ;
    end if;
  end process;
--***************************************************************************
--* Frame end
--***************************************************************************
  FrameEnd : process(no_bits_rcvd)
    variable vfrend : std_logic;
  begin
    if no_bits_rcvd = work.manchester_decoder_pkg.LF then
      vfrend := '1';
    else
      vfrend := '0';
    end if;
    frend <= vfrend;
  end process;
--***************************************************************************
--* Increment the clock
--***************************************************************************
  IncClkdiv : process (clk_i)
  begin
    if rising_edge(clk_i) then
      if clkreset = '1' then
        clkdiv <= (others => '0');
      else
        clkdiv <= clkdiv + ONE;
      end if;
    end if;
  end process;



---------------------------------------------
-- Process to detect unexpected edges
----------------------------------------------


  process (clk_i)
  begin
    if rising_edge(clk_i) then
--if rst = '0' then
--glitchDetecCounter <= (others => '0');
--unexpectedEdge <= '0' ; 
--else

      if ((mdire = '1') or (mdife = '1')) then
        glitchDetecCounter <= (others => '0');
      elsif glitchDetecCounter = C17_40 then
        glitchDetecCounter <= glitchDetecCounter;
      else
        glitchDetecCounter <= glitchDetecCounter + ONE;
      end if;

      if ((mdire = '1')or (mdife = '1')) then
        if (glitchDetecCounter < C17_40) then
          unexpectedEdge <= '1';
        else
          unexpectedEdge <= '0';
        end if;
      else
        unexpectedEdge <= '0';
      end if;
--end if;
    end if;
  end process;
--***************************************************************************
--* Mdi at 3/4
--***************************************************************************
  Mdi34 : process (clk_i)
  begin
    if rising_edge(clk_i) then
--      if rst = '0' then
--      nrz34 <= '0' ;
--      else
      if s34 = '1' then
        nrz34 <= mdi2;
      end if;
--      end if ;
    end if;
  end process;
--***************************************************************************
--* Mdi at 1/4
--***************************************************************************
--Mdi14:process (rst,clk_i)
--begin
--if rst = '0' then
--nrz14 <= '0' ;
--elsif rising_edge(clk_i) then
--if s14 = '1' then
--nrz14 <= mdi2 ;
--end if ;
--end if ;
--end process ;
--***************************************************************************
--* Code violation detection
--***************************************************************************
  CodeVio : process(mdi2, nrz34, s14)
  begin
    cvd  <= not(mdi2 xor nrz34) and s14;  -- I use mdi2 instead of nrz14 because
    -- nrz34 is delayed one cycle respect
    -- to s14.
    hcvd <= (mdi2 and nrz34) and s14;
    lcvd <= (not(mdi2 or nrz34)) and s14;
  end process;
--***************************************************************************
--* Register Errors
--***************************************************************************

  TotalErr : process (rst_n_i, clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        error_o <= (others => '0');
      else
        if mdst = dFrame then
          error_o(TOTALERRORPOS) <= unexpectedEdge or perrd or sberrd;
          error_o(CVPOS)         <= unexpectedEdge;
          error_o(PERRPOS)       <= perrd;
          error_o(SERRPOS)       <= sberrd;
          error_o(QERRPOS)       <= '0';
        elsif mdst = vQueu then
          error_o(TOTALERRORPOS) <= qerr;
          error_o(QERRPOS)       <= qerr;
          error_o(CVPOS)         <= unexpectedEdge;
          error_o(PERRPOS)       <= '0';
          error_o(SERRPOS)       <= '0';
        else
          error_o(TOTALERRORPOS) <= unexpectedEdge;
          error_o(QERRPOS)       <= '0';
          error_o(CVPOS)         <= unexpectedEdge;
          error_o(PERRPOS)       <= '0';
          error_o(SERRPOS)       <= '0';
        end if;
      end if;
    end if;
  end process;
--***************************************************************************
--* Bit detection
--***************************************************************************
  BitDetec : process(mdi2, s14)
  begin
    oned  <= (mdi2) and s14;
    zerod <= not(mdi2) and s14;
  end process;
--***************************************************************************
--* Parity error detection
--**************************************************************************
  ParErrDet : process (rst_n_i, clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        preg <= '0';
      else
        if rstpar = '1' then
          preg <= '0';
        elsif s14 = '1' then
          preg <= mdi1 xor preg;
        end if;
      end if;
    end if;
  end process;
-----------------------------------------------------------------------------
-- Parity reset
-- Check Start Byte bit
-- Milisecond Pulse
-----------------------------------------------------------------------------
  ParSBitMil : process(no_bits_rcvd, preg, s34, milrec, mdi1, s14, sscrec)
    variable vrstpar : std_logic;
--variable vcsbb : std_logic;
    variable vperrd  : std_logic;
    variable vsberrd : std_logic;
    variable vtmil   : std_logic;
    variable vtssc   : std_logic;
  begin
    vrstpar := '0';
    vperrd  := '0';
    vsberrd := '0';
    vtmil   := '0';
    vtssc   := '0';
    case no_bits_rcvd is
      when FIS | SES | THS | FOS => vrstpar := s34;
--                             vsberrd :=  not (mdi1) and s14;
      when FIP                   =>     --  venmil := '1';
        vtmil   := milrec;
        vtssc   := sscrec;
        vperrd  := (not(preg)) and s34;
        vsberrd := not (mdi1) and s14;
      when SEP | THP | FOP =>           -- vrstpar  :=  s34;
        vperrd  := (not(preg)) and s34;
        vsberrd := not (mdi1) and s14;
--when FOE => vrstpar := '1';
--                               vperrd := not(preg);
      when others => vrstpar := '0';
                     vperrd  := '0';
                     vsberrd := '0';
                     vtmil   := '0';
                     vtssc   := '0';
    end case;
    tssc   <= vtssc;
    tmil   <= vtmil;
    rstpar <= vrstpar;
    perrd  <= vperrd;
    sberrd <= vsberrd;
  end process;

--***************************************************************************
--*milisecond received
--***************************************************************************
  process(rsr)
    variable vmilrec : std_logic;
    variable vscrec  : std_logic;
  begin
    vmilrec := '0';
    vscrec  := '0';
    if rsr(RSRUP downto RSRUP - 8) = MILLISECOND then
      vmilrec := '1';
    end if;
    if rsr(RSRUP downto RSRUP - 8) = SUPERCYCLE then
      vscrec := '1';
    end if;
    sscrec <= vscrec;
    milrec <= vmilrec;
  end process;
--***************************************************************************
--* Milisecond Trigger registered by clk_i
--**************************************************************************
  tmilreg : process (rst_n_i, clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        tmilr <= '0';
        tsscr <= '0';
      else
        tmilr <= tmil;
        tsscr <= tssc;
      end if;
    end if;
  end process;
--***************************************************************************
--*Milisecond Out
--***************************************************************************

  mil_pulse_o <= tmilr and mdiRe;
  sc_pulse_o  <= tsscr and mdiRe;

--***************************************************************************
--*Data Out
--***************************************************************************
  DataOut : process (rst_n_i, clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
--dout <= (others => '0') ;
        data_ready_o <= '0';
      else

        if ready = '1' then
--dout <= rsr(RSRUP-1 downto RSRUP-1-7)&rsr(RSRUP-3-8 downto RSRUP-3-15)&rsr(RSRUP-5-16 downto RSRUP-5-23)&rsr(RSRUP-7-24 downto RSRUP-7-31);
          data_o <= rsr(RSRUP-7-24 downto RSRUP-7-31)&rsr(RSRUP-5-16 downto RSRUP-5-23)&rsr(RSRUP-3-8 downto RSRUP-3-15)&rsr(RSRUP-1 downto RSRUP-1-7);
        end if;
        data_ready_o <= ready;
      end if;
    end if;
  end process;
--///////////////////////////////////////////////////////////////////////////
end synMilReg;

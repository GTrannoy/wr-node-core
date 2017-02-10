// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// RFGenerator class : Generates a modulated RF sinewave
class RFGenerator2;
// Extension of the class RFGenerator (defined in the file RF_Gen_class.svh)
// which simulated the signal FSK modulated as the RF at the SPS during 
// ions runs.
// The extension tries to solve 2 limitaitons:
// 1) Simulate the beam acceleration : Trev not constant during the beam cycle.
// 2) The 2 fRF used in the FSK modulation shold be such that after a Trev the 
// number of period cycles should be an integer number.
//
   real sample_freq;
   int  lp_ratio;
   real lp_sample_freq;
   real lp_sample_period;
   
   real frev_inj; // Revolution frequency at the injection energy
   real frev_top; // Revolution frequency at the top energy
   real ramp_t;   // Duration of the accelaration ramp
   real fRF1, fRF2, fRF1_tmp, fRF2_tmp;  // Frf modulation frequencies
   real t, dt, phi;
   int Ns;  // Current number of samples
   
   int frev_Nsamples;  // Number of samples in Trev

   real y_under[$];  // Queue with undersampled data
   real y_orig[$];   // Queue with original data (FSK modulated)
   real y_sign_q[$]; // Queue with sign of original data
   
   real frev_sign_q[$];

   int Nper1, Nper2;
   real frev, frev_tmp, favg;   // Current Rev. freq and Avg. fRF
   int fRF1_Ns, fRF2_Ns;  // Number of samples per fRF
   
   function new();
      
      sample_freq = 1e10 ;      // Model sampling frequency : 10GHz 
      lp_sample_freq = 125e6;   // System sampling frequency: 125MHz
      lp_ratio = sample_freq/lp_sample_freq; // Downsampling ratio : 10GHz/125MHz = 80
      
      lp_sample_period = (1.0/lp_sample_freq);   // 8ns : system period
      
      frev_inj = 1/23.274213e-6;  // Rev. freq. @ injection  (~42.966 kHz)
      frev_top = 1/23.052932e-6;  // Rev. freq. @ top energy (~43.378 kHz)
      ramp_t = 20 ;               // Ramp duration [s]
      
      t=0;       // Current time
      Ns=0;      // Number of (model) samples treated 
      phi=0;     // current phase of RF signal

      $display("Undersampling freq %.0f", lp_sample_freq);
      
      dt = 1.0/sample_freq;       // Model sampling period : 100ps
         
   endfunction  // new

   // This function calculates the instant fRF
   function real f_rf(real t);
      
      real x;
      real D_BW;
      
      // frev increases along the beam acceleration ramp
      // here the value of frev at a particular t is calculated
      if (t < ramp_t)  //Frev ramp
         frev_tmp = frev_inj + (t / ramp_t) * (frev_top - frev_inj); //instant frev
      else
         frev_tmp = frev_top;

      //$display("Current ~frev %.0f", frev_tmp);

      // Number of samples the model contains in Trev[s] 
      // It changes along the ramp. At injection :232742; At top En.: 230529
      // 2213 samples difference along the ramp
      frev_Nsamples = ((1/frev_tmp) * sample_freq); 

      // Now I adjust frev so that the number of samples is exact:
      frev = sample_freq / frev_Nsamples;
      
      //$display("Current ~frev %.0f", frev);

      // Favg is the average frequency (fRF1 + fRF1)/2
      // The SPS harmonic number is 4620, this is the relation between
      // frev and fRF (for not FSK modulated fRF)
      // or frev and favg (for FSK modulated fRF)
      favg = 4620 * frev;   // (~198.5MHz @ inj)
      
      //$display("Current favg %.0f", favg);
      
      // fRF1 and fRF2 are different till transition energy and 
      // identical afterwards. Here we assume transition energy 
      // point at 80% of the ramp. 
      
      // I do not know what is the criteria for chosing fRF1 and fRF2
      // I assume they differ by 1.42MHz initially
      if (t < 0.8 * ramp_t) 
         D_BW = 1.42e6 - 1.42e6 * (t / (0.8 * ramp_t)); 
      else
         D_BW = 0;  
      
      // Inital aprox. values of fRF1 and fRF2
      fRF1_tmp = favg + D_BW; // (~199.93 MHz @ inj)
      fRF2_tmp = favg - D_BW; // f2 ~ 2*favg-fRF1
      
      //$display("Inital aprox. fRF1= %.0f and fRF2= %.0f", fRF1_tmp, fRF2_tmp);
      
      // Number of complete fRF1 periods in ~ half Trev : fRF1*(Trev/2)
      Nper1 = ( fRF1_tmp/ (2*frev) ); //(~2327 @ inj)
      
      // Number of samples per Trev where fRF=fRF1 (~116350 @ inj)
      fRF1_Ns = (Nper1 * (1/fRF1_tmp)) * sample_freq; 
      
      // now I can adjust fRF1 w.r.t. the aproximations done
      fRF1 = Nper1 * sample_freq / fRF1_Ns;
      
      //$display("Nper1= %.0f , fRF1_Ns= %.0f, fRF1= %.0f",Nper1, fRF1_Ns, fRF1);
      
      //Number of samples per Trev where fRF=fRF2 (~116392 @ inj)
      fRF2_Ns = frev_Nsamples - fRF1_Ns;
      
      // Nper2 * (1/fRF2) = (1/sample_freq) * fRF2_Ns
      // Let's call x = Nper2 * (1/fRF2)
      x = fRF2_Ns / sample_freq;
      Nper2 = (x * fRF2_tmp);
      
      // now I can adjust fRF2 w.r.t. the aproximations done
      fRF2 = Nper2/x;
      
      //$display("Nper2= %.0f , fRF2_Ns= %.0f, fRF2= %.0f",Nper2, fRF2_Ns, fRF2);
      
      if( Ns % frev_Nsamples < fRF1_Ns )
         return fRF1;
      else
         return fRF2;

   endfunction

   function real a_rf (real t);
       
      if( Ns % frev_Nsamples < fRF1_Ns )
	     return 1;
      else
	     return -1;
   endfunction // a_rf
   
   // This function calculates de amplitude value of the RF signals
   // Modeled at 10Gs/s : y_orig
   // Sampled by the system at 125MS/s : y_under
   function void run(int n);
      int  i;
      real y;
      
      for(i=0;i<n;i++)
      begin
	     y_sign_q.push_back(a_rf(t));
         
	     y=$sin(phi);
	     phi += 2.0*3.14159265358*f_rf(t) * dt;
	     y_orig.push_back(y);
	 
 	     if( (Ns % lp_ratio) == 0)  // System sampling
	        y_under.push_back(y);
	       
	     Ns++;
	     t+=dt;
      end
   endfunction // run

   function real y();
      if ( y_orig.size() == 0 )
	        run(10000);  // 1us

      return y_orig.pop_front();
   endfunction // y_orig

   function int y_size();
      return y_orig.size();
   endfunction // y_orig
   
   function real y_sign();
      if ( y_sign_q.size() == 0 )
	        run(10000);
  
      return y_sign_q.pop_front();
   endfunction // y_orig
   
   function real y_under_sample();
      if ( y_under.size() == 0 )
	        run(10000);

      return y_under.pop_front();
      
   endfunction // y_under_sample

   function int Get_Ns();
      return Ns;
   endfunction

   function int Get_fRF1_Ns();
      return fRF1_Ns;
   endfunction

   function int Get_fRF2_Ns();
      return fRF2_Ns;
   endfunction

   function int Get_frev_Nsamples();
      return frev_Nsamples;
   endfunction

   function real Get_fRF1();
     return fRF1;
   endfunction

   function real Get_fRF2();
     return fRF2;
   endfunction

   function real Get_frev();
     return frev;
   endfunction

   function real Get_favg();
     return favg;
   endfunction

   function int Get_Nper1();
     return Nper1;
   endfunction

   function int Get_Nper2();
     return Nper2;
   endfunction

   function real Get_phi();
     return phi;
   endfunction


endclass // RFGenerator



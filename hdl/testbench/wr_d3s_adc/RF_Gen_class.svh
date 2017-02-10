// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//      RFGenerator class : Generates a modulated RF sinewave
// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
class RFGenerator;
// Class generating a signal FSK modulated as the RF at the SPS during 
// ions runs. This model is a bit simplified since :
// 1) Trev is assumed to be constant.along the beam cycleand
// 2) The 2 fRF used in the FSK modulation are not linked to Trev 
//    so that there will be an integer number of complete periods.

   real sample_freq;
   int  lp_ratio;
   real lp_sample_freq;
   real lp_sample_period;
   real tune_start;
   real tune_end;
   real tune_t_max;
   real mod_period;
   real mod_f1, mod_f2;
   real t, dt, phi;
   
   uint64_t t_int;
   uint64_t mod_period_int;
   
   real y_under[$];  // Queue with undersampled data
   real y_orig[$];   // Queue with original data (FSK modulated)
   real y_sign_q[$]; // Queue with sign of original data
   
   function new();
      
      sample_freq = 1e10 ;     // Model sampling frequency : 10GHz 
      lp_sample_freq = 125e6;  // System sampling frequency: 125MHz
      lp_ratio = sample_freq/lp_sample_freq; // Downsampling ratio : 10GHz/125MHz = 80

      lp_sample_period = (1.0/lp_sample_freq);  // 8ns : system period
      
      tune_t_max = 20;            // Ramp duration [s]
      mod_period = 1.0/43.478e3;  // Trev (Assumed to be constant) : 23us
      
      tune_start = 0e6 ;
      tune_end = 3e6;             // FSK mod. BW : 3MHz
      mod_f1 = 190e6;             // FSK fixed frequency #1
      mod_f2 = 202e6;             // FSK fixed frequency #2

      t=0;
      t_int=0;
      phi=0;
      
      $display("Undersampling freq %.0f", lp_sample_freq);
      
      dt = 1.0/sample_freq;       // Model sampling period : 100ps
      
      mod_period_int = mod_period * sample_freq;
         
   endfunction  // new
   
   
   function real f_rf (real t);
      
      real f_base = tune_start + (t / tune_t_max) * (tune_end-tune_start);
      // f_base increments linearly 3MHz in 20s.

      if( t_int % mod_period_int < mod_period_int / 2 )
         return mod_f1 + f_base;  // Increments linearly between 190e6 - 193MHz
      else
         return mod_f2 + f_base;  // Increments linearly between 202e6 - 205MHz
      
   endfunction // f_rf
   
   function real a_rf (real t);
      
      if( t_int % mod_period_int < mod_period_int / 2 )
         return 1;
      else
         return -1;
   
   endfunction // a_rf
   
   function void run(int n);
      int  i;
      real y;
      
      for(i=0;i<n;i++)
      begin
         y_sign_q.push_back(a_rf(t));
         
         y=$cos(phi);
         phi += 2.0*3.14159265358*f_rf(t) * dt;
         y_orig.push_back(y);
         
         if( (t_int % lp_ratio) == 0)
            y_under.push_back(y);
         
         t_int++;
         t+=dt;
      end
   endfunction // run
   
   function real y();
      if ( y_orig.size() == 0 )
         run(10000);
      
      return y_orig.pop_front();
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
   
endclass // RFGenerator
// =-=-=-=-=-=-=-=-   END RFGenerator class   -=-=-=-=-=-=-=-=-=-=-


`include "wrn_cpu_csr_regs.vh"


class NodeCPUControl;
   protected CBusAccessor bus;
   protected uint32_t base;
   
   function new ( CBusAccessor bus_, input uint32_t base_);
      base = base_;
      bus = bus_;
   endfunction // new

   protected task writel ( uint32_t r, uint32_t v );
      bus.write ( base + r, v );
   endtask // _write

   protected task readl (  uint32_t r, ref uint32_t v );
      uint64_t tmp;
      bus.read (base + r, tmp );
      v= tmp;
   endtask // readl
   
   task init();
      uint32_t app_id, core_count;
      int i;
      
      
      readl(`ADDR_WRN_CPU_CSR_APP_ID, app_id);
      readl(`ADDR_WRN_CPU_CSR_CORE_COUNT, core_count);

      core_count&='hf;
      
      $display("App ID: %x", app_id);
      $display("Core count: %d", core_count);
      for(i=0;i<core_count;i++)
      begin
         uint32_t memsize;
         writel(`ADDR_WRN_CPU_CSR_CORE_SEL, i);
         readl(`ADDR_WRN_CPU_CSR_CORE_MEMSIZE, memsize);
         $display("Core %d: %d kB private memory", i, memsize/1024);
 
      end
      
      
      
      
   endtask // init

   task reset_core(int core, int reset);
      uint32_t rstr;
      readl(`ADDR_WRN_CPU_CSR_RESET, rstr);

      if(reset)
        rstr |= (1<<core);
      else
        rstr &= ~(1<<core);
      writel(`ADDR_WRN_CPU_CSR_RESET, rstr);
   endtask // enable_cpu


   task load_firmware(int core, string filename);
      integer f = $fopen(filename,"r");
      uint32_t q[$];
      int     n, i;
      
      reset_core(core, 1);

      writel(`ADDR_WRN_CPU_CSR_CORE_SEL, core);

      
      
      while(!$feof(f))
        begin
           int addr, data;
           string cmd;
           
           $fscanf(f,"%s %08x %08x", cmd,addr,data);
           if(cmd == "write")
             begin
                writel(`ADDR_WRN_CPU_CSR_UADDR, addr);
                writel(`ADDR_WRN_CPU_CSR_UDATA, data);
		q.push_back(data);
		n++;
		
             end
        end

      for(i=0;i<n;i++)
	begin
	   uint32_t rv;
           writel(`ADDR_WRN_CPU_CSR_UADDR, i);
           readl(`ADDR_WRN_CPU_CSR_UDATA, rv);
	   $display("readback: addr %x d %x", i, rv);
	   if(rv != q[i])
	     $display("verification error\n");
	   
	end
      
      
   endtask
        
      
      
   
   
   
endclass 



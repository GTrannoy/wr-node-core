import wishbone_pkg::*;
import wr_node_pkg::*;

`include "vhd_wishbone_master.svh"
`include "cpu_csr_driver.svh"
`include "mqueue_host.svh"
`include "mt_tpu_csr.vh"

class CWRNode;

   function  new ( CBusAccessor acc_, input uint32_t base_);

   endfunction // new
      
endclass // CWRNode

typedef struct {
   uint32_t timestamp;
   int 	       probe_id;
} tpu_sample_t;


class CMockTurtleTPU;

   static const int ACT_StartRecording = 0;
   static const int ACT_StopRecording = 1;
   static const int ACT_ProbeStart = 2;
   static const int ACT_ProbeEnd = 3;
   static const int ACT_Disabled = 'hf;
      

   protected CBusAccessor m_acc;
   protected uint32_t m_base;
   
   protected int m_n_channels;
   protected int m_buffer_size;

   task automatic writel ( uint32_t r, uint32_t v );
      m_acc.write ( m_base + r, v );
   endtask // _write

   task automatic readl (  uint32_t r, ref uint32_t v );
      uint64_t tmp;
      m_acc.read (m_base + r, tmp );
      
      v= tmp;
   endtask // readl

  
   function  new ( CBusAccessor acc, uint32_t base );
      m_acc = acc;
      m_base = base;
   endfunction // new

   task automatic init();
      uint32_t rv;
      readl( `ADDR_TPU_CSR, rv );
      if ( rv & `TPU_CSR_PRESENT )
	begin
	   int i;
	   
	   m_n_channels = (rv & `TPU_CSR_PROBE_COUNT) >> `TPU_CSR_PROBE_COUNT_OFFSET;
	   readl( `ADDR_TPU_BUF_SIZE, rv );
	   m_buffer_size = rv;
	   
	   $display("TPU found, channels = %d, buffer size = %d", m_n_channels, m_buffer_size);

	   for(i=0;i<m_n_channels;i++)
	     configure_probe( i, 0, ACT_Disabled, 0);
  
	end

      
      
      
      
   endtask // init

   task automatic restart();
      writel( `ADDR_TPU_CSR, 0 );
      writel( `ADDR_TPU_CSR, `TPU_CSR_ENABLE );
   endtask // star
   
   task automatic select_probe(int probe_id);
      uint32_t rv           ;
      readl( `ADDR_TPU_CSR, rv );
      rv &= ~`TPU_CSR_PROBE_SEL;
      rv |= (probe_id << `TPU_CSR_PROBE_SEL_OFFSET);
      writel( `ADDR_TPU_CSR, rv );
   endtask // select_probe
   
   
   task automatic configure_probe( int probe_id, int core_id, int action, uint32_t pc_match );
      uint32_t probe_csr;

      select_probe(probe_id);
      
      probe_csr = action << `TPU_PROBE_CSR_ACTION_OFFSET;
      probe_csr |= core_id << `TPU_PROBE_CSR_CORE_ID_OFFSET;
      probe_csr |= pc_match << `TPU_PROBE_CSR_PC_OFFSET;

      writel( `ADDR_TPU_PROBE_CSR, probe_csr );
   endtask // configure_probe

   task automatic show_probes();
      int i ;
      uint32_t action,core_id,pc_match;
      
      for (i=0; i<m_n_channels; i++)
	begin
	   uint32_t probe_csr;
	   select_probe(i);
	   readl( `ADDR_TPU_PROBE_CSR, probe_csr );


	   action = ( probe_csr & `TPU_PROBE_CSR_ACTION ) >> `TPU_PROBE_CSR_ACTION_OFFSET;
	   core_id = ( probe_csr & `TPU_PROBE_CSR_CORE_ID ) >> `TPU_PROBE_CSR_CORE_ID_OFFSET;
	   pc_match = ( probe_csr & `TPU_PROBE_CSR_PC ) >> `TPU_PROBE_CSR_PC_OFFSET;
	   $display("Probe %d: action %x core %d pc_match %x", i, action, core_id, pc_match);
	   
	end
      

   endtask // show_probes
   
	
   
   task automatic load_probes( string filename );
      int f=$fopen(filename,"r");
      string tag;
      
      
      while(!$feof(f))
	begin
	   $fscanf(f, "%s", tag);
	   if (tag == "config") begin
	      int id, core_id, ch, action, addr;
	      
	      $fscanf(f,"%x %x %x %x %x", ch, action, core_id, addr, id );
	      configure_probe(ch, core_id, action, addr );
	      
	   end
	   
	   
	end
      $fclose(f);
      
      
      
   endtask // load_probes

   task automatic poll( ref int ready );
      uint32_t rv           ;
      readl( `ADDR_TPU_CSR, rv );

      ready = rv &  `TPU_CSR_READY ? 1 : 0;
   endtask // poll

   task automatic read_samples ( ref tpu_sample_t samples[$] );
      uint32_t n_samples,rv ;
      int ready=0, i;
      
      
      while(!ready)
	begin
	   poll(ready);
	   #1us;
	end

      readl( `ADDR_TPU_BUF_COUNT, n_samples );
      n_samples++;
      
      
      $display("Got %d samples", n_samples);
      
      for(i=0;i<n_samples;i++)
	begin
	   uint32_t channel_id, tstamp;
	   
	   writel( `ADDR_TPU_BUF_ADDR, i );
	   readl( `ADDR_TPU_BUF_DATA, rv );

	   tstamp = (rv & `TPU_BUF_DATA_TSTAMP ) >> `TPU_BUF_DATA_TSTAMP_OFFSET;
	   channel_id = (rv & `TPU_BUF_DATA_ID ) >> `TPU_BUF_DATA_ID_OFFSET;
	   
	   
	   
	   $display("Sample %d probe %d ts %d", i, channel_id, tstamp);
	   
	   
     
	end
      
      
      
   endtask // read_samples
   

endclass // CMockTurtleTPU

   
module main;

   reg rst_n = 0;
   reg clk_sys = 0;
   reg clk_cpu = 0;

   always #4ns clk_cpu <= ~clk_cpu;
   always@(posedge clk_cpu)
     clk_sys <= ~clk_sys;
   
	       
   initial begin
      repeat(20) @(posedge clk_sys);
      rst_n = 1;
   end

   wire host_irq;   

   IVHDWishboneMaster Host ( clk_sys, rst_n );

   wr_node_core # (
		   .g_double_core_clock(1'b0)
		   )DUT (
			 .clk_i   (clk_sys),
			 .clk_cpu_i(clk_cpu),
			 .rst_n_i (rst_n),
			 .host_slave_i (Host.master.out),
			 .host_slave_o (Host.master.in),
			 .host_irq_o(host_irq)
			 );

   initial begin
      NodeCPUControl cpu_csr;
      MQueueHost hmq;
      uint64_t rv;
      CBusAccessor host_acc;
      CMockTurtleTPU tpu;
      tpu_sample_t trace[$];
      
      #10us;
      
      host_acc = Host.get_accessor();
      
      
      cpu_csr = new ( Host.get_accessor(), 'hc000 );
      hmq = new ( Host.get_accessor(), 0 );
      tpu = new ( Host.get_accessor(), 'hd000 );
      
      
      // enable all IRQs
      host_acc.write(`MQUEUE_GCR_IRQ_MASK, 'hffff);
      
      cpu_csr.init();
      tpu.init();
      tpu.load_probes("../../sw/probes-test-single/probes.dat");

      tpu.show_probes();
      tpu.restart();
      
      
      cpu_csr.load_firmware (0, "../../sw/probes-test-single/probes1.ram");
      cpu_csr.reset_core(0, 0);

      
      $display("CPU0 started\n");
      tpu.read_samples(trace);

      
      forever begin
	 cpu_csr.update();
         #1us;
	 @(posedge clk_sys);
      end

   end // initial begin
   

   
   
endmodule

`define MQUEUE_BASE_IN(x) ('h4000 + (x) * 'h400)
`define MQUEUE_BASE_OUT(x) ('h8000 + (x) * 'h400)

`define MQUEUE_CMD_CLAIM (1<<24)
`define MQUEUE_CMD_PURGE (1<<25)
`define MQUEUE_CMD_READY (1<<26)
`define MQUEUE_CMD_DISCARD (1<<27)

`define MQUEUE_SLOT_COMMAND 0
`define MQUEUE_SLOT_STATUS 4

`define MQUEUE_GCR_INCOMING_STATUS_MASK (32'h0000ffff)

`define MQUEUE_GCR_SLOT_COUNT 0
`define MQUEUE_GCR_SLOT_STATUS 4
`define MQUEUE_GCR_IRQ_MASK 8
`define MQUEUE_GCR_IRQ_COALESCE 12


class MQueueCB;
   protected CBusAccessor bus;
   protected uint32_t base;
   
   function new ( CBusAccessor bus_, input uint32_t base_);
      base = base_;
      bus = bus_;
   endfunction // new

   task outgoing_write ( int slot, uint32_t r, uint32_t v );
      
      bus.write ( base + `MQUEUE_BASE_OUT(slot) + r, v);
   endtask // slot_write
   
   
   task send(int slot, uint32_t data[] );
      int i;
      
      outgoing_write( slot, `MQUEUE_SLOT_COMMAND, `MQUEUE_CMD_CLAIM);
      for(i=0;i<data.size(); i++)
        outgoing_write( slot, 8 + i * 4, data[i]);
      outgoing_write( slot, `MQUEUE_SLOT_COMMAND, `MQUEUE_CMD_READY | data.size());
   endtask // send
   
endclass 

class MQueueHost;
   protected CBusAccessor bus;
   protected uint32_t base;
   protected bit initialized;

   protected int n_in, n_out;

   typedef struct {
      uint32_t data[$];
   } mqueue_message_t;
     
   typedef mqueue_message_t slot_queue_t[$];
      
   slot_queue_t slots_in[16], slots_out[16];
   
   function bit poll(int slot);
      return slots_in[slot].size() != 0;
   endfunction // poll

   function mqueue_message_t recv (int slot);
      mqueue_message_t tmp = slots_in[slot][$];
      slots_in[slot].pop_back();
      return tmp;
   endfunction

   task send (int slot, uint32_t data[$]);
      mqueue_message_t msg;
      msg.data = data;
      slots_out[slot].push_back(msg);
   endtask // send

   function int idle();
      int i;
      for(i=0;i<n_out;i++)
        if(slots_out[i].size())
          return 0;
      return 1;
   endfunction // idle
   
        
      
     
   
   function new( CBusAccessor bus_, input uint32_t base_);
      base = base_;
      bus = bus_;
      initialized = 0;
      
   endfunction // new
   
   task incoming_write ( int slot, uint32_t r, uint32_t v );
      
      bus.write ( base + `MQUEUE_BASE_IN(slot) + r, v );
   endtask // slot_write

   task incoming_read ( int slot, uint32_t r, ref uint32_t v );
      uint64_t tmp;
      
      bus.read ( base + `MQUEUE_BASE_IN(slot) + r, tmp );
      v= tmp;
      
   endtask // slot_write

   task outgoing_read ( int slot, uint32_t r, ref uint32_t v );
      uint64_t tmp;
      
      bus.read ( base + `MQUEUE_BASE_OUT(slot) + r, tmp );
      v= tmp;
   endtask // slot_write

   task outgoing_write ( int slot, uint32_t r, uint32_t v );
      bus.write ( base + `MQUEUE_BASE_OUT(slot) + r, v);
   endtask // slot_write

   
   task gcr_read ( uint32_t r, output uint32_t rv );
      uint64_t tmp;
      
      bus.read ( base + r, tmp );
      rv = tmp;
      
   endtask // gcr_read

   task outgoing_check_full( int slot, output int full );
      uint32_t rv;
      outgoing_read( slot, `MQUEUE_SLOT_STATUS, rv);
      full = (rv & 1) ? 1:  0;
   endtask // outgoing_full


   task incoming_send(int slot, uint32_t data[$] );
      int i;
      
      incoming_write( slot, `MQUEUE_SLOT_COMMAND, `MQUEUE_CMD_CLAIM);
      for(i=0;i<data.size(); i++)
        incoming_write( slot, 8 + i * 4, data[i]);
      incoming_write( slot, `MQUEUE_SLOT_COMMAND, `MQUEUE_CMD_READY | data.size());

      $display("in%d tx size=%d ", slot, data.size());

   endtask // send

   task init();
      uint32_t slot_count, slot_status;
      int i, entries, size;
      
      gcr_read(`MQUEUE_GCR_SLOT_COUNT, slot_count);

      n_in = slot_count & 'hff;
      n_out = (slot_count >> 8) & 'hff;

      $display("HMQ init: CPU->Host (outgoing) slots: %d Host->CPU (incoming) slots: %d", n_out, n_in);
      for(i =0 ; i<n_out; i++)begin
         outgoing_read(i, `MQUEUE_SLOT_STATUS, slot_status);
         size = 1 << (( slot_status >> 28) & 'hf);
         entries = 1 << (( slot_status >> 2) & 'h3f);
         
         $display(" - out%d: size=%d, entries=%d", i, size, entries);

      end

      for(i =0 ; i<n_in; i++)
        begin
         incoming_read(i, `MQUEUE_SLOT_STATUS, slot_status);
         size = 1 << (( slot_status >> 28) & 'hf);
         entries = 1 << (( slot_status >> 2) & 'h3f);
         
         $display(" - in%d: size=%d, entries=%d", i, size, entries);

      end
      
      initialized = 1;
      
   endtask // init

   task outgoing_input(int slot);
      uint32_t stat;
      int count, i;
      
      outgoing_read ( slot, `MQUEUE_SLOT_STATUS, stat );

      
      count = (stat >> 16) & 'hff;

      $display("slot stat %x", stat);
      
      
      $display("out%d rx size=%d ", slot, count);
      for(i=0;i<count;i++)begin
         uint32_t d;
         
         outgoing_read ( slot, 8 + i * 4, d );
         $display("data: %x", d);
      end

      outgoing_write( slot, `MQUEUE_SLOT_COMMAND, `MQUEUE_CMD_DISCARD );
      
      
   endtask // read_incoming
   
   task update();
      uint32_t in_stat;
      int i;
      
      
      if(!initialized)
        init();

      gcr_read( `MQUEUE_GCR_SLOT_STATUS, in_stat);

      $display("GCR stat %x", in_stat);
      

      if(in_stat & `MQUEUE_GCR_INCOMING_STATUS_MASK)
        begin
           for(i = 0; i < n_in ;i++)
             if(in_stat & (1<<i))
                  outgoing_input (i);
           
        end
      
      for(i = 0; i < n_out ;i++)
        begin
           if ( slots_out[i].size() )
             begin
                incoming_send(i, slots_out[i][$].data);
                slots_out[i].pop_back();
             end
        end
      
      
      
      
   endtask // update
   

      
   
endclass

  


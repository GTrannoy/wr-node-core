#include <stdint.h>

#include "mqueue.h"
#include "hw/wrn_cpu_lr.h"

static void delay(int n)
{
    int i;
    for(i=0;i<n;i++) asm volatile("nop");
}

#define CPU_LR_BASE 0x100000

static inline uint32_t lr_readl(uint32_t addr)
{
    return *(volatile uint32_t *) (CPU_LR_BASE + addr);
}

struct my_buffer {
  int a;
  int b;
  int c;
};

struct list_timestamp {
  uint32_t seconds;
  uint32_t cycles;
  uint32_t frac;
};

struct list_trigger_message {
  struct rmq_message_addr hdr;
  uint32_t system_id;
  uint32_t source_port_id;
  uint32_t trigger_id;
  uint32_t seq_id;
  struct list_timestamp ts;
};

main()
{
    int i;
    //   volatile struct my_buffer *buf = mq_send_buffer(0, 0);
    //    volatile struct list_trigger_message *msg = mq_send_buffer(0, 0);

#if 1 
    volatile struct my_buffer *tx = mq_map_out_buffer(0, 0);
    volatile struct my_buffer *rx = mq_map_in_buffer(0, 0);
    volatile struct list_trigger_message *rmq_tx = mq_map_out_buffer(1, 0);
#endif


/*    *(volatile uint32_t *) (0x200000) = 0;
    *(volatile uint32_t *) (0x200000) = 1;
    *(volatile uint32_t *) (0x200000) = 0;
    *(volatile uint32_t *) (0x200000) = 1;*/


//    mq_claim(0, 0);
//    mq_send (0, 0, 7);
	    i++;
//for(;;);

    for(;;)
    {
/*	if(mq_poll() & 1)
	{
	    mq_claim(0,0);
	    tx->a = i;
	    mq_send(0,0,1);
*/

	    mq_claim(1, 0);
	    rmq_tx->hdr.target_ip = 0xffffffff;
	    rmq_tx->hdr.target_port = 0xebd0;
	    rmq_tx->hdr.target_offset = 0x20000;
	    rmq_tx->system_id = 1;
	    rmq_tx->source_port_id = 2;
	    rmq_tx->trigger_id = 3;
	    rmq_tx->seq_id = 4;
	    rmq_tx->ts.seconds = lr_readl(WRN_CPU_LR_REG_TAI_SEC);
	    rmq_tx->ts.cycles  = lr_readl(WRN_CPU_LR_REG_TAI_CYCLES);

	    mq_send (1, 0, 20);

//	    mq_discard(0, 0);
	    i++;
//	}    

	delay(1000);
    }

#if 0
    i=0;
    for(;;)
    {
	mq_claim(0, 0);    
        tx->a = i;
	mq_send(0, 0, 1);
	i++;
    }

    for(;;)
      {
	if( mq_poll() & 1)
	    mq_discard(0, 0);
      }

/*        if(mq_poll() & 1)
          {
            mq_claim(0, 0);
            tx->a = rx->a + 1;
            tx->b = rx->b * 3;
            tx->c = 100 - rx->c;
            mq_send(0, 0, 3);
          }

       

      }

*/
#endif

    for(;;);
}

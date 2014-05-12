#include <stdint.h>

#include "mqueue.h"

static void delay(int n)
{
    int i;
    for(i=0;i<n;i++) asm volatile("nop");
}

struct my_buffer {
  int a;
  int b;
  int c;
};

struct list_timestamp {
  uint32_t seconds;
  uint32_t ticks;
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

/*    for(;;)
    {
	*(volatile uint32_t *) (0x200000) = 0xffffffff;
	delay(1000000);
	*(volatile uint32_t *) (0x200000) = 0x0;
	delay(1000000);

    }

*/

#if 1 
    volatile struct my_buffer *tx = mq_map_out_buffer(0, 0);
    volatile struct my_buffer *rx = mq_map_in_buffer(0, 0);
    volatile struct list_trigger_message *rmq_tx = mq_map_out_buffer(1, 0);
#endif

    i=0;
    for(;;)
    {
	mq_claim(0, 0);    
        tx->a = i;
	mq_send(0, 0, 1);
	i++;
	delay(1000000);
    }


}
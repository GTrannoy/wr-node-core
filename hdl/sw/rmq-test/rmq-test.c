#include "rt.h"


static inline void send()
{
    uint32_t *msg = mq_map_out_buffer(1, 0);

    mq_claim(1, 0);
//    static const uint8_t dst_mac[] =  {0xff,0xff,0xff,0xff,0xff,0xff};
  


    int i;
    for(i=0;i<16;i++)
    {
	msg[i] = i;
    }

    mq_send(1, 0, 4);
}

main()
{
  struct rmq_address bind_addr = {
    RMQ_FRAME_UDP,
    0,
  //  dst_mac,
    {0xff,0xff,0xff,0xff,0xff,0xff},
    0x800,
    0xffffffff,
    0xffffffff,
    0x1234,
    0xebd1
  };

  struct rmq_address bind_addr_in = {
    RMQ_FRAME_UDP,
    RMQ_FILTER_DST_PORT,
  //  dst_mac,
    {0xff,0xff,0xff,0xff,0xff,0xff},
    0x0,
    0x0,
    0x0,
    0x0,
    0xcafe
  };

    rmq_bind_out( 0, &bind_addr );
    rmq_bind_in(0, &bind_addr_in);
    send();

    for(;;)
    {
  
      int size = rmq_poll(0) >> 2;

      if(size)
      {
        int i;
        pp_printf("Rx: %d\n", size);
        volatile uint32_t *buf = mq_map_in_buffer(1, 0);

        for(i=0;i<size;i++) 

          pp_printf("Buf: %x\n", buf[i]);

        mq_discard(1, 0);      

      }

    }
}
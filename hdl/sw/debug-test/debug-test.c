/*
 * This work is part of the White Rabbit Node Core project.
 *
 * Copyright (C) 2013-2014 CERN (www.cern.ch)
 * Author: Tomasz Wlostowski <tomasz.wlostowski@cern.ch>
 *
 * Released according to the GNU GPL, version 2 or any later version.
 */

#include <string.h>
#include <stdint.h>

#include "rt.h"

uint32_t _lm32_read_ea()
{
  uint32_t r;
  asm volatile ("mv %0, ea" : "=r"(r) );
  return r;
}

uint32_t _lm32_read_err_addr()
{
  uint32_t r;
  asm volatile (".word 0x91800800\nmv %0,r1" : "=r"(r) : : "r1"); 
  return r;
}


void _exception_entry(int eid)
{
  
  pp_printf("Fatal exception %d at PC = 0x%x.\n", eid, _lm32_read_ea() );
  pp_printf("Offending memory address = 0x%x.\n",  _lm32_read_err_addr() );

  for(;;);
}

main()
{   
  volatile int n = 0;

    


      puts("Test\n");
 n = n / 0;
  
   
//  volatile int q = *(volatile int *)(0x100000); //lr_readl(0);

  pp_printf("Hello, world %d\n\r", n++);

//  *(volatile int *)(0xdeadbeef) = 0xfff;
  for(;;);
  for(;;)
  {
    volatile int x = mq_poll();

  }
/*  volatile uint32_t *msg = mq_map_out_buffer(0, 0);
  mq_claim(0, 0);
  msg[0] = 1;
  mq_enqueue(0, 0, 1);
  mq_claim(0, 0);
  msg[0] = 2;
  mq_enqueue(0, 0, 1);
  mq_claim(0, 0);
  msg[0] = 3;
  mq_enqueue(0, 0, 1);
  mq_commit(0, 0);*/

  for(;;);

}

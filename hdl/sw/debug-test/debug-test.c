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
  
//  pp_printf("Fatal exception %d at PC = 0x%x.\n", eid, _lm32_read_ea() );
//  pp_printf("Offending memory address = 0x%x.\n",  _lm32_read_err_addr() );

  for(;;);
}

main()
{   
  volatile int n = 0;

  puts("TEst\n");
  for(;;)
  {
//    dp_writel(1, 0x1008);
    volatile int x = dp_readl(0x1008);
    puts("read\n");
  }
#if 0
  asm volatile("nop\nnop\nnop");

    if(x&1)
      puts("1 ");
    else
      puts("0 ");

  asm volatile("nop\nnop\nnop");

/*    dp_writel(1, 0x100c);
    x = dp_readl(0x1008);
    if(x&1)
      puts("1 "); 
    else
      puts("0 ");

    puts(" \n");

    dp_writel(2, 0x1008);
    dp_writel(2, 0x100c);*/
  }
#endif

  for(;;);

}

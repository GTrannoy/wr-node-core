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

SMEM int dupa;

main()
{   
  volatile int n = 0;

  volatile void *ptr = &dupa;

  *(volatile uint32_t*)(ptr) = 0;
  pp_printf("%x\n",*(volatile uint32_t*)(ptr));

  *(volatile uint8_t*)(ptr) = 0xde;
  pp_printf("%x\n",*(volatile uint32_t*)(ptr));

  *(volatile uint8_t*)(ptr+1) = 0xad;
  pp_printf("%x\n",*(volatile uint32_t*)(ptr));

  *(volatile uint8_t*)(ptr+2) = 0xbe;
  pp_printf("%x\n",*(volatile uint32_t*)(ptr));

  *(volatile uint8_t*)(ptr+3) = 0xef;
  pp_printf("%x\n",*(volatile uint32_t*)(ptr));
  
  pp_printf("%p\n",ptr);

}

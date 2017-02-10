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
#include "hw/TrevGen_wb_slave.h"
#include "hw/wr_d3s_adc_slave.h"

#define BASE_D3S_ADC_SLAVE 0x2000  // Base address of D3S_ADC_SLAVE core 
#define BASE_TrevGen 0x100  //Trev Generator

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

  puts("Test\n");
   
    for (n=1;n<3;n++) 
    {
       volatile int WR_cycles = lr_readl(WRN_CPU_LR_REG_TAI_CYCLES);
       volatile int next_Trev_ts_ns = (WR_cycles + 100 <<3) ;
       // Try to write something to d3s_adc_slave
         
       dp_writel(next_Trev_ts_ns     , BASE_D3S_ADC_SLAVE + D3SS_REG_FREV_TS_NS);
       dp_writel( D3SS_FREV_CR_VALID , BASE_D3S_ADC_SLAVE + D3SS_REG_FREV_CR);
       dp_writel(~D3SS_FREV_CR_VALID , BASE_D3S_ADC_SLAVE + D3SS_REG_FREV_CR);

       // Try to write something to TrevGenerator
       dp_writel(next_Trev_ts_ns    , BASE_D3S_ADC_SLAVE + BASE_TrevGen + TREVGEN_REG_RM_NEXT_TICK);  
       dp_writel(next_Trev_ts_ns    , BASE_D3S_ADC_SLAVE + BASE_TrevGen + TREVGEN_REG_STROBE_P);
   }

  for(;;);

}

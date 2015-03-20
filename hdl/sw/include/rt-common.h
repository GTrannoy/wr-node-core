/*
 * This work is part of the White Rabbit Node Core project.
 *
 * Copyright (C) 2013-2014 CERN (www.cern.ch)
 * Author: Tomasz Wlostowski <tomasz.wlostowski@cern.ch>
 *
 * Released according to the GNU GPL, version 2 or any later version.
 */


/*.
 * White Rabbit Node Core
 *
 * rt-common.h: common WRN CPU definitions and routines
 */

#ifndef __RT_COMMON_H
#define __RT_COMMON_H

#include <stdint.h>
#include <stdio.h>

#include "hw/wrn_cpu_lr.h"

/* Dedicated Peripheral base */
#define CPU_DP_BASE 0x200000

/* CPU Local Registers base */
#define CPU_LR_BASE 0x100000

void rt_set_debug_slot(int slot);

static inline uint32_t dp_readl ( uint32_t reg )
{
  return *(volatile uint32_t *) ( reg + CPU_DP_BASE );
}

static inline void dp_writel ( uint32_t value, uint32_t reg )
{
     *(volatile uint32_t *) ( reg + CPU_DP_BASE ) = value;
}

static inline uint32_t lr_readl ( uint32_t reg )
{
  return *(volatile uint32_t *) ( reg + CPU_LR_BASE );
}

static inline uint32_t lr_writel ( uint32_t value, uint32_t reg )
{
  *(volatile uint32_t *) ( reg + CPU_LR_BASE ) = value;
}

static inline void gpio_set ( int pin )
{
    lr_writel ( (1<<pin), WRN_CPU_LR_REG_GPIO_SET );
}

static inline void gpio_clear ( int pin )
{
    lr_writel ( (1<<pin), WRN_CPU_LR_REG_GPIO_CLEAR );
}

/* fixme: use Timing Unit */
static inline void delay(int n)
{
    int i;
    for(i=0;i<n;i++) asm volatile("nop");
}

#endif

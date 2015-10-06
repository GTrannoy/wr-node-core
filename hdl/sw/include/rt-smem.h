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
 * rt-smem.h: Shared Memory definitions & API
 */

#ifndef __WRNODE_SMEM_H
#define __WRNODE_SMEM_H

#define SMEM_RANGE_ADD 0x10000
#define SMEM_RANGE_SUB 0x20000
#define SMEM_RANGE_SET 0x30000
#define SMEM_RANGE_CLEAR 0x40000
#define SMEM_RANGE_FLIP 0x50000
#define SMEM_RANGE_TEST_AND_SET 0x60000

#define SMEM __attribute__((section(".smem")))

static inline void smem_atomic_add(int *p, int x)
{
  *(volatile int *)(p + (SMEM_RANGE_ADD >> 2)) = x;
}

static inline void smem_atomic_sub(int *p, int x)
{
  *(volatile int *)(p + (SMEM_RANGE_SUB >> 2)) = x;
}

static inline int smem_atomic_test_and_set(int *p)
{
    return  *(volatile int *)(p + (SMEM_RANGE_TEST_AND_SET >> 2));
}

#endif

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
 * rt-mqueue.h: Message Queues definitions and functions
 */

#ifndef __RT_MQUEUE_H
#define __RT_MQUEUE_H

#define REG_LR_POLL    0x100000

/* MQ Base addresses */
#define HMQ_BASE           0x40010000
#define RMQ_BASE           0x40020000

/* MQ Slot offsets */
#define MQ_GCR       (0x0)
#define MQ_IN(slot)  (0x4000 + (slot) * 0x400)
#define MQ_OUT(slot) (0x8000 + (slot) * 0x400)

/* MQ Commands */
#define MQ_CMD_CLAIM (1 << 24)
#define MQ_CMD_PURGE (1 << 25)
#define MQ_CMD_READY (1 << 26)
#define MQ_CMD_DISCARD (1 << 27)

/* MQ Registers */
#define MQ_SLOT_COMMAND 0
#define MQ_SLOT_STATUS 4
#define MQ_SLOT_DATA_START 8

struct rmq_message_addr {
    uint32_t target_ip;
    uint32_t target_port;
    uint32_t target_offset;
};

static inline void mq_writel( int remote, uint32_t val, uint32_t reg )
{
  if(remote)
    * (volatile uint32_t * ) (RMQ_BASE + reg) = val ;
  else
    * (volatile uint32_t * ) (HMQ_BASE + reg) = val ;
}

static inline void mq_claim (int remote, int slot)
{
  mq_writel ( remote, MQ_CMD_CLAIM, MQ_OUT(slot) + MQ_SLOT_COMMAND );
}

static inline void mq_send( int remote, int slot, int count)
{
  mq_writel ( remote, MQ_CMD_READY | count, MQ_OUT(slot) + MQ_SLOT_COMMAND );
}

static inline void mq_discard (int remote, int slot)
{
  mq_writel ( remote, MQ_CMD_DISCARD, MQ_IN(slot) );
}

static void *mq_map_out_buffer(int remote, int slot)
{
  uint32_t base = remote ? RMQ_BASE : HMQ_BASE;
  return (void *) (base + MQ_OUT (slot) + MQ_SLOT_DATA_START );
}

static void *mq_map_in_buffer(int remote, int slot)
{
  uint32_t base = remote ? RMQ_BASE : HMQ_BASE;
  return (void *) (base + MQ_IN (slot) + MQ_SLOT_DATA_START );
}

static inline uint32_t mq_poll()
{
  return *(volatile uint32_t *) ( REG_LR_POLL );
}

static inline uint32_t rmq_poll(int slot)
{
  return *(volatile uint32_t *) ( REG_LR_POLL ) & ( 1<< (16 + slot ));
}

#endif

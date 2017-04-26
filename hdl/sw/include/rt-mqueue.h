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
#define HMQ_BASE           0x40000000
#define RMQ_BASE           0x40100000

/* MQ Slot offsets */
#define MQ_GCR       (0x0)
#define MQ_IN(slot)  (0x4000 + (slot) * 0x1000)
#define MQ_OUT(slot) (0x8000 + (slot) * 0x1000)

/* MQ Commands */
#define MQ_CMD_CLAIM (1 << 24)
#define MQ_CMD_PURGE (1 << 25)
#define MQ_CMD_READY (1 << 26)
#define MQ_CMD_DISCARD (1 << 27)
#define MQ_CMD_ENQUEUE (1 << 29)
#define MQ_CMD_COMMIT (1 << 30)

/* MQ Registers */
#define MQ_SLOT_COMMAND 0
#define MQ_SLOT_STATUS 4
#define MQ_SLOT_DATA_START 8

#define RMQ_SLOT_OUT_CONFIG 8
#define RMQ_SLOT_OUT_MAC_HI 12
#define RMQ_SLOT_OUT_MAC_LO 16
#define RMQ_SLOT_OUT_ETHERTYPE 20
#define RMQ_SLOT_OUT_DST_IP 24
#define RMQ_SLOT_OUT_SRC_IP 28
#define RMQ_SLOT_OUT_DST_PORT 32
#define RMQ_SLOT_OUT_SRC_PORT 36

#define RMQ_SLOT_DATA_START 128

#define RMQ_FRAME_RAW 0
#define RMQ_FRAME_UDP 1
#define RMQ_FRAME_TLV 2

#define RMQ_FILTER_RAW (1<<2)
#define RMQ_FILTER_UDP (1<<0)
#define RMQ_FILTER_DST_PORT  (1<<5)
#define RMQ_FILTER_ETHERTYPE (1<<5)
#define RMQ_FILTER_DST_MAC   (1<<3)
#define RMQ_FILTER_DST_IP   (1<<6)
#define RMQ_FILTER_TLV0   (1<<7)
#define RMQ_FILTER_TLV1   (1<<8)
#define RMQ_FILTER_TLV2   (1<<9)
#define RMQ_FILTER_TLV3   (1<<10)

#define RMQ_SLOT_IN_CONFIG 8
#define RMQ_SLOT_IN_DST_MAC_HI 12
#define RMQ_SLOT_IN_DST_MAC_LO 16
#define RMQ_SLOT_IN_ETHERTYPE 20
#define RMQ_SLOT_IN_DST_IP 24
#define RMQ_SLOT_IN_DST_PORT 28
#define RMQ_SLOT_IN_DST_TYPE0 32
#define RMQ_SLOT_IN_DST_TYPE1 36
#define RMQ_SLOT_IN_DST_TYPE2 40
#define RMQ_SLOT_IN_DST_TYPE3 44


struct rmq_address {


  uint32_t type;
  uint32_t filter;

  uint8_t dst_mac[6];
  uint16_t ethertype;
  uint32_t src_ip;
  uint32_t dst_ip;
  uint16_t src_port;
  uint16_t dst_port;

  uint32_t tlvs[4];
};


static inline void mq_writel( int remote, uint32_t val, uint32_t reg )
{
  if(remote)
    * (volatile uint32_t * ) (RMQ_BASE + reg) = val ;
  else
    * (volatile uint32_t * ) (HMQ_BASE + reg) = val ;
}


static inline uint32_t mq_readl( int remote, uint32_t reg )
{
  if(remote)
    return * (volatile uint32_t * ) (RMQ_BASE + reg) ;
  else
    return * (volatile uint32_t * ) (HMQ_BASE + reg) ;
}

static inline void mq_claim (int remote, int slot)
{
  mq_writel ( remote, MQ_CMD_CLAIM, MQ_OUT(slot) + MQ_SLOT_COMMAND );
}

static inline void mq_enqueue (int remote, int slot, int count)
{
  mq_writel ( remote, MQ_CMD_ENQUEUE | count, MQ_OUT(slot) + MQ_SLOT_COMMAND );
}

static inline void mq_commit (int remote, int slot)
{
  mq_writel ( remote, MQ_CMD_COMMIT, MQ_OUT(slot) + MQ_SLOT_COMMAND );
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
  if(remote)
    return (void *) (base + MQ_OUT (slot) + RMQ_SLOT_DATA_START );
  else
    return (void *) (base + MQ_OUT (slot) + MQ_SLOT_DATA_START );
}

static void *mq_map_in_buffer(int remote, int slot)
{
  uint32_t base = remote ? RMQ_BASE : HMQ_BASE;

  if(remote)
    return (void *) (base + MQ_IN (slot) + RMQ_SLOT_DATA_START );
  else
    return (void *) (base + MQ_IN (slot) + MQ_SLOT_DATA_START );


}

static inline uint32_t mq_poll()
{
  return *(volatile uint32_t *) ( REG_LR_POLL );
}

static inline uint32_t rmq_poll(int slot)
{
  int ready = *(volatile uint32_t *) ( REG_LR_POLL ) & ( 1<< (16 + slot ));

  if( ready )
  {
    uint32_t status = mq_readl( 1, MQ_IN(slot) + MQ_SLOT_STATUS );
    return ( status >> 16) & 0xfff;
  }
  
  return 0;
}

static inline void rmq_bind_in ( int slot, struct rmq_address* addr )
{
  uint32_t cfg = 0;

  switch(addr->type)
  {
    case RMQ_FRAME_UDP:
      cfg |= RMQ_FILTER_UDP;
      break;
    case RMQ_FRAME_TLV:
      cfg |= RMQ_FILTER_UDP;
      break;
    case RMQ_FRAME_RAW:
      cfg |= RMQ_FILTER_RAW;
      break;
  }

  cfg |= addr->filter;
  uint32_t tmp;
  mq_writel( 1, cfg, MQ_IN(slot) + RMQ_SLOT_IN_CONFIG );
  tmp = ( (uint32_t)addr->dst_mac[0] << 8 ) | addr->dst_mac[1];

  mq_writel( 1, tmp, MQ_IN(slot) + RMQ_SLOT_IN_DST_MAC_HI );
  tmp = ( (uint32_t)addr->dst_mac[2] << 24 ) |
( (uint32_t)addr->dst_mac[3] << 16 ) |
( (uint32_t)addr->dst_mac[4] << 8 ) |
( (uint32_t)addr->dst_mac[5] << 0 );

  mq_writel( 1, tmp, MQ_IN(slot) + RMQ_SLOT_IN_DST_MAC_LO );
  mq_writel( 1, addr->ethertype, MQ_IN(slot) + RMQ_SLOT_IN_ETHERTYPE );
  mq_writel( 1, addr->dst_ip, MQ_IN(slot) + RMQ_SLOT_IN_DST_IP );
  mq_writel( 1, addr->dst_port, MQ_IN(slot) + RMQ_SLOT_IN_DST_PORT );

}

static inline void rmq_bind_out ( int slot, struct rmq_address* addr )
{
  uint32_t tmp;
  mq_writel( 1, addr->type == RMQ_FRAME_UDP ? 1 : 0, MQ_OUT(slot) + RMQ_SLOT_OUT_CONFIG );
  tmp = ( (uint32_t)addr->dst_mac[0] << 8 ) | addr->dst_mac[1];
  mq_writel( 1, tmp, MQ_OUT(slot) + RMQ_SLOT_OUT_MAC_HI );
  tmp = ( (uint32_t)addr->dst_mac[2] << 24 ) |
( (uint32_t)addr->dst_mac[3] << 16 ) |
( (uint32_t)addr->dst_mac[4] << 8 ) |
( (uint32_t)addr->dst_mac[5] << 0 );

  mq_writel( 1, tmp, MQ_OUT(slot) + RMQ_SLOT_OUT_MAC_LO );
  mq_writel( 1, addr->ethertype, MQ_OUT(slot) + RMQ_SLOT_OUT_ETHERTYPE );
  mq_writel( 1, addr->src_ip, MQ_OUT(slot) + RMQ_SLOT_OUT_SRC_IP );
  mq_writel( 1, addr->dst_ip, MQ_OUT(slot) + RMQ_SLOT_OUT_DST_IP );
  mq_writel( 1, addr->src_port, MQ_OUT(slot) + RMQ_SLOT_OUT_SRC_PORT );
  mq_writel( 1, addr->dst_port, MQ_OUT(slot) + RMQ_SLOT_OUT_DST_PORT );


}


#endif

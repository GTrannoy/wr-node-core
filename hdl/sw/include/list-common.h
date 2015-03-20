/*
 * This work is part of the White Rabbit Node Core project.
 *
 * Copyright (C) 2013-2014 CERN (www.cern.ch)
 * Author: Tomasz Wlostowski <tomasz.wlostowski@cern.ch>
 *
 * Released according to the GNU GPL, version 2 or any later version.
 */


/*.
 * LHC Instability Trigger Distribution (LIST) Firmware.
 *
 * list-common.h: common structures and definitions
 */

#ifndef __LIST_COMMON_H
#define __LIST_COMMON_H

#ifdef WRNODE_RT

/* Mqueue slots assigned to the TDC/FD mezzanines */

#define TDC_IN_SLOT_CONTROL 0
#define TDC_OUT_SLOT_CONTROL 0

#define FD_IN_SLOT_CONTROL 1
#define FD_OUT_SLOT_CONTROL 1

#define TDC_OUT_SLOT_LOGGING 2
#define FD_OUT_SLOT_LOGGING 3

#define TDC_OUT_SLOT_REMOTE 0
#define FD_IN_SLOT_REMOTE 0

#endif

/* Command and log message IDs */
#define ID_LOG_RAW_INPUT	  	 0x1
#define ID_LOG_SENT_TRIGGER 	 0x2

#define ID_TDC_CMD_CHAN_ENABLE	 		        0x1
#define ID_TDC_CMD_CHAN_SET_DEAD_TIME       0x2
#define ID_TDC_CMD_CHAN_SET_DELAY 		      0x3
#define ID_TDC_CMD_CHAN_GET_STATE 		      0x4
#define ID_TDC_CMD_CHAN_ARM	 		            0x5
#define ID_TDC_CMD_CHAN_SET_MODE 		        0x7
#define ID_TDC_CMD_CHAN_SET_SEQ 	       	  0x8
#define ID_TDC_CMD_CHAN_ASSIGN_TRIGGER 		  0x9
#define ID_TDC_CMD_CHAN_SET_FLAGS 		      0xa
#define ID_TDC_CMD_CHAN_SET_TIMEBASE_OFFSET	0xb
#define ID_TDC_CMD_PING                     0xc
#define ID_TDC_CMD_SOFTWARE_TRIGGER         0xd
#define ID_TDC_CMD_CHAN_SET_LOG_LEVEL       0xe
#define ID_TDC_CMD_CHAN_RESET_COUNTERS      0xf


#define ID_FD_CMD_CHAN_ENABLE               0x1
#define ID_FD_CMD_CHAN_ASSIGN_TRIGGER       0x2
#define ID_FD_CMD_READ_HASH	    0x3
#define ID_FD_CMD_CHAN_REMOVE_TRIGGER       0x4
#define ID_FD_CMD_CHAN_GET_STATE            0x5
#define ID_FD_CMD_CHAN_SET_DELAY            0x6
#define ID_FD_CMD_CHAN_SET_WIDTH            0x7
#define ID_FD_CMD_CHAN_SET_MODE             0x8
#define ID_FD_CMD_SOFTWARE_TRIGGER          0x9
#define ID_FD_CMD_CHAN_ARM                  0xa

#define ID_REP_ACK			0x100
#define ID_REP_STATE			0x101
#define ID_REP_NACK			0x102
#define ID_REP_TRIGGER_HANDLE		0x103
#define ID_REP_HASH_ENTRY		0x104

#define TDC_NUM_CHANNELS 5
#define TDC_TRIGGER_COALESCE_LIMIT 5

#define FD_NUM_CHANNELS 4
#define FD_HASH_ENTRIES 128
#define FD_MAX_QUEUE_PULSES 16

/*!..
 * This enum is used by list_in_set_trigger_mode() and list_out_set_trigger_mode() to set input/output triggering mode.
  */
enum list_trigger_mode {
    LIST_TRIGGER_MODE_SINGLE = 1, /*!< In SINGLE mode, the input/output will trigger only on the 1st pulse/trigger message after arming.*/
    LIST_TRIGGER_MODE_AUTO = 2    /*!< In AUTO mode, the input/output will trigger on every pulse/trigger message.*/
};

/*!
 * This enum is used in list_input_state / list_output_state structures to pass state information 
 */
enum list_io_flags {                
    LIST_ENABLED = (1 << 0),          /*!< I/O is physically enabled */
    LIST_TRIGGER_ASSIGNED = (1 << 1), /*!< I/O is has a trigger assigned */
    LIST_LAST_VALID = (1 << 2),       /*!< I/O processed at least one pulse. It's timestamp/ID is in the "last" field. */
    LIST_ARMED = (1 << 3),            /*!< I/O is armed */
    LIST_TRIGGERED = (1 << 4),        /*!< I/O has triggered */
    LIST_WR_TIMING_OK = (1 << 5)      /*!< The output has correct WR time */
};

enum list_log_level {
    LIST_LOG_NOTHING = 0,
    LIST_LOG_RAW = (1 << 0),        /*!< Input only: log all pulses coming to the TDC input */
    LIST_LOG_SENT = (1 << 1),       /*!< Input only: log all sent triggers */
    LIST_LOG_PROMISC = (1 << 2),    /*!< Output only: promiscious mode - log all trigger messages received from WR network */
    LIST_LOG_FILTERED = (1 << 3),   /*!< Output only: log all trigger messages that have been assigned to the output */
    LIST_LOG_EXECUTED = (1 << 4),   /*!< Output only: log all triggers executed on the output */
    LIST_LOG_MISSED   = (1 << 5),   /*!< Output only: log all triggers missed by the output */

    LIST_LOG_ALL = 0xff
};

#define HASH_ENT_EMPTY          0
#define HASH_ENT_DIRECT         (1<<0)
#define HASH_ENT_CONDITION      (1<<1)
#define HASH_ENT_CONDITIONAL    (1<<2)
#define HASH_ENT_DISABLED       (1<<3)

struct list_timestamp {
  int32_t seconds;
  int32_t cycles;
  int32_t frac;
};

struct list_id 
{
  uint32_t system;
  uint32_t source_port;
  uint32_t trigger;
};

struct list_trigger_entry {
     struct list_timestamp ts;
     struct list_id id;
     uint32_t seq;
};


struct list_log_entry {
    uint32_t type;
    uint32_t seq;
    int channel;
    struct list_id id;
    struct list_timestamp ts;
};

#ifdef WRNODE_RT
struct list_trigger_message {
  struct rmq_message_addr hdr;
  uint32_t transmit_seconds;
  uint32_t transmit_cycles;
  int count;
  struct list_trigger_entry triggers[TDC_TRIGGER_COALESCE_LIMIT];
};
#endif


#ifdef WRNODE_RT
static inline void ts_add(struct list_timestamp *a, const struct list_timestamp *b)
{
    a->frac += b->frac;

    if(a->frac >= 4096)
    {
    	a->frac -= 4096;
    	a->cycles ++;
    }

    a->cycles += b->cycles;

    if(a->cycles >= 125000000)
    {
    	a->cycles -= 125000000;
    	a->seconds++;
    }

    a->seconds += b->seconds;
}

static inline void ts_sub(struct list_timestamp *a, const struct list_timestamp *b)
{
    a->frac -= b->frac;

    if(a->frac < 0)
    {
    	a->frac += 4096;
    	a->cycles --;
    }

    a->cycles -= b->cycles;

    if(a->cycles < 0)
    {
    	a->cycles += 125000000;
    	a->seconds--;
    }

    a->seconds -= b->seconds;

    if(a->seconds == -1)
    {
      a->seconds = 0;
      a->cycles -= 125000000;
    }
}
#endif

#endif

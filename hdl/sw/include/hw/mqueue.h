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
 * mqueue.h: MQ register definitions (Host side)
 */

#ifndef __MQUEUE_H
#define __MQUEUE_H

// Nax number of supported incoming/outgoing slots
#define MAX_MQUEUE_SLOTS 16

// HMQ base address (wrs to the base addr of the WR Node Core)
#define BASE_HMQ        0x00000

// Global Control Registers base address, relative to BASE_HMQ (SLOT_COUNT, SLOT_STATUS, interrupt control, etc). 
// Common for all incoming/outgoing slots in the queue
#define MQUEUE_BASE_GCR       (0x0)
// Incoming slot base address, relative to BASE_HMQ
#define MQUEUE_BASE_IN(slot)  (0x4000 + (slot) * 0x400)
// Outgoung slot base address, relative to BASE_HMQ
#define MQUEUE_BASE_OUT(slot) (0x8000 + (slot) * 0x400)


// MQ slot registers, relative to the base address of each slot: MQUEUE_BASE_IN(slot_no) or MQUEUE_BASE_OUT(slot_no)
#define MQUEUE_SLOT_COMMAND 0
// Status register
#define MQUEUE_SLOT_STATUS 4
// Start of data block
#define MQUEUE_SLOT_DATA_START 8

// Layout of MQUEUE_SLOT_COMMAND register:

// Claim: prepares a slot to send a message (w/o)
#define MQUEUE_CMD_CLAIM (1<<24)

// Purge: erases all messages from a slot (w/o)
#define MQUEUE_CMD_PURGE (1<<25)

// Ready: pushes the message to the queue. (w/o)
#define MQUEUE_CMD_READY (1<<26)

// Discard: removes last message from the queue, advancing to the next one (w/o)
#define MQUEUE_CMD_DISCARD (1<<27)

// Size of the message to be sent, in words (w/o). Must be written together with the
// READY command, e.g.:
// writel (MQUEUE_CMD_READY | 10, MQUEUE_SLOT_COMMAND);
#define MQUEUE_CMD_MSG_SIZE_MASK 0xff
#define MQUEUE_CMD_MSG_SIZE_SHIFT 0

// Layout of MQUEUE_SLOT_STATUS register:

// [0] Slot is full
#define MQUEUE_SLOT_STATUS_FULL (1<<0)
// [1] Slot is empty
#define MQUEUE_SLOT_STATUS_EMPTY (1<<1)

// [15:8] Number of occupied entries 
#define MQUEUE_SLOT_STATUS_OCCUPIED_SHIFT 8
#define MQUEUE_SLOT_STATUS_OCCUPIED_MASK  0xff00

// [23:16] Number of transferred words in the message currently on top of the slot
#define MQUEUE_SLOT_STATUS_MSG_SIZE_SHIFT 16
#define MQUEUE_SLOT_STATUS_MSG_SIZE_MASK  0xff0000

// [31:28] log2(number of words in the slot).
#define MQUEUE_SLOT_STATUS_LOG2_WIDTH_SHIFT 28
#define MQUEUE_SLOT_STATUS_LOG2_WIDTH_MASK  0xf0000000

// [7:2] log2(number of entries in the slot).
#define MQUEUE_SLOT_STATUS_LOG2_ENTRIES_SHIFT 2
#define MQUEUE_SLOT_STATUS_LOG2_ENTRIES_MASK  0xfc

//
// MQ Global Control Registers.Adresses relative to MQUEUE_BASE_GCR:
//
#define MQUEUE_GCR_INCOMING_STATUS_MASK (0x0000ffff)

// Number of slots in this implementation of HMQ
#define MQUEUE_GCR_SLOT_COUNT 0
// EMPTY bits of all slots in a single register (for polling/IRQ status)
#define MQUEUE_GCR_SLOT_STATUS 4
// Interrupt mask (Outgoing: EMPTY, Incoming: not EMPTY)
#define MQUEUE_GCR_IRQ_MASK 8
// IRQ Coalescing register (reserved for future use)
#define MQUEUE_GCR_IRQ_COALESCE 12

// Layout of SLOT_COUNT register

// [7:0] Number of Incoming slots
#define MQUEUE_GCR_SLOT_COUNT_N_IN_SHIFT 0
#define MQUEUE_GCR_SLOT_COUNT_N_IN_MASK 0xff

// [15:8] Number of Outgoing slots
#define MQUEUE_GCR_SLOT_COUNT_N_OUT_SHIFT 8
#define MQUEUE_GCR_SLOT_COUNT_N_OUT_MASK 0xff00

// Layout of SLOT_STATUS register

// [15:0] Outgoing slots status. Each bit indicates a NOT EMPTY status of the corresponding outgoing slot
#define MQUEUE_GCR_SLOT_STATUS_OUT_SHIFT 0
#define MQUEUE_GCR_SLOT_STATUS_OUT_MASK 0xffff

// [31:16] Incoming slots status. Each bit indicates an EMPTY status of the corresponding incoming slot
#define MQUEUE_GCR_SLOT_STATUS_IN_SHIFT 16
#define MQUEUE_GCR_SLOT_STATUS_IN_MASK 0xffff0000

// Layout of IRQ_MASK register

// [15:0] Outgoing slots status interrupt mask. Each bit enables generation of interrupt on NOT EMPTY status of the corresponding outgoing slot.
#define MQUEUE_GCR_IRQ_MASK_OUT_SHIFT 0
#define MQUEUE_GCR_IRQ_MASK_OUT_MASK 0xffff

// [31:16] Incoming slots status interrupt mask. Each bit enables generation of interrupt on EMPTY status of the corresponding incoming slot.
#define MQUEUE_GCR_IRQ_MASK_IN_SHIFT 16
#define MQUEUE_GCR_IRQ_MASK_IN_MASK 0xffff0000

// Layout of IRQ_COALSESCE register
// The register is left for future IRQ coalescing support (if ever needed)

#endif

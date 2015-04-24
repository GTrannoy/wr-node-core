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
 * rt-message.h: Message assembling helper functions
 */

#ifndef __RT_MESSAGE_H
#define __RT_MESSAGE_H

#ifdef WRNODE_RT

#include "wrtd-common.h"

enum wrnc_msg_direction {
    WRNC_MSG_DIR_SEND = 0,
    WRNC_MSG_DIR_RECEIVE = 1
};

struct wrnc_msg {
	uint32_t datalen; /**< payload length*/
	volatile uint32_t *data; /**< payload */
	uint32_t max_size; /**< maximum message size for chosen slot */
	uint32_t offset; /**< serialization/deserialization offset */
	enum wrnc_msg_direction direction; /**< serialization direction (used by wrnc_msg_x functions) */
	int error; /** serialization error status */
	int slot; /** concerned slot */
};

static inline struct wrnc_msg hmq_msg_claim_out (int slot, int max_size)
{
    struct wrnc_msg b;

    mq_claim(0, slot);

    b.data = mq_map_out_buffer ( 0, slot );
    b.direction = WRNC_MSG_DIR_SEND;
    b.max_size = max_size;
    b.offset = 0;
    b.datalen = 0;
    b.slot = slot;
    return b;
}

static inline struct wrnc_msg hmq_msg_claim_in (int slot, int max_size)
{
    struct wrnc_msg b;
    b.data = mq_map_in_buffer ( 0, slot );
    b.direction = WRNC_MSG_DIR_RECEIVE;
    b.max_size = max_size;
    b.datalen = max_size;
    b.offset = 0;
    b.slot = slot;
    return b;
}

static inline void hmq_msg_send (struct wrnc_msg *buf)
{
    mq_send ( 0, buf->slot, buf->datalen );
}

#endif

#endif

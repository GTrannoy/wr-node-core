#ifndef __LIST_SERIALIZERS_H
#define __LIST_SERIALIZERS_H

#include "rt-mqueue.h"

struct mq_buffer {
    volatile uint32_t *ctl;
    volatile uint32_t *data;
    int remaining_words;
    int used_words;
};

static inline struct mq_buffer mq_buffer_init_in( int remote, int slot, int n_words )
{
    struct mq_buffer b;
    b.data = mq_map_in_buffer ( remote, slot );
    b.remaining_words = n_words;
    b.used_words = 0;
    return b;
}

static inline struct mq_buffer mq_buffer_init_out( int remote, int slot, int n_words )
{
    struct mq_buffer b;
    b.data = mq_map_out_buffer ( remote, slot );
    b.remaining_words = n_words;
    b.used_words = 0;
    return b;
}

static inline void mq_buffer_send ( struct mq_buffer *buf, int remote, int slot )
{
    mq_send ( remote, slot, buf->used_words );
}

static inline void mq_buffer_require ( struct mq_buffer *buf, int n_words )
{
    buf->remaining_words -= n_words;
    buf->used_words += n_words;
}

static inline void bag_int ( struct mq_buffer *buf, int data )
{
    mq_buffer_require ( buf, 1 );
    buf->data[0] = data;
    buf->data++;
}

static inline void bag_ts ( struct mq_buffer *buf, struct list_timestamp *ts )
{
    mq_buffer_require ( buf, 3 );
    buf->data[0] = ts->seconds;
    buf->data[1] = ts->cycles;
    buf->data[2] = ts->frac;
    buf->data += 3;
}

static inline void bag_id ( struct mq_buffer *buf, struct list_id *id )
{
    mq_buffer_require ( buf, 3 );
    buf->data[0] = id->system;
    buf->data[1] = id->source_port;
    buf->data[2] = id->trigger;
    buf->data += 3;
}

static inline void bag_trigger_entry ( struct mq_buffer *buf, struct list_trigger_entry *ent )
{
    mq_buffer_require ( buf, 7 );
    buf->data[0] = ent->ts.seconds;
    buf->data[1] = ent->ts.cycles;
    buf->data[2] = ent->ts.frac;
    buf->data[3] = ent->id.system;
    buf->data[4] = ent->id.source_port;
    buf->data[5] = ent->id.trigger;
    buf->data[6] = ent->seq;
    buf->data += 7;
}

static inline void bag_skip ( struct mq_buffer *buf, int n_words )
{
    mq_buffer_require ( buf, n_words );
    buf->data += n_words;
}

/*int unbag_int ( struct mq_buffer *buf, int *data );
int unbag_ts ( struct mq_buffer *buf, struct list_timestamp *ts );
int unbag_trigger_entry ( struct mq_buffer *buf, struct list_trigger_entry *ent );
*/

#endif

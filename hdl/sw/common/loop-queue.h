#ifndef __LOOP_QUEUE_H
#define __LOOP_QUEUE_H

#include "rt.h"
#include "list-common.h"

#define LOOP_QUEUE_SIZE 16

void loop_queue_init();

void loop_queue_push(struct list_id *id, uint32_t seq, struct list_timestamp *ts);
struct list_trigger_entry *loop_queue_pop();

#endif


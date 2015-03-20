#include "rt.h"
#include "list-common.h"

#define LOOP_QUEUE_SIZE 16

static SMEM int head, tail, count;
static SMEM struct list_trigger_entry buf[16];

void loop_queue_init()
{
    head = tail = count = 0;
}

void loop_queue_push(struct list_id *id, uint32_t seq, struct list_timestamp *ts)
{
    if(count == LOOP_QUEUE_SIZE)
	return;
	
    buf[head].id = *id;
    buf[head].seq = seq;
    buf[head].ts = *ts;
    
    head++;
    
    if(head == LOOP_QUEUE_SIZE)
	head = 0;
    count++;
}

struct list_trigger_entry *loop_queue_pop()
{
    if(!count)
        return NULL;
    
    struct list_trigger_entry *rv = &buf[tail];
    
    tail++;
    if(tail == LOOP_QUEUE_SIZE)
	tail = 0;
    count--;
    
    return rv;
}
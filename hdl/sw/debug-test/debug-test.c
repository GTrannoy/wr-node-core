/*
 * This work is part of the White Rabbit Node Core project.
 *
 * Copyright (C) 2013-2014 CERN (www.cern.ch)
 * Author: Tomasz Wlostowski <tomasz.wlostowski@cern.ch>
 *
 * Released according to the GNU GPL, version 2 or any later version.
 */

#include <string.h>

#include "rt.h"

volatile SMEM int mutex;

static inline void send()
{
    uint32_t *msg = mq_map_out_buffer(0, 0);

    mq_claim(0, 0);


    int i;
    for(i=0;i<38;i++)
    {
	msg[i] = i;
    }

    mq_send(0, 0, 38);
}


main()
{   
    int n = 0;


    send();
//    pp_printf("T1: %d\n",  smem_atomic_test_and_set( &mutex ) );
//    pp_printf("T2: %d\n",  smem_atomic_test_and_set( &mutex ) );


//    puts("Test\n");


    for(;;);


}
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

main()
{   
  int n = 0;

    


  //    puts("Test\n");

   
  pp_printf("Hello, world %d\n\r", n++);

  volatile uint32_t *msg = mq_map_out_buffer(0, 0);
  mq_claim(0, 0);
  msg[0] = 1;
  mq_enqueue(0, 0, 1);
  mq_claim(0, 0);
  msg[0] = 2;
  mq_enqueue(0, 0, 1);
  mq_claim(0, 0);
  msg[0] = 3;
  mq_enqueue(0, 0, 1);
  mq_commit(0, 0);

  for(;;);

}

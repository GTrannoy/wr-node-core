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
#include "rt_profile.h"

void print_string_profiled( const char *str )
{
  mt_profile_start(0);

  int c;
  while(c = *str++)
  {
    mt_probe_trigger(0);
    lr_writel(c, WRN_CPU_LR_REG_DBG_CHR);

  }
  lr_writel(0, WRN_CPU_LR_REG_DBG_CHR);

  mt_profile_stop(0);
}

main()
{   
  int n = 0;

  mt_probe_create(0, "loop-timing")

  print_string_profiled("Hello, world");
  return 0;
}

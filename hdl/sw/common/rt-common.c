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
 * rt-common.c: common RT CPU functions
 */

#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "rt-common.h"

int puts(const char *p)
{
    int n = 0;
    char c;
    while(c = *p++)
    {
	lr_writel(c, WRN_CPU_LR_REG_DBG_CHR);
	n++;
    }
    return n;
}


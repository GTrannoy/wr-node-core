/*
 * This work is part of the White Rabbit Node Core project.
 *
 * Copyright (C) 2013-2014 CERN (www.cern.ch)
 * Author: Alessandro Rubini <rubini@gnudd.com>
 *
 * Released according to the GNU GPL, version 2 or any later version.
 */

#ifndef __PP_PRINTF_H
#define __PP_PRINTF_H

#include <stdarg.h>

#define CONFIG_PRINT_BUFSIZE 128

extern int pp_printf(const char *fmt, ...)
        __attribute__((format(printf,1,2)));

extern int pp_sprintf(char *s, const char *fmt, ...)
        __attribute__((format(printf,2,3)));

extern int pp_vprintf(const char *fmt, va_list args);

extern int pp_vsprintf(char *buf, const char *, va_list)
        __attribute__ ((format (printf, 2, 0)));

/* This is what we rely on for output */
extern int puts(const char *s);

#endif

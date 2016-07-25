/*
  Register definitions for slave core: TOF

  * File           : ../wb/TrevGen_wb_slave.h
  * Author         : auto-generated by wbgen2 from TrevGen_wb_slave.wb
  * Created        : Thu Jun 16 16:54:34 2016
  * Standard       : ANSI C

    THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE TrevGen_wb_slave.wb
    DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!

*/

#ifndef __WBGEN2_REGDEFS_TREVGEN_WB_SLAVE_WB
#define __WBGEN2_REGDEFS_TREVGEN_WB_SLAVE_WB

#ifdef __KERNEL__
#include <linux/types.h>
#else
#include <inttypes.h>
#endif

#if defined( __GNUC__)
#define PACKED __attribute__ ((packed))
#else
#error "Unsupported compiler?"
#endif

#ifndef __WBGEN2_MACROS_DEFINED__
#define __WBGEN2_MACROS_DEFINED__
#define WBGEN2_GEN_MASK(offset, size) (((1<<(size))-1) << (offset))
#define WBGEN2_GEN_WRITE(value, offset, size) (((value) & ((1<<(size))-1)) << (offset))
#define WBGEN2_GEN_READ(reg, offset, size) (((reg) >> (offset)) & ((1<<(size))-1))
#define WBGEN2_SIGN_EXTEND(value, bits) (((value) & (1<<bits) ? ~((1<<(bits))-1): 0 ) | (value))
#endif


/* definitions for register: MinTrev */

/* definitions for register: MaxTrev */

/* definitions for register: Ctrl parameters */

/* definitions for field: WRLtcy in reg: Ctrl parameters */
#define TOF_CTRL_WRLTCY_MASK                  WBGEN2_GEN_MASK(0, 20)
#define TOF_CTRL_WRLTCY_SHIFT                 0
#define TOF_CTRL_WRLTCY_W(value)              WBGEN2_GEN_WRITE(value, 0, 20)
#define TOF_CTRL_WRLTCY_R(reg)                WBGEN2_GEN_READ(reg, 0, 20)

/* definitions for field: GMargin in reg: Ctrl parameters */
#define TOF_CTRL_GMARGIN_MASK                 WBGEN2_GEN_MASK(24, 2)
#define TOF_CTRL_GMARGIN_SHIFT                24
#define TOF_CTRL_GMARGIN_W(value)             WBGEN2_GEN_WRITE(value, 24, 2)
#define TOF_CTRL_GMARGIN_R(reg)               WBGEN2_GEN_READ(reg, 24, 2)

/* definitions for field: GWidth in reg: Ctrl parameters */
#define TOF_CTRL_GWIDTH_MASK                  WBGEN2_GEN_MASK(26, 2)
#define TOF_CTRL_GWIDTH_SHIFT                 26
#define TOF_CTRL_GWIDTH_W(value)              WBGEN2_GEN_WRITE(value, 26, 2)
#define TOF_CTRL_GWIDTH_R(reg)                WBGEN2_GEN_READ(reg, 26, 2)
/* [0x0]: REG MinTrev */
#define TOF_REG_MINTREV 0x00000000
/* [0x4]: REG MaxTrev */
#define TOF_REG_MAXTREV 0x00000004
/* [0x8]: REG Ctrl parameters */
#define TOF_REG_CTRL 0x00000008
#endif
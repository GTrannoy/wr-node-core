/*
  Register definitions for slave core: WR Node CPU Control/Status registers block

  * File           : wrn_cpu_csr.h
  * Author         : auto-generated by wbgen2 from wrn_cpu_csr.wb
  * Created        : Mon Dec  8 15:40:37 2014
  * Standard       : ANSI C

    THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE wrn_cpu_csr.wb
    DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!

*/

#ifndef __WBGEN2_REGDEFS_WRN_CPU_CSR_WB
#define __WBGEN2_REGDEFS_WRN_CPU_CSR_WB

#include <inttypes.h>

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


/* definitions for register: Application ID Register */

/* definitions for register: CPU Reset Register */

/* definitions for register: CPU Enable Register */

/* definitions for register: CPU Upload Address Register */

/* definitions for field: Address in reg: CPU Upload Address Register */
#define WRN_CPU_CSR_UADDR_ADDR_MASK           WBGEN2_GEN_MASK(0, 20)
#define WRN_CPU_CSR_UADDR_ADDR_SHIFT          0
#define WRN_CPU_CSR_UADDR_ADDR_W(value)       WBGEN2_GEN_WRITE(value, 0, 20)
#define WRN_CPU_CSR_UADDR_ADDR_R(reg)         WBGEN2_GEN_READ(reg, 0, 20)

/* definitions for register: Core Select Register */

/* definitions for register: Core Count Register */

/* definitions for register: Core Memory Size */

/* definitions for register: CPU Upload Data Register */

/* definitions for register: CPU Debug Register */

/* definitions for field: JTAG data in reg: CPU Debug Register */
#define WRN_CPU_CSR_DBG_JTAG_JDATA_MASK       WBGEN2_GEN_MASK(0, 8)
#define WRN_CPU_CSR_DBG_JTAG_JDATA_SHIFT      0
#define WRN_CPU_CSR_DBG_JTAG_JDATA_W(value)   WBGEN2_GEN_WRITE(value, 0, 8)
#define WRN_CPU_CSR_DBG_JTAG_JDATA_R(reg)     WBGEN2_GEN_READ(reg, 0, 8)

/* definitions for field: JTAG address in reg: CPU Debug Register */
#define WRN_CPU_CSR_DBG_JTAG_JADDR_MASK       WBGEN2_GEN_MASK(8, 3)
#define WRN_CPU_CSR_DBG_JTAG_JADDR_SHIFT      8
#define WRN_CPU_CSR_DBG_JTAG_JADDR_W(value)   WBGEN2_GEN_WRITE(value, 8, 3)
#define WRN_CPU_CSR_DBG_JTAG_JADDR_R(reg)     WBGEN2_GEN_READ(reg, 8, 3)

/* definitions for field: JTAG reset in reg: CPU Debug Register */
#define WRN_CPU_CSR_DBG_JTAG_RSTN             WBGEN2_GEN_MASK(16, 1)

/* definitions for field: JTAG TCK in reg: CPU Debug Register */
#define WRN_CPU_CSR_DBG_JTAG_TCK              WBGEN2_GEN_MASK(17, 1)

/* definitions for field: JTAG Update in reg: CPU Debug Register */
#define WRN_CPU_CSR_DBG_JTAG_UPDATE           WBGEN2_GEN_MASK(18, 1)

/* definitions for register: CPU Debug Message Register */

/* definitions for field: Debug message byte for the selected core in reg: CPU Debug Message Register */
#define WRN_CPU_CSR_DBG_MSG_DATA_MASK         WBGEN2_GEN_MASK(0, 8)
#define WRN_CPU_CSR_DBG_MSG_DATA_SHIFT        0
#define WRN_CPU_CSR_DBG_MSG_DATA_W(value)     WBGEN2_GEN_WRITE(value, 0, 8)
#define WRN_CPU_CSR_DBG_MSG_DATA_R(reg)       WBGEN2_GEN_READ(reg, 0, 8)

/* definitions for register: CPU Debug Messge Poll Register */

/* definitions for field: Debug Message data available in reg: CPU Debug Messge Poll Register */
#define WRN_CPU_CSR_DBG_POLL_READY_MASK       WBGEN2_GEN_MASK(0, 8)
#define WRN_CPU_CSR_DBG_POLL_READY_SHIFT      0
#define WRN_CPU_CSR_DBG_POLL_READY_W(value)   WBGEN2_GEN_WRITE(value, 0, 8)
#define WRN_CPU_CSR_DBG_POLL_READY_R(reg)     WBGEN2_GEN_READ(reg, 0, 8)

/* definitions for register: CPU Debug Messge Interrupt Mask Register */

/* definitions for field: Per-CPU Debug Message Interrupt Enable in reg: CPU Debug Messge Interrupt Mask Register */
#define WRN_CPU_CSR_DBG_IMSK_ENABLE_MASK      WBGEN2_GEN_MASK(0, 8)
#define WRN_CPU_CSR_DBG_IMSK_ENABLE_SHIFT     0
#define WRN_CPU_CSR_DBG_IMSK_ENABLE_W(value)  WBGEN2_GEN_WRITE(value, 0, 8)
#define WRN_CPU_CSR_DBG_IMSK_ENABLE_R(reg)    WBGEN2_GEN_READ(reg, 0, 8)
/* [0x0]: REG Application ID Register */
#define WRN_CPU_CSR_REG_APP_ID 0x00000000
/* [0x4]: REG CPU Reset Register */
#define WRN_CPU_CSR_REG_RESET 0x00000004
/* [0x8]: REG CPU Enable Register */
#define WRN_CPU_CSR_REG_ENABLE 0x00000008
/* [0xc]: REG CPU Upload Address Register */
#define WRN_CPU_CSR_REG_UADDR 0x0000000c
/* [0x10]: REG Core Select Register */
#define WRN_CPU_CSR_REG_CORE_SEL 0x00000010
/* [0x14]: REG Core Count Register */
#define WRN_CPU_CSR_REG_CORE_COUNT 0x00000014
/* [0x18]: REG Core Memory Size */
#define WRN_CPU_CSR_REG_CORE_MEMSIZE 0x00000018
/* [0x1c]: REG CPU Upload Data Register */
#define WRN_CPU_CSR_REG_UDATA 0x0000001c
/* [0x20]: REG CPU Debug Register */
#define WRN_CPU_CSR_REG_DBG_JTAG 0x00000020
/* [0x24]: REG CPU Debug Message Register */
#define WRN_CPU_CSR_REG_DBG_MSG 0x00000024
/* [0x28]: REG CPU Debug Messge Poll Register */
#define WRN_CPU_CSR_REG_DBG_POLL 0x00000028
/* [0x2c]: REG CPU Debug Messge Interrupt Mask Register */
#define WRN_CPU_CSR_REG_DBG_IMSK 0x0000002c
#endif

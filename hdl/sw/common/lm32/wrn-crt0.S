/****************************************************************************
**
**  Name: crt0ram.S
**
**  Description:
**        Implements boot-code that calls LatticeDDInit (that calls main())
**        Implements exception handlers (actually, redirectors)
**
**  $Revision: $
**
** Disclaimer:
**
**   This source code is intended as a design reference which
**   illustrates how these types of functions can be implemented.  It
**   is the user's responsibility to verify their design for
**   consistency and functionality through the use of formal
**   verification methods.  Lattice Semiconductor provides no warranty
**   regarding the use or functionality of this code.
**
** --------------------------------------------------------------------
**
**                     Lattice Semiconductor Corporation
**                     5555 NE Moore Court
**                     Hillsboro, OR 97214
**                     U.S.A
**
**                     TEL: 1-800-Lattice (USA and Canada)
**                          (503)268-8001 (other locations)
**
**                     web:   http://www.latticesemi.com
**                     email: techsupport@latticesemi.com
**
** --------------------------------------------------------------------------
**
**  Change History (Latest changes on top)
**
**  Ver    Date        Description
** --------------------------------------------------------------------------
**  3.8   Apr-15-2011  Added __MICO_USER_<handler>_HANDLER__ preprocessor to 
**                     allow customers to implement their own handlers for:
**                     DATA_ABORT, INST_ABORT
**  
**  3.1   Jun-18-2008  Added __MICO_NO_INTERRUPTS__ preprocessor
**                     option to exclude invoking MicoISRHandler
**                     to reduce code-size in apps that don't use
**                     interrupts
**
**  3.0   Mar-25-2008  Added Header
**
**---------------------------------------------------------------------------
*****************************************************************************/

/*
 * LatticeMico32 C startup code.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

/* From include/sys/signal.h */  
#define SIGINT  2   /* interrupt */
#define SIGTRAP 5   /* trace trap */
#define SIGFPE  8   /* arithmetic exception */
#define SIGSEGV 11  /* segmentation violation */

//#define MICO32_FULL_CONTEXT_SAVE_RESTORE


/* Exception handlers - Must be 32 bytes long. */
        .section    .boot, "ax", @progbits
	
        .global	_start  
_start: 
	   
        .global _reset_handler
        .type 	_reset_handler, @function
_reset_handler:
    xor r0, r0, r0
    wcsr    IE, r0
    wcsr    IM, r0
    mvhi    r1, hi(_reset_handler)
    ori     r1, r1, lo(_reset_handler)
    wcsr    EBA, r1
    calli   _crt0
    nop
        .size	_reset_handler, .-_reset_handler
	
.extern _irq_entry
.org 0xc0
        .global _interrupt_handler
        .type 	_interrupt_handler, @function
_interrupt_handler:
		nop
		
.org 0x100
        .global _crt0
        .type 	_crt0, @function
_crt0:
    /* Clear r0 */
    xor     r0, r0, r0
    xor     r1, r1, r1
    xor     r2, r2, r2
    xor     r3, r3, r3

    /* Setup stack and global pointer */
    mvhi    sp, hi(_fstack)
    ori     sp, sp, lo(_fstack)
    mvhi    gp, hi(_gp)
    ori     gp, gp, lo(_gp)
	
    mvhi    r1, hi(_fbss)
    ori     r1, r1, lo(_fbss)
    mvi     r2, 0
    mvhi    r3, hi(_ebss)
    ori     r3, r3, lo(_ebss)
    sub     r3, r3, r1
/*    calli   memset */
    mvi     r1, 0
    mvi     r2, 0
    mvi     r3, 0
    calli   main

loopf:
	bi loopf



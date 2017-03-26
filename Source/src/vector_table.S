/**
* @file asm_vectors.s
*
* This file contains the initial vector table for the Cortex A53 processor
* Currently NEON registers are not saved on stack if interrupt is taken.
* It will be implemented.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who     Date     Changes
* ----- ------- -------- ---------------------------------------------------
* 5.00  pkp 5/21/14 Initial version
* </pre>
*
* @note
*
* None.
*
******************************************************************************/



//.org 0
.text

.globl _boot
.globl _vector_table
.globl _freertos_vector_table

.globl FIQInterrupt
.globl IRQInterrupt
.globl SErrorInterrupt
.globl SynchronousInterrupt

//.org 0

.section .vectors, "a"

_vector_table:

.set    VBAR, _vector_table

.org VBAR
    b   _boot

.org (VBAR + 0x80)
    b   .

.org (VBAR + 0x100)
    b   .

.org (VBAR + 0x180)
    b   .


.org (VBAR + 0x200)
    b   .

.org (VBAR + 0x280)
    b   .

.org (VBAR + 0x300)
    b   .

.org (VBAR + 0x380)
    b   .



.org (VBAR + 0x400)
    b   .

.org (VBAR + 0x480)
    b   .

.org (VBAR + 0x500)
    b   .

.org (VBAR + 0x580)
    b   .

.org (VBAR + 0x600)
    b   .

.org (VBAR + 0x680)
    b   .

.org (VBAR + 0x700)
    b   .

.org (VBAR + 0x780)
    b   .



/******************************************************************************
 * Vector table to use when FreeRTOS is running.
 *****************************************************************************/
.set    FREERTOS_VBAR, (VBAR+0x1000)

.org(FREERTOS_VBAR)
_freertos_vector_table:
    b   FreeRTOS_SWI_Handler

.org (FREERTOS_VBAR + 0x80)
    b   FreeRTOS_IRQ_Handler

.org (FREERTOS_VBAR + 0x100)
    b   .

.org (FREERTOS_VBAR + 0x180)
    b   .

.org (FREERTOS_VBAR + 0x200)
    b   FreeRTOS_SWI_Handler

.org (FREERTOS_VBAR + 0x280)
    b   FreeRTOS_IRQ_Handler

.org (FREERTOS_VBAR + 0x300)
    b   .

.org (FREERTOS_VBAR + 0x380)
    b   .

.org (FREERTOS_VBAR + 0x400)
    b   .

.org (FREERTOS_VBAR + 0x480)
    b   .

.org (FREERTOS_VBAR + 0x500)
    b   .

.org (FREERTOS_VBAR + 0x580)
    b   .

.org (FREERTOS_VBAR + 0x600)
    b   .

.org (FREERTOS_VBAR + 0x680)
    b   .

.org (FREERTOS_VBAR + 0x700)
    b   .

.org (FREERTOS_VBAR + 0x780)
    b   .

.org (FREERTOS_VBAR + 0x800)


_boot:
    mov      x0, #0
    mov      x1, #0
    mov      x2, #0
    mov      x3, #0
    mov      x4, #0
    mov      x5, #0
    mov      x6, #0
    mov      x7, #0
    mov      x8, #0
    mov      x9, #0
    mov      x10, #0
    mov      x11, #0
    mov      x12, #0
    mov      x13, #0
    mov      x14, #0
    mov      x15, #0
    mov      x16, #0
    mov      x17, #0
    mov      x18, #0
    mov      x19, #0
    mov      x20, #0
    mov      x21, #0
    mov      x22, #0
    mov      x23, #0
    mov      x24, #0
    mov      x25, #0
    mov      x26, #0
    mov      x27, #0
    mov      x28, #0
    mov      x29, #0
    mov      x30, #0
//need to complete
    b main
.end


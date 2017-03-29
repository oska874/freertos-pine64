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
.global __el3_stack


//.org 0

.section .vectors, "a"

_vector_table:

.set    VBAR, _vector_table
/****/
.set L0Table,   MMUTableL0
.set L1Table,   MMUTableL1
.set L2Table,   MMUTableL2
.set vector_base,   _vector_table
.set rvbar_base,    0x01700ca0 /*rvbaraddr0_L*/
.set counterfreq,   600000//?
.set EL3_stack,     __el3_stack
.set EL2_stack,     __el2_stack
.set EL1_stack,     __el1_stack
.set EL0_stack,     __el0_stack
/***/

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
#if 1 //check Which core am I,if not core0 then sleep
    mrs      x0, MPIDR_EL1
    and      x0, x0, #0xFF                        //Mask off to leave Aff0
    cbz      x0, OKToRun                          //If core 0, run the primary init code
EndlessLoop0:
    wfi
    b        EndlessLoop0
#endif

OKToRun:
    /*Set vector table base address*/
    ldr x1, =vector_base
    msr VBAR_EL3,x1
    /* Set reset vector address */
    /* Get the cpu ID */
    mrs  x0, MPIDR_EL1
    and  x0, x0, #0xFF
    mov  w0, w0
    ldr  w2, =rvbar_base

    /* calculate the rvbar base address for particular CPU core */
    mov  w3, #0x8
    mul  w0, w0, w3
    add  w2, w2, w0
    /* store vector base address to RVBAR */
    str  x1, [x2]

    /*Define stack pointer for current exception level*/
    ldr  x2,=EL3_stack
    mov  sp,x2

    /* Disable trapping of CPTR_EL3 accesses or use of Adv.SIMD/FPU*/
    mov      x0, #0                 // Clear all trap bits
    msr      CPTR_EL3, x0

    /* Configure SCR_EL3 */
    mov      w1, #0                 //; Initial value of register is unknown
    orr      w1, w1, #(1 << 11)     //; Set ST bit (Secure EL1 can access CNTPS_TVAL_EL1, CNTPS_CTL_EL1 & CNTPS_CVAL_EL1)
    orr      w1, w1, #(1 << 10)     //; Set RW bit (EL1 is AArch64, as this is the Secure world)
    orr      w1, w1, #(1 << 3)      //; Set EA bit (SError routed to EL3)
    orr      w1, w1, #(1 << 2)      //; Set FIQ bit (FIQs routed to EL3)
    orr      w1, w1, #(1 << 1)      //; Set IRQ bit (IRQs routed to EL3)
    msr      SCR_EL3, x1

    /*Enable ECC protection*/
    mrs x0, S3_1_C11_C0_2   // register L2CTLR_EL1
    orr x0, x0, #(1<<22)
    msr S3_1_C11_C0_2, x0
    /*configure cpu auxiliary control register EL1 */
    ldr x0,=0x80CA000       // L1 Data prefetch control - 5, Enable device split throttle, 2 independent data prefetch streams
    msr S3_1_C15_C2_0, x0   //CPUACTLR_EL1

    /* program the counter frequency */
    ldr x0,=counterfreq
    msr CNTFRQ_EL0, x0

    /*Enable hardware coherency between cores*/
    mrs      x0, S3_1_c15_c2_1      //Read EL1 CPU Extended Control Register
    orr      x0, x0, #(1 << 6)      //Set the SMPEN bit
    msr      S3_1_c15_c2_1, x0      //Write EL1 CPU Extended Control Register
    isb

    tlbi    ALLE3
    ic      IALLU                   //; Invalidate I cache to PoU
    bl  invalidate_dcaches
    dsb  sy
    isb

    ldr      x1, =L0Table       //; Get address of level 0 for TTBR0_EL3
    msr      TTBR0_EL3, x1      //; Set TTBR0_EL3

    /**********************************************
    * Set up memory attributes
    * This equates to:
    * 0 = b01000100 = Normal, Inner/Outer Non-Cacheable
    * 1 = b11111111 = Normal, Inner/Outer WB/WA/RA
    * 2 = b00000000 = Device-nGnRnE
    * 3 = b00000100 = Device-nGnRE
    * 4 = b10111011 = Normal, Inner/Outer WT/WA/RA
    **********************************************/
    ldr      x1, =0x000000BB0400FF44
    msr      MAIR_EL3, x1

    /**********************************************
     * Set up TCR_EL3
     * Physical Address Size PS =  010 -> 40bits 1TB
     * Granual Size TG0 = 00 -> 4KB
     * size offset of the memory region T0SZ = 24 -> (region size 2^(64-24) = 2^40)
     ***************************************************/
    ldr     x1,=0x80823518
    msr     TCR_EL3, x1
    isb

    /* Enable SError Exception for asynchronous abort */
    mrs     x1,DAIF
    bic x1,x1,#(0x1<<8)
        msr DAIF,x1

    /* Configure SCTLR_EL3 */
    mov      x1, #0                //Most of the SCTLR_EL3 bits are unknown at reset
    orr      x1, x1, #(1 << 12) //Enable I cache
    orr      x1, x1, #(1 << 3)  //Enable SP alignment check
    orr      x1, x1, #(1 << 2)  //Enable caches
    orr      x1, x1, #(1 << 0)  //Enable MMU
    msr      SCTLR_EL3, x1
    dsb  sy
    isb
    
    /* make sure argc and argv are valid */
    mov x0, #0
    mov x1, #0

    b main

invalidate_dcaches:

    dmb     ISH
    mrs     x0, CLIDR_EL1          //; x0 = CLIDR
    ubfx    w2, w0, #24, #3        //; w2 = CLIDR.LoC
    cmp     w2, #0                 //; LoC is 0?
    b.eq    invalidateCaches_end   //; No cleaning required and enable MMU
    mov     w1, #0                 //; w1 = level iterator

invalidateCaches_flush_level:
    add     w3, w1, w1, lsl #1     //; w3 = w1 * 3 (right-shift for cache type)
    lsr     w3, w0, w3             //; w3 = w0 >> w3
    ubfx    w3, w3, #0, #3         //; w3 = cache type of this level
    cmp     w3, #2                 //; No cache at this level?
    b.lt    invalidateCaches_next_level

    lsl     w4, w1, #1
    msr     CSSELR_EL1, x4         //; Select current cache level in CSSELR
    isb                            //; ISB required to reflect new CSIDR
    mrs     x4, CCSIDR_EL1         //; w4 = CSIDR

    ubfx    w3, w4, #0, #3
    add     w3, w3, #2             //; w3 = log2(line size)
    ubfx    w5, w4, #13, #15
    ubfx    w4, w4, #3, #10        //; w4 = Way number
    clz     w6, w4                 //; w6 = 32 - log2(number of ways)

invalidateCaches_flush_set:
    mov     w8, w4                 //; w8 = Way number
invalidateCaches_flush_way:
    lsl     w7, w1, #1             //; Fill level field
    lsl     w9, w5, w3
    orr     w7, w7, w9             //; Fill index field
    lsl     w9, w8, w6
    orr     w7, w7, w9             //; Fill way field
    dc      CISW, x7               //; Invalidate by set/way to point of coherency
    subs    w8, w8, #1             //; Decrement way
    b.ge    invalidateCaches_flush_way
    subs    w5, w5, #1             //; Descrement set
    b.ge    invalidateCaches_flush_set

invalidateCaches_next_level:
    add     w1, w1, #1             //; Next level
    cmp     w2, w1
    b.gt    invalidateCaches_flush_level

invalidateCaches_end:
    ret
.end


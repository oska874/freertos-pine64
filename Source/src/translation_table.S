


    .globl  MMUTableL0
    .globl  MMUTableL1
    .globl  MMUTableL2

.section .mmu_tbl0,"a"
MMUTableL0:
.set SECT, MMUTableL1       /* 0x0000_0000 -  0x7F_FFFF_FFFF */
.8byte  SECT + 0x3


.section .mmu_tbl1,"a"
MMUTableL1:
.set SECT, MMUTableL2       /* 0x0000_0000 - 0x3FFF_FFFF */
.8byte  SECT + 0x3      /* 1GB DDR */


.section .mmu_tbl2,"a"
MMUTableL2:
.set SECT, 0

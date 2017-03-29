
_STACK_SIZE = 0x2000;
_EL0_STACK_SIZE = 1024;
_EL1_STACK_SIZE = 2048;
_EL2_STACK_SIZE = 1024;

MEMORY
{
    CODE_SEG(rx)    :ORIGIN = 0x100000  ,LENGTH = 500K
    DATA_SEG(rwx)   :ORIGIN = 0x200000  ,LENGTH = 500K
}

ENTRY(_boot)

SECTIONS
{
    .text :
    {
        KEEP (*(.vectors))
        *(.text.entry)
        *(.text)
    }>CODE_SEG

    .data :
    {
        *(.data)
        *(.rodata)
        *(.rodata.*)
    }>CODE_SEG

    .sbss :
    {
      *(.sbss) *(.sbss.*) *(.scommon)
    }>DATA_SEG

     .bss :
    {
        *(.dynbss) *(.bss) *(.bss.*) *(COMMON) *(.gnu.linkonce.b*)
    }>DATA_SEG

    .stack (NOLOAD) : {
        . = ALIGN(64);
        _el3_stack_end = .;
        . += _STACK_SIZE;
        __el3_stack = .;

        _el2_stack_end = .;
        . += _EL2_STACK_SIZE;
        . = ALIGN(64);
        __el2_stack = .;

        _el1_stack_end = .;
        . += _EL1_STACK_SIZE;
        . = ALIGN(64);
        __el1_stack = .;

        _el0_stack_end = .;
        . += _EL0_STACK_SIZE;
        . = ALIGN(64);
        __el0_stack = .;
    }
}

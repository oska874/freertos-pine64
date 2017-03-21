

ENTRY(_vector_table)

MEMORY
{
    CODE_SEG(rx)    :ORIGIN =   ,LENGTH = 
    DATA_SEG(rwx)   :ORIGIN =   ,LENGTH =
}


SECTIONS
{
    .text:
    {
        *(.text.entry)
        *(.text)
        . = ALIGN(4096);
    }

    .data:
    {
        *(.data)
        . = ALIGN(4096);
    }

    .sbss:
    {
      *(.sbss) *(.sbss.*) *(.scommon)
      . = ALIGN(4096);
    }

     .bss:
    {
        *(.dynbss) *(.bss) *(.bss.*) *(COMMON) *(.gnu.linkonce.b*)
        . = ALIGN(4096);
    }

}

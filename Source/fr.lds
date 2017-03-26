
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

}

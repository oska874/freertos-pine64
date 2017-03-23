ENTRY(_start)

MEMORY
{
    CODE_SEG(rx)    :ORIGIN = 0x100000  ,LENGTH = 500K
    DATA_SEG(rwx)   :ORIGIN = 0x17d000  ,LENGTH = 500K
}


SECTIONS
{
    .text:
    {
        *(.text)
        . = ALIGN(4096);
    }>CODE_SEG

    .data:
    {
        *(.data)
        . = ALIGN(4096);
    }>CODE_SEG

    .sbss:
    {
      *(.sbss) *(.sbss.*) *(.scommon)
      . = ALIGN(4096);
    }>DATA_SEG

     .bss:
    {
        *(.dynbss) *(.bss) *(.bss.*) *(COMMON) *(.gnu.linkonce.b*)
        . = ALIGN(4096);
    }>DATA_SEG

}

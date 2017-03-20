OUTPUT_FORMAT("elf32-lm32")
ENTRY(_start)
MEMORY
{
    ram :
 ORIGIN = 0x00000000,
 LENGTH = 32768 - 2048
    stack :
 ORIGIN = 32768 - 2048,
 LENGTH = 2048
    smem :
 ORIGIN = 0x40200000,
 LENGTH = 65536
}

SECTIONS
{
 .boot : { *(.boot) } > ram
 .text : { *(.text .text.*) } > ram =0
 .rodata : { *(.rodata .rodata.*) } > ram
 .data : {
  *(.data .data.*)
  _gp = ALIGN(16) + 0x7ff0;
 } > ram
 .bss : {
  _fbss = .;
  *(.bss .bss.*)
  *(COMMON)
  _ebss = .;
 } > ram

 .smem : { *(.smem) } > smem

 PROVIDE(_endram = ORIGIN(stack));
 PROVIDE(_fstack = ORIGIN(stack) + LENGTH(stack) - 4);
}
PROVIDE(mprintf = pp_printf);

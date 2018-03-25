OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)

MEMORY
{
    DDR0 : ORIGIN = 0x80010000, LENGTH = 0x20000
}

SECTIONS {
    .stub : {
        *start.o (.text)
    } > DDR0

    .text : {
        . = ALIGN(4);
        __text_start__ = .;
        *(.text*)
        *(.rodata*)
        __text_end__ = .;
    } >DDR0

    .data : {
        __data_start__ = .;
        . = ALIGN(4);
        *(.data*)
        __data_end__ = .;
    } >DDR0

    .bss : {
        . = ALIGN(4);
        __bss_start__ = .;
        *(.bss*)
        *(.tbss*)
        *(COMMON)
        __bss_end__ = .;
    } >DDR0

    __exidx_start = .;
    .ARM.exidx : {
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    } >DDR0
    __exidx_end = .;

    .init_array : {
        crti.o(.init_array)
        KEEP (*(SORT(EXCLUDE_FILE(crti.o crtn.o) .init_array.*)))
        KEEP (*(EXCLUDE_FILE(crti.o crtn.o) .init_array))
        crtn.o(.init_array)
    } > DDR0

    .fini_array : {
        crti.o(.fini_array)
        KEEP (*(SORT(EXCLUDE_FILE(crti.o crtn.o) .fini_array.*)))
        KEEP (*(EXCLUDE_FILE(crti.o crtn.o) .fini_array))
        crtn.o(.fini_array)
    } > DDR0

    .heap : {
        . = ALIGN(4);
        __end__ = .;
        end = __end__;
        __HeapBase = __end__;
        *(.heap*)
        . = . + 0x800;
        __HeapLimit = .;
    } >DDR0

    .stack : {
        . = ALIGN(4);
        __StackLimit = . ;
        *(.stack*)
        . = . + 0x1C000;
        __StackTop = .;
    } >DDR0
    _stack = __StackTop;
}

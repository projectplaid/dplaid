module kernel;

import core.bitop;

version (LDC)
{
    import ldc.llvmasm;
}

//Must be stored as second 32-bit word in .text section
alias void function() ISR;
extern (C) immutable ISR undefined_instruction_vector = &EmptyISR;
extern (C) immutable ISR software_interrupt_vector = &EmptyISR;
extern (C) immutable ISR prefetch_abort_vector = &EmptyISR;
extern (C) immutable ISR data_abort_vector = &EmptyISR;
extern (C) immutable ISR interrupt_vector = &EmptyISR;
extern (C) immutable ISR fast_interrupt_vector = &EmptyISR;

const ubyte* UART0 = cast(ubyte*)0x1c090000;

// this is to keep the linker happy
extern (C) void abort() @nogc
{
    while (true)
    {
    }    
}

// naive implementation for the moment.  Eventually,
// this should be implemented in assembly
extern(C) void* memset(void* dest, int value, size_t num) pure nothrow @nogc
{

    byte* d = cast(byte*)dest;
    for(int i = 0; i < num; i++)
    {
        d[i] = cast(byte)value;
    }

    return dest;
}

extern(C) void* memcpy(scope return void* destination, scope const(void*) source, size_t num) pure nothrow @nogc
{
    ubyte* dest = cast(ubyte*)destination;
    ubyte* src = cast(ubyte*)source;

    while (num--)
    {
        *dest++ = *src++;
    }

    return destination;
}

void EmptyISR() pure nothrow @nogc
{
    while (true)
    {
    }
}

// defined in the linker
extern(C) extern __gshared ubyte __text_end__;
extern(C) extern __gshared ubyte __data_start__;
extern(C) extern __gshared ubyte __data_end__;
extern(C) extern __gshared ubyte __bss_start__;
extern(C) extern __gshared ubyte __bss_end__;

extern(C) void hardwareInit()
{
    // copy data segment out of ROM and into RAM
    memcpy(&__data_start__, &__text_end__, &__data_end__ - &__data_start__);

    // zero out variables initialized to void
    memset(&__bss_start__, 0, &__bss_end__ - &__bss_start__);

    kernel_main();
}

extern(C) void kernel_main()
{
    volatileStore(UART0, 'H');
    volatileStore(UART0, 'e');
    volatileStore(UART0, 'l');
    volatileStore(UART0, 'l');
    volatileStore(UART0, 'o');

    while (true)
    {
    }
}
OBJS=start.o uart.o kernel.o

DFLAGS=-mtriple=armv7a-none-eabi -mcpu=cortex-a15 -betterC -g -dw -float-abi=soft -wi -nogc
CFLAGS=-mcpu=cortex-a15 -mfloat-abi=soft -ffreestanding -ggdb -Wall -Werror
LDFLAGS=-nostartfiles -nodefaultlibs -nostdlib
#-Wl,-gc-sections

.PHONY: all run clean
.SUFFIXES: .o .d .S

all: plaid.kernel

plaid.kernel: $(OBJS) linker.ld
	arm-none-eabi-gcc $(CFLAGS) -Tlinker.ld $(LDFLAGS) -o $@ $(OBJS) -lgcc

.d.o:
	ldc2 $(DFLAGS) -c $< -of=$@

.S.o:
	arm-none-eabi-gcc $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o plaid.kernel

run: plaid.kernel
	QEMU_AUDIO_DRV=none qemu-system-arm -M vexpress-a15 -cpu cortex-a15 -m 512 -kernel plaid.kernel -serial mon:stdio -nographic

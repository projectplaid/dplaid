DFLAGS=-mtriple=armv7a-none-eabi -mcpu=cortex-a15 -betterC -g -dw -float-abi=soft -wi -nogc -O0
CFLAGS=-mcpu=cortex-a15 -mfloat-abi=soft -ffreestanding -ggdb -Wall -Werror -O0 -std=c99
#-nostartfiles 
LDFLAGS=-nodefaultlibs -nostdlib
#-Wl,-gc-sections

CRTI_OBJ=crti.o
CRTBEGIN_OBJ:=$(shell arm-none-eabi-gcc $(CFLAGS) -print-file-name=crtbegin.o)
CRTEND_OBJ:=$(shell arm-none-eabi-gcc $(CFLAGS) -print-file-name=crtend.o)
CRTN_OBJ=crtn.o

OBJS=start.o soc.o uart.o interrupt.o kernel.o
LINK_OBJS=$(CRTI_OBJ) $(CRTBEGIN_OBJ) $(OBJS) $(CRTEND_OBJ) $(CRTN_OBJ)

.PHONY: all run clean
.SUFFIXES: .o .d .S

all: plaid.kernel

plaid.kernel: $(CRTI_OBJ) $(OBJS) $(CRTN_OBJ) linker.ld
	arm-none-eabi-gcc $(CFLAGS) -Tlinker.ld $(LDFLAGS) -o $@ $(LINK_OBJS) -lgcc

.d.o:
	ldc2 $(DFLAGS) -c $< -of=$@

.S.o:
	arm-none-eabi-gcc $(CFLAGS) -c $< -o $@

.c.o:
	arm-none-eabi-gcc $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o plaid.kernel

run: plaid.kernel
	QEMU_AUDIO_DRV=none qemu-system-arm -M vexpress-a15 -cpu cortex-a15 -m 512 -kernel plaid.kernel -serial mon:stdio -nographic $(QEMU_OPTS)

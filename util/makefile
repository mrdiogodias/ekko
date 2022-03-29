SOURCES       := $(shell find . -name '*.s')
OBJECTS       := $(SOURCES:%.s=%.o)
TESTDATA      := $(SOURCES:%.s=%.elf)
HEXDATA       := $(SOURCES:%.s=%.hex)
MEMDATA       := $(SOURCES:%.s=%.mem)
VMEMDATA      := $(SOURCES:%.s=%.vmem)

CFLAGS=-mabi=ilp32e -march=rv32im -static -mcmodel=medany \
	   -fvisibility=hidden -nostdlib -nostartfiles -Wall -g -Os
LDFLAGS=-T linker.ld -m elf32lriscv -O binary
  
OC=riscv32-unknown-elf-objcopy
CC=riscv32-unknown-elf-gcc
LD=riscv32-unknown-elf-ld

all: clean $(TESTDATA) $(MEMDATA) $(HEXDATA)
%.elf: %.s
	@echo "Building $< -> $@"
	@$(CC) -c $(CFLAGS) -o $(@:%.elf=%.o) $<
	@$(LD) $(LDFLAGS) $(@:%.elf=%.o) -o $@

%.hex: %.elf
	@echo "Building $< -> $@"
	@$(OC) -O ihex $(@:%.hex=%.elf) $@ --only-section .text\*

%.mem: %.elf
	@echo "Building $< -> $@"
	@$(OC) -O binary $(@:%.mem=%.elf) $(@:%.mem=%.bin) --only-section .text\*
	@hexdump -ve '1/4 "%08x\n"' $(@:%.mem=%.bin) > $@

%.bin: %.elf
	@$(OC) -O binary $^ $@

%.vmem: %.bin
	srec_cat $^ -binary -offset 0x0000 -byte-swap 4 -o $@ -vmem

simhex: $(HEXDATA)
	@echo "Building prog.hex for http://tice.sea.eseo.fr/riscv/"

testmem: $(MEMDATA)
	@echo "Building memdata for unit tests"

clean:
	@echo "Cleaning build files"
	@rm -f $(OBJECTS) *.elf *.hex *.mem *.bin
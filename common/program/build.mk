# MIPSfpga-plus makefile
# Stanislav Zhelnio, 2017
#
# based on:
#      microAptiv_UP makefile for MIPSfpga
#      Andrea Guerrieri scripts

help:
	$(info make help       - show this message)
	$(info make all        - alternative for: compile program size disasm readmemh srecord)
	$(info make program    - build program.elf from sources)
	$(info make compile    - compile all C sources to ASM)
	$(info make size       - show program size information)
	$(info make disasm     - disassemble program.elf )
	$(info make readmemh   - create verilog memory init file for simulation)
	$(info make srecord    - create Motorola S-record file to use it with UART loader)
	$(info make clean      - delete all created files)
	$(info make load       - load program into the device memory, run it and detach gdb)
	$(info make debug      - load program into the device memory, wait for gdb commands)
	$(info make attach     - attach to the device, wait for gdb commands)
	$(info make modelsim   - simulate program and device using Modelsim)
	$(info make icarus     - simulate program and device using Icarus Verilog)
	$(info make gtkwave    - show the result of Icarus Verilog simulation in GTKWave)
	@true

#########################################################
# Path and program settings

CC = mips-mti-elf-gcc
LD = mips-mti-elf-gcc
OD = mips-mti-elf-objdump
OC = mips-mti-elf-objcopy
SZ = mips-mti-elf-size
GDB = mips-mti-elf-gdb

# OpenOCD debugger
OCD = openocd
OCD_CONF = ../../scripts/load/openocd.cfg

# UART interface for memory programming
UART_MEM_LOADER_DEV=/dev/ttyUSB0

LDSCRIPT = $(COMMON_PROGRAM)/reset_ram.ld

#########################################################
# Compile settings and tasks

# -EL           - Little-endian
# -march=m14kc  - MIPSfpga = MIPS microAptiv UP based on MIPS M14Kc
# -msoft-float  - should not use floating-point processor instructions
# -O1           - optimization level
# -std=c99		- C99 lang standard options enabled
CFLAGS  = -EL -march=m14kc -msoft-float -O1 -std=c99 -I$(COMMON_INCLUDE)
LDFLAGS = -EL -march=m14kc -msoft-float -Wl,-Map=program.map

# -g -gdwarf-2  - debug symbols to use with gdb
DBFLAGS = -g -gdwarf-2 

# Set up the link addresses for a bootable C program on MIPSfpga
LDFLAGS += -T $(LDSCRIPT)

ASOURCES= \
$(COMMON_PROGRAM)/boot.S

# CSOURCES= \
# main.c

COBJECTS = $(CSOURCES:.c=.o)
CASMS    = $(CSOURCES:.c=.s)
AOBJECTS = $(ASOURCES:.S=.o)

.PHONY: clean sim

all: compile build size disasm readmemh srecord

compile:  $(CASMS)
build:    program.elf
disasm:   program.dis
readmemh: program.hex32
srecord:  program.rec

PROGRAM=program

$(PROGRAM).elf : $(AOBJECTS) $(COBJECTS) 
	$(LD)  $(LDFLAGS) $(AOBJECTS) $(COBJECTS) $(DBFLAGS) -o $@

.c.o:
	$(CC) -c $(CFLAGS) $(DBFLAGS) $< -o $@

.S.o:
	$(CC) -c $(CFLAGS) $(DBFLAGS) $< -o $@

.c.s:
	$(CC) -S $(CFLAGS) $< -o $@

size: $(PROGRAM).elf
	$(SZ) $^

%.dis: %.elf
	$(OD) -DSlv $^ > $@

%.hex: %.elf
	$(OC) $^ -O verilog $@

%.hex32: %.hex
	cat $^ | $(COMMON_PROGRAM)/hex32.awk > $@

%.rec: %.elf
	$(OC) $^ -O srec $@

clean:
	rm -f main.s *.o *.elf *.map *.dis *.hex32 *.rec *.log

#########################################################
# On Board Debug

GDBCMD_ATTACH  = --silent
GDBCMD_ATTACH += -ex "set pagination off"
GDBCMD_ATTACH += -ex "file program.elf"
GDBCMD_ATTACH += -ex "target remote | $(OCD) -f $(OCD_CONF) -p -c 'log_output openocd.log'"

GDBCMD_LOAD   += -ex "monitor reset halt"
GDBCMD_LOAD   += -ex "load"
GDBCMD_LOAD   += -ex "compare-sections"

GDBCMD_BREAK  += -ex "b main"
GDBCMD_BREAK  += -ex "continue"

GDBCMD_INT    += -ex "interrupt"

GDBCMD_RESRUN += -ex "monitor reset run"

attach:
	$(GDB) $(GDBCMD_ATTACH) $(GDBCMD_INT)

load:
	$(GDB) --batch $(GDBCMD_ATTACH) $(GDBCMD_LOAD) $(GDBCMD_RESRUN)

debug:
	$(GDB) $(GDBCMD_ATTACH) $(GDBCMD_LOAD) $(GDBCMD_BREAK)

#########################################################
# UART programming

uart:
	stty -F $(UART_MEM_LOADER_DEV) raw speed 115200 -crtscts cs8 -parenb -cstopb
	cat program.rec > $(UART_MEM_LOADER_DEV)

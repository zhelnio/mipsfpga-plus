
# MIPSfpga-plus makefile
# Stanislav Zhelnio, 2017-2019
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

# this .mk file current dir
TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

COMMON_PROGRAM  := $(TOP_DIR)/common/program
COMMON_INCLUDE  := $(TOP_DIR)/common/include
COMMON_RUN      := $(TOP_DIR)/common/run
DIR_PROGRAM     := $(TOP_DIR)/program
DIR_MODULE      := $(TOP_DIR)/module
DIR_BOARD       := $(TOP_DIR)/board
DIR_TB          := $(TOP_DIR)/tb
DIR_BUILD       := $(TOP_DIR)/build
DIR_BUILD_SIM   := $(TOP_DIR)/build/sim

include $(TOP_DIR)/config.mk
include $(DIR_MODULE)/files.mk
include $(DIR_TB)/top/files.mk

ifeq ($(MFP_CONFIG_C5GX_LPDDR2),y)
include $(DIR_BOARD)/c5gx/lpddr2_mm/files.mk
include $(DIR_TB)/micron_ddr2/files.mk
endif

ifeq ($(MFP_CONFIG_BOARD_C5GX),y)
include $(DIR_BOARD)/c5gx/top/files.mk
endif

ifeq ($(MFP_CONFIG_BOARD_DE10LITE),y)
include $(DIR_BOARD)/de10_lite/top/files.mk
endif

ifeq ($(MFP_CONFIG_BOARD_DE10LITE_ADC),y)
include $(DIR_BOARD)/de10_lite/adc/files.mk
endif

ifeq ($(MFP_CONFIG_BOARD_DE10LITE_PLL),y)
include $(DIR_BOARD)/de10_lite/pll/files.mk
endif


ifeq ($(abspath $(PWD)/..),$(DIR_PROGRAM))
    RESET_RAM_INIT = $(abspath $(MFP_CONFIG_RESET_RAM_DEFAULT))
else
    RESET_RAM_INIT = $(abspath $(MFP_CONFIG_RESET_RAM_INIT))
endif
ifneq ($(RESET_RAM_INIT),)
    QUARTUS_MACRO   += "MFP_RESET_RAM_HEX=\"$(RESET_RAM_INIT)\""
    MSIM_MACRO      += MFP_RESET_RAM_HEX="$(RESET_RAM_INIT)"
endif

# convert config path to abs path
# program      => program
# folder/file  => $(TOP_DIR)/folder/file
# /folder/file => /folder/file
conf2path = $(strip $(if $(filter     /%, $(1)), $(1), \
					$(if $(findstring /,  $(1)), $(TOP_DIR)/$(1), \
					$(1))))

##############################################
# global targets

mrproper:
	rm -rf $(DIR_BUILD)

##############################################
# Quartus MegaWizard & QSYS rtl generation    

QUARTUS_BUILD_QIP  = $(filter %.qip,  $(patsubst $(DIR_BOARD)%.v,    $(DIR_BUILD)%.qip,  $(QUARTUS_IP)))
QUARTUS_BUILD_QSYS = $(filter %.qsys, $(patsubst $(DIR_BOARD)%.qsys, $(DIR_BUILD)%.qsys, $(QUARTUS_IP)))
QUARTUS_BUILD_IP   = $(QUARTUS_BUILD_QIP)
QUARTUS_BUILD_IP  += $(QUARTUS_BUILD_QSYS)

$(DIR_BUILD)/%.qip: $(DIR_BOARD)/%.v
	mkdir -p $(dir $@)
	cp $^ $(@D)/$(^F)
	cp $^ $(@D)/$(^F).bak
	cd $(@D) && qmegawiz -silent OPTIONAL_FILES="SIM_NETLIST|SYNTH_NETLIST" $(^F)
	mv $(@D)/$(^F).bak $(@D)/$(^F)

$(DIR_BUILD)/%.qsys: $(DIR_BOARD)/%.qsys
	mkdir -p $(dir $@)
	cp $^ $(@D)/$(^F)
	cd $(@D) && qsys-generate -syn -sim $@

##############################################
# Quartus

# BOARD_NAME    ?= de10_lite
BOARD_NAME    ?= c5gx

QUARTUS_FILES += $(RTL_SYN_FILES)
QUARTUS_FILES += $(QUARTUS_BUILD_IP)
QUARTUS_FILES += $(RESET_RAM_INIT)
export QUARTUS_FILES
export QUARTUS_PROJECT ?= system
export QUARTUS_TOP     ?= $(BOARD_NAME)
export QUARTUS_MACRO

QUARTUS_BUILD_DIR = $(DIR_BUILD)/$(BOARD_NAME)
QUARTUS_BUILD_QPF = $(QUARTUS_BUILD_DIR)/$(QUARTUS_PROJECT).qpf
QUARTUS_BUILD_QSF = $(QUARTUS_BUILD_DIR)/$(QUARTUS_PROJECT).qsf
QUARTUS_BUILD_SOF = $(QUARTUS_BUILD_DIR)/$(QUARTUS_PROJECT).sof

$(QUARTUS_BUILD_QSF): $(QUARTUS_FILES)
	mkdir -p $(QUARTUS_BUILD_DIR)
	cd $(QUARTUS_BUILD_DIR) && quartus_sh -t $(COMMON_RUN)/quartus_create.tcl

$(QUARTUS_BUILD_QPF): $(QUARTUS_BUILD_QSF)

quartus_create: $(QUARTUS_BUILD_QPF) $(QUARTUS_BUILD_QSF)

quartus_open:
	cd $(QUARTUS_BUILD_DIR) && quartus $(QUARTUS_PROJECT) &

quartus_build:
	cd $(QUARTUS_BUILD_DIR) && quartus_sh --flow compile $(QUARTUS_PROJECT)

CABLE_NAME ?= "USB-Blaster"
quartus_load:
	quartus_pgm -c $(CABLE_NAME) -m JTAG -o "p;$(QUARTUS_BUILD_SOF)"

quartus_clean:
	rm -rf $(QUARTUS_BUILD_DIR)

quartus_sim: $(QUARTUS_BUILD_QPF) $(DIR_BUILD_SIM)
	cd $(DIR_BUILD_SIM) && ip-setup-simulation --quartus-project=$(QUARTUS_BUILD_QPF)

test:
	cd $(DIR_BOARD)/$(BOARD_NAME)/lpddr2_mm && qsys-edit lpddr2_mm.qsys

##############################################
# Memory image

$(RESET_RAM_INIT):
	make -C $(@D) $(@F)

##############################################
# Simulation common

SIMULATION_FILES  = $(RTL_SYN_FILES) $(RTL_SIM_FILES)
SIMULATION_V_SV   = $(filter %.v %.sv, $(SIMULATION_FILES))
SIMULATION_INCDIR = $(sort $(realpath $(dir $(filter %.vh %.svh, $(SIMULATION_FILES)))))

sim_clean:
	rm -rf $(DIR_BUILD_SIM)

$(DIR_BUILD_SIM):
	mkdir -p $(DIR_BUILD_SIM)

##############################################
# Modelsim

# quartus ip init file for modelsim
MODELSIM_QIP_TCL = $(if $(strip $(QUARTUS_BUILD_IP)), $(DIR_BUILD_SIM)/mentor/msim_setup.tcl )
$(MODELSIM_QIP_TCL): quartus_sim

# extract lib list from msim_setup.tcl
QIP_TCL_PATTERN  = eval vsim -t ps
MODELSIM_LIB = $(if $(wildcard $(MODELSIM_QIP_TCL)), \
                    $(filter-out $$% $(QIP_TCL_PATTERN), \
                        $(shell grep '$(QIP_TCL_PATTERN)' $(MODELSIM_QIP_TCL))))

MODELSIM_OPT += $(if $(MODELSIM_QIP_TCL), -do "source $(MODELSIM_QIP_TCL); dev_com; com")
MODELSIM_OPT += -do $(COMMON_RUN)/modelsim_run.tcl

VLOG_OPT += -sv05compat
VLOG_OPT += -sv
VLOG_OPT += $(SIMULATION_V_SV)
VLOG_OPT += $(addprefix +define+,$(RTL_SIM_DEFINES))
VLOG_OPT += $(addprefix +define+,$(MSIM_MACRO))
VLOG_OPT += $(addprefix +incdir+,$(SIMULATION_INCDIR))
export VLOG_OPT

VSIM_OPT += -novopt
VSIM_OPT += work.$(RTL_SIM_TOPNAME)
VSIM_OPT += $(MODELSIM_LIB)
export VSIM_OPT

modelsim_gui: $(DIR_BUILD_SIM) $(MODELSIM_QIP_TCL)
	cp $(COMMON_RUN)/modelsim_wave.do $(DIR_BUILD_SIM)/wave.do
	cd $(DIR_BUILD_SIM) && vsim $(MODELSIM_OPT)


#########################################################
# Program compile

TOOLCHAIN_PREFIX = $(call conf2path,$(MFP_BUILD_TOOLCHAIN_PREFIX))

CC       = $(TOOLCHAIN_PREFIX)gcc
LD       = $(TOOLCHAIN_PREFIX)gcc
OBJDUMP  = $(TOOLCHAIN_PREFIX)objdump
OBJCOPY  = $(TOOLCHAIN_PREFIX)objcopy
ELFSIZE  = $(TOOLCHAIN_PREFIX)size
READELF  = $(TOOLCHAIN_PREFIX)readelf
GDB      = $(TOOLCHAIN_PREFIX)gdb

HEXCONV  = $(call conf2path,$(MFP_BUILD_DEFAULT_HEXCONV))
LDSCRIPT = $(call conf2path,$(MFP_BUILD_DEFAULT_LDSCRIPT))
BOOTS    = $(call conf2path,$(MFP_BUILD_DEFAULT_BOOTS))

CFLAGS  += $(MFP_BUILD_DEFAULT_FLAGS)
CFLAGS  += $(MFP_BUILD_DEFAULT_CFLAGS)
CFLAGS  += -I$(COMMON_INCLUDE)

ASFLAGS  = $(CFLAGS)
CPPFLAGS = $(CFLAGS)

LDFLAGS += $(MFP_BUILD_DEFAULT_FLAGS) 
LDFLAGS += $(MFP_BUILD_DEFAULT_LDFLAGS) 
LDFLAGS += -T $(LDSCRIPT)

ASOURCES += $(BOOTS)
AOBJECTS  = $(ASOURCES:.S=.o)
COBJECTS  = $(CSOURCES:.c=.o)
CASMS     = $(CSOURCES:.c=.s)

AOUT_ELF := $(MFP_BUILD_DEFAULT_AOUT)
AOUT     := $(basename $(AOUT_ELF))

compile:  $(CASMS)
build:    $(AOUT_ELF)
disasm:   $(AOUT).dis
readmemh: $(AOUT).hex32
srecord:  $(AOUT).rec
all:      compile build disasm readmemh srecord report

$(AOUT_ELF) : $(AOBJECTS) $(COBJECTS) 
	$(LD) $(LDFLAGS) $^ -o $@

.c.s:
	$(CC) -S $(CFLAGS) $< -o $@

report: $(AOUT_ELF)
	$(ELFSIZE) $<
	$(READELF) -l $<

$(AOUT).dis: $(AOUT_ELF)
	$(OBJDUMP) -DSl $< > $@
$(AOUT).rec: $(AOUT_ELF)
	$(OBJCOPY) $< -O srec $@

$(AOUT).hex: $(AOUT_ELF)
	$(OBJCOPY) $< -O verilog $@

%.hex32: %.hex
	cat $< | $(HEXCONV) > $@

clean:
	$(RM) $(AOUT_ELF) $(AOBJECTS) $(COBJECTS) $(CASMS)
	$(RM) *.map *.dis *.hex *.hex32 *.rec *.log 

# #########################################################
# # On Board Debug

# # OpenOCD debugger
# OCD      = $(call conf2path,$(MFP_DEBUG_DEFAULT_OCD_BIN))
# OCD_CONF = $(call conf2path,$(MFP_DEBUG_DEFAULT_OCD_CONF))

# GDBCMD_ATTACH  = --silent
# GDBCMD_ATTACH += -ex "set pagination off"
# GDBCMD_ATTACH += -ex "file program.elf"
# GDBCMD_ATTACH += -ex "target remote | $(OCD) -f $(OCD_CONF) -p -c 'log_output openocd.log'"

# GDBCMD_LOAD   += -ex "monitor reset halt"
# GDBCMD_LOAD   += -ex "load"
# GDBCMD_LOAD   += -ex "compare-sections"

# GDBCMD_BREAK  += -ex "b main"
# GDBCMD_BREAK  += -ex "continue"

# GDBCMD_INT    += -ex "interrupt"

# GDBCMD_RESRUN += -ex "monitor reset run"

# attach:
# 	$(GDB) $(GDBCMD_ATTACH) $(GDBCMD_INT)

# load:
# 	$(GDB) --batch $(GDBCMD_ATTACH) $(GDBCMD_LOAD) $(GDBCMD_RESRUN)

# debug:
# 	$(GDB) $(GDBCMD_ATTACH) $(GDBCMD_LOAD) $(GDBCMD_BREAK)

# #########################################################
# # Icarus verilog simulation

# TOPMODULE=mfp_testbench
# IVARG = -g2005 
# IVARG += -D SIMULATION
# IVARG += -I ../../../core
# IVARG += -I ../../../system_rtl
# IVARG += -I ../../../system_rtl/uart16550
# IVARG += -I ../../../testbench
# IVARG += -I ../../../testbench/sdr_sdram
# IVARG += -s $(TOPMODULE)
# IVARG += ../../../core/*.v
# IVARG += ../../../system_rtl/*.v
# IVARG += ../../../system_rtl/uart16550/*.v
# IVARG += ../../../testbench/*.v
# IVARG += ../../../testbench/sdr_sdram/*.v

# icarus:
# 	rm -rf sim
# 	mkdir sim
# 	cp *.hex sim
# 	cd sim && iverilog $(IVARG)
# 	cd sim && vvp -la.lst a.out -n
	
# gtkwave:
# 	cd sim && gtkwave dump.vcd

# #########################################################
# # How to make a bat replacement
# #  make --no-print-directory -n debug > debug.bat
# #  make --no-print-directory -n debug > attach.bat




# #########################################################
# # UART programming

# # UART interface for memory programming
# UART_MEM_LOADER_DEV=/dev/ttyUSB0

# uart:
# 	stty -F $(UART_MEM_LOADER_DEV) raw speed 115200 -crtscts cs8 -parenb -cstopb
# 	cat program.rec > $(UART_MEM_LOADER_DEV)
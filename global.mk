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
include $(DIR_BOARD)/c5gx/lpddr2/files.mk
include $(DIR_TB)/micron_ddr2/files.mk
endif

ifeq ($(MFP_CONFIG_BOARD_C5GX),y)
include $(DIR_BOARD)/c5gx/top/files.mk
endif

ifeq ($(abspath $(PWD)/..),$(DIR_PROGRAM))
    RESET_RAM_INIT = $(abspath $(MFP_CONFIG_RESET_RAM_DEFAULT))
else
    RESET_RAM_INIT = $(abspath $(MFP_CONFIG_RESET_RAM_INIT))
endif
QUARTUS_MACRO   += "MFP_RESET_RAM_HEX=\"$(RESET_RAM_INIT)\""
MSIM_MACRO      += MFP_RESET_RAM_HEX="$(RESET_RAM_INIT)"

##############################################
# global targets

mrproper:
	rm -rf $(DIR_BUILD)

##############################################
# Quartus MegaWizard qip and rtl generation

QUARTUS_MW_QIP  = $(patsubst $(DIR_BOARD)%.v, $(DIR_BUILD)%.qip, $(QUARTUS_MW_IP))

$(DIR_BUILD)/%.qip: $(DIR_BOARD)/%.v
	mkdir -p $(dir $@)
	cp $^ $(@D)/$(^F)
	cp $^ $(@D)/$(^F).bak
	cd $(@D) && qmegawiz -silent OPTIONAL_FILES="SIM_NETLIST|SYNTH_NETLIST" $(^F)
	mv $(@D)/$(^F).bak $(@D)/$(^F)

# TODO: generation from qsys
#qsys-generate -syn -sim adc.qsys

##############################################
# Quartus

BOARD_NAME    ?= c5gx

QUARTUS_FILES += $(RTL_SYN_FILES)
QUARTUS_FILES += $(QUARTUS_MW_QIP)
QUARTUS_FILES += $(RESET_RAM_INIT)
export QUARTUS_FILES
export QUARTUS_PROJECT ?= system
export QUARTUS_TOP     ?= $(BOARD_NAME)
export QUARTUS_MACRO

QUARTUS_BUILD_DIR = $(DIR_BUILD)/$(BOARD_NAME)
QUARTUS_BUILD_QPF = $(QUARTUS_BUILD_DIR)/$(QUARTUS_PROJECT).qpf

$(QUARTUS_BUILD_QPF): $(QUARTUS_FILES)
	mkdir -p $(QUARTUS_BUILD_DIR)
	cd $(QUARTUS_BUILD_DIR) && quartus_sh -t $(COMMON_RUN)/quartus_create.tcl

quartus_create: $(QUARTUS_BUILD_QPF)

quartus_open:
	cd $(QUARTUS_BUILD_DIR) && quartus $(QUARTUS_PROJECT) &

quartus_clean:
	rm -rf $(QUARTUS_BUILD_DIR)

quartus_sim: $(QUARTUS_BUILD_QPF) $(DIR_BUILD_SIM)
	cd $(DIR_BUILD_SIM) && ip-setup-simulation --quartus-project=$(QUARTUS_BUILD_QPF)

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
MODELSIM_QIP_TCL = $(if $(QUARTUS_MW_QIP), $(DIR_BUILD_SIM)/mentor/msim_setup.tcl )
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

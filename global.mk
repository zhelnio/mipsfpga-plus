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
RTL_SIM_DEFINES += MFP_RESET_RAM_HEX="$(RESET_RAM_INIT)"
QUARTUS_MACRO   += "MFP_RESET_RAM_HEX=\"$(RESET_RAM_INIT)\""

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
# Modelsim

ifneq ($(QUARTUS_MW_QIP),)
    # quartus ip init file for modelsim
    MODELSIM_QIP_TCL = $(DIR_BUILD_SIM)/mentor/msim_setup.tcl
    
    # add msim_setup.tcl to modelsim command args
    MODELSIM_OPT    += -do "source $(MODELSIM_QIP_TCL); dev_com; com"
    
    # extract lib list from msim_setup.tcl
    MODELSIM_QIP_LIB_PATTERN  = eval vsim -t ps
    MODELSIM_LIB = $(filter-out $$%, \
                        $(filter-out $(MODELSIM_QIP_LIB_PATTERN), \
                            $(shell grep '$(MODELSIM_QIP_LIB_PATTERN)' $(MODELSIM_QIP_TCL)) \
                        ) \
                    )
else
    MODELSIM_LIB = -L work
endif

MODELSIM_OPT    += -do $(COMMON_RUN)/modelsim_run.tcl



VLOG_FILES = $(RTL_SYN_FILES) $(RTL_SIM_FILES)

VLOG_OPT += -sv05compat
VLOG_OPT += -sv
VLOG_OPT += $(filter %.v %.sv, $(VLOG_FILES))
VLOG_OPT += $(addprefix +define+,$(RTL_SIM_DEFINES))
VLOG_OPT += $(addprefix +incdir+,$(sort $(realpath $(dir $(filter %.vh %.svh %.hex, $(VLOG_FILES))))))
export VLOG_OPT

VSIM_OPT += work.$(RTL_SIM_TOPNAME)
VSIM_OPT += $(MODELSIM_LIB)
export VSIM_OPT

$(DIR_BUILD_SIM):
	mkdir -p $(DIR_BUILD_SIM)

modelsim_gui: $(DIR_BUILD_SIM)
    ifneq ($(QUARTUS_MW_QIP),)
		$(MAKE) quartus_sim
    endif
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

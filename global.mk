# this .mk file current dir
TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

COMMON_PROGRAM  := $(TOP_DIR)/common/program
COMMON_INCLUDE  := $(TOP_DIR)/common/include
COMMON_RUN      := $(TOP_DIR)/common/run
DIR_MODULE      := $(TOP_DIR)/module
DIR_BOARD       := $(TOP_DIR)/board
DIR_TB          := $(TOP_DIR)/tb
DIR_BUILD       := $(TOP_DIR)/build

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

##############################################
# global targets

clean:
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
export QUARTUS_FILES
export QUARTUS_PROJECT ?= system
export QUARTUS_TOP     ?= $(BOARD_NAME)

QUARTUS_BUILD_DIR = $(DIR_BUILD)/$(BOARD_NAME)

quartus_create: $(QUARTUS_FILES)
	mkdir -p $(QUARTUS_BUILD_DIR)
	cd $(QUARTUS_BUILD_DIR) && quartus_sh -t $(COMMON_RUN)/quartus_create.tcl

quartus_open:
	cd $(QUARTUS_BUILD_DIR) && quartus $(QUARTUS_PROJECT) &

quartus_clean:
	rm -rf $(QUARTUS_BUILD_DIR)

##############################################
# Modelsim

#RTL_SIM_FILES += $(RTL_SYN_FILES)

test:
	@echo $(RTL_SIM_FILES)


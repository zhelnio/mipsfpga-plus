
QUARTUS_BOARD_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/de10_lite.v 
QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/de10_lite.tcl
QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/de10_lite.sdc
QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/board_config.vh
QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/de10_lite_ejtag.tcl

QUARTUS_TOP    = de10_lite

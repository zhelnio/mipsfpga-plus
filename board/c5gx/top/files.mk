
QUARTUS_BOARD_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/c5gx.v 
QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/c5gx.tcl
QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/c5gx.sdc
QUARTUS_FILES += $(QUARTUS_BOARD_DIR)/c5gx_ejtag.tcl

QUARTUS_TOP    = c5gx

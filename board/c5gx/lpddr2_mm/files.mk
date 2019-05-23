
DIR_BOARD_C5GX_LPDDR2_MM := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

QUARTUS_IP    += $(DIR_BOARD_C5GX_LPDDR2_MM)/lpddr2_mm.qsys
QUARTUS_FILES += $(DIR_BOARD_C5GX_LPDDR2_MM)/lpddr2_c5gx.tcl

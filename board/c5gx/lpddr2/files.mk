
DIR_BOARD_C5GX_LPDDR2 := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

QUARTUS_MW_IP += $(DIR_BOARD_C5GX_LPDDR2)/lpddr2.v
RTL_SYN_FILES += $(DIR_BOARD_C5GX_LPDDR2)/lpddr2_reset.v
RTL_SYN_FILES += $(DIR_BOARD_C5GX_LPDDR2)/lpddr2_wrapper.v
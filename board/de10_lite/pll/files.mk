
DIR_BOARD_DE10LITE_PLL := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

QUARTUS_IP    += $(DIR_BOARD_DE10LITE_PLL)/pll.v
RTL_SYN_FILES += $(DIR_BOARD_DE10LITE_PLL)/mfp_clock_max10.v

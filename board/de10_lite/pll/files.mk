
DIR_BOARD_DE10LITE_PLL := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

QUARTUS_IP += $(DIR_BOARD_DE10LITE_PLL)/pll.v

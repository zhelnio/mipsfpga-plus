
DIR_BOARD_DE10LITE_ADC := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

QUARTUS_IP += $(DIR_BOARD_DE10LITE_ADC)/adc.qsys

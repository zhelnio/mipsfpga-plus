
DIR_BOARD_DE10LITE_ADC := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

QUARTUS_IP    += $(DIR_BOARD_DE10LITE_ADC)/adc.qsys
RTL_SYN_FILES += $(DIR_BOARD_DE10LITE_ADC)/adc_max10_core.v
RTL_SYN_FILES += $(DIR_BOARD_DE10LITE_ADC)/adc_max10_core.vh
RTL_SYN_FILES += $(DIR_BOARD_DE10LITE_ADC)/ahb_lite_adc_max10.v

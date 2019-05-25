
ifeq ($(BOARD_DE10LITE_ADC),y)
SYNTHESIS_IP  += $(call current-dir)/adc.qsys
SYNTHESIS_FILE+= $(call generic-rtl-files)
endif


ifeq ($(MODULE_UART_AHB_PROGRAMMER),y)
SYNTHESIS_RTL += $(call generic-rtl-files, rtl)
endif

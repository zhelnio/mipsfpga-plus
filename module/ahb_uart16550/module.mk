
ifeq ($(MODULE_AHB_UART16550),y)
SYNTHESIS_RTL += $(call generic-rtl-files, uart16550)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif


ifeq ($(MODULE_AHB_SDRAM),y)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif

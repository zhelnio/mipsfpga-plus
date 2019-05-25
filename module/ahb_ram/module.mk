
ifeq ($(MODULE_AHB_RAM),y)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif

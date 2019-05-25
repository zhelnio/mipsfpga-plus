
ifeq ($(MODULE_AHB_AVALON),y)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif

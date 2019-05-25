
ifeq ($(MODULE_AHB_LITE),y)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif

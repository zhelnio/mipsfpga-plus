
ifeq ($(MODULE_AHB_GPIO),y)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif

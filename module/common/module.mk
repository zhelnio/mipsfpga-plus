
ifeq ($(MODULE_COMMON),y)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif

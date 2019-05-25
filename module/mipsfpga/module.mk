
ifeq ($(MODULE_MIPSFPGA),y)
SYNTHESIS_RTL += $(call generic-rtl-files, core)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif


ifeq ($(MODULE_MFP_SYSTEM),y)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif


ifeq ($(MODULE_MFP_EIC),y)
SYNTHESIS_RTL += $(call generic-rtl-files)
endif

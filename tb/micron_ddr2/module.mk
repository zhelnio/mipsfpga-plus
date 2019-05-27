
ifeq ($(TB_MICRON_DDR2),y)
SIMULATION_RTL   += $(call generic-rtl-files)
SIMULATION_MACRO += sg25
endif

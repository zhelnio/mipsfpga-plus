
ifeq ($(TB_MICRON_SDRAM),y)
SIMULATION_RTL += $(call generic-rtl-files)
endif

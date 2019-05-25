
ifeq ($(TB_TOP),y)
SIMULATION_RTL += $(call generic-rtl-files)
SIMULATION_TOP := mfp_testbench
endif

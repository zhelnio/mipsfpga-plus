
ifeq ($(TB_TOP),y)
SIMULATION_RTL += $(call generic-rtl-files)
SIMULATION_TOP := mfp_testbench
SIMULATION_FILE+= $(call current)/modelsim_wave.do
endif

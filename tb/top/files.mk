
DIR_TB_TOP := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

RTL_SIM_FILES += $(filter %.v %.sv %.vh, %.svh,  \
                    $(wildcard $(DIR_TB_TOP)/*)  \
                  )

RTL_SIM_TOPNAME = mfp_testbench

MODELSIM_DO += $(DIR_TB_TOP)/modelsim_wave.do

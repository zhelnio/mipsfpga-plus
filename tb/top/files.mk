
DIR_TB_TOP := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

RTL_SIM_FILES += $(filter %.v %.sv %.vh, %.svh,  \
                    $(wildcard $(DIR_TB_TOP)/*)  \
                  )

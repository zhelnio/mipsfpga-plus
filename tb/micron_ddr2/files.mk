
DIR_TB_MICRON_DDR2 := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

RTL_SIM_FILES += $(filter %.v %.sv %.vh, %.svh,         \
                    $(wildcard $(DIR_TB_MICRON_DDR2)/*) \
                  )

RTL_SIM_DEFINES += sg25

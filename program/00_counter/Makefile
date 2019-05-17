# MIPSfpga-plus makefile
# Stanislav Zhelnio, 2017-2019

CSOURCES += main.c

include $(PWD)/../../global.mk
include $(COMMON_PROGRAM)/build.mk

RTL_SIM_DEFINES += MFP_RESET_RAM_HEX="$(abspath program.hex32)"

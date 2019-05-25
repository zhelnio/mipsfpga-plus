
ifeq ($(BOARD_DE10LITE),y)
SYNTHESIS_RTL += $(call current-dir)/de10_lite.v
SYNTHESIS_FILE+= $(call current-dir)/de10_lite.tcl
SYNTHESIS_FILE+= $(call current-dir)/de10_lite.sdc
SYNTHESIS_FILE+= $(call current-dir)/de10_lite_ejtag.tcl
SYNTHESIS_TOP := de10_lite
SYNTHESIS_TOOL:= quartus
endif

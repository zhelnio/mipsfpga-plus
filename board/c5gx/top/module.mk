
ifeq ($(BOARD_C5GX),y)
SYNTHESIS_RTL += $(call current-dir)/c5gx.v
SYNTHESIS_FILE+= $(call current-dir)/c5gx.tcl
SYNTHESIS_FILE+= $(call current-dir)/c5gx.sdc
SYNTHESIS_FILE+= $(call current-dir)/c5gx_ejtag.tcl
SYNTHESIS_TOP := c5gx
SYNTHESIS_TOOL:= quartus
endif

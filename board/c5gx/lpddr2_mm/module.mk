
ifeq ($(BOARD_C5GX_LPDDR2),y)
SYNTHESIS_IP  += $(call current-dir)/lpddr2_mm.qsys
SYNTHESIS_FILE+= $(call current-dir)/lpddr2_c5gx.tcl
endif

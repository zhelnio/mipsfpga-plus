
ifeq ($(BOARD_DE10LITE_PLL),y)
SYNTHESIS_IP  += $(call current-dir)/pll.v
SYNTHESIS_RTL += $(call current-dir)/mfp_clock_max10.v
endif

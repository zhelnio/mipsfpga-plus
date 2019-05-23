
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CGXFC5C6F27C7

#============================================================
# ADC
#============================================================
set_instance_assignment -name IO_STANDARD "1.2 V" -to ADC_CONVST
set_instance_assignment -name IO_STANDARD "1.2 V" -to ADC_SCK
set_instance_assignment -name IO_STANDARD "1.2 V" -to ADC_SDI
set_instance_assignment -name IO_STANDARD "1.2 V" -to ADC_SDO

#============================================================
# AUD
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_ADCDAT
set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_ADCLRCK
set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_BCLK
set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_DACDAT
set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_DACLRCK
set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_XCK

#============================================================
# CLOCK
#============================================================
set_instance_assignment -name IO_STANDARD LVDS -to CLOCK_125_p
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50_B5B
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50_B6A
set_instance_assignment -name IO_STANDARD "2.5 V" -to CLOCK_50_B7A
set_instance_assignment -name IO_STANDARD "2.5 V" -to CLOCK_50_B8A

#============================================================
# CPU
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CPU_RESET_n

#============================================================
# GPIO
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[28]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[29]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[30]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[31]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[32]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[33]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[34]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO[35]

#============================================================
# HDMI
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_DE
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_HS
set_instance_assignment -name IO_STANDARD "1.2 V" -to HDMI_TX_INT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_VS

#============================================================
# HEX0
#============================================================
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[0]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[1]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[2]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[3]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[4]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[5]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[6]

#============================================================
# HEX1
#============================================================
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[0]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[1]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[2]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[3]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[4]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[5]
set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[6]

#============================================================
# HSMC
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKIN0
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKIN_n[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKIN_n[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKIN_p[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKIN_p[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKOUT0
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKOUT_n[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKOUT_n[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKOUT_p[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKOUT_p[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_D[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_D[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_D[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_D[3]
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to HSMC_GXB_RX_p[0]
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to HSMC_GXB_RX_p[1]
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to HSMC_GXB_RX_p[2]
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to HSMC_GXB_RX_p[3]
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to HSMC_GXB_TX_p[0]
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to HSMC_GXB_TX_p[1]
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to HSMC_GXB_TX_p[2]
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to HSMC_GXB_TX_p[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[8]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[9]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[10]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[11]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[12]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[13]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[14]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[15]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_n[16]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[8]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[9]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[10]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[11]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[12]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[13]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[14]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[15]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_RX_p[16]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[8]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[9]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[10]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[11]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[12]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[13]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[14]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[15]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_n[16]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[8]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[9]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[10]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[11]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[12]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[13]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[14]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[15]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_TX_p[16]

#============================================================
# I2C
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to I2C_SCL
set_instance_assignment -name IO_STANDARD "2.5 V" -to I2C_SDA

#============================================================
# KEY
#============================================================
set_instance_assignment -name IO_STANDARD "1.2 V" -to KEY[0]
set_instance_assignment -name IO_STANDARD "1.2 V" -to KEY[1]
set_instance_assignment -name IO_STANDARD "1.2 V" -to KEY[2]
set_instance_assignment -name IO_STANDARD "1.2 V" -to KEY[3]

#============================================================
# LEDG
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[7]

#============================================================
# LEDR
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[8]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[9]

#============================================================
# REFCLK
#============================================================
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to REFCLK_p0
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to REFCLK_p1

#============================================================
# SD
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_CMD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[3]

#============================================================
# SMA
#============================================================
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to SMA_GXB_RX_p
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to SMA_GXB_TX_p

#============================================================
# SRAM
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_CE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_LB_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_OE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_UB_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_WE_n

#============================================================
# SW
#============================================================
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[0]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[1]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[2]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[3]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[4]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[5]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[6]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[7]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[8]
set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[9]

#============================================================
# UART
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to UART_RX
set_instance_assignment -name IO_STANDARD "2.5 V" -to UART_TX

#============================================================
# HEX2
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[6]

#============================================================
# HEX3
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[6]

#============================================================
# End of pin assignments by Terasic System Builder
#============================================================



set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_location_assignment PIN_AB22 -to ADC_CONVST
set_location_assignment PIN_AA21 -to ADC_SCK
set_location_assignment PIN_Y10 -to ADC_SDI
set_location_assignment PIN_W10 -to ADC_SDO
set_location_assignment PIN_D7 -to AUD_ADCDAT
set_location_assignment PIN_C7 -to AUD_ADCLRCK
set_location_assignment PIN_E6 -to AUD_BCLK
set_location_assignment PIN_H10 -to AUD_DACDAT
set_location_assignment PIN_G10 -to AUD_DACLRCK
set_location_assignment PIN_D6 -to AUD_XCK
set_location_assignment PIN_U12 -to CLOCK_125_p
set_location_assignment PIN_R20 -to CLOCK_50_B5B
set_location_assignment PIN_N20 -to CLOCK_50_B6A
set_location_assignment PIN_H12 -to CLOCK_50_B7A
set_location_assignment PIN_M10 -to CLOCK_50_B8A
set_location_assignment PIN_AB24 -to CPU_RESET_n
set_location_assignment PIN_T21 -to GPIO[0]
set_location_assignment PIN_D26 -to GPIO[1]
set_location_assignment PIN_K25 -to GPIO[2]
set_location_assignment PIN_E26 -to GPIO[3]
set_location_assignment PIN_K26 -to GPIO[4]
set_location_assignment PIN_M26 -to GPIO[5]
set_location_assignment PIN_M21 -to GPIO[6]
set_location_assignment PIN_P20 -to GPIO[7]
set_location_assignment PIN_T22 -to GPIO[8]
set_location_assignment PIN_T19 -to GPIO[9]
set_location_assignment PIN_U19 -to GPIO[10]
set_location_assignment PIN_U22 -to GPIO[11]
set_location_assignment PIN_P8 -to GPIO[12]
set_location_assignment PIN_R8 -to GPIO[13]
set_location_assignment PIN_R9 -to GPIO[14]
set_location_assignment PIN_R10 -to GPIO[15]
set_location_assignment PIN_F26 -to GPIO[16]
set_location_assignment PIN_Y9 -to GPIO[17]
set_location_assignment PIN_G26 -to GPIO[18]
set_location_assignment PIN_Y8 -to GPIO[19]
set_location_assignment PIN_AA7 -to GPIO[20]
set_location_assignment PIN_AA6 -to GPIO[21]
set_location_assignment PIN_AD7 -to GPIO[22]
set_location_assignment PIN_AD6 -to GPIO[23]
set_location_assignment PIN_U20 -to GPIO[24]
set_location_assignment PIN_V22 -to GPIO[25]
set_location_assignment PIN_V20 -to GPIO[26]
set_location_assignment PIN_W21 -to GPIO[27]
set_location_assignment PIN_W20 -to GPIO[28]
set_location_assignment PIN_Y24 -to GPIO[29]
set_location_assignment PIN_Y23 -to GPIO[30]
set_location_assignment PIN_AA23 -to GPIO[31]
set_location_assignment PIN_AA22 -to GPIO[32]
set_location_assignment PIN_AC24 -to GPIO[33]
set_location_assignment PIN_AC23 -to GPIO[34]
set_location_assignment PIN_AC22 -to GPIO[35]
set_location_assignment PIN_Y25 -to HDMI_TX_CLK
set_location_assignment PIN_V23 -to HDMI_TX_D[0]
set_location_assignment PIN_AA26 -to HDMI_TX_D[1]
set_location_assignment PIN_W25 -to HDMI_TX_D[2]
set_location_assignment PIN_W26 -to HDMI_TX_D[3]
set_location_assignment PIN_V24 -to HDMI_TX_D[4]
set_location_assignment PIN_V25 -to HDMI_TX_D[5]
set_location_assignment PIN_U24 -to HDMI_TX_D[6]
set_location_assignment PIN_T23 -to HDMI_TX_D[7]
set_location_assignment PIN_T24 -to HDMI_TX_D[8]
set_location_assignment PIN_T26 -to HDMI_TX_D[9]
set_location_assignment PIN_R23 -to HDMI_TX_D[10]
set_location_assignment PIN_R25 -to HDMI_TX_D[11]
set_location_assignment PIN_P22 -to HDMI_TX_D[12]
set_location_assignment PIN_P23 -to HDMI_TX_D[13]
set_location_assignment PIN_N25 -to HDMI_TX_D[14]
set_location_assignment PIN_P26 -to HDMI_TX_D[15]
set_location_assignment PIN_P21 -to HDMI_TX_D[16]
set_location_assignment PIN_R24 -to HDMI_TX_D[17]
set_location_assignment PIN_R26 -to HDMI_TX_D[18]
set_location_assignment PIN_AB26 -to HDMI_TX_D[19]
set_location_assignment PIN_AA24 -to HDMI_TX_D[20]
set_location_assignment PIN_AB25 -to HDMI_TX_D[21]
set_location_assignment PIN_AC25 -to HDMI_TX_D[22]
set_location_assignment PIN_AD25 -to HDMI_TX_D[23]
set_location_assignment PIN_Y26 -to HDMI_TX_DE
set_location_assignment PIN_U26 -to HDMI_TX_HS
set_location_assignment PIN_T12 -to HDMI_TX_INT
set_location_assignment PIN_U25 -to HDMI_TX_VS
set_location_assignment PIN_V19 -to HEX0[0]
set_location_assignment PIN_V18 -to HEX0[1]
set_location_assignment PIN_V17 -to HEX0[2]
set_location_assignment PIN_W18 -to HEX0[3]
set_location_assignment PIN_Y20 -to HEX0[4]
set_location_assignment PIN_Y19 -to HEX0[5]
set_location_assignment PIN_Y18 -to HEX0[6]
set_location_assignment PIN_AA18 -to HEX1[0]
set_location_assignment PIN_AD26 -to HEX1[1]
set_location_assignment PIN_AB19 -to HEX1[2]
set_location_assignment PIN_AE26 -to HEX1[3]
set_location_assignment PIN_AE25 -to HEX1[4]
set_location_assignment PIN_AC19 -to HEX1[5]
set_location_assignment PIN_AF24 -to HEX1[6]
set_location_assignment PIN_N9 -to HSMC_CLKIN0
set_location_assignment PIN_G14 -to HSMC_CLKIN_n[1]
set_location_assignment PIN_K9 -to HSMC_CLKIN_n[2]
set_location_assignment PIN_G15 -to HSMC_CLKIN_p[1]
set_location_assignment PIN_L8 -to HSMC_CLKIN_p[2]
set_location_assignment PIN_A7 -to HSMC_CLKOUT0
set_location_assignment PIN_A18 -to HSMC_CLKOUT_n[1]
set_location_assignment PIN_A16 -to HSMC_CLKOUT_n[2]
set_location_assignment PIN_A19 -to HSMC_CLKOUT_p[1]
set_location_assignment PIN_A17 -to HSMC_CLKOUT_p[2]
set_location_assignment PIN_D11 -to HSMC_D[0]
set_location_assignment PIN_H14 -to HSMC_D[1]
set_location_assignment PIN_D12 -to HSMC_D[2]
set_location_assignment PIN_H13 -to HSMC_D[3]
set_location_assignment PIN_AD2 -to HSMC_GXB_RX_p[0]
set_location_assignment PIN_AB2 -to HSMC_GXB_RX_p[1]
set_location_assignment PIN_Y2 -to HSMC_GXB_RX_p[2]
set_location_assignment PIN_V2 -to HSMC_GXB_RX_p[3]
set_location_assignment PIN_AE4 -to HSMC_GXB_TX_p[0]
set_location_assignment PIN_AC4 -to HSMC_GXB_TX_p[1]
set_location_assignment PIN_AA4 -to HSMC_GXB_TX_p[2]
set_location_assignment PIN_W4 -to HSMC_GXB_TX_p[3]
set_location_assignment PIN_M12 -to HSMC_RX_n[0]
set_location_assignment PIN_L11 -to HSMC_RX_n[1]
set_location_assignment PIN_H17 -to HSMC_RX_n[2]
set_location_assignment PIN_K11 -to HSMC_RX_n[3]
set_location_assignment PIN_J16 -to HSMC_RX_n[4]
set_location_assignment PIN_J11 -to HSMC_RX_n[5]
set_location_assignment PIN_G17 -to HSMC_RX_n[6]
set_location_assignment PIN_F12 -to HSMC_RX_n[7]
set_location_assignment PIN_F18 -to HSMC_RX_n[8]
set_location_assignment PIN_E15 -to HSMC_RX_n[9]
set_location_assignment PIN_D13 -to HSMC_RX_n[10]
set_location_assignment PIN_D15 -to HSMC_RX_n[11]
set_location_assignment PIN_D16 -to HSMC_RX_n[12]
set_location_assignment PIN_D17 -to HSMC_RX_n[13]
set_location_assignment PIN_E19 -to HSMC_RX_n[14]
set_location_assignment PIN_D20 -to HSMC_RX_n[15]
set_location_assignment PIN_A24 -to HSMC_RX_n[16]
set_location_assignment PIN_N12 -to HSMC_RX_p[0]
set_location_assignment PIN_M11 -to HSMC_RX_p[1]
set_location_assignment PIN_H18 -to HSMC_RX_p[2]
set_location_assignment PIN_L12 -to HSMC_RX_p[3]
set_location_assignment PIN_H15 -to HSMC_RX_p[4]
set_location_assignment PIN_J12 -to HSMC_RX_p[5]
set_location_assignment PIN_G16 -to HSMC_RX_p[6]
set_location_assignment PIN_G12 -to HSMC_RX_p[7]
set_location_assignment PIN_E18 -to HSMC_RX_p[8]
set_location_assignment PIN_F16 -to HSMC_RX_p[9]
set_location_assignment PIN_E13 -to HSMC_RX_p[10]
set_location_assignment PIN_C14 -to HSMC_RX_p[11]
set_location_assignment PIN_E16 -to HSMC_RX_p[12]
set_location_assignment PIN_D18 -to HSMC_RX_p[13]
set_location_assignment PIN_E20 -to HSMC_RX_p[14]
set_location_assignment PIN_D21 -to HSMC_RX_p[15]
set_location_assignment PIN_B24 -to HSMC_RX_p[16]
set_location_assignment PIN_E11 -to HSMC_TX_n[0]
set_location_assignment PIN_B9 -to HSMC_TX_n[1]
set_location_assignment PIN_C10 -to HSMC_TX_n[2]
set_location_assignment PIN_B11 -to HSMC_TX_n[3]
set_location_assignment PIN_A11 -to HSMC_TX_n[4]
set_location_assignment PIN_B19 -to HSMC_TX_n[5]
set_location_assignment PIN_C15 -to HSMC_TX_n[6]
set_location_assignment PIN_A21 -to HSMC_TX_n[7]
set_location_assignment PIN_C12 -to HSMC_TX_n[8]
set_location_assignment PIN_A9 -to HSMC_TX_n[9]
set_location_assignment PIN_A13 -to HSMC_TX_n[10]
set_location_assignment PIN_C22 -to HSMC_TX_n[11]
set_location_assignment PIN_B14 -to HSMC_TX_n[12]
set_location_assignment PIN_A22 -to HSMC_TX_n[13]
set_location_assignment PIN_B17 -to HSMC_TX_n[14]
set_location_assignment PIN_C18 -to HSMC_TX_n[15]
set_location_assignment PIN_B20 -to HSMC_TX_n[16]
set_location_assignment PIN_E10 -to HSMC_TX_p[0]
set_location_assignment PIN_C9 -to HSMC_TX_p[1]
set_location_assignment PIN_D10 -to HSMC_TX_p[2]
set_location_assignment PIN_A12 -to HSMC_TX_p[3]
set_location_assignment PIN_B10 -to HSMC_TX_p[4]
set_location_assignment PIN_C20 -to HSMC_TX_p[5]
set_location_assignment PIN_B15 -to HSMC_TX_p[6]
set_location_assignment PIN_B22 -to HSMC_TX_p[7]
set_location_assignment PIN_C13 -to HSMC_TX_p[8]
set_location_assignment PIN_A8 -to HSMC_TX_p[9]
set_location_assignment PIN_B12 -to HSMC_TX_p[10]
set_location_assignment PIN_C23 -to HSMC_TX_p[11]
set_location_assignment PIN_A14 -to HSMC_TX_p[12]
set_location_assignment PIN_A23 -to HSMC_TX_p[13]
set_location_assignment PIN_C17 -to HSMC_TX_p[14]
set_location_assignment PIN_C19 -to HSMC_TX_p[15]
set_location_assignment PIN_B21 -to HSMC_TX_p[16]
set_location_assignment PIN_B7 -to I2C_SCL
set_location_assignment PIN_G11 -to I2C_SDA
set_location_assignment PIN_P11 -to KEY[0]
set_location_assignment PIN_P12 -to KEY[1]
set_location_assignment PIN_Y15 -to KEY[2]
set_location_assignment PIN_Y16 -to KEY[3]
set_location_assignment PIN_L7 -to LEDG[0]
set_location_assignment PIN_K6 -to LEDG[1]
set_location_assignment PIN_D8 -to LEDG[2]
set_location_assignment PIN_E9 -to LEDG[3]
set_location_assignment PIN_A5 -to LEDG[4]
set_location_assignment PIN_B6 -to LEDG[5]
set_location_assignment PIN_H8 -to LEDG[6]
set_location_assignment PIN_H9 -to LEDG[7]
set_location_assignment PIN_F7 -to LEDR[0]
set_location_assignment PIN_F6 -to LEDR[1]
set_location_assignment PIN_G6 -to LEDR[2]
set_location_assignment PIN_G7 -to LEDR[3]
set_location_assignment PIN_J8 -to LEDR[4]
set_location_assignment PIN_J7 -to LEDR[5]
set_location_assignment PIN_K10 -to LEDR[6]
set_location_assignment PIN_K8 -to LEDR[7]
set_location_assignment PIN_H7 -to LEDR[8]
set_location_assignment PIN_J10 -to LEDR[9]
set_location_assignment PIN_V6 -to REFCLK_p0
set_location_assignment PIN_N7 -to REFCLK_p1
set_location_assignment PIN_AB6 -to SD_CLK
set_location_assignment PIN_W8 -to SD_CMD
set_location_assignment PIN_U7 -to SD_DAT[0]
set_location_assignment PIN_T7 -to SD_DAT[1]
set_location_assignment PIN_V8 -to SD_DAT[2]
set_location_assignment PIN_T8 -to SD_DAT[3]
set_location_assignment PIN_M2 -to SMA_GXB_RX_p
set_location_assignment PIN_K2 -to SMA_GXB_TX_p
set_location_assignment PIN_B25 -to SRAM_A[0]
set_location_assignment PIN_B26 -to SRAM_A[1]
set_location_assignment PIN_H19 -to SRAM_A[2]
set_location_assignment PIN_H20 -to SRAM_A[3]
set_location_assignment PIN_D25 -to SRAM_A[4]
set_location_assignment PIN_C25 -to SRAM_A[5]
set_location_assignment PIN_J20 -to SRAM_A[6]
set_location_assignment PIN_J21 -to SRAM_A[7]
set_location_assignment PIN_D22 -to SRAM_A[8]
set_location_assignment PIN_E23 -to SRAM_A[9]
set_location_assignment PIN_G20 -to SRAM_A[10]
set_location_assignment PIN_F21 -to SRAM_A[11]
set_location_assignment PIN_E21 -to SRAM_A[12]
set_location_assignment PIN_F22 -to SRAM_A[13]
set_location_assignment PIN_J25 -to SRAM_A[14]
set_location_assignment PIN_J26 -to SRAM_A[15]
set_location_assignment PIN_N24 -to SRAM_A[16]
set_location_assignment PIN_M24 -to SRAM_A[17]
set_location_assignment PIN_N23 -to SRAM_CE_n
set_location_assignment PIN_E24 -to SRAM_D[0]
set_location_assignment PIN_E25 -to SRAM_D[1]
set_location_assignment PIN_K24 -to SRAM_D[2]
set_location_assignment PIN_K23 -to SRAM_D[3]
set_location_assignment PIN_F24 -to SRAM_D[4]
set_location_assignment PIN_G24 -to SRAM_D[5]
set_location_assignment PIN_L23 -to SRAM_D[6]
set_location_assignment PIN_L24 -to SRAM_D[7]
set_location_assignment PIN_H23 -to SRAM_D[8]
set_location_assignment PIN_H24 -to SRAM_D[9]
set_location_assignment PIN_H22 -to SRAM_D[10]
set_location_assignment PIN_J23 -to SRAM_D[11]
set_location_assignment PIN_F23 -to SRAM_D[12]
set_location_assignment PIN_G22 -to SRAM_D[13]
set_location_assignment PIN_L22 -to SRAM_D[14]
set_location_assignment PIN_K21 -to SRAM_D[15]
set_location_assignment PIN_H25 -to SRAM_LB_n
set_location_assignment PIN_M22 -to SRAM_OE_n
set_location_assignment PIN_M25 -to SRAM_UB_n
set_location_assignment PIN_G25 -to SRAM_WE_n
set_location_assignment PIN_AC9 -to SW[0]
set_location_assignment PIN_AE10 -to SW[1]
set_location_assignment PIN_AD13 -to SW[2]
set_location_assignment PIN_AC8 -to SW[3]
set_location_assignment PIN_W11 -to SW[4]
set_location_assignment PIN_AB10 -to SW[5]
set_location_assignment PIN_V10 -to SW[6]
set_location_assignment PIN_AC10 -to SW[7]
set_location_assignment PIN_Y11 -to SW[8]
set_location_assignment PIN_AE19 -to SW[9]
set_location_assignment PIN_M9 -to UART_RX
set_location_assignment PIN_L9 -to UART_TX
set_location_assignment PIN_AD7 -to HEX2[0]
set_location_assignment PIN_AD6 -to HEX2[1]
set_location_assignment PIN_U20 -to HEX2[2]
set_location_assignment PIN_V22 -to HEX2[3]
set_location_assignment PIN_V20 -to HEX2[4]
set_location_assignment PIN_W21 -to HEX2[5]
set_location_assignment PIN_W20 -to HEX2[6]
set_location_assignment PIN_Y24 -to HEX3[0]
set_location_assignment PIN_Y23 -to HEX3[1]
set_location_assignment PIN_AA23 -to HEX3[2]
set_location_assignment PIN_AA22 -to HEX3[3]
set_location_assignment PIN_AC24 -to HEX3[4]
set_location_assignment PIN_AC23 -to HEX3[5]
set_location_assignment PIN_AC22 -to HEX3[6]


#============================================================

set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "2.5 V"
set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
set_global_assignment -name OPTIMIZATION_TECHNIQUE BALANCED
set_global_assignment -name SYNTH_TIMING_DRIVEN_SYNTHESIS ON
set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "ACTIVE SERIAL X4"
set_global_assignment -name USE_CONFIGURATION_DEVICE ON
set_global_assignment -name STRATIXII_CONFIGURATION_DEVICE EPCQ256
set_global_assignment -name CRC_ERROR_OPEN_DRAIN ON
set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -rise
set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -fall
set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -rise
set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -fall
set_global_assignment -name ACTIVE_SERIAL_CLOCK FREQ_100MHZ
set_global_assignment -name OPTIMIZE_HOLD_TIMING "ALL PATHS"
set_global_assignment -name OPTIMIZE_MULTI_CORNER_TIMING ON
set_global_assignment -name FITTER_EFFORT "STANDARD FIT"
set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

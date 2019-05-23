


MFP_CONFIG_C5GX_LPDDR2=y
MFP_CONFIG_BOARD_C5GX=y

# MFP_CONFIG_BOARD_DE10LITE=y
# MFP_CONFIG_BOARD_DE10LITE_ADC=y
# MFP_CONFIG_BOARD_DE10LITE_PLL=y

# MFP_CONFIG_RESET_RAM_INIT=program/00_counter/program.hex32
MFP_CONFIG_RESET_RAM_DEFAULT=program.hex32



# tools settings
MFP_BUILD_TOOLCHAIN_PREFIX = mips-mti-elf-

MFP_BUILD_DEFAULT_CC      = mips-mti-elf-gcc
MFP_BUILD_DEFAULT_LD      = mips-mti-elf-gcc
MFP_BUILD_DEFAULT_OBJDUMP = mips-mti-elf-objdump
MFP_BUILD_DEFAULT_OBJCOPY = mips-mti-elf-objcopy
MFP_BUILD_DEFAULT_ELFSIZE = mips-mti-elf-size
MFP_BUILD_DEFAULT_READELF = mips-mti-elf-readelf
MFP_BUILD_DEFAULT_GDB     = mips-mti-elf-gdb
MFP_BUILD_DEFAULT_HEXCONV = common/program/hex32.awk

# -EL           - Little-endian
# -march=m14kc  - MIPSfpga = MIPS microAptiv UP based on MIPS M14Kc
# -msoft-float  - should not use floating-point processor instructions
# -O1           - optimization level
# -std=c99		- C99 lang standard options enabled
# -g -gdwarf-2  - debug symbols to use with gdb
MFP_BUILD_DEFAULT_FLAGS= -EL -march=m14kc -msoft-float -g -gdwarf-2
MFP_BUILD_DEFAULT_CFLAGS= -O1 -std=c99
MFP_BUILD_DEFAULT_LDFLAGS= -Wl,-Map=program.map

# native.ld    - default MIPSfpga-plus script
# reset_ram.ld - new script
MFP_BUILD_DEFAULT_LDSCRIPT=common/program/reset_ram.ld
MFP_BUILD_DEFAULT_BOOTS=common/program/boot.S
MFP_BUILD_DEFAULT_AOUT=program.elf


MFP_DEBUG_DEFAULT_OCD_BIN=openocd
MFP_DEBUG_DEFAULT_OCD_CONF=common/probe/busbluster/openocd.cfg

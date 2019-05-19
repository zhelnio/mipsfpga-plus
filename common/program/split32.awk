#!/usr/bin/awk -f

# Stanislav Zhelnio, 2019
# hex file convertor
#  Input:  .hex file created with 'objcopy -O verilog'
#  Output: .hex file for Verilog $readmemh function to init 32-bit width memory

{
    print "ARGV[0]"

    #reset = 0
    if (substr($1, 1, 1) == "@") {
        addr = substr($1, 2, 8)
        decaddr=strtonum("0x"addr)
        if(decaddr < 0x90000000) {
            reset = 0
            print "WoW " reset " " addr

        } else {
            reset = 1
            print "WoW " reset " " addr
        }
        printf("@%08x\n",decaddr/4)
    } else {
        print reset " "$4 $3 $2 $1 " " $8 $7 $6 $5 " " $12 $11 $10 $9 " " $16 $15 $14 $13
    }
}

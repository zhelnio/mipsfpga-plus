#!/usr/bin/awk -f
{
    if (substr($1, 1, 1) == "@") {
        addr = substr($1, 2, 8)
        decaddr=strtonum("0x"addr)
        printf("@%08x\n",decaddr/4)
    } else {
        print $4 $3 $2 $1 " " $8 $7 $6 $5 " " $12 $11 $10 $9 " " $16 $15 $14 $13
    }
}

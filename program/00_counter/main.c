#include "mfp_gpio.h"

int main ()
{
    long long int n = 0;

    for (;;)
    {
        long long int val = n;//n >> 16; //((n >> 8) & 0xffffff00) | (n & 0xff);

        MFP_RED_LEDS      = val >> 8;
        MFP_GREEN_LEDS    = MFP_RED_LEDS;
        MFP_7_SEGMENT_HEX = val;

        n ++;
    }

    return 0;
}

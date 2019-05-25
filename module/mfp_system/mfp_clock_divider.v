
module mfp_clock_divider
#(
    parameter   CLOCK_DIV_MODE0 = 0,
                CLOCK_DIV_MODE1 = CLOCK_DIV_MODE0,
                CLOCK_DIV_MODE2 = CLOCK_DIV_MODE0,
                CLOCK_DIV_MODE3 = CLOCK_DIV_MODE0,
                CLOCK_DIV_WIDTH = CLOCK_DIV_MODE0 
)(
    input            gclk,
    input      [1:0] mode,
    output reg       clk
);
    reg [CLOCK_DIV_WIDTH:0] cntr;

    always @ (posedge gclk)
        cntr <= cntr + 1'b1;

    always @ (posedge gclk)
        case (mode)
            2'b00 : clk <= cntr[CLOCK_DIV_MODE0];
            2'b01 : clk <= cntr[CLOCK_DIV_MODE1];
            2'b10 : clk <= cntr[CLOCK_DIV_MODE2];
            2'b11 : clk <= cntr[CLOCK_DIV_MODE3];
        endcase

endmodule


module mfp_clock_slow
#(
    parameter MODE = 50, // supported: 50, 100
              TOOL = ""  // supported: "quartus", "vivado", ""
)(
    input        gclk,
    input  [1:0] mode,
    output       clk_cpu,
    output       clk_adc,
    output       clk_dram,
    output       clk_debug,
    output       locked 
);
    // Mode = 50 when gclk == 50 MHz,
    //       100             100 MHz
    localparam CLOCK_DIV_MODE0 = (MODE == 50) ?  0 :  1, // clk_cpu = 25   MHz
               CLOCK_DIV_MODE1 = (MODE == 50) ? 20 : 21, // clk_cpu = 12   Hz
               CLOCK_DIV_MODE2 = (MODE == 50) ? 25 : 26; // clk_cpu = 0.75 Hz

    // mode pins debouncer
    wire[1:0] mode_d;
    mfp_debouncer #(.WIDHT(2)) mode_debouncer (gclk, mode, mode_d);

    // clock divider
    wire      clk_o
    mfp_clock_divider #  (
        .CLOCK_DIV_MODE0 ( CLOCK_DIV_MODE0 ),
        .CLOCK_DIV_MODE1 ( CLOCK_DIV_MODE1 ),
        .CLOCK_DIV_MODE2 ( CLOCK_DIV_MODE2 ) 
    ) mfp_clock_divider  (
        .gclk            ( gclk            ),
        .mode            ( dmode           ),
        .clk             ( clk_o           )
    );

    // make clock signal global
    generate
        if(TOOL == "quartus")
            global global_buf ( .in(clk_o), .out(clk_cpu));

        if(TOOL == "vivado")
            BUFG   global_buf (.I(clk_o), .O(clk_cpu));
    endgenerate

    // other clocks
    assign clk_adc   = 1'b0;
    assign clk_dram  = 1'b0;
    assign clk_debug = gclk;
    assign locked    = 1'b1;

endmodule

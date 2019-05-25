
module mfp_clock_stub
#(
    parameter MODE = 0,
              TOOL = ""
)(
    input        gclk,
    input  [1:0] mode,
    output       clk_cpu,
    output       clk_adc,
    output       clk_dram,
    output       clk_debug,
    output       locked 
);
    assign clk_cpu   = gclk;
    assign clk_adc   = 1'b0; //TODO: add ADC clock generation for simulator
    assign clk_dram  = 1'b0;
    assign clk_debug = gclk;
    assign locked    = 1'b1;
endmodule

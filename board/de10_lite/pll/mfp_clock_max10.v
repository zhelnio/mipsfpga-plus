
module mfp_clock_max10
#(
    parameter MODE = 0,
              TOOL = ""
)(
    input        gclk,
    input  [1:0] mode,      // ignored
    output       clk_cpu,
    output       clk_adc,
    output       clk_dram,
    output       clk_debug,
    output       locked 
);
    pll pll(gclk, clk_adc, clk_cpu, clk_dram, clk_debug, locked);
endmodule

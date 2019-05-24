
module mfp_reset
#(
    parameter DELAY_VALUE = 63
)(
    input  clk,
    input  clk_locked,
    input  pin_rst_cold,
    input  pin_rst_soft,
    input  pin_ej_rst_n,
    input  pin_ej_trst_n,
    input  memory_load,

    output reg SI_Reset,
    output reg SI_ColdReset,
    output reg EJ_TRST_N
);
    wire rst_cold;
    wire rst_soft;
    wire ej_rst_n;
    wire ej_trst_n;
    wire locked;

    // debouncer 
    mfp_synczer s_pin_rst_cold  (clk, pin_rst_cold,  rst_cold);
    mfp_synczer s_pin_rst_soft  (clk, pin_rst_soft,  rst_soft);
    mfp_synczer s_pin_ej_rst_n  (clk, pin_ej_rst_n,  ej_rst_n);
    mfp_synczer s_pll_locked    (clk, clk_locked,    locked);
    mfp_synczer s_pin_ej_trst_n (clk, pin_ej_trst_n, ej_trst_n);

    // cold reset with delay
    localparam CNTR_WIDTH = $clog2(DELAY_VALUE);
    
    reg [CNTR_WIDTH-1:0] delay;
    initial delay = DELAY_VALUE;
    wire delay_end = delay == 0;

    always @(posedge clk)
        if(rst_cold)
            delay <= DELAY_VALUE;
        else if(locked & ~delay_end) 
            delay <= delay - 1;

    always @(posedge clk)
        SI_ColdReset <= ~delay_end;

    // soft reset
    always @(posedge clk)
        SI_Reset <= rst_soft | ~ej_rst_n | SI_ColdReset | memory_load;

    // ejtag cold reset
    always @(posedge clk)
        EJ_TRST_N <= ~SI_ColdReset & ej_trst_n;

endmodule

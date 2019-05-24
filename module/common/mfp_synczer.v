
module mfp_synczer
(
    input      clk,
    input      d,
    output reg q
);
    reg val;
    always @(posedge clk)
        { q, val } <= { val, d };

endmodule

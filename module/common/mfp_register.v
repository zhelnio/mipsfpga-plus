

module mfp_register_r
#(
    parameter WIDTH = 1
)(
    input                    clk,
    input                    rst_n,
    input      [ WIDTH-1:0 ] d,
    input                    wr,
    output reg [ WIDTH-1:0 ] q
);
    always @ (posedge clk or negedge rst_n)
        if(~rst_n)
            q <= { WIDTH { 1'b0 } };
        else
            if(wr) q <= d;
endmodule

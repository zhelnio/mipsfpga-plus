
module mfp_debouncer_pin
#(
    parameter DEPTH = 8
)(
    input      clk,
    input      in,
    output reg out
);
    // synchronizer
    wire synced_in;
    mfp_synczer sync (clk, in, synced_in);

    // debouncer
    reg  [ DEPTH-1:0] cntr;
    always @ (posedge clk)
        cntr <= out ^ synced_in ? cntr + 1 : '0;

    always @ (posedge clk)
        if(cntr == '1) out <= synced_in;

endmodule

module mfp_debouncer
#(
    parameter DEPTH = 8,
              WIDHT = 1
)(
    input             clk,
    input [WIDHT-1:0] in,
    input [WIDHT-1:0] out
);

    genvar ii;
    generate
        for(ii=0; ii<WIDHT; ii+=1)
            mfp_debouncer_pin #(DEPTH) debouncer (clk, in[ii], out[ii]);
    endgenerate

endmodule

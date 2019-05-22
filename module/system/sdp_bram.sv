
module sdp_bram
#(
    parameter ADDR_WIDTH = 6,
              DATA_WIDTH = 1,
              INIT_RMEMH = ""
)(
    input                       clk,
    input      [ADDR_WIDTH-1:0] wa,
    input                       we,
    input      [DATA_WIDTH-1:0] wd,
    input      [ADDR_WIDTH-1:0] ra,
    input                       re,
    output     [DATA_WIDTH-1:0] rd
);
    localparam RAM_SIZE  = 2**(ADDR_WIDTH);

    reg [DATA_WIDTH-1:0] ram [RAM_SIZE - 1:0];
    reg [DATA_WIDTH-1:0] rdata;
    assign rd = rdata;

    always @(posedge clk)
        if (we) ram[wa] <= wd;

    always @(posedge clk)
        if (re) rdata <= ram [ra];

    // BUG: implemented as DFF
    // TODO: fix, implement as ROM in another module
    generate
        if(INIT_RMEMH != "")
           initial $readmemh (INIT_RMEMH, ram);
    endgenerate

endmodule

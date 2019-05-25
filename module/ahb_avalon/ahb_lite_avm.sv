/* Simple AHB-Lite - Avalon-MM converter
 * Copyright(c) 2019 Stanislav Zhelnio
 */

`include "mfp_ahb_lite.vh"

module ahb_lite_avm
#(
   parameter HADDR_WIDTH = 17,  // AHB addr width
             HDATA_WIDTH = 32,  // AHB data width
             AADDR_OFFST = 2,   // Avalon-MM is word addressed in this implementation
             AADDR_WIDTH = 27,  //TODO:fix it
   parameter AV_BE_WIDTH = HDATA_WIDTH / 8,
             AV_BC_WIDTH = 3
)(
    // AHB-Lite side
    input                    HCLK,
    input                    HRESETn,
    input  [HADDR_WIDTH-1:0] HADDR,
    input  [            2:0] HBURST,
    input                    HMASTLOCK, // ignored
    input  [            3:0] HPROT,     // ignored
    input                    HSEL,
    input  [            2:0] HSIZE,
    input  [            1:0] HTRANS,
    input  [HDATA_WIDTH-1:0] HWDATA,
    input                    HWRITE,
    input                    HREADY,
    output [HDATA_WIDTH-1:0] HRDATA,
    output                   HREADYOUT,
    output                   HRESP,

    // Avalon-MM side
    output                   avm_clk,
    output                   avm_rst_n,
    input                    avm_waitrequest,
    input                    avm_readdatavalid,
    input  [HDATA_WIDTH-1:0] avm_readdata,
    output                   avm_write,
    output                   avm_read,
    output [AADDR_WIDTH-1:0] avm_address,
    output [AV_BE_WIDTH-1:0] avm_byteenable,
    output [AV_BC_WIDTH-1:0] avm_burstcount,
    output                   avm_beginbursttransfer,
    output                   avm_begintransfer,
    output [HDATA_WIDTH-1:0] avm_writedata 
);
    assign avm_clk   = HCLK;
    assign avm_rst_n = HRESETn;

    // AHB side request
    wire ahb_act = HTRANS != `HTRANS_IDLE && HSEL && HREADY;

    reg [HADDR_WIDTH-1:0] ahb_addr;
    always_ff @(posedge HCLK)
        if(ahb_act) ahb_addr <= HADDR;

    // FSM, slow but simple
    localparam S_IDLE  = 0,
               S_WRITE = 1,
               S_READ0 = 2,
               S_READ1 = 3;

    reg [1:0] State, Next;
    always_ff @(posedge HCLK or negedge HRESETn)
        if(~HRESETn) State <= S_IDLE;
        else         State <= Next;

    always_comb begin
        Next = State;
        case(State)
            S_IDLE  : if(ahb_act) Next = HWRITE ? S_WRITE : S_READ0;
            S_WRITE : if(~avm_waitrequest  ) Next = S_IDLE;
            S_READ0 : if(~avm_waitrequest  ) Next = S_READ1;
            S_READ1 : if( avm_readdatavalid) Next = S_IDLE;
        endcase
    end

    // FSM output
    reg [HDATA_WIDTH-1:0] rdata;
    always_ff @(posedge HCLK)
        if(avm_readdatavalid) rdata <= avm_readdata;

    assign HRDATA    = rdata;
    assign HRESP     = 0;
    assign HREADYOUT = State == S_IDLE;

    // Avalon side request
    assign avm_write     = State == S_WRITE;
    assign avm_read      = State == S_READ0;
    assign avm_address   = ahb_addr [AADDR_OFFST +: AADDR_WIDTH];
    assign avm_writedata = HWDATA;

    // byteenable 
    localparam BENAB_WIDTH = HDATA_WIDTH / 8;
    localparam BADDR_WIDTH = $clog2(BENAB_WIDTH);
    reg [BENAB_WIDTH-1:0] benab;
    assign avm_byteenable = benab [AV_BE_WIDTH-1:0];

    always_ff @(posedge HCLK)
        if(ahb_act)
            case(HSIZE) // write mask
                `HSIZE_1 : benab <= 8'b00000001 << HADDR[BADDR_WIDTH-1:0];
                `HSIZE_2 : benab <= 8'b00000011 << HADDR[BADDR_WIDTH-1:0];
                `HSIZE_4 : benab <= 8'b00001111 << HADDR[BADDR_WIDTH-1:0];
                `HSIZE_8 : benab <= 8'b11111111;
                default  : benab <= 8'b00000000;
            endcase

    // burstcount is always 1 for simplest case because:
    // - MIPSfpga supports only HBURST=WRAP4
    // - native Avalon-MM burst order corresponds to HBURST=INCR*
    reg avm_bt;
    always_ff @(posedge HCLK)
        avm_bt <= (State == S_IDLE && Next != S_IDLE);

    assign avm_burstcount         = 1;
    assign avm_begintransfer      = avm_bt;
    assign avm_beginbursttransfer = avm_bt;

endmodule

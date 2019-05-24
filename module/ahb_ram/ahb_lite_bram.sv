module ahb_lite_bram
#(
    parameter   HADDR_WIDTH = 17,
                HDATA_WIDTH = 32,
                INIT_RMEMH  = "",
                MADDR_WIDTH = HADDR_WIDTH - $clog2(HDATA_WIDTH / 8)
)(
    // AHB-Lite side
    input                    HCLK,
    input                    HRESETn,
    input  [HADDR_WIDTH-1:0] HADDR,
    input  [            2:0] HBURST,    // ignored
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
    output                   HRESP
);
    // bram wires
    wire [MADDR_WIDTH-1:0] wa;
    wire                   we;
    wire [HDATA_WIDTH-1:0] wd;
    wire [MADDR_WIDTH-1:0] ra;
    wire                   re;
    wire [HDATA_WIDTH-1:0] rd;

    ahb_lite_sdp    #(
        .HADDR_WIDTH ( HADDR_WIDTH ),
        .HDATA_WIDTH ( HDATA_WIDTH ),
        .MADDR_WIDTH ( MADDR_WIDTH ) 
    ) ahb_lite_sdp   (
        .HCLK        ( HCLK        ),
        .HRESETn     ( HRESETn     ),
        .HADDR       ( HADDR       ),
        .HTRANS      ( HTRANS      ),
        .HSIZE       ( HSIZE       ),
        .HWRITE      ( HWRITE      ),
        .HWDATA      ( HWDATA      ),
        .HRDATA      ( HRDATA      ),
        .HREADY      ( HREADY      ),
        .HRESP       ( HRESP       ),
        .HSEL        ( HSEL        ),
        .HREADYOUT   ( HREADYOUT   ),
        .wa          ( wa          ),
        .we          ( we          ),
        .wd          ( wd          ),
        .ra          ( ra          ),
        .re          ( re          ),
        .rd          ( rd          ) 
    );

    sdp_bram #(
        .ADDR_WIDTH ( MADDR_WIDTH ),
        .DATA_WIDTH ( HDATA_WIDTH ),
        .INIT_RMEMH ( INIT_RMEMH  ) 
    ) sdp_bram (
        .clk        ( HCLK        ),
        .wa         ( wa          ),
        .we         ( we          ),
        .wd         ( wd          ),
        .ra         ( ra          ),
        .re         ( re          ),
        .rd         ( rd          ) 
    );

endmodule

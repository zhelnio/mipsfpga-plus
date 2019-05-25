`include "mfp_ahb_lite.vh"

module mfp_ahb_gpio
#(
    parameter GPIOW_COUNT = 1,
              GPIOR_COUNT = GPIOW_COUNT,
    parameter HDATA_WIDTH = 32
)(
    input                          HCLK,
    input                          HRESETn,
    input  [HDATA_WIDTH-1:0]       HADDR,
    input  [            2:0]       HBURST,
    input                          HMASTLOCK,
    input  [            3:0]       HPROT,
    input  [            2:0]       HSIZE,
    input                          HSEL,
    input  [            1:0]       HTRANS,
    input  [HDATA_WIDTH-1:0]       HWDATA,
    input                          HWRITE,
    input                          HREADY,
    output [HDATA_WIDTH-1:0]       HRDATA,
    output                         HREADYOUT,
    output                         HRESP,
    input  [GPIOR_COUNT-1:0][31:0] gpio_rd,
    output                  [31:0] gpio_wd,
    output [GPIOW_COUNT-1:0]       gpio_we 
);

    localparam MADDR_WIDTH = $clog2( GPIOW_COUNT>GPIOR_COUNT ? GPIOW_COUNT : GPIOR_COUNT ),
               HADDR_WIDTH = MADDR_WIDTH + 2;

    // bram wires
    wire [MADDR_WIDTH-1:0] wa;
    wire                   we;
    wire [HDATA_WIDTH-1:0] wd;
    wire [MADDR_WIDTH-1:0] ra;
    wire                   re;
    reg  [HDATA_WIDTH-1:0] rd;

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

    assign gpio_wd = wd;
    assign gpio_we = we ? (1 << wa) : '0;

    always @(posedge HCLK)
        if(re) rd <= gpio_rd [ra];

endmodule
`include "mfp_ahb_lite.vh"

module mfp_ahb_gpio
#(
    parameter HDATA_WIDTH = 32,
              GPIO_W      = 1,
              GPIO_R      = GPIO_W
)(
    input                     HCLK,
    input                     HRESETn,
    input  [ HDATA_WIDTH-1:0] HADDR,
    input  [             2:0] HBURST,
    input                     HMASTLOCK,
    input  [             3:0] HPROT,
    input  [             2:0] HSIZE,
    input                     HSEL,
    input  [             1:0] HTRANS,
    input  [ HDATA_WIDTH-1:0] HWDATA,
    input                     HWRITE,
    input                     HREADY,
    output [ HDATA_WIDTH-1:0] HRDATA,
    output                    HREADYOUT,
    output                    HRESP,

    input  [GPIO_R-1:0][31:0] gpio_rd,
    output             [31:0] gpio_wd,
    output [GPIO_W-1:0]       gpio_we 
);

    localparam MADDR_WIDTH = $clog2( GPIO_W>GPIO_R ? GPIO_W : GPIO_R ),
               HADDR_WIDTH = MADDR_WIDTH + 2;

    // bram wires
    wire     [MADDR_WIDTH-1:0] wa;
    wire                       we;
    wire     [HDATA_WIDTH-1:0] wd;
    wire     [MADDR_WIDTH-1:0] ra;
    wire                       re;
    wire reg [HDATA_WIDTH-1:0] rd;

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

module mfp_gpio_pin
#(
    parameter COUNT_BTN  = 32,
              COUNT_SW   = 32,
              COUNT_LEDR = 32,
              COUNT_LEDG = 32,
              COUNT_7SEG = 32
)(
    input                         clk,
    input                         rst_n,
    output [    GPIO_R-1:0][31:0] gpio_rd,
    input                  [31:0] gpio_wd,
    input  [    GPIO_W-1:0]       gpio_we,
    input  [COUNT_BTN -1:0]       pin_sw,
    input  [COUNT_SW  -1:0]       pin_btn,
    output [COUNT_LEDR-1:0]       pin_ledr,
    output [COUNT_LEDG-1:0]       pin_ledg,
    output [COUNT_7SEG-1:0]       pin_7seg
);
    localparam  ADDR_LEDR = 0,
                ADDR_LEDG = 1,
                ADDR_SW   = 2,
                ADDR_BTN  = 3,
                ADDR_7SEG = 4;

    wire [COUNT_SW -1:0] d_sw;
    mfp_debouncer #(.WIDHT(COUNT_SW )) deb_sw  (clk, pin_sw,  d_sw);

    wire [COUNT_BTN-1:0] d_btn;
    mfp_debouncer #(.WIDHT(COUNT_BTN)) deb_btn (clk, pin_btn, d_btn);

    mfp_register_r #(COUNT_LEDR) r_ledr (clk, rst_n, gpio_w [COUNT_LEDR-1:0], gpio_we [ADDR_LEDR], pin_ledr);
    mfp_register_r #(COUNT_LEDG) r_ledg (clk, rst_n, gpio_w [COUNT_LEDG-1:0], gpio_we [ADDR_LEDG], pin_ledg);
    mfp_register_r #(COUNT_7SEG) r_7seg (clk, rst_n, gpio_w [COUNT_7SEG-1:0], gpio_we [ADDR_7SEG], pin_7seg);

    assign gpio_r[ADDR_LEDR] = 32'b0 | pin_ledr;
    assign gpio_r[ADDR_LEDG] = 32'b0 | pin_ledg;
    assign gpio_r[ADDR_SW  ] = 32'b0 | d_sw;
    assign gpio_r[ADDR_BTN ] = 32'b0 | d_btn;
    assign gpio_r[ADDR_7SEG] = 32'b0 | pin_7seg;

endmodule

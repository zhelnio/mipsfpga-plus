
module mfp_gpio_map
#(
    parameter GPIOW_COUNT      = 5,
              GPIOR_COUNT      = GPIOW_COUNT,
    parameter BOARD_WIDTH_BTN  = 32,
              BOARD_WIDTH_SW   = 32,
              BOARD_WIDTH_LEDR = 32,
              BOARD_WIDTH_LEDG = 32,
              BOARD_WIDTH_7SEG = 32 
)(
    input                          clk,
    input                          rst_n,
    output [GPIOR_COUNT-1:0][31:0] gpio_rd,
    input                   [31:0] gpio_wd,
    input  [GPIOW_COUNT-1:0]       gpio_we,
    input  [ BOARD_WIDTH_BTN -1:0] pin_sw,
    input  [ BOARD_WIDTH_SW  -1:0] pin_btn,
    output [ BOARD_WIDTH_LEDR-1:0] pin_ledr,
    output [ BOARD_WIDTH_LEDG-1:0] pin_ledg,
    output [ BOARD_WIDTH_7SEG-1:0] pin_7seg
);
    localparam  ADDR_LEDR = 0,
                ADDR_LEDG = 1,
                ADDR_SW   = 2,
                ADDR_BTN  = 3,
                ADDR_7SEG = 4;

    wire [BOARD_WIDTH_SW -1:0] d_sw;
    mfp_debouncer #(.WIDHT(BOARD_WIDTH_SW )) deb_sw  (clk, pin_sw,  d_sw);

    wire [BOARD_WIDTH_BTN-1:0] d_btn;
    mfp_debouncer #(.WIDHT(BOARD_WIDTH_BTN)) deb_btn (clk, pin_btn, d_btn);

    mfp_register_r #(BOARD_WIDTH_LEDR) r_ledr (clk, rst_n, gpio_w[BOARD_WIDTH_LEDR-1:0], gpio_we[ADDR_LEDR], pin_ledr);
    mfp_register_r #(BOARD_WIDTH_LEDG) r_ledg (clk, rst_n, gpio_w[BOARD_WIDTH_LEDG-1:0], gpio_we[ADDR_LEDG], pin_ledg);
    mfp_register_r #(BOARD_WIDTH_7SEG) r_7seg (clk, rst_n, gpio_w[BOARD_WIDTH_7SEG-1:0], gpio_we[ADDR_7SEG], pin_7seg);

    assign gpio_r[ADDR_LEDR] = 32'b0 | pin_ledr;
    assign gpio_r[ADDR_LEDG] = 32'b0 | pin_ledg;
    assign gpio_r[ADDR_SW  ] = 32'b0 | d_sw;
    assign gpio_r[ADDR_BTN ] = 32'b0 | d_btn;
    assign gpio_r[ADDR_7SEG] = 32'b0 | pin_7seg;

endmodule


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

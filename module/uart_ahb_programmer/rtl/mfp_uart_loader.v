
module mfp_uart_loader
#(
    parameter CLK_FREQ  = 50000000,
              BOUD_RATE = 115200
)(
    input             clk,
    input             reset_n,
    input             uart_rx,
    output            uart_load,

    output     [31:0] HADDR,
    output     [ 2:0] HBURST,
    output            HMASTLOCK,
    output     [ 3:0] HPROT,
    output     [ 2:0] HSIZE,
    output     [ 1:0] HTRANS,
    output     [31:0] HWDATA,
    output            HWRITE 
);
    // data from uart
    wire [7:0] char_data;
    wire       char_ready;

    // memory transactions
    wire [31:0] write_address;
    wire [ 7:0] write_byte;
    wire        write_enable;

    mfp_uart_receiver  #(
        .clock_frequency( CLK_FREQ      ),
        .baud_rate      ( BOUD_RATE     ) 
    ) mfp_uart_receiver (
        .clock          ( clk           ),
        .reset_n        ( reset_n       ),
        .rx             ( uart_rx       ),
        .byte_data      ( char_data     ),
        .byte_ready     ( char_ready    )
    );

    mfp_srec_parser mfp_srec_parser
    (
        .clock          ( clk           ),
        .reset_n        ( reset_n       ),
        .char_data      ( char_data     ),
        .char_ready     ( char_ready    ), 
        .in_progress    ( uart_load     ),
        .format_error   (               ),
        .checksum_error (               ),
        .error_location (               ),
        .write_address  ( write_address ),
        .write_byte     ( write_byte    ),
        .write_enable   ( write_enable  )
    );

    mfp_srec_parser_ahb ahb_lite_bridge
    (
        .clock          ( clk           ),
        .reset_n        ( reset_n       ),
        .write_address  ( write_address ),
        .write_byte     ( write_byte    ),
        .write_enable   ( write_enable  ), 
        .HADDR          ( HADDR         ),
        .HBURST         ( HBURST        ),
        .HMASTLOCK      ( HMASTLOCK     ),
        .HPROT          ( HPROT         ),
        .HSIZE          ( HSIZE         ),
        .HTRANS         ( HTRANS        ),
        .HWDATA         ( HWDATA        ),
        .HWRITE         ( HWRITE        )
    );

endmodule

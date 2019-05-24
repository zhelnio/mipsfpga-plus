
module mfp_uart_loader
(
    input             clk,
    input             reset_n,
    input             uart_rx,
    output            uart_load

    output     [31:0] HADDR,
    output     [ 2:0] HBURST,
    output            HMASTLOCK,
    output     [ 3:0] HPROT,
    output     [ 2:0] HSIZE,
    output     [ 1:0] HTRANS,
    output     [31:0] HWDATA,
    output            HWRITE,
);
    // data from uart
    wire [7:0] char_data;
    wire       char_ready;

    // memory transactions
    wire [31:0] write_address;
    wire [ 7:0] write_byte;
    wire        write_enable;

    mfp_uart_receiver mfp_uart_receiver
    (
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

module mfp_uart_programmer
#(
    parameter ENABLED = 0
)(
    input             clk,
    input             rst_n,
    input             uart_rx,
    output            uart_load,
    input             s_HRESETn,
    input      [31:0] s_HADDR,
    input      [ 2:0] s_HBURST,
    input             s_HMASTLOCK,
    input      [ 3:0] s_HPROT,
    input      [ 2:0] s_HSIZE,
    input      [ 1:0] s_HTRANS,
    input      [31:0] s_HWDATA,
    input             s_HWRITE,
    output            m_HRESETn,
    output     [31:0] m_HADDR,
    output     [ 2:0] m_HBURST,
    output            m_HMASTLOCK,
    output     [ 3:0] m_HPROT,
    output     [ 2:0] m_HSIZE,
    output     [ 1:0] m_HTRANS,
    output     [31:0] m_HWDATA,
    output            m_HWRITE 
);
    wire [31:0] l_HADDR;
    wire [ 2:0] l_HBURST;
    wire        l_HMASTLOCK;
    wire [ 3:0] l_HPROT;
    wire [ 2:0] l_HSIZE;
    wire [ 1:0] l_HTRANS;
    wire [31:0] l_HWDATA;
    wire        l_HWRITE;

    wire bypass = ~ENABLED | ~uart_load;

    assign m_HRESETn   = bypass ? s_HRESETn   : 1'b1;
    assign m_HADDR     = bypass ? s_HADDR     : l_HADDR;
    assign m_HBURST    = bypass ? s_HBURST    : l_HBURST;
    assign m_HMASTLOCK = bypass ? s_HMASTLOCK : l_HMASTLOCK;
    assign m_HPROT     = bypass ? s_HPROT     : l_HPROT;
    assign m_HSIZE     = bypass ? s_HSIZE     : l_HSIZE;
    assign m_HTRANS    = bypass ? s_HTRANS    : l_HTRANS;
    assign m_HWDATA    = bypass ? s_HWDATA    : l_HWDATA;
    assign m_HWRITE    = bypass ? s_HWRITE    : l_HWRITE;

    mfp_uart_loader mfp_uart_loader
    (
        .clk       ( clk         ),
        .reset_n   ( rst_n       ),
        .uart_rx   ( uart_rx     ),
        .uart_load ( uart_load   ),
        .HADDR     ( l_HADDR     ),
        .HBURST    ( l_HBURST    ),
        .HMASTLOCK ( l_HMASTLOCK ),
        .HPROT     ( l_HPROT     ),
        .HSIZE     ( l_HSIZE     ),
        .HTRANS    ( l_HTRANS    ),
        .HWDATA    ( l_HWDATA    ),
        .HWRITE    ( l_HWRITE    ) 
    );

endmodule

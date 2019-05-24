/* Altera MAX10 ADC controller for MIPSfpga+ system 
 * managed using AHB-Lite bus
 * Copyright(c) 2017 Stanislav Zhelnio
 */

`include "mfp_adc_max10_core.vh"

module mfp_ahb_lite_adc_max10
(
    // global
    input                   clk_adc,
    input                   clk_locked,

    // trigger and interrupt
    input                   ADC_Trigger,
    output                  ADC_Interrupt,

    //ABB-Lite side
    input                   HCLK,
    input                   HRESETn,
    input      [ 31 : 0 ]   HADDR,
    input      [  2 : 0 ]   HBURST,
    input                   HMASTLOCK,  // ignored
    input      [  3 : 0 ]   HPROT,      // ignored
    input                   HSEL,
    input      [  2 : 0 ]   HSIZE,
    input      [  1 : 0 ]   HTRANS,
    input      [ 31 : 0 ]   HWDATA,
    input                   HWRITE,
    input                   HREADY,
    output     [ 31 : 0 ]   HRDATA,
    output                  HREADYOUT,
    output                  HRESP 
);
    // from bus slave to ADC control
    wire [`ADC_ADDR_WIDTH-1:0] read_addr;
    wire                       read_enable;
    wire [`ADC_ADDR_WIDTH-1:0] write_addr;
    wire [                3:0] write_mask;
    wire                       write_enable;

    // from ADC control to ADC core (Avalon-ST)
    wire                       ADC_C_Valid,    //  command.valid
    wire [                4:0] ADC_C_Channel,  //         .channel
    wire                       ADC_C_SOP,      //         .startofpacket
    wire                       ADC_C_EOP,      //         .endofpacket
    wire                       ADC_C_Ready,    //         .ready
    wire                       ADC_R_Valid,    // response.valid
    wire [                4:0] ADC_R_Channel,  //         .channel
    wire [               11:0] ADC_R_Data,     //         .data
    wire                       ADC_R_SOP,      //         .startofpacket
    wire                       ADC_R_EOP,      //         .endofpacket

    assign HRESP  = 1'b0;

    mfp_ahb_lite_slave
    #(
        .ADDR_WIDTH ( `ADC_ADDR_WIDTH ),
        .ADDR_START (               2 )
    )
    decoder
    (
        .HCLK           ( HCLK          ),
        .HRESETn        ( HRESETn       ),
        .HADDR          ( HADDR         ),
        .HSIZE          ( HSIZE         ),
        .HTRANS         ( HTRANS        ),
        .HWRITE         ( HWRITE        ),
        .HSEL           ( HSEL          ),
        .HREADY         ( HREADY        ),
        .HREADYOUT      ( HREADYOUT     ),
        .read_enable    ( read_enable   ),
        .read_addr      ( read_addr     ),
        .write_enable   ( write_enable  ),
        .write_addr     ( write_addr    ),
        .write_mask     ( write_mask    )
    );

    mfp_adc_max10_core adc_core
    (
        .CLK            ( HCLK          ),
        .RESETn         ( HRESETn       ),
        .read_addr      ( read_addr     ),
        .read_data      ( HRDATA        ),
        .write_addr     ( write_addr    ),
        .write_data     ( HWDATA        ),
        .write_enable   ( write_enable  ),
        .ADC_C_Valid    ( ADC_C_Valid   ),
        .ADC_C_Channel  ( ADC_C_Channel ),
        .ADC_C_SOP      ( ADC_C_SOP     ),
        .ADC_C_EOP      ( ADC_C_EOP     ),
        .ADC_C_Ready    ( ADC_C_Ready   ),
        .ADC_R_Valid    ( ADC_R_Valid   ),
        .ADC_R_Channel  ( ADC_R_Channel ),
        .ADC_R_Data     ( ADC_R_Data    ),
        .ADC_R_SOP      ( ADC_R_SOP     ),
        .ADC_R_EOP      ( ADC_R_EOP     ),
        .ADC_Trigger    ( ADC_Trigger   ),
        .ADC_Interrupt  ( ADC_Interrupt )
    );

    adc adc
    (
        .adc_pll_clock_clk      ( clk_adc       ),
        .adc_pll_locked_export  ( clk_locked    ),
        .clock_clk              ( HCLK          ),
        .command_valid          ( ADC_C_Valid   ),
        .command_channel        ( ADC_C_Channel ),
        .command_startofpacket  ( ADC_C_SOP     ),
        .command_endofpacket    ( ADC_C_EOP     ),
        .command_ready          ( ADC_C_Ready   ),
        .reset_sink_reset_n     ( HRESETn       ),
        .response_valid         ( ADC_R_Valid   ),
        .response_channel       ( ADC_R_Channel ),
        .response_data          ( ADC_R_Data    ),
        .response_startofpacket ( ADC_R_SOP     ),
        .response_endofpacket   ( ADC_R_EOP     ) 
    );

endmodule


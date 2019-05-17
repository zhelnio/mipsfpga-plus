`include "mfp_ahb_lite_matrix_config.vh"

//TODO: check with ddr2
//`timescale 1 ns / 100 ps

`timescale 1 ps / 1 ps

module mfp_testbench;

    reg         SI_ClkIn;
    reg         SI_ColdReset;
    reg         SI_Reset;

    wire [31:0] HADDR;
    wire [31:0] HRDATA;
    wire [31:0] HWDATA;
    wire        HWRITE;
    wire        HREADY;
    wire [ 1:0] HTRANS;

    reg         EJ_TRST_N_probe;
    reg         EJ_TDI;
    wire        EJ_TDO;
    reg         EJ_TMS;
    reg         EJ_TCK;
    reg         EJ_DINT;

    reg  [`MFP_N_SWITCHES          - 1:0] IO_Switches;
    reg  [`MFP_N_BUTTONS           - 1:0] IO_Buttons;
    wire [`MFP_N_RED_LEDS          - 1:0] IO_RedLEDs;
    wire [`MFP_N_GREEN_LEDS        - 1:0] IO_GreenLEDs;
    wire [`MFP_7_SEGMENT_HEX_WIDTH - 1:0] IO_7_SegmentHEX;

    `ifdef MFP_USE_SDRAM_MEMORY
    reg                                 SDRAM_CLK;
    wire                                SDRAM_CKE;
    wire                                SDRAM_CSn;
    wire                                SDRAM_RASn;
    wire                                SDRAM_CASn;
    wire                                SDRAM_WEn;
    wire  [`SDRAM_ADDR_BITS   - 1 : 0]  SDRAM_ADDR;
    wire  [`SDRAM_BA_BITS     - 1 : 0]  SDRAM_BA;
    wire  [`SDRAM_DQ_BITS     - 1 : 0]  SDRAM_DQ;
    wire  [`SDRAM_DM_BITS     - 1 : 0]  SDRAM_DQM;
    `endif

    `ifdef MFP_USE_AVALON_MEMORY
    wire          avm_clk;
    wire          avm_rst_n;
    wire          avm_waitrequest;
    wire          avm_readdatavalid;
    wire [ 31:0 ] avm_readdata;
    wire          avm_write;
    wire          avm_read;
    wire [ 31:0 ] avm_address;
    wire [  3:0 ] avm_byteenable;
    wire [  2:0 ] avm_burstcount;
    wire          avm_beginbursttransfer;
    wire          avm_begintransfer;
    wire [ 31:0 ] avm_writedata;

    //LPDDR2
    wire [9:0]  mem_ca;
    wire [0:0]  mem_ck;
    wire [0:0]  mem_ck_n;
    wire [0:0]  mem_cke;
    wire [0:0]  mem_cs_n;
    wire [3:0]  mem_dm;
    wire [31:0] mem_dq;
    wire [3:0]  mem_dqs;
    wire [3:0]  mem_dqs_n;
    `endif

    reg         UART_RX;
    wire        UART_TX;

    `ifdef MFP_USE_DUPLEX_UART
    wire        UART_STX;
    wire        UART_SRX = UART_STX;
    `endif

    `ifdef MFP_USE_ADC_MAX10
    wire          ADC_C_Valid;
    wire [  4:0 ] ADC_C_Channel;
    wire          ADC_C_SOP;
    wire          ADC_C_EOP;
    wire          ADC_C_Ready;
    wire          ADC_R_Valid;
    wire [  4:0 ] ADC_R_Channel;
    wire [ 11:0 ] ADC_R_Data;
    wire          ADC_R_SOP;
    wire          ADC_R_EOP;
    `endif

    `ifdef MFP_DEMO_LIGHT_SENSOR
    wire        SPI_CS;
    wire        SPI_SCK;
    wire        SPI_SDO;
    `endif

    //----------------------------------------------------------------

    mfp_system system
    (
        .SI_ClkIn         ( SI_ClkIn         ),
        .SI_ColdReset     ( SI_ColdReset     ),
        .SI_Reset         ( SI_Reset         ),
                                              
        .HADDR            ( HADDR            ),
        .HRDATA           ( HRDATA           ),
        .HWDATA           ( HWDATA           ),
        .HWRITE           ( HWRITE           ),
        .HREADY           ( HREADY           ),
        .HTRANS           ( HTRANS           ),
                                              
        .EJ_TRST_N_probe  ( EJ_TRST_N_probe  ),
        .EJ_TDI           ( EJ_TDI           ),
        .EJ_TDO           ( EJ_TDO           ),
        .EJ_TMS           ( EJ_TMS           ),
        .EJ_TCK           ( EJ_TCK           ),
        .EJ_DINT          ( EJ_DINT          ),

        `ifdef MFP_USE_SDRAM_MEMORY
        .SDRAM_CKE        ( SDRAM_CKE        ),
        .SDRAM_CSn        ( SDRAM_CSn        ),
        .SDRAM_RASn       ( SDRAM_RASn       ),
        .SDRAM_CASn       ( SDRAM_CASn       ),
        .SDRAM_WEn        ( SDRAM_WEn        ),
        .SDRAM_ADDR       ( SDRAM_ADDR       ),
        .SDRAM_BA         ( SDRAM_BA         ),
        .SDRAM_DQ         ( SDRAM_DQ         ),
        .SDRAM_DQM        ( SDRAM_DQM        ),
        `endif

        `ifdef MFP_USE_AVALON_MEMORY
        .avm_clk                ( avm_clk                ),
        .avm_rst_n              ( avm_rst_n              ),
        .avm_waitrequest        ( avm_waitrequest        ),
        .avm_readdatavalid      ( avm_readdatavalid      ),
        .avm_readdata           ( avm_readdata           ),
        .avm_write              ( avm_write              ),
        .avm_read               ( avm_read               ),
        .avm_address            ( avm_address            ),
        .avm_byteenable         ( avm_byteenable         ),
        .avm_burstcount         ( avm_burstcount         ),
        .avm_beginbursttransfer ( avm_beginbursttransfer ),
        .avm_begintransfer      ( avm_begintransfer      ),
        .avm_writedata          ( avm_writedata          ),
        `endif
                                              
        .IO_Switches      ( IO_Switches      ),
        .IO_Buttons       ( IO_Buttons       ),
        .IO_RedLEDs       ( IO_RedLEDs       ),
        .IO_GreenLEDs     ( IO_GreenLEDs     ), 
        .IO_7_SegmentHEX  ( IO_7_SegmentHEX  ),
                                               
        `ifdef MFP_USE_DUPLEX_UART
        .UART_SRX         ( UART_SRX         ), 
        .UART_STX         ( UART_STX         ),
        `endif

        `ifdef MFP_USE_ADC_MAX10
        .ADC_C_Valid      (  ADC_C_Valid      ),
        .ADC_C_Channel    (  ADC_C_Channel    ),
        .ADC_C_SOP        (  ADC_C_SOP        ),
        .ADC_C_EOP        (  ADC_C_EOP        ),
        .ADC_C_Ready      (  ADC_C_Ready      ),
        .ADC_R_Valid      (  ADC_R_Valid      ),
        .ADC_R_Channel    (  ADC_R_Channel    ),
        .ADC_R_Data       (  ADC_R_Data       ),
        .ADC_R_SOP        (  ADC_R_SOP        ),
        .ADC_R_EOP        (  ADC_R_EOP        ),
        `endif

        `ifdef MFP_DEMO_LIGHT_SENSOR
        .SPI_CS           ( SPI_CS           ),
        .SPI_SCK          ( SPI_SCK          ),
        .SPI_SDO          ( SPI_SDO          ),
        `endif

        .UART_RX          ( UART_RX          ),
        .UART_TX          ( UART_TX          )
    );

    pmod_als_spi_stub pmod_als_spi_stub
    (
        .cs               ( SPI_CS           ),
        .sck              ( SPI_SCK          ),
        .sdo              ( SPI_SDO          )
    );

    `ifdef MFP_USE_ADC_MAX10
        reg         ADC_CLK;

        adc_core adc
        (
            .adc_pll_clock_clk      ( ADC_CLK       ),
            .adc_pll_locked_export  ( 1'b1          ),
            .clock_clk              ( SI_ClkIn      ),
            .command_valid          ( ADC_C_Valid   ),
            .command_channel        ( ADC_C_Channel ),
            .command_startofpacket  ( ADC_C_SOP     ),
            .command_endofpacket    ( ADC_C_EOP     ),
            .command_ready          ( ADC_C_Ready   ),
            .reset_sink_reset_n     ( ~SI_Reset     ),
            .response_valid         ( ADC_R_Valid   ),
            .response_channel       ( ADC_R_Channel ),
            .response_data          ( ADC_R_Data    ),
            .response_startofpacket ( ADC_R_SOP     ),
            .response_endofpacket   ( ADC_R_EOP     ) 
        );

        parameter Tadc = 100;
        initial begin
            ADC_CLK = 0;
            forever ADC_CLK = #(Tadc/2) ~ADC_CLK;
        end

    `endif

    //----------------------------------------------------------------

    `ifdef MFP_USE_SDRAM_MEMORY

        parameter tT = 20; //TODО: (50?)

        initial begin
            SDRAM_CLK = 0; 
            @(posedge SI_ClkIn);
            #(`SDRAM_MEM_CLK_PHASE_SHIFT)
            forever SDRAM_CLK = #(tT/2) ~SDRAM_CLK;
        end

        initial
        begin
            SI_ClkIn = 0;
            forever #(tT/2) SI_ClkIn = ~SI_ClkIn;
        end

        sdr sdram0 (SDRAM_DQ, SDRAM_ADDR, SDRAM_BA, SDRAM_CLK, SDRAM_CKE, 
                    SDRAM_CSn, SDRAM_RASn, SDRAM_CASn, SDRAM_WEn, SDRAM_DQM);
    `else
        initial
        begin
            SI_ClkIn = 0;
            forever
            //    # 20 
            # 10000
            SI_ClkIn = ~ SI_ClkIn;
        end
    `endif //MFP_USE_SDRAM_MEMORY

    //----------------------------------------------------------------

    `ifdef MFP_USE_AVALON_MEMORY
    lpddr2_wrapper lpddr2_wrapper
    (
        .clk_global      ( SI_ClkIn               ),
        .rst_global_n    (~SI_ColdReset           ),
        .mem_ca          ( mem_ca                 ),
        .mem_ck          ( mem_ck                 ),
        .mem_ck_n        ( mem_ck_n               ),
        .mem_cke         ( mem_cke                ),
        .mem_cs_n        ( mem_cs_n               ),
        .mem_dm          ( mem_dm                 ),
        .mem_dq          ( mem_dq                 ),
        .mem_dqs         ( mem_dqs                ),
        .mem_dqs_n       ( mem_dqs_n              ),
        .avm_clk         ( avm_clk                ),
        .avm_rst_n       ( avm_rst_n              ),
        .avm_ready       ( avm_waitrequest        ),
        .avm_burstbegin  ( avm_beginbursttransfer ),
        .avm_addr        ( avm_address     [26:0] ),
        .avm_rdata_valid ( avm_readdatavalid      ),
        .avm_rdata       ( avm_readdata           ),
        .avm_wdata       ( avm_writedata          ),
        .avm_be          ( avm_byteenable         ),
        .avm_read_req    ( avm_read               ),
        .avm_write_req   ( avm_write              ),
        .avm_size        ( avm_burstcount [0]     ) 
    );
    `endif

    mobile_ddr2 mobile_ddr2(
        .ck    ( mem_ck    ),
        .ck_n  ( mem_ck_n  ),
        .cke   ( mem_cke   ),
        .cs_n  ( mem_cs_n  ),
        .ca    ( mem_ca    ),
        .dm    ( mem_dm    ),
        .dq    ( mem_dq    ),
        .dqs   ( mem_dqs   ),
        .dqs_n ( mem_dqs_n ) 
    );

    //----------------------------------------------------------------

    initial
    begin
        EJ_TRST_N_probe <= 1'b1;
        EJ_TDI          <= 1'b0;
        EJ_TMS          <= 1'b0;
        EJ_TCK          <= 1'b0;
        EJ_DINT         <= 1'b0;
        IO_Switches     <= 18'b0;
        IO_Buttons      <= 5'b0;
        UART_RX         <= 1'b0;
    end

    initial
    begin
        SI_ColdReset <= 0;
        SI_Reset     <= 0;

        repeat (10)  @(posedge SI_ClkIn);

        SI_ColdReset <= 1;
        SI_Reset     <= 1;

        repeat (20)  @(posedge SI_ClkIn);

        SI_ColdReset <= 0;
        SI_Reset     <= 0;
    end

    //----------------------------------------------------------------

    initial
    begin
        $dumpvars;

        $timeformat
        (
            -9,    // 1 ns
            1,     // Number of digits after decimal point
            "ns",  // suffix
            10     // Max number of digits 
        );
    end

    //----------------------------------------------------------------

    /*
    always @ (negedge SI_ClkIn)
    begin
        if (HADDR == 32'h1fc00058)
        begin
            $display ("Data cache initialized. About to make kseg0 cacheable.");
            $stop;
	end
	else if (HADDR == 32'h00000644)
        begin
	    $display ("Beginning of program code.");
            $stop;
	end
    end
    */

    //----------------------------------------------------------------

    integer cycle; initial cycle = 0;

    initial mobile_ddr2.mcd_info = 1;

    always @ (posedge SI_ClkIn)
    begin

        if(HREADY)
            $display ("%5d HCLK %b HADDR %h HRDATA %h HWDATA %h HWRITE %b HREADY %b HTRANS %b LEDR %b LEDG %b 7SEG %h",
                cycle, system.HCLK, HADDR, HRDATA, HWDATA,      HWRITE, HREADY, HTRANS, IO_RedLEDs, IO_GreenLEDs, IO_7_SegmentHEX);


    //     $display ("%5d HCLK %b HADDR %h HRDATA %h HWDATA %h HWRITE %b HREADY %b HTRANS %b LEDR %b LEDG %b 7SEG %h",
    //         cycle, system.HCLK, HADDR, HRDATA, HWDATA,      HWRITE, HREADY, HTRANS, IO_RedLEDs, IO_GreenLEDs, IO_7_SegmentHEX);

    //     `ifdef MFP_DEMO_PIPE_BYPASS

    //     if ( system.mpc_aselwr_e  ) $display ( "%5d PIPE_BYPASS mpc_aselwr_e"  , cycle );
    //     if ( system.mpc_bselall_e ) $display ( "%5d PIPE_BYPASS mpc_bselall_e" , cycle );
    //     if ( system.mpc_aselres_e ) $display ( "%5d PIPE_BYPASS mpc_aselres_e" , cycle );
    //     if ( system.mpc_bselres_e ) $display ( "%5d PIPE_BYPASS mpc_bselres_e" , cycle );

    //     `endif

        cycle = cycle + 1;

    //     // if (cycle > 21000)
    //     // begin
    //     //     $display ("Timeout");
    //     //     // $finish;
            
    //     // end
    end

endmodule


module pmod_als_spi_stub
#(
    parameter value = 8'hAB
)
(
    input             cs,
    input             sck,
    output reg        sdo
);
    wire [7:0]  tvalue  = value;
    wire [15:0] tpacket = { 4'b0, tvalue, 4'b0 };

    reg  [15:0] buffer;

    always @(negedge sck) begin
        if(!cs)
            { sdo, buffer } <= { buffer, 1'b0 };
        else
            buffer <= tpacket;
    end

endmodule

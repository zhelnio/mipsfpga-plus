
`include "mfp_ahb_lite_matrix_config.vh"

module c5gx (

    `ifdef UNUSED
      output             ADC_CONVST,
      output             ADC_SCK,
      output             ADC_SDI,
      input              ADC_SDO,
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_XCK,
      output             HDMI_TX_CLK,
      output      [23:0] HDMI_TX_D,
      output             HDMI_TX_DE,
      output             HDMI_TX_HS,
      input              HDMI_TX_INT,
      output             HDMI_TX_VS,
      input              HSMC_CLKIN0,
      input       [2:1]  HSMC_CLKIN_n,
      input       [2:1]  HSMC_CLKIN_p,
      output             HSMC_CLKOUT0,
      output      [2:1]  HSMC_CLKOUT_n,
      output      [2:1]  HSMC_CLKOUT_p,
      inout       [3:0]  HSMC_D,
      input       [3:0]  HSMC_GXB_RX_p,
      output      [3:0]  HSMC_GXB_TX_p,
      inout       [16:0] HSMC_RX_n,
      inout       [16:0] HSMC_RX_p,
      inout       [16:0] HSMC_TX_n,
      inout       [16:0] HSMC_TX_p,
      output             I2C_SCL,
      inout              I2C_SDA,
      input              REFCLK_p0,
      input              REFCLK_p1,
      output             SD_CLK,
      inout              SD_CMD,
      inout       [3:0]  SD_DAT,
      input              SMA_GXB_RX_p,
      output             SMA_GXB_TX_p,
      output      [17:0] SRAM_A,
      output             SRAM_CE_n,
      inout       [15:0] SRAM_D,
      output             SRAM_LB_n,
      output             SRAM_OE_n,
      output             SRAM_UB_n,
      output             SRAM_WE_n,
    `endif

      input              CLOCK_125_p,
      input              CLOCK_50_B5B,
      input              CLOCK_50_B6A,
      input              CLOCK_50_B7A,
      input              CLOCK_50_B8A,
      input              CPU_RESET_n,

      output      [9:0]  DDR2LP_CA,
      output      [1:0]  DDR2LP_CKE,
      output             DDR2LP_CK_n,
      output             DDR2LP_CK_p,
      output      [1:0]  DDR2LP_CS_n,
      output      [3:0]  DDR2LP_DM,
      inout       [31:0] DDR2LP_DQ,
      inout       [3:0]  DDR2LP_DQS_n,
      inout       [3:0]  DDR2LP_DQS_p,
      input              DDR2LP_OCT_RZQ,

    `ifdef FULL_GPIO
      inout       [35:0] GPIO,
    `else
      inout       [21:0] GPIO,
      output      [6:0]  HEX2,
      output      [6:0]  HEX3,
    `endif
      output      [6:0]  HEX0,
      output      [6:0]  HEX1,
      input       [3:0]  KEY,
      output      [7:0]  LEDG,
      output      [9:0]  LEDR,
      input       [9:0]  SW,
      input              UART_RX,
      output             UART_TX
);

    // global clock signals
    wire clk;

    `ifdef MFP_USE_SLOW_CLOCK_AND_CLOCK_MUX

        wire       CLK_Lock = 1'b1;
        wire       muxed_clk;
        wire [1:0] sw_db;

        mfp_multi_switch_or_button_sync_and_debouncer
        # (.WIDTH (2))
        mfp_multi_switch_or_button_sync_and_debouncer
        (   
            .clk    ( MAX10_CLK1_50 ),
            .sw_in  ( SW [1:0] ),
            .sw_out ( sw_db    )
        );

        mfp_clock_divider_50_MHz_to_25_MHz_12_Hz_0_75_Hz 
        mfp_clock_divider_50_MHz_to_25_MHz_12_Hz_0_75_Hz
        (
            .clki    ( MAX10_CLK1_50  ),
            .sel_lo  ( sw_db [0] ),
            .sel_mid ( sw_db [1] ),
            .clko    ( muxed_clk )
        );

        global gclk
        (
            .in     ( muxed_clk  ), 
            .out    ( clk        )
        );

    `else
        wire   CLK_Lock = 1'b1;
        assign clk = CLOCK_50_B5B;
    `endif

    wire [`MFP_N_SWITCHES          - 1:0] IO_Switches;
    wire [`MFP_N_BUTTONS           - 1:0] IO_Buttons;
    wire [`MFP_N_RED_LEDS          - 1:0] IO_RedLEDs;
    wire [`MFP_N_GREEN_LEDS        - 1:0] IO_GreenLEDs;
    wire [`MFP_7_SEGMENT_HEX_WIDTH - 1:0] IO_7_SegmentHEX;

    assign IO_Switches = { { `MFP_N_SWITCHES - 10 { 1'b0 } } ,   SW  [9:0] };
    assign IO_Buttons  = { { `MFP_N_BUTTONS  -  2 { 1'b0 } } , ~ KEY [3:0] };

    wire [31:0] HADDR, HRDATA, HWDATA;
    wire        HWRITE;

    assign LEDR = IO_RedLEDs   [9:0];
    assign LEDG = IO_GreenLEDs [7:0];

    `define MFP_EJTAG_DEBUGGER
    `ifdef MFP_EJTAG_DEBUGGER
        // MIPSfpga EJTAG BusBluster 3 connector pinout
        // EJTAG     DIRECTION   PIN      CONN      PIN    DIRECTION EJTAG 
        // =====     ========= ======== ========= ======== ========= ======
        //  VCC       output   GPIO[10]  13 | 14  GPIO[11]  output    VCC  
        //  GND       output   GPIO[12]  15 | 16  GPIO[13]  output    GND  
        //  NC        output   GPIO[14]  17 | 18  GPIO[15]  input    EJ_TCK
        //  NC        output   GPIO[16]  19 | 20  GPIO[17]  output   EJ_TDO
        //  EJ_RST_N  input    GPIO[18]  21 | 22  GPIO[19]  input    EJ_TDI
        //  EJ_TRST_N input    GPIO[20]  23 | 24  GPIO[21]  input    EJ_TMS

        wire EJ_VCC    = 1'b1;
        wire EJ_GND    = 1'b0;
        wire EJ_NC     = 1'bz;
        wire EJ_TCK    = GPIO[15];
        // wire EJ_RST_N  = GPIO[18];
        wire EJ_TDI    = GPIO[19];
        // wire EJ_TRST_N = GPIO[20];
        wire EJ_TMS    = GPIO[21];
        wire EJ_DINT   = 1'b0;
        wire EJ_TDO;

        assign GPIO[10] = EJ_VCC;
        assign GPIO[11] = EJ_VCC;
        assign GPIO[12] = EJ_GND;
        assign GPIO[13] = EJ_GND;
        assign GPIO[14] = EJ_NC;
        assign GPIO[16] = EJ_NC;
        assign GPIO[17] = EJ_TDO;
    `endif

    wire pll_locked    = CLK_Lock;
    wire pin_rst_cold  = 1'b0;
    wire pin_rst_soft  = ~CPU_RESET_n;

    wire pin_ej_rst_n  = GPIO[18];
    wire pin_ej_trst_n = GPIO[20];

    wire SI_Reset;
    wire SI_ColdReset;
    wire EJ_TRST_N;

    mfp_reset mfp_reset
    (
        .clk           ( clk           ),
        .pll_locked    ( pll_locked    ),
        .pin_rst_cold  ( pin_rst_cold  ),
        .pin_rst_soft  ( pin_rst_soft  ),
        .pin_ej_rst_n  ( pin_ej_rst_n  ),
        .pin_ej_trst_n ( pin_ej_trst_n ),
        .SI_Reset      ( SI_Reset      ),
        .SI_ColdReset  ( SI_ColdReset  ),
        .EJ_TRST_N     ( EJ_TRST_N     ) 
    );

    // TODO: remap connections
    // `ifdef MFP_DEMO_LIGHT_SENSOR
    //     //  ALS   CONN   PIN         DIRECTION
    //     // ===== ====== =====      =============
    //     //  VCC    29   3.3V
    //     //  GND    31   GPIO[26]   output
    //     //  SCK    33   GPIO[28]   output
    //     //  SDO    35   GPIO[30]   input
    //     //  NC     37   GPIO[32]   not connected
    //     //  CS     39   GPIO[34]   output

    //     wire    ALS_GND = 1'b0;
    //     wire    ALS_SCK;
    //     wire    ALS_SDO;
    //     wire    ALS_NC  = 1'bz;
    //     wire    ALS_CS;

    //     assign GPIO[26] = ALS_GND;
    //     assign GPIO[28] = ALS_SCK;
    //     assign ALS_SDO  = GPIO[30];
    //     assign GPIO[32] = ALS_NC;
    //     assign GPIO[34] = ALS_CS;
    // `endif

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

    lpddr2_wrapper lpddr2_wrapper
    (
        .clk_global      ( clk                    ),
        .rst_global_n    ( ~SI_ColdReset          ),
        .mem_ca          ( DDR2LP_CA              ),
        .mem_ck          ( DDR2LP_CK_p            ),
        .mem_ck_n        ( DDR2LP_CK_n            ),
        .mem_cke         ( DDR2LP_CKE             ),
        .mem_cs_n        ( DDR2LP_CS_n            ),
        .mem_dm          ( DDR2LP_DM              ),
        .mem_dq          ( DDR2LP_DQ              ),
        .mem_dqs         ( DDR2LP_DQS_p           ),
        .mem_dqs_n       ( DDR2LP_DQS_n           ),
        .mem_rzqin       ( DDR2LP_OCT_RZQ         ),
        .avm_clk         ( avm_clk                ),
        .avm_rst_n       ( avm_rst_n              ),
        .avm_waitrequest ( avm_waitrequest        ),
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

    mfp_system mfp_system
    (
        .SI_ClkIn         (   clk             ),
        .SI_Reset         (   SI_Reset        ),
        .SI_ColdReset     (   SI_ColdReset    ),
                          
        .HADDR            (   HADDR           ),
        .HRDATA           (   HRDATA          ),
        .HWDATA           (   HWDATA          ),
        .HWRITE           (   HWRITE          ),

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

        `ifdef MFP_EJTAG_DEBUGGER
        .EJ_TRST_N_probe  (   EJ_TRST_N       ),
        .EJ_TDI           (   EJ_TDI          ),
        .EJ_TDO           (   EJ_TDO          ),
        .EJ_TMS           (   EJ_TMS          ),
        .EJ_TCK           (   EJ_TCK          ),
        .EJ_DINT          (   EJ_DINT         ),
        `endif

        .IO_Switches      (   IO_Switches     ),
        .IO_Buttons       (   IO_Buttons      ),
        .IO_RedLEDs       (   IO_RedLEDs      ),
        .IO_GreenLEDs     (   IO_GreenLEDs    ), 
        .IO_7_SegmentHEX  (   IO_7_SegmentHEX ),

        `ifdef MFP_USE_DUPLEX_UART
        .UART_SRX         (   UART_RX         ), 
        .UART_STX         (   UART_TX         ),
        `endif

        `ifdef MFP_DEMO_LIGHT_SENSOR
        .SPI_CS           (   ALS_CS          ),
        .SPI_SCK          (   ALS_SCK         ),
        .SPI_SDO          (   ALS_SDO         ),
        `endif

        .UART_RX          (   GPIO [1]        ),
        .UART_TX          (   GPIO [3]        )
    );

    mfp_single_digit_seven_segment_display digit_3 ( IO_7_SegmentHEX [15:12] , HEX3 [6:0] );
    mfp_single_digit_seven_segment_display digit_2 ( IO_7_SegmentHEX [11: 8] , HEX2 [6:0] );
    mfp_single_digit_seven_segment_display digit_1 ( IO_7_SegmentHEX [ 7: 4] , HEX1 [6:0] );
    mfp_single_digit_seven_segment_display digit_0 ( IO_7_SegmentHEX [ 3: 0] , HEX0 [6:0] );

endmodule

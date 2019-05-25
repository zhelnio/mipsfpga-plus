
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
    wire SI_ColdReset;
    wire SI_Reset;

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
    wire [ 26:0 ] avm_address;
    wire [  3:0 ] avm_byteenable;
    wire [  2:0 ] avm_burstcount;
    wire          avm_beginbursttransfer;
    wire          avm_begintransfer;
    wire [ 31:0 ] avm_writedata;

    lpddr2_mm lpddr2_mm (
        .avm_waitrequest   ( avm_waitrequest    ),
        .avm_readdata      ( avm_readdata       ),
        .avm_readdatavalid ( avm_readdatavalid  ),
        .avm_burstcount    ( avm_burstcount     ),
        .avm_writedata     ( avm_writedata      ),
        .avm_address       ( avm_address        ),
        .avm_write         ( avm_write          ),
        .avm_read          ( avm_read           ),
        .avm_byteenable    ( avm_byteenable     ),
        .avm_debugaccess   (                    ),
        .gclk_clk          ( clk                ),
        .grst_reset_n      ( ~SI_ColdReset      ),
        .srst_reset_n      ( ~SI_Reset          ),
        .mclk_clk          ( avm_clk            ),
        .mrst_reset        ( ~avm_rst_n         ),
        .oct_rzqin         ( DDR2LP_OCT_RZQ     ),
        .lpddr2_mem_ca     ( DDR2LP_CA          ),
        .lpddr2_mem_ck     ( DDR2LP_CK_p        ),
        .lpddr2_mem_ck_n   ( DDR2LP_CK_n        ),
        .lpddr2_mem_cke    ( DDR2LP_CKE         ),
        .lpddr2_mem_cs_n   ( DDR2LP_CS_n        ),
        .lpddr2_mem_dm     ( DDR2LP_DM          ),
        .lpddr2_mem_dq     ( DDR2LP_DQ          ),
        .lpddr2_mem_dqs    ( DDR2LP_DQS_p       ),
        .lpddr2_mem_dqs_n  ( DDR2LP_DQS_n       ) 
    );
    `endif

    localparam WIDTH_7SEG = 16;
    wire [WIDTH_7SEG-1:0] gpio_7seg;

    // MIPSfpga EJTAG BusBluster 3 connector pinout
    // EJTAG     DIRECTION   PIN      CONN      PIN    DIRECTION EJTAG 
    // =====     ========= ======== ========= ======== ========= ======
    //  VCC       output   GPIO[10]  13 | 14  GPIO[11]  output    VCC  
    //  GND       output   GPIO[12]  15 | 16  GPIO[13]  output    GND  
    //  NC        output   GPIO[14]  17 | 18  GPIO[15]  input    EJ_TCK
    //  NC        output   GPIO[16]  19 | 20  GPIO[17]  output   EJ_TDO
    //  EJ_RST_N  input    GPIO[18]  21 | 22  GPIO[19]  input    EJ_TDI
    //  EJ_TRST_N input    GPIO[20]  23 | 24  GPIO[21]  input    EJ_TMS

    wire EJ_VCC = 1'b1;
    wire EJ_GND = 1'b0;
    wire EJ_NC  = 1'bz;

    assign GPIO[10] = EJ_VCC;
    assign GPIO[11] = EJ_VCC;
    assign GPIO[12] = EJ_GND;
    assign GPIO[13] = EJ_GND;
    assign GPIO[14] = EJ_NC;
    assign GPIO[16] = EJ_NC;

    mfp_system #(
        .BOARD_WIDTH_BTN        ( 4             ),
        .BOARD_WIDTH_SW         ( 10            ),
        .BOARD_WIDTH_LEDR       ( 10            ),
        .BOARD_WIDTH_LEDG       ( 8             ),
        .BOARD_WIDTH_7SEG       ( WIDTH_7SEG    ) 
    ) system (
        .gclk                   ( CLOCK_50_B5B  ),
        .pin_clk_mode           ( SW [1:0]      ),
        .pin_rst_cold           ( 1'b0          ),
        .pin_rst_soft           ( ~CPU_RESET_n  ),
        .uart_prg_rx            ( GPIO [1]      ),
        .SI_ColdReset           ( SI_ColdReset  ),
        .SI_Reset               ( SI_Reset      ),
        .EJ_RST_N               ( GPIO[18]      ),
        .EJ_TRST_N              ( GPIO[20]      ),
        .EJ_TDI                 ( GPIO[19]      ),
        .EJ_TDO                 ( GPIO[17]      ),
        .EJ_TMS                 ( GPIO[21]      ),
        .EJ_TCK                 ( GPIO[15]      ),
        .EJ_DINT                ( 1'b0          ),

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

        `ifdef MFP_DEMO_LIGHT_SENSOR
        .als_spi_cs             (                        ),   //TODO
        .als_spi_sck            (                        ),   //TODO
        .als_spi_sdo            ( 1'b0                   ),   //TODO
        `endif

        .uart_rx                ( UART_RX                ),
        .uart_tx                ( UART_TX                ),
        .pin_gpio_sw            ( SW                     ),
        .pin_gpio_btn           ( ~KEY                   ),
        .pin_gpio_ledr          ( LEDR                   ),
        .pin_gpio_ledg          ( LEDG                   ),
        .pin_gpio_7seg          ( gpio_7seg              ) 
    );

    mfp_single_digit_seven_segment_display digit_3 ( gpio_7seg [15:12] , HEX3 [6:0] );
    mfp_single_digit_seven_segment_display digit_2 ( gpio_7seg [11: 8] , HEX2 [6:0] );
    mfp_single_digit_seven_segment_display digit_1 ( gpio_7seg [ 7: 4] , HEX1 [6:0] );
    mfp_single_digit_seven_segment_display digit_0 ( gpio_7seg [ 3: 0] , HEX0 [6:0] );

endmodule

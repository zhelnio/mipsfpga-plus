`include "m14k_const.vh"
`include "mfp_ahb_lite_matrix_config.vh"
`include "mfp_eic_core.vh"

module mfp_system
#(
    parameter MFP_EJTAG_MANUFID = 11'b0, //11'h02;
              MFP_EJTAG_PARTNUM = 16'b0  //16'hF1;
)(
    input         gclk,
    input  [ 1:0] pin_clk_mode,
    input         pin_rst_cold,
    input         pin_rst_soft,
    input         uart_prg_rx,

    output        SI_ColdReset,
    output        SI_Reset,

    input         EJ_RST_N,
    input         EJ_TRST_N,
    input         EJ_TDI,
    output tri    EJ_TDO,
    input         EJ_TMS,
    input         EJ_TCK,
    input         EJ_DINT,

    `ifdef MFP_USE_SDRAM_MEMORY
    output                                  SDRAM_CLK,
    output                                  SDRAM_CKE,
    output                                  SDRAM_CSn,
    output                                  SDRAM_RASn,
    output                                  SDRAM_CASn,
    output                                  SDRAM_WEn,
    output [`SDRAM_ADDR_BITS - 1 : 0 ]      SDRAM_ADDR,
    output [`SDRAM_BA_BITS   - 1 : 0 ]      SDRAM_BA,
    inout  [`SDRAM_DQ_BITS   - 1 : 0 ]      SDRAM_DQ,
    output [`SDRAM_DM_BITS   - 1 : 0 ]      SDRAM_DQM,
    `endif

    `ifdef MFP_USE_AVALON_MEMORY
    output                                  avm_clk,
    output                                  avm_rst_n,
    input                                   avm_waitrequest,
    input                                   avm_readdatavalid,
    input  [                         31:0 ] avm_readdata,
    output                                  avm_write,
    output                                  avm_read,
    output [                         26:0 ] avm_address,
    output [                          3:0 ] avm_byteenable,
    output [                          2:0 ] avm_burstcount,
    output                                  avm_beginbursttransfer,
    output                                  avm_begintransfer,
    output [                         31:0 ] avm_writedata,
    `endif

    `ifdef MFP_DEMO_LIGHT_SENSOR
    output                                  SPI_CS,
    output                                  SPI_SCK,
    input                                   SPI_SDO,
    `endif

    input         uart_rx,
    output        uart_tx,

    input  [`MFP_N_SWITCHES          - 1:0] IO_Switches,
    input  [`MFP_N_BUTTONS           - 1:0] IO_Buttons,
    output [`MFP_N_RED_LEDS          - 1:0] IO_RedLEDs,
    output [`MFP_N_GREEN_LEDS        - 1:0] IO_GreenLEDs,
    output [`MFP_7_SEGMENT_HEX_WIDTH - 1:0] IO_7_SegmentHEX
);
    wire        SI_ClkIn;

    wire        cpu_HCLK;
    wire        cpu_HRESETn;
    wire [31:0] cpu_HADDR;
    wire [ 2:0] cpu_HBURST;
    wire        cpu_HMASTLOCK;
    wire [ 3:0] cpu_HPROT;
    wire [ 2:0] cpu_HSIZE;
    wire [ 1:0] cpu_HTRANS;
    wire [31:0] cpu_HWDATA;
    wire        cpu_HWRITE;
    wire [31:0] cpu_HRDATA;
    wire        cpu_HREADY;
    wire        cpu_HRESP;

    wire [ 7:0] SI_Int;

  `ifdef MFP_USE_IRQ_EIC
    wire [17:1] SI_Offset;
    wire [ 3:0] SI_EISS;
    wire [ 5:0] SI_EICVector;
    wire        SI_EICPresent;
    wire        SI_TimerInt;
    wire [ 1:0] SI_SWInt;
    wire        SI_IAck;
    wire [ 7:0] SI_IPL;
    wire [ 5:0] SI_IVN;
    wire [17:1] SI_ION;
  `endif
  
  `ifdef MFP_DEMO_PIPE_BYPASS
    wire        mpc_aselres_e;
    wire        mpc_aselwr_e;
    wire        mpc_bselall_e;
    wire        mpc_bselres_e;
  `endif

    wire        EJ_TRST_N_cpu;
    wire        EJ_TDO_cpu;
    wire        EJ_TDOz_cpu;

    wire        pll_locked;
    wire        clk_debug;
    wire        clk_adc;
    wire        clk_dram;

    wire        bus_HRESETn;
    wire [31:0] bus_HADDR;
    wire [ 2:0] bus_HBURST;
    wire        bus_HMASTLOCK;
    wire [ 3:0] bus_HPROT;
    wire [ 2:0] bus_HSIZE;
    wire [ 1:0] bus_HTRANS;
    wire [31:0] bus_HWDATA;
    wire        bus_HWRITE;

    wire        memory_load;

    // system clock source
    `MFP_MACRO_CLOCK_SOURCE #(
        .MODE      ( `MFP_MACRO_CLOCK_MODE ),
        .TOOL      ( `MFP_MACRO_BUILD_TOOL )
    ) clock_source (
        .gclk      ( gclk         ),
        .mode      ( pin_clk_mode ),
        .clk_cpu   ( SI_ClkIn     ),
        .clk_adc   ( clk_adc      ),
        .clk_dram  ( clk_dram     ),
        .clk_debug ( clk_debug    ),
        .locked    ( pll_locked   ) 
    );

    // system reset
    mfp_reset mfp_reset
    (
        .clk           ( SI_ClkIn      ),
        .clk_locked    ( pll_locked    ),
        .pin_rst_cold  ( pin_rst_cold  ),
        .pin_rst_soft  ( pin_rst_soft  ),
        .pin_ej_rst_n  ( EJ_RST_N      ),
        .pin_ej_trst_n ( EJ_TRST_N     ),
        .memory_load   ( memory_load   ),
        .SI_Reset      ( SI_Reset      ),
        .SI_ColdReset  ( SI_ColdReset  ),
        .EJ_TRST_N     ( EJ_TRST_N_cpu )
    );

    // cpu
    mfp_cpu_mipsfpga 
    #(
        parameter MFP_EJTAG_MANUFID = 11'b0, //11'h02;
                  MFP_EJTAG_PARTNUM = 16'b0  //16'hF1;
    ) mfp_cpu_mipsfpga (
        .SI_ClkIn      ( SI_ClkIn      ),
        .SI_ColdReset  ( SI_ColdReset  ),
        .SI_Reset      ( SI_Reset      ),
        .HCLK          ( cpu_HCLK      ),
        .HRESETn       ( cpu_HRESETn   ),
        .HADDR         ( cpu_HADDR     ),
        .HBURST        ( cpu_HBURST    ),
        .HMASTLOCK     ( cpu_HMASTLOCK ),
        .HPROT         ( cpu_HPROT     ),
        .HSIZE         ( cpu_HSIZE     ),
        .HTRANS        ( cpu_HTRANS    ),
        .HWDATA        ( cpu_HWDATA    ),
        .HWRITE        ( cpu_HWRITE    ),
        .HRDATA        ( cpu_HRDATA    ),
        .HREADY        ( cpu_HREADY    ),
        .HRESP         ( cpu_HRESP     ),
        .SI_Int        ( SI_Int        ),

        `ifdef MFP_USE_IRQ_EIC
        .SI_Offset     ( SI_Offset     ),
        .SI_EISS       ( SI_EISS       ),
        .SI_EICVector  ( SI_EICVector  ),
        .SI_EICPresent ( SI_EICPresent ),
        .SI_TimerInt   ( SI_TimerInt   ),
        .SI_SWInt      ( SI_SWInt      ),
        .SI_IAck       ( SI_IAck       ),
        .SI_IPL        ( SI_IPL        ),
        .SI_IVN        ( SI_IVN        ),
        .SI_ION        ( SI_ION        ),
        `endif

        `ifdef MFP_DEMO_PIPE_BYPASS
        .mpc_aselres_e ( mpc_aselres_e ),
        .mpc_aselwr_e  ( mpc_aselwr_e  ),
        .mpc_bselall_e ( mpc_bselall_e ),
        .mpc_bselres_e ( mpc_bselres_e ),
        `endif

        .EJ_TRST_N     ( EJ_TRST_N_cpu ),
        .EJ_TDI        ( EJ_TDI        ),
        .EJ_TMS        ( EJ_TMS        ),
        .EJ_TCK        ( EJ_TCK        ),
        .EJ_DINT       ( EJ_DINT       ),
        .EJ_TDO        ( EJ_TDO_cpu    ),
        .EJ_TDOzstate  ( EJ_TDOz_cpu   ) 
    );

    // uart programmer
    mfp_uart_programmer #(
        .ENABLED     ( `MFP_MACRO_ENABLE_UART_PROGRAMMER )
    ) mfp_uart_programmer (
        .clk         ( cpu_HCLK      ),
        .rst_n       ( SI_ColdReset  ),
        .uart_rx     ( uart_prg_rx   ),
        .uart_load   ( memory_load   ),
        .s_HRESETn   ( cpu_HRESETn   ),
        .s_HADDR     ( cpu_HADDR     ),
        .s_HBURST    ( cpu_HBURST    ),
        .s_HMASTLOCK ( cpu_HMASTLOCK ),
        .s_HPROT     ( cpu_HPROT     ),
        .s_HSIZE     ( cpu_HSIZE     ),
        .s_HTRANS    ( cpu_HTRANS    ),
        .s_HWDATA    ( cpu_HWDATA    ),
        .s_HWRITE    ( cpu_HWRITE    ),
        .m_HRESETn   ( bus_HRESETn   ),
        .m_HADDR     ( bus_HADDR     ),
        .m_HBURST    ( bus_HBURST    ),
        .m_HMASTLOCK ( bus_HMASTLOCK ),
        .m_HPROT     ( bus_HPROT     ),
        .m_HSIZE     ( bus_HSIZE     ),
        .m_HTRANS    ( bus_HTRANS    ),
        .m_HWDATA    ( bus_HWDATA    ),
        .m_HWRITE    ( bus_HWRITE    ) 
    );

    // peripheral

/*
mfp_ahb_lite_matrix matrix
(
    input                         HCLK,
    input                         HRESETn,
    input  [     HADDR_WIDTH-1:0] cpu_HADDR,
    input  [                 2:0] cpu_HBURST,
    input                         cpu_HMASTLOCK,
    input  [                 3:0] cpu_HPROT,
    input  [                 2:0] cpu_HSIZE,
    input  [                 1:0] cpu_HTRANS,
    input  [     HDATA_WIDTH-1:0] cpu_HWDATA,
    input                         cpu_HWRITE,
    output [     HDATA_WIDTH-1:0] cpu_HRDATA,
    output                        cpu_HREADY,
    output                        cpu_HRESP,

    `ifdef MFP_USE_SDRAM_MEMORY
    output                        SDRAM_CKE,
    output                        SDRAM_CSn,
    output                        SDRAM_RASn,
    output                        SDRAM_CASn,
    output                        SDRAM_WEn,
    output [`SDRAM_ADDR_BITS-1:0] SDRAM_ADDR,
    output [`SDRAM_BA_BITS  -1:0] SDRAM_BA,
    inout  [`SDRAM_DQ_BITS  -1:0] SDRAM_DQ,
    output [`SDRAM_DM_BITS  -1:0] SDRAM_DQM,
    `endif

    `ifdef MFP_USE_AVALON_MEMORY
    output                        avm_clk,
    output                        avm_rst_n,
    input                         avm_waitrequest,
    input                         avm_readdatavalid,
    input  [     HDATA_WIDTH-1:0] avm_readdata,
    output                        avm_write,
    output                        avm_read,
    output [                26:0] avm_address,
    output [                 3:0] avm_byteenable,
    output [                 2:0] avm_burstcount,
    output                        avm_beginbursttransfer,
    output                        avm_begintransfer,
    output [     HDATA_WIDTH-1:0] avm_writedata,
    `endif

    `ifdef MFP_DEMO_LIGHT_SENSOR
    output                        als_spi_cs,
    output                        als_spi_sck,
    input                         als_spi_sdo,
    `endif

    input                         uart_rx,
    output                        uart_tx,
    output                        uart_int,

    `ifdef MFP_USE_IRQ_EIC
    input  [ `EIC_CHANNELS - 1:0] EIC_input,
    output [                17:1] EIC_Offset,
    output [                 3:0] EIC_ShadowSet,
    output [                 7:0] EIC_Interrupt,
    output [                 5:0] EIC_Vector,
    output                        EIC_Present,
    input                         EIC_IAck,
    input  [                 7:0] EIC_IPL,
    input  [                 5:0] EIC_IVN,
    input  [                17:1] EIC_ION,
    `endif //MFP_USE_IRQ_EIC

    `ifdef MFP_USE_ADC_MAX10
    input                         clk_adc,
    input                         clk_locked,
    input                         adc_trigger,
    output                        adc_int,
    `endif

    input  [    GPIO_R-1:0][31:0] gpio_rd,
    output                 [31:0] gpio_wd,
    output [    GPIO_W-1:0]       gpio_we 
);



*/


































    assign EJ_TDO = EJ_TDOz_cpu ? 1'bz : EJ_TDO_cpu;

    `ifdef MFP_USE_SDRAM_MEMORY
      assign SDRAM_CLK = clk_dram;
    `endif




    wire MFP_Reset;


    wire         uart_interrupt;

    `ifdef MFP_USE_ADC_MAX10
        wire ADC_Interrupt;

        //TODO: in future it will be connected to advanced timer output
        wire ADC_Trigger    = 1'b0;
    `else
        wire ADC_Interrupt  = 1'b0;
    `endif



    m14k_top m14k_top
    (
        ...
        .SI_Reset              ( SI_Reset | MFP_Reset  ),
        ...
    );

        assign EJ_ManufID            = MFP_EJTAG_MANUFID;
        assign EJ_PartNumber         = MFP_EJTAG_PARTNUM;
        assign SI_ClkIn              = clk;

    // Interrupt settings
    //     
    //     vector                vector 
    //      mode   eic mode  IntCtl.VS=0x1   destination
    //     ------  --------  -------------  -------------
    //              ...
    //   ^  hw7     eic9        .320        
    // p |  hw6     eic8        .300        
    // r |  hw5     eic7        .2E0        timer int
    // i |  hw4     eic6        .2C0        adc int
    // o |  hw3     eic5        .2A0        uart int
    // r |  hw2     eic4        .280        
    // i |  hw1     eic3        .260        
    // t |  hw0     eic2        .240        
    // y |  sw1     eic1        .220        software int 1
    //   |  sw0     eic0        .200        software int 0

    `ifdef MFP_USE_IRQ_EIC
        wire  [ `EIC_CHANNELS - 1 : 0 ] EIC_input;
        assign EIC_input[`EIC_CHANNELS - 1:8] = {`EIC_CHANNELS - 6 {1'b0}};
        assign EIC_input[7]   =  SI_TimerInt;
        assign EIC_input[6]   =  ADC_Interrupt;
        assign EIC_input[5]   =  uart_interrupt;
        assign EIC_input[4:2] =  3'b0;
        assign EIC_input[1]   =  SI_SWInt[1];
        assign EIC_input[0]   =  SI_SWInt[0];
        assign SI_IPTI        =  3'h0;
    `else
        assign SI_Offset      = 17'b0;
        assign SI_EISS        =  4'b0;
        assign SI_Int[7:5]    =  4'b0;
        assign SI_Int[4]      =  ADC_Interrupt;
        assign SI_Int[3]      =  uart_interrupt;
        assign SI_Int[2:0]    =  3'b0;
        assign SI_EICVector   =  6'b0;
        assign SI_EICPresent  =  1'b0;
        assign SI_IPTI        =  3'h7; //enable MIPS timer interrupt on HW5
    `endif //MFP_USE_IRQ_EIC


    `ifdef MFP_DEMO_CACHE_MISSES

    wire burst = HTRANS == `HTRANS_NONSEQ && HBURST == `HBURST_WRAP4;
    assign IO_GreenLEDs = { { `MFP_N_GREEN_LEDS - (1 + 1 + 6) { 1'b0 } }, HCLK, burst, HADDR [7:2] };

    `elsif MFP_DEMO_PIPE_BYPASS

    assign IO_GreenLEDs = { { `MFP_N_GREEN_LEDS - 5 { 1'b0 } },

        HCLK,
        mpc_aselwr_e,   // Bypass res_w as src A
        mpc_bselall_e,  // Bypass res_w as src B
        mpc_aselres_e,  // Bypass res_m as src A
        mpc_bselres_e   // Bypass res_m as src B
    };

    `endif

    mfp_ahb_lite_matrix_with_loader matrix_loader
    (
        .HCLK             (   HCLK             ),
        .HRESETn          ( ~ SI_Reset         ),  // Not HRESETn - this is necessary for serial loader
        .HADDR            (   HADDR            ),
        .HBURST           (   HBURST           ),
        .HMASTLOCK        (   HMASTLOCK        ),
        .HPROT            (   HPROT            ),
        .HSIZE            (   HSIZE            ),
        .HTRANS           (   HTRANS           ),
        .HWDATA           (   HWDATA           ),
        .HWRITE           (   HWRITE           ),
        .HRDATA           (   HRDATA           ),
        .HREADY           (   HREADY           ),
        .HRESP            (   HRESP            ),
        
        `ifdef MFP_USE_SDRAM_MEMORY
        .SDRAM_CKE        (   SDRAM_CKE        ),
        .SDRAM_CSn        (   SDRAM_CSn        ),
        .SDRAM_RASn       (   SDRAM_RASn       ),
        .SDRAM_CASn       (   SDRAM_CASn       ),
        .SDRAM_WEn        (   SDRAM_WEn        ),
        .SDRAM_ADDR       (   SDRAM_ADDR       ),
        .SDRAM_BA         (   SDRAM_BA         ),
        .SDRAM_DQ         (   SDRAM_DQ         ),
        .SDRAM_DQM        (   SDRAM_DQM        ),
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

        .IO_Switches      (   IO_Switches      ),
        .IO_Buttons       (   IO_Buttons       ),
        .IO_RedLEDs       (   IO_RedLEDs       ),

        `ifdef MFP_DEMO_CACHE_MISSES
        .IO_GreenLEDs     (                    ),
        `elsif MFP_DEMO_PIPE_BYPASS
        .IO_GreenLEDs     (                    ),
        `else
        .IO_GreenLEDs     (   IO_GreenLEDs     ),
        `endif

        .IO_7_SegmentHEX  (   IO_7_SegmentHEX  ),
                                               
        `ifdef MFP_DEMO_LIGHT_SENSOR           
        .SPI_CS           ( SPI_CS             ),
        .SPI_SCK          ( SPI_SCK            ),
        .SPI_SDO          ( SPI_SDO            ),
        `endif                                 
                                               
        .UART_RX          (   UART_RX          ), 
        .UART_TX          (   UART_TX          ),

        `ifdef MFP_USE_DUPLEX_UART
        .UART_SRX         (   UART_SRX         ), 
        .UART_STX         (   UART_STX         ),
        `endif //MFP_USE_DUPLEX_UART
        .UART_INT         (   uart_interrupt   ),

        `ifdef MFP_USE_IRQ_EIC
        .EIC_input        (   EIC_input        ),
        .EIC_Offset       (   SI_Offset        ),
        .EIC_ShadowSet    (   SI_EISS          ),
        .EIC_Interrupt    (   SI_Int           ),
        .EIC_Vector       (   SI_EICVector     ),
        .EIC_Present      (   SI_EICPresent    ),
        .EIC_IAck         (   SI_IAck          ),
        .EIC_IPL          (   SI_IPL           ),
        .EIC_IVN          (   SI_IVN           ),
        .EIC_ION          (   SI_ION           ),
        `endif //MFP_USE_IRQ_EIC
    );

endmodule



module mfp_clock_stub
#(
    parameter MODE = 0,
              TOOL = ""
)(
    input        gclk,
    input  [1:0] mode,
    output       clk_cpu,
    output       clk_adc,
    output       clk_dram,
    output       clk_debug,
    output       locked 
);
    assign clk_cpu   = gclk;
    assign clk_adc   = 1'b0;
    assign clk_dram  = 1'b0;
    assign clk_debug = gclk;
    assign locked    = 1'b1;
endmodule

module mfp_clock_max10
#(
    parameter MODE = 0,
              TOOL = ""
)(
    input        gclk,
    input  [1:0] mode,      // ignored
    output       clk_cpu,
    output       clk_adc,
    output       clk_dram,
    output       clk_debug,
    output       locked 
);
    pll pll(gclk, clk_adc, clk_cpu, clk_dram, clk_debug, locked);
endmodule


module mfp_clock_slow
#(
    parameter MODE = 50, // supported: 50, 100
              TOOL = ""  // supported: "quartus", "vivado", ""
)(
    input        gclk,
    input  [1:0] mode,
    output       clk_cpu,
    output       clk_adc,
    output       clk_dram,
    output       clk_debug,
    output       locked 
);
    // Mode = 50 when gclk == 50 MHz,
    //       100             100 MHz
    localparam CLOCK_DIV_MODE0 = (MODE == 50) ?  0 :  1, // clk_cpu = 25   MHz
               CLOCK_DIV_MODE1 = (MODE == 50) ? 20 : 21, // clk_cpu = 12   Hz
               CLOCK_DIV_MODE2 = (MODE == 50) ? 25 : 26; // clk_cpu = 0.75 Hz

    // mode pins debouncer
    wire[1:0] mode_d;
    mfp_debouncer #( .DEPTH ( 2 ) mode_debouncer (gclk, mode, mode_d);

    // clock divider
    wire      clk_o
    mfp_clock_divider #  (
        .CLOCK_DIV_MODE0 ( CLOCK_DIV_MODE0 ),
        .CLOCK_DIV_MODE1 ( CLOCK_DIV_MODE1 ),
        .CLOCK_DIV_MODE2 ( CLOCK_DIV_MODE2 ) 
    ) mfp_clock_divider  (
        .gclk            ( gclk            ),
        .mode            ( dmode           ),
        .clk             ( clk_o           )
    );

    // make clock signal global
    generate
        if(TOOL == "quartus")
            global global_buf ( .in(clk_o), .out(clk_cpu));

        if(TOOL == "vivado")
            BUFG   global_buf (.I(clk_o), .O(clk_cpu));
    endgenerate

    // other clocks
    assign clk_adc   = 1'b0;
    assign clk_dram  = 1'b0;
    assign clk_debug = gclk;
    assign locked    = 1'b1;

endmodule


module mfp_clock_divider
(
    parameter   CLOCK_DIV_MODE0 = 0,
                CLOCK_DIV_MODE1 = CLOCK_DIV_MODE0,
                CLOCK_DIV_MODE2 = CLOCK_DIV_MODE0,
                CLOCK_DIV_MODE3 = CLOCK_DIV_MODE0,
                CLOCK_DIV_WIDTH = CLOCK_DIV_MODE0 
)(
    input            gclk,
    input      [1:0] mode,
    output reg       clk
);
    reg [CLOCK_DIV_WIDTH:0] cntr;

    always @ (posedge clki)
        cntr <= cntr + 1'b1;

    always @ (posedge clki)
        case (mode)
            2'b00 : clk <= cntr[CLOCK_DIV_MODE0];
            2'b01 : clk <= cntr[CLOCK_DIV_MODE1];
            2'b10 : clk <= cntr[CLOCK_DIV_MODE2];
            2'b11 : clk <= cntr[CLOCK_DIV_MODE3];
        endcase

endmodule



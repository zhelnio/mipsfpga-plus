`include "m14k_const.vh"
`include "mfp_config.vh"
`include "mfp_eic_core.vh"

module mfp_system
#(
    parameter AHB_ROM_ADDR_WIDTH = `MFP_MACRO_AHB_ROM_ADDR_WIDTH,
              AHB_ROM_INIT_RMEMH = `MFP_MACRO_AHB_ROM_INIT_RMEMH,
              AHB_RAM_ADDR_WIDTH = `MFP_MACRO_AHB_RAM_ADDR_WIDTH,
              AHB_RAM_INIT_RMEMH = `MFP_MACRO_AHB_RAM_INIT_RMEMH,
              UART_PROGAM_ENABLE = `MFP_MACRO_UART_PROGAM_ENABLE,
              UART_PROGAM_CLKFRQ = `MFP_MACRO_UART_PROGAM_CLKFRQ,
              UART_PROGAM_BOUDRT = `MFP_MACRO_UART_PROGAM_BOUDRT,
              CLOCK_SOURCE_MODE  = `MFP_MACRO_CLOCK_SOURCE_MODE,
              CURRENT_RTL_TOOL   = `MFP_MACRO_CURRENT_RTL_TOOL,
    parameter SDRAM_ADDR_BITS    = `DEFAULT_SDRAM_ADDR_BITS,
              SDRAM_ROW_BITS     = `DEFAULT_SDRAM_ROW_BITS,
              SDRAM_COL_BITS     = `DEFAULT_SDRAM_COL_BITS,
              SDRAM_DQ_BITS      = `DEFAULT_SDRAM_DQ_BITS,
              SDRAM_DM_BITS      = `DEFAULT_SDRAM_DM_BITS,
              SDRAM_BA_BITS      = `DEFAULT_SDRAM_BA_BITS,
    parameter EJTAG_MANUFID      = `DEFAULT_EJTAG_MANUFID,
              EJTAG_PARTNUM      = `DEFAULT_EJTAG_PARTNUM,
    parameter BOARD_WIDTH_BTN    = `DEFAULT_WIDTH_BTN,
              BOARD_WIDTH_SW     = `DEFAULT_WIDTH_SW,
              BOARD_WIDTH_LEDR   = `DEFAULT_WIDTH_LEDR,
              BOARD_WIDTH_LEDG   = `DEFAULT_WIDTH_LEDG,
              BOARD_WIDTH_7SEG   = `DEFAULT_WIDTH_7SEG 
)(
    input                         gclk,
    input  [                 1:0] pin_clk_mode,
    input                         pin_rst_cold,
    input                         pin_rst_soft,
    input                         uart_prg_rx,
    output                        SI_ColdReset,
    output                        SI_Reset,

    input                         EJ_RST_N,
    input                         EJ_TRST_N,
    input                         EJ_TDI,
    output tri                    EJ_TDO,
    input                         EJ_TMS,
    input                         EJ_TCK,
    input                         EJ_DINT,

    `ifdef MFP_MACRO_USE_SDRAM_MEMORY
    output                        SDRAM_CLK,
    output                        SDRAM_CKE,
    output                        SDRAM_CSn,
    output                        SDRAM_RASn,
    output                        SDRAM_CASn,
    output                        SDRAM_WEn,
    output [SDRAM_ADDR_BITS-1:0]  SDRAM_ADDR,
    output [SDRAM_BA_BITS  -1:0]  SDRAM_BA,
    inout  [SDRAM_DQ_BITS  -1:0]  SDRAM_DQ,
    output [SDRAM_DM_BITS  -1:0]  SDRAM_DQM,
    `endif

    `ifdef MFP_MACRO_USE_AVALON_MEMORY
    output                        avm_clk,
    output                        avm_rst_n,
    input                         avm_waitrequest,
    input                         avm_readdatavalid,
    input  [                31:0] avm_readdata,
    output                        avm_write,
    output                        avm_read,
    output [                26:0] avm_address,
    output [                 3:0] avm_byteenable,
    output [                 2:0] avm_burstcount,
    output                        avm_beginbursttransfer,
    output                        avm_begintransfer,
    output [                31:0] avm_writedata,
    `endif

    `ifdef MFP_MACRO_USE_PMOD_ALS
    output                        als_spi_cs,
    output                        als_spi_sck,
    input                         als_spi_sdo,
    `endif

    input                         uart_rx,
    output                        uart_tx,

    input  [BOARD_WIDTH_BTN -1:0] pin_gpio_sw,
    input  [BOARD_WIDTH_SW  -1:0] pin_gpio_btn,
    output [BOARD_WIDTH_LEDR-1:0] pin_gpio_ledr,
    output [BOARD_WIDTH_LEDG-1:0] pin_gpio_ledg,
    output [BOARD_WIDTH_7SEG-1:0] pin_gpio_7seg
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
    wire [ 2:0] SI_IPTI;
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
  
  `ifdef MFP_MACRO_DEMO_PIPE_BYPASS
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

    wire        adc_trigger;
    wire        adc_interrupt;
    wire        uart_interrupt;

    wire [`EIC_CHANNELS-1:0] EIC_input;
    wire [              7:0] EIC_Interrupt;

    localparam BOARD_GPIO_COUNT = 5;

    wire [BOARD_GPIO_COUNT-1:0][31:0] gpio_rd;
    wire                       [31:0] gpio_wd;
    wire [BOARD_GPIO_COUNT-1:0]       gpio_we;
    wire [BOARD_WIDTH_LEDG-1:0]       pin_ledg;

    // system clock source
    `MFP_MACRO_CLOCK_SOURCE #(
        .MODE      ( CLOCK_SOURCE_MODE ),
        .TOOL      ( CURRENT_RTL_TOOL  )
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
    cpu_mipsfpga 
    #(
        .EJTAG_MANUFID ( EJTAG_MANUFID ),
        .EJTAG_PARTNUM ( EJTAG_PARTNUM )
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
        .SI_IPTI       ( SI_IPTI       ),
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

        `ifdef MFP_MACRO_DEMO_PIPE_BYPASS
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
        .ENABLED     ( UART_PROGAM_ENABLE ),
        .CLK_FREQ    ( UART_PROGAM_CLKFRQ ),
        .BOUD_RATE   ( UART_PROGAM_BOUDRT )
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
    mfp_ahb_lite_matrix #(
        .AHB_ROM_ADDR_WIDTH     ( AHB_ROM_ADDR_WIDTH     ),
        .AHB_ROM_INIT_RMEMH     ( AHB_ROM_INIT_RMEMH     ),
        .AHB_RAM_ADDR_WIDTH     ( AHB_RAM_ADDR_WIDTH     ),
        .AHB_RAM_INIT_RMEMH     ( AHB_RAM_INIT_RMEMH     ),
        .SDRAM_ADDR_BITS        ( SDRAM_ADDR_BITS        ),
        .SDRAM_ROW_BITS         ( SDRAM_ROW_BITS         ),
        .SDRAM_COL_BITS         ( SDRAM_COL_BITS         ),
        .SDRAM_DQ_BITS          ( SDRAM_DQ_BITS          ),
        .SDRAM_DM_BITS          ( SDRAM_DM_BITS          ),
        .SDRAM_BA_BITS          ( SDRAM_BA_BITS          ),
        .GPIOR_COUNT            ( BOARD_GPIO_COUNT       ),
        .GPIOW_COUNT            ( BOARD_GPIO_COUNT       ) 
    ) matrix (
        .HCLK                   ( cpu_HCLK               ),
        .HRESETn                ( bus_HRESETn            ),
        .cpu_HADDR              ( bus_HADDR              ),
        .cpu_HBURST             ( bus_HBURST             ),
        .cpu_HMASTLOCK          ( bus_HMASTLOCK          ),
        .cpu_HPROT              ( bus_HPROT              ),
        .cpu_HSIZE              ( bus_HSIZE              ),
        .cpu_HTRANS             ( bus_HTRANS             ),
        .cpu_HWDATA             ( bus_HWDATA             ),
        .cpu_HWRITE             ( bus_HWRITE             ),
        .cpu_HRDATA             ( cpu_HRDATA             ),
        .cpu_HREADY             ( cpu_HREADY             ),
        .cpu_HRESP              ( cpu_HRESP              ),

        `ifdef MFP_MACRO_USE_SDRAM_MEMORY
        .SDRAM_CKE              ( SDRAM_CKE              ),
        .SDRAM_CSn              ( SDRAM_CSn              ),
        .SDRAM_RASn             ( SDRAM_RASn             ),
        .SDRAM_CASn             ( SDRAM_CASn             ),
        .SDRAM_WEn              ( SDRAM_WEn              ),
        .SDRAM_ADDR             ( SDRAM_ADDR             ),
        .SDRAM_BA               ( SDRAM_BA               ),
        .SDRAM_DQ               ( SDRAM_DQ               ),
        .SDRAM_DQM              ( SDRAM_DQM              ),
        `endif

        `ifdef MFP_MACRO_USE_AVALON_MEMORY
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

        `ifdef MFP_MACRO_USE_PMOD_ALS
        .als_spi_cs             ( als_spi_cs             ),
        .als_spi_sck            ( als_spi_sck            ),
        .als_spi_sdo            ( als_spi_sdo            ),
        `endif

        .uart_rx                ( uart_rx                ),
        .uart_tx                ( uart_tx                ),
        .uart_int               ( uart_interrupt         ),

        `ifdef MFP_MACRO_USE_IRQ_EIC
        .EIC_input              ( EIC_input              ),
        .EIC_Offset             ( SI_Offset              ),
        .EIC_ShadowSet          ( SI_EISS                ),
        .EIC_Interrupt          ( EIC_Interrupt          ),
        .EIC_Vector             ( SI_EICVector           ),
        .EIC_Present            ( SI_EICPresent          ),
        .EIC_IAck               ( SI_IAck                ),
        .EIC_IPL                ( SI_IPL                 ),
        .EIC_IVN                ( SI_IVN                 ),
        .EIC_ION                ( SI_ION                 ),
        `endif

        `ifdef MFP_MACRO_USE_ADC_MAX10 
        .clk_adc                ( clk_adc                ),
        .clk_locked             ( pll_locked             ),
        .adc_trigger            ( adc_trigger            ),
        .adc_int                ( adc_interrupt          ),
        `endif

        .gpio_rd                ( gpio_rd                ),
        .gpio_wd                ( gpio_wd                ),
        .gpio_we                ( gpio_we                ) 
    );

    // pin to interrutp connection
    mfp_interrupt_map #(
        .EIC_CHANNELS     ( `EIC_CHANNELS    )
    ) mfp_interrupt_map (
        .SI_EICPresent    ( SI_EICPresent    ),
        .SI_TimerInt      ( SI_TimerInt      ),
        .SI_SWInt         ( SI_SWInt         ),
        .adc_interrupt    ( adc_interrupt    ),
        .uart_interrupt   ( uart_interrupt   ),
        .EIC_Interrupt    ( EIC_Interrupt    ),
        .EIC_input        ( EIC_input        ),
        .SI_Int           ( SI_Int           ),
        .SI_IPTI          ( SI_IPTI          ) 
    );

    `ifndef MFP_MACRO_USE_IRQ_EIC
    mfp_eic_stub  #(
        .EIC_CHANNELS     ( `EIC_CHANNELS    )
    ) mfp_eic_stub (
        .EIC_input        ( EIC_input        ),
        .EIC_Offset       ( SI_Offset        ),
        .EIC_ShadowSet    ( SI_EISS          ),
        .EIC_Interrupt    ( EIC_Interrupt    ),
        .EIC_Vector       ( SI_EICVector     ),
        .EIC_Present      ( SI_EICPresent    ),
        .EIC_IAck         ( SI_IAck          ),
        .EIC_IPL          ( SI_IPL           ),
        .EIC_IVN          ( SI_IVN           ),
        .EIC_ION          ( SI_ION           ) 
    );
    `endif

    // pin to gpio connection
    mfp_gpio_map #(
        .GPIOW_COUNT      ( BOARD_GPIO_COUNT ),
        .GPIOR_COUNT      ( BOARD_GPIO_COUNT ),
        .BOARD_WIDTH_BTN  ( BOARD_WIDTH_BTN  ),
        .BOARD_WIDTH_SW   ( BOARD_WIDTH_SW   ),
        .BOARD_WIDTH_LEDR ( BOARD_WIDTH_LEDR ),
        .BOARD_WIDTH_LEDG ( BOARD_WIDTH_LEDG ),
        .BOARD_WIDTH_7SEG ( BOARD_WIDTH_7SEG ) 
    ) mfp_gpio_map (
        .clk              ( cpu_HCLK         ),
        .rst_n            ( bus_HRESETn      ),
        .gpio_rd          ( gpio_rd          ),
        .gpio_wd          ( gpio_wd          ),
        .gpio_we          ( gpio_we          ),
        .pin_sw           ( pin_gpio_sw      ),
        .pin_btn          ( pin_gpio_btn     ),
        .pin_ledr         ( pin_gpio_ledr    ),
        .pin_ledg         ( pin_gpio_ledg    ),
        .pin_7seg         ( pin_gpio_7seg    ) 
    );

    assign EJ_TDO = EJ_TDOz_cpu ? 1'bz : EJ_TDO_cpu;

    `ifdef MFP_MACRO_USE_SDRAM_MEMORY
        assign SDRAM_CLK = clk_dram;
    `endif

    assign adc_trigger = 1'b0;
    `ifndef MFP_MACRO_USE_ADC_MAX10
        assign adc_interrupt = 1'b0;
    `endif

    `ifdef MFP_MACRO_DEMO_CACHE_MISSES
        wire burst = HTRANS == `HTRANS_NONSEQ && HBURST == `HBURST_WRAP4;
        assign pin_gpio_ledg = { '0, HCLK, burst, HADDR [7:2] };

    `elsif MFP_MACRO_DEMO_PIPE_BYPASS
        assign pin_gpio_ledg = { '0,
                                  HCLK,
                                  mpc_aselwr_e,   // Bypass res_w as src A
                                  mpc_bselall_e,  // Bypass res_w as src B
                                  mpc_aselres_e,  // Bypass res_m as src A
                                  mpc_bselres_e   // Bypass res_m as src B
                                };
    `else
        assign pin_gpio_ledg = pin_ledg;
    `endif

endmodule

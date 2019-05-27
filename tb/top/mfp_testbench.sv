`include "mfp_config.vh"

//`timescale 1 ns / 100 ps
`timescale 1 ps / 1 ps

`define CLOCK_T_GLOBAL      20000
`define CLOCK_T_ADC         100000
`define CLOCK_SDRAM_SHIFT   12000
`define CLOCK_T_SDRAM       `CLOCK_T_GLOBAL
// `define CYCLE_LIMIT         40000

module mfp_testbench;

    parameter AHB_ROM_ADDR_WIDTH = `MFP_MACRO_AHB_ROM_ADDR_WIDTH,
              AHB_ROM_INIT_RMEMH = `MFP_MACRO_AHB_ROM_INIT_RMEMH,
              AHB_RAM_ADDR_WIDTH = `MFP_MACRO_AHB_RAM_ADDR_WIDTH,
              AHB_RAM_INIT_RMEMH = `MFP_MACRO_AHB_RAM_INIT_RMEMH,
              UART_PROGAM_ENABLE = `MFP_MACRO_UART_PROGAM_ENABLE,
              UART_PROGAM_CLKFRQ = `MFP_MACRO_UART_PROGAM_CLKFRQ,
              UART_PROGAM_BOUDRT = `MFP_MACRO_UART_PROGAM_BOUDRT,
              CLOCK_SOURCE_MODE  = `MFP_MACRO_CLOCK_SOURCE_MODE,
              CURRENT_RTL_TOOL   = `MFP_MACRO_CURRENT_RTL_TOOL;
    parameter SDRAM_ADDR_BITS    = `DEFAULT_SDRAM_ADDR_BITS,
              SDRAM_ROW_BITS     = `DEFAULT_SDRAM_ROW_BITS,
              SDRAM_COL_BITS     = `DEFAULT_SDRAM_COL_BITS,
              SDRAM_DQ_BITS      = `DEFAULT_SDRAM_DQ_BITS,
              SDRAM_DM_BITS      = `DEFAULT_SDRAM_DM_BITS,
              SDRAM_BA_BITS      = `DEFAULT_SDRAM_BA_BITS;
    parameter EJTAG_MANUFID      = `DEFAULT_EJTAG_MANUFID,
              EJTAG_PARTNUM      = `DEFAULT_EJTAG_PARTNUM;
    parameter BOARD_WIDTH_BTN    = `DEFAULT_WIDTH_BTN,
              BOARD_WIDTH_SW     = `DEFAULT_WIDTH_SW,
              BOARD_WIDTH_LEDR   = `DEFAULT_WIDTH_LEDR,
              BOARD_WIDTH_LEDG   = `DEFAULT_WIDTH_LEDG,
              BOARD_WIDTH_7SEG   = `DEFAULT_WIDTH_7SEG;

    reg         gclk;
    wire  [1:0] pin_clk_mode = '0;
    reg         pin_rst_cold;
    reg         pin_rst_soft;
    wire        uart_prg_rx  = '0;
    wire        SI_ColdReset;
    wire        SI_Reset;

    wire        EJ_RST_N   = '1;
    wire        EJ_TRST_N  = '1;
    wire        EJ_TDI     = '1;
    wire        EJ_TDO;
    wire        EJ_TMS     = '1;
    wire        EJ_TCK     = '1;
    wire        EJ_DINT    = '1;

    wire                       SDRAM_CLK;
    wire                       SDRAM_CKE;
    wire                       SDRAM_CSn;
    wire                       SDRAM_RASn;
    wire                       SDRAM_CASn;
    wire                       SDRAM_WEn;
    wire [SDRAM_ADDR_BITS-1:0] SDRAM_ADDR;
    wire [SDRAM_BA_BITS  -1:0] SDRAM_BA;
    wire [SDRAM_DQ_BITS  -1:0] SDRAM_DQ;
    wire [SDRAM_DM_BITS  -1:0] SDRAM_DQM;

    wire         avm_clk;
    wire         avm_rst_n;
    wire         avm_waitrequest;
    wire         avm_readdatavalid;
    wire [ 31:0] avm_readdata;
    wire         avm_write;
    wire         avm_read;
    wire [ 26:0] avm_address;
    wire [  3:0] avm_byteenable;
    wire [  2:0] avm_burstcount;
    wire         avm_beginbursttransfer;
    wire         avm_begintransfer;
    wire [ 31:0] avm_writedata;

    wire         als_spi_cs;
    wire         als_spi_sck;
    wire         als_spi_sdo;

    wire         uart_tx;
    wire         uart_rx = uart_tx;

    wire [BOARD_WIDTH_BTN -1:0] pin_gpio_sw  = '0;
    wire [BOARD_WIDTH_SW  -1:0] pin_gpio_btn = '0;
    wire [BOARD_WIDTH_LEDR-1:0] pin_gpio_ledr;
    wire [BOARD_WIDTH_LEDG-1:0] pin_gpio_ledg;
    wire [BOARD_WIDTH_7SEG-1:0] pin_gpio_7seg;

    wire [9:0]  mem_ca;
    wire [0:0]  mem_ck;
    wire [0:0]  mem_ck_n;
    wire [0:0]  mem_cke;
    wire [0:0]  mem_cs_n;
    wire [3:0]  mem_dm;
    wire [31:0] mem_dq;
    wire [3:0]  mem_dqs;
    wire [3:0]  mem_dqs_n;

    mfp_system #(
        .AHB_ROM_ADDR_WIDTH ( AHB_ROM_ADDR_WIDTH),
        .AHB_ROM_INIT_RMEMH ( AHB_ROM_INIT_RMEMH),
        .AHB_RAM_ADDR_WIDTH ( AHB_RAM_ADDR_WIDTH),
        .AHB_RAM_INIT_RMEMH ( AHB_RAM_INIT_RMEMH),
        .UART_PROGAM_ENABLE ( UART_PROGAM_ENABLE),
        .UART_PROGAM_CLKFRQ ( UART_PROGAM_CLKFRQ),
        .UART_PROGAM_BOUDRT ( UART_PROGAM_BOUDRT),
        .CLOCK_SOURCE_MODE  ( CLOCK_SOURCE_MODE ),
        .CURRENT_RTL_TOOL   ( CURRENT_RTL_TOOL  ),
        .SDRAM_ADDR_BITS    ( SDRAM_ADDR_BITS   ),
        .SDRAM_ROW_BITS     ( SDRAM_ROW_BITS    ),
        .SDRAM_COL_BITS     ( SDRAM_COL_BITS    ),
        .SDRAM_DQ_BITS      ( SDRAM_DQ_BITS     ),
        .SDRAM_DM_BITS      ( SDRAM_DM_BITS     ),
        .SDRAM_BA_BITS      ( SDRAM_BA_BITS     ),
        .EJTAG_MANUFID      ( EJTAG_MANUFID     ),
        .EJTAG_PARTNUM      ( EJTAG_PARTNUM     ),
        .BOARD_WIDTH_BTN    ( BOARD_WIDTH_BTN   ),
        .BOARD_WIDTH_SW     ( BOARD_WIDTH_SW    ),
        .BOARD_WIDTH_LEDR   ( BOARD_WIDTH_LEDR  ),
        .BOARD_WIDTH_LEDG   ( BOARD_WIDTH_LEDG  ),
        .BOARD_WIDTH_7SEG   ( BOARD_WIDTH_7SEG  ) 
    ) system (
        .gclk               ( gclk              ),
        .pin_clk_mode       ( pin_clk_mode      ),
        .pin_rst_cold       ( pin_rst_cold      ),
        .pin_rst_soft       ( pin_rst_soft      ),
        .uart_prg_rx        ( uart_prg_rx       ),
        .SI_ColdReset       ( SI_ColdReset      ),
        .SI_Reset           ( SI_Reset          ),
        .EJ_RST_N           ( EJ_RST_N          ),
        .EJ_TRST_N          ( EJ_TRST_N         ),
        .EJ_TDI             ( EJ_TDI            ),
        .EJ_TDO             ( EJ_TDO            ),
        .EJ_TMS             ( EJ_TMS            ),
        .EJ_TCK             ( EJ_TCK            ),
        .EJ_DINT            ( EJ_DINT           ),
        `ifdef MFP_MACRO_USE_SDRAM_MEMORY
        .SDRAM_CLK          ( SDRAM_CLK         ),
        .SDRAM_CKE          ( SDRAM_CKE         ),
        .SDRAM_CSn          ( SDRAM_CSn         ),
        .SDRAM_RASn         ( SDRAM_RASn        ),
        .SDRAM_CASn         ( SDRAM_CASn        ),
        .SDRAM_WEn          ( SDRAM_WEn         ),
        .SDRAM_ADDR         ( SDRAM_ADDR        ),
        .SDRAM_BA           ( SDRAM_BA          ),
        .SDRAM_DQ           ( SDRAM_DQ          ),
        .SDRAM_DQM          ( SDRAM_DQM         ),
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
        .als_spi_cs          ( als_spi_cs    ),
        .als_spi_sck         ( als_spi_sck   ),
        .als_spi_sdo         ( als_spi_sdo   ),
        `endif
        .uart_rx             ( uart_rx       ),
        .uart_tx             ( uart_tx       ),
        .pin_gpio_sw         ( pin_gpio_sw   ),
        .pin_gpio_btn        ( pin_gpio_btn  ),
        .pin_gpio_ledr       ( pin_gpio_ledr ),
        .pin_gpio_ledg       ( pin_gpio_ledg ),
        .pin_gpio_7seg       ( pin_gpio_7seg ) 
    );

    `ifdef MFP_MACRO_USE_PMOD_ALS
    pmod_als_spi_stub pmod_als_spi_stub (
        .cs               ( SPI_CS           ),
        .sck              ( SPI_SCK          ),
        .sdo              ( SPI_SDO          )
    );
    `endif

    `ifdef MFP_MACRO_USE_SDRAM_MEMORY
    sdr sdr (
        .Dq     ( SDRAM_DQ   ),
        .Addr   ( SDRAM_ADDR ),
        .Ba     ( SDRAM_BA   ),
        .Clk    ( SDRAM_CLK  ),
        .Cke    ( SDRAM_CKE  ),
        .Cs_n   ( SDRAM_CSn  ),
        .Ras_n  ( SDRAM_RASn ),
        .Cas_n  ( SDRAM_CASn ),
        .We_n   ( SDRAM_WEn  ),
        .Dqm    ( SDRAM_DQM  ) 
    );
    `endif

    `ifdef MFP_MACRO_USE_AVALON_MEMORY
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
        .avm_debugaccess   ( 1'b0               ),
        .gclk_clk          ( gclk               ),
        .grst_reset_n      ( ~SI_ColdReset      ),
        .srst_reset_n      ( ~SI_Reset          ),
        .mclk_clk          ( avm_clk            ),
        .mrst_reset        ( ~avm_rst_n         ),
        .oct_rzqin         (                    ),
        .lpddr2_mem_ca     ( mem_ca             ),
        .lpddr2_mem_ck     ( mem_ck             ),
        .lpddr2_mem_ck_n   ( mem_ck_n           ),
        .lpddr2_mem_cke    ( mem_cke            ),
        .lpddr2_mem_cs_n   ( mem_cs_n           ),
        .lpddr2_mem_dm     ( mem_dm             ),
        .lpddr2_mem_dq     ( mem_dq             ),
        .lpddr2_mem_dqs    ( mem_dqs            ),
        .lpddr2_mem_dqs_n  ( mem_dqs_n          ) 
    );

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
    `endif

    initial begin
        gclk <= '0;
        forever #(`CLOCK_T_GLOBAL/2) gclk <= ~gclk;
    end

    initial begin
        pin_rst_cold <= 1'b1;
        pin_rst_soft <= 1'b1;

        repeat (10) @(posedge gclk);
        pin_rst_cold <= 1'b0;

        repeat (10) @(posedge gclk);
        pin_rst_soft <= 1'b0;
    end

    initial begin
        $dumpvars;
        $timeformat ( -9,    // 1 ns
                      1,     // Number of digits after decimal point
                      "ns",  // suffix
                      10     // Max number of digits 
                    );
    end

    //----------------------------------------------------------------

    integer cycle; initial cycle = 0;
    always @ (posedge gclk) begin
        cycle = cycle + 1;
        `ifdef CYCLE_LIMIT
            if(cycle > `CYCLE_LIMIT) begin
                  $display ("Timeout");
                  $finish
            end
        `endif
    end

    //----------------------------------------------------------------

    always @ (posedge gclk) begin
        if(system.cpu_HCLK)
            $display("yep!");
    end

    //initial mobile_ddr2.mcd_info = 1;

    // always @ (posedge gclk)
    // begin

    //     if(HREADY)
    //         $display ("%5d HCLK %b HADDR %h HRDATA %h HWDATA %h HWRITE %b HREADY %b HTRANS %b LEDR %b LEDG %b 7SEG %h",
    //             cycle, system.HCLK, HADDR, HRDATA, HWDATA,      HWRITE, HREADY, HTRANS, IO_RedLEDs, IO_GreenLEDs, IO_7_SegmentHEX);


    //     $display ("%5d HCLK %b HADDR %h HRDATA %h HWDATA %h HWRITE %b HREADY %b HTRANS %b LEDR %b LEDG %b 7SEG %h",
    //         cycle, system.HCLK, HADDR, HRDATA, HWDATA,      HWRITE, HREADY, HTRANS, IO_RedLEDs, IO_GreenLEDs, IO_7_SegmentHEX);

    //     `ifdef MFP_MACRO_DEMO_PIPE_BYPASS

    //     if ( system.mpc_aselwr_e  ) $display ( "%5d PIPE_BYPASS mpc_aselwr_e"  , cycle );
    //     if ( system.mpc_bselall_e ) $display ( "%5d PIPE_BYPASS mpc_bselall_e" , cycle );
    //     if ( system.mpc_aselres_e ) $display ( "%5d PIPE_BYPASS mpc_aselres_e" , cycle );
    //     if ( system.mpc_bselres_e ) $display ( "%5d PIPE_BYPASS mpc_bselres_e" , cycle );

    //     `endif

endmodule

module mfp_clock_tb
#(
    parameter MODE = 0,
              TOOL = ""
)(
    input           gclk,
    input     [1:0] mode,
    output          clk_cpu,
    output reg      clk_adc,
    output reg      clk_dram,
    output          clk_debug,
    output          locked 
);
    assign clk_cpu   = gclk;
    assign clk_debug = gclk;
    assign locked    = 1'b1;

    initial begin
        clk_adc <= 1'b0;
        @(posedge gclk);
        forever #(`CLOCK_T_ADC/2) clk_adc <= ~clk_adc;
    end

    initial begin
        clk_dram <= 1'b0;
        @(posedge gclk);
        #(`CLOCK_SDRAM_SHIFT)
        forever clk_dram = #(`CLOCK_T_SDRAM/2) ~clk_dram;
    end

endmodule

//     /*
//     always @ (negedge SI_ClkIn)
//     begin
//         if (HADDR == 32'h1fc00058)
//         begin
//             $display ("Data cache initialized. About to make kseg0 cacheable.");
//             $stop;
// 	end
// 	else if (HADDR == 32'h00000644)
//         begin
// 	    $display ("Beginning of program code.");
//             $stop;
// 	end
//     end
//     */

module pmod_als_spi_stub
#(
    parameter value = 8'hAB
)(
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

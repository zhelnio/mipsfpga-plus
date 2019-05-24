`include "mfp_ahb_lite.vh"
`include "mfp_ahb_lite_matrix_config.vh"
`include "mfp_eic_core.vh"

module mfp_ahb_lite_matrix
#(
    parameter HADDR_WIDTH = 32,
              HDATA_WIDTH = 32
)(
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
    localparam HPORT_COUNT = 7;

    // peripheral devices
    // TODO: move slow devices to APB
    wire [HPORT_COUNT-1:0][HADDR_WIDTH-1:0] HADDR;
    wire [HPORT_COUNT-1:0][            2:0] HBURST;
    wire [HPORT_COUNT-1:0]                  HMASTLOCK;
    wire [HPORT_COUNT-1:0][            3:0] HPROT;
    wire [HPORT_COUNT-1:0]                  HSEL;
    wire [HPORT_COUNT-1:0][            2:0] HSIZE;
    wire [HPORT_COUNT-1:0][            1:0] HTRANS;
    wire [HPORT_COUNT-1:0][HDATA_WIDTH-1:0] HWDATA;
    wire [HPORT_COUNT-1:0]                  HWRITE;
    wire [HPORT_COUNT-1:0][HDATA_WIDTH-1:0] HRDATA;
    wire [HPORT_COUNT-1:0]                  HREADYOUT;
    wire [HPORT_COUNT-1:0]                  HREADY;
    wire [HPORT_COUNT-1:0]                  HRESP;

    // AHB addr decoder
    wire                  [HADDR_WIDTH-1:0] d_HADDR,
    wire [HPORT_COUNT-1:0]                  d_HSEL

    // AHB-Lite interconnect
    ahb_lite_1xN    #(
        .HDATA_WIDTH ( HDATA_WIDTH   ),
        .HADDR_WIDTH ( HADDR_WIDTH   ),
        .HPORT_COUNT ( HPORT_COUNT   ) 
    ) ahb_lite_1xN   (
        .HCLK        ( HCLK          ),
        .HRESETn     ( HRESETn       ),
        .s_HADDR     ( cpu_HADDR     ),
        .s_HBURST    ( cpu_HBURST    ),
        .s_HMASTLOCK ( cpu_HMASTLOCK ),
        .s_HPROT     ( cpu_HPROT     ),
        .s_HSIZE     ( cpu_HSIZE     ),
        .s_HTRANS    ( cpu_HTRANS    ),
        .s_HWDATA    ( cpu_HWDATA    ),
        .s_HWRITE    ( cpu_HWRITE    ),
        .s_HRDATA    ( cpu_HRDATA    ),
        .s_HREADY    ( cpu_HREADY    ),
        .s_HRESP     ( cpu_HRESP     ),
        .m_HADDR     ( HADDR         ),
        .m_HBURST    ( HBURST        ),
        .m_HMASTLOCK ( HMASTLOCK     ),
        .m_HPROT     ( HPROT         ),
        .m_HSEL      ( HSEL          ),
        .m_HSIZE     ( HSIZE         ),
        .m_HTRANS    ( HTRANS        ),
        .m_HWDATA    ( HWDATA        ),
        .m_HWRITE    ( HWRITE        ),
        .m_HRDATA    ( HRDATA        ),
        .m_HREADYOUT ( HREADYOUT     ),
        .m_HREADY    ( HREADY        ),
        .m_HRESP     ( HRESP         ),
        .d_HADDR     ( d_HADDR       ),
        .d_HSEL      ( d_HSEL        ) 
    );

    // addr decoder
    ahb_decoder     #(
        .HPORT_COUNT ( HPORT_COUNT   )
    ) ahb_decoder    (
        .HADDR       ( d_HADDR       ),
        .HSEL        ( d_HSEL        ) 
    );

    //RESET
    ahb_lite_bram #(
        .HADDR_WIDTH      ( `MFP_RESET_RAM_ADDR_WIDTH ),
        .HDATA_WIDTH      (  HDATA_WIDTH              ),
        .INIT_RMEMH       ( `MFP_RESET_RAM_HEX        )
    ) reset_ram (
        .HCLK             ( HCLK            ),
        .HRESETn          ( HRESETn         ),
        .HADDR            ( HADDR           ),
        .HBURST           ( HBURST          ),
        .HMASTLOCK        ( HMASTLOCK       ),
        .HPROT            ( HPROT           ),
        .HSEL             ( HSEL        [0] ),
        .HSIZE            ( HSIZE           ),
        .HTRANS           ( HTRANS          ),
        .HWDATA           ( HWDATA          ),
        .HWRITE           ( HWRITE          ),
        .HRDATA           ( RDATA       [0] ),
        .HREADYOUT        ( HREADYOUT   [0] ),
        .HREADY           ( HREADY          ),
        .HRESP            ( RESP        [0] ) 
    );

    //RAM
    `ifdef MFP_USE_SDRAM_MEMORY
        mfp_ahb_ram_sdram
        #(
            .ADDR_BITS    ( `SDRAM_ADDR_BITS ),
            .ROW_BITS     ( `SDRAM_ROW_BITS  ),
            .COL_BITS     ( `SDRAM_COL_BITS  ),
            .DQ_BITS      ( `SDRAM_DQ_BITS   ),
            .DM_BITS      ( `SDRAM_DM_BITS   ),
            .BA_BITS      ( `SDRAM_BA_BITS   )
        )
    `elsif MFP_USE_BUSY_MEMORY
        mfp_ahb_ram_busy
        #(
            .ADDR_WIDTH ( `MFP_RAM_ADDR_WIDTH )
        )
    `elsif MFP_USE_AVALON_MEMORY
        ahb_lite_avm 
        #(
            .HADDR_WIDTH ( HADDR_WIDTH ),
            .HDATA_WIDTH ( HDATA_WIDTH ),
            .AV_BE_WIDTH ( 4           ),
            .AV_BC_WIDTH ( 3           ) 
        )
    `else
        ahb_lite_bram
        #(
            .HADDR_WIDTH ( `MFP_RAM_ADDR_WIDTH )
        )
    `endif
    ram
    (
        .HCLK             ( HCLK            ),
        .HRESETn          ( HRESETn         ),
        .HADDR            ( HADDR           ),
        .HBURST           ( HBURST          ),
        .HMASTLOCK        ( HMASTLOCK       ),
        .HPROT            ( HPROT           ),
        .HSEL             ( HSEL        [1] ),
        .HSIZE            ( HSIZE           ),
        .HTRANS           ( HTRANS          ),
        .HWDATA           ( HWDATA          ),
        .HWRITE           ( HWRITE          ),
        .HRDATA           ( RDATA       [1] ),
        .HREADYOUT        ( HREADYOUT   [1] ),
        .HREADY           ( HREADY          ),
        .HRESP            ( RESP        [1] ) 

        `ifdef MFP_USE_SDRAM_MEMORY
        ,
        .CKE              ( SDRAM_CKE       ),
        .CSn              ( SDRAM_CSn       ),
        .RASn             ( SDRAM_RASn      ),
        .CASn             ( SDRAM_CASn      ),
        .WEn              ( SDRAM_WEn       ),
        .ADDR             ( SDRAM_ADDR      ),
        .BA               ( SDRAM_BA        ),
        .DQ               ( SDRAM_DQ        ),
        .DQM              ( SDRAM_DQM       )
        `endif

        `ifdef MFP_USE_AVALON_MEMORY
        ,
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
        .avm_writedata          ( avm_writedata          ) 
        `endif
    );

    //GPIO
    mfp_ahb_gpio gpio
    (
        .HCLK             ( HCLK            ),
        .HRESETn          ( HRESETn         ),
        .HADDR            ( HADDR           ),
        .HBURST           ( HBURST          ),
        .HMASTLOCK        ( HMASTLOCK       ),
        .HPROT            ( HPROT           ),
        .HSEL             ( HSEL        [2] ),
        .HSIZE            ( HSIZE           ),
        .HTRANS           ( HTRANS          ),
        .HWDATA           ( HWDATA          ),
        .HWRITE           ( HWRITE          ),
        .HRDATA           ( RDATA       [2] ),
        .HREADYOUT        ( HREADYOUT   [2] ),
        .HREADY           ( HREADY          ),
        .HRESP            ( RESP        [2] ),
        .gpio_rd          ( gpio_rd         ),
        .gpio_wd          ( gpio_wd         ),
        .gpio_we          ( gpio_we         ) 
    );

    //UART
    mfp_ahb_lite_uart16550  uart
    (
        .HCLK             ( HCLK            ),
        .HRESETn          ( HRESETn         ),
        .HADDR            ( HADDR           ),
        .HBURST           ( HBURST          ),
        .HMASTLOCK        ( HMASTLOCK       ),
        .HPROT            ( HPROT           ),
        .HSEL             ( HSEL        [3] ),
        .HSIZE            ( HSIZE           ),
        .HTRANS           ( HTRANS          ),
        .HWDATA           ( HWDATA          ),
        .HWRITE           ( HWRITE          ),
        .HRDATA           ( RDATA       [3] ),
        .HREADYOUT        ( HREADYOUT   [3] ),
        .HREADY           ( HREADY          ),
        .HRESP            ( RESP        [3] ),
        .UART_SRX         ( uart_rx         ),
        .UART_STX         ( uart_tx         ),
        .UART_RTS         (                 ),
        .UART_CTS         ( 1'b0            ),
        .UART_DTR         (                 ),
        .UART_DSR         ( 1'b0            ),
        .UART_RI          ( 1'b0            ),
        .UART_DCD         ( 1'b0            ),
        .UART_BAUD        (                 ),
        .UART_INT         ( uart_int        ) 
    );

    // EIC
    `ifdef MFP_USE_IRQ_EIC
    mfp_ahb_lite_eic eic
    (
        .HCLK             ( HCLK            ),
        .HRESETn          ( HRESETn         ),
        .HADDR            ( HADDR           ),
        .HBURST           ( HBURST          ),
        .HMASTLOCK        ( HMASTLOCK       ),
        .HPROT            ( HPROT           ),
        .HSEL             ( HSEL        [4] ),
        .HSIZE            ( HSIZE           ),
        .HTRANS           ( HTRANS          ),
        .HWDATA           ( HWDATA          ),
        .HWRITE           ( HWRITE          ),
        .HRDATA           ( RDATA       [4] ),
        .HREADYOUT        ( HREADYOUT   [4] ),
        .HREADY           ( HREADY          ),
        .HRESP            ( RESP        [4] ),

        .EIC_input        ( EIC_input       ),

        .EIC_Offset       ( EIC_Offset      ),
        .EIC_ShadowSet    ( EIC_ShadowSet   ),
        .EIC_Interrupt    ( EIC_Interrupt   ),
        .EIC_Vector       ( EIC_Vector      ),
        .EIC_Present      ( EIC_Present     ),
        .EIC_IAck         ( EIC_IAck        ),
        .EIC_IPL          ( EIC_IPL         ),
        .EIC_IVN          ( EIC_IVN         ),
        .EIC_ION          ( EIC_ION         )
    );
    `endif

    // ADC MAX10
    `ifdef MFP_USE_ADC_MAX10
    mfp_ahb_lite_adc_max10 adc
    (
        .clk_adc          ( clk_adc         ),
        .clk_locked       ( clk_locked      ),
        .ADC_Trigger      ( adc_trigger     ),
        .ADC_Interrupt    ( adc_int         ),
        .HCLK             ( HCLK            ),
        .HRESETn          ( HRESETn         ),
        .HADDR            ( HADDR           ),
        .HBURST           ( HBURST          ),
        .HMASTLOCK        ( HMASTLOCK       ),
        .HPROT            ( HPROT           ),
        .HSEL             ( HSEL        [5] ),
        .HSIZE            ( HSIZE           ),
        .HTRANS           ( HTRANS          ),
        .HWDATA           ( HWDATA          ),
        .HWRITE           ( HWRITE          ),
        .HRDATA           ( RDATA       [5] ),
        .HREADYOUT        ( HREADYOUT   [5] ),
        .HREADY           ( HREADY          ),
        .HRESP            ( RESP        [5] ),
    );
    `endif

    `ifdef MFP_DEMO_LIGHT_SENSOR
    mfp_ahb_lite_pmod_als als
    (
        .HCLK             ( HCLK            ),
        .HRESETn          ( HRESETn         ),
        .HADDR            ( HADDR           ),
        .HBURST           ( HBURST          ),
        .HMASTLOCK        ( HMASTLOCK       ),
        .HPROT            ( HPROT           ),
        .HSEL             ( HSEL        [6] ),
        .HSIZE            ( HSIZE           ),
        .HTRANS           ( HTRANS          ),
        .HWDATA           ( HWDATA          ),
        .HWRITE           ( HWRITE          ),
        .HRDATA           ( RDATA       [6] ),
        .HREADYOUT        ( HREADYOUT   [6] ),
        .HREADY           ( HREADY          ),
        .HRESP            ( RESP        [6] ),
        .SPI_CS           ( als_spi_cs      ),
        .SPI_SCK          ( als_spi_sck     ),
        .SPI_SDO          ( als_spi_sdo     )
    );
    `endif

endmodule

//--------------------------------------------------------------------

module ahb_decoder #(
    parameter HPORT_COUNT = 7
)(
    input  [           31:0] HADDR,
    output [HPORT_COUNT-1:0] HSEL
);

    // Decode based on most significant bits of the address

    // RAM   4 MB max at 0xbfc00000 (physical: 0x1fc00000 - 0x1fffffff)
    assign HSEL [0] = ( HADDR [28:22] == `MFP_RESET_RAM_ADDR_MATCH );

    // RAM  64 MB max at 0x80000000 (physical: 0x00000000 - 0x03FFFFFF)
    assign HSEL [1] = ( HADDR [28:26] == `MFP_RAM_ADDR_MATCH       );

    // GPIO  4 MB max at 0xbf800000 (physical: 0x1f800000 - 0x1fbfffff)
    assign HSEL [2] = ( HADDR [28:22] == `MFP_GPIO_ADDR_MATCH      );

    // UART  4 KB max at 0xb0401000 (physical: 0x10401000 - 0x10401fff)
    assign HSEL [3] = ( HADDR [28:12] == `MFP_UART_ADDR_MATCH      );

    // EIC   4 KB max at 0xb0402000 (physical: 0x10402000 - 0x10402fff)
    assign HSEL [4] = ( HADDR [28:12] == `MFP_EIC_ADDR_MATCH       );

    // ADC MAX10 4 KB max at 0xb0403000 (physical: 0x10403000 - 0x10403fff)
    assign HSEL [5] = ( HADDR [28:12] == `MFP_ADC_MAX10_ADDR_MATCH );

    // Light Sensor 4 KB max at 0xb0404000 (physical: 0x10404000 - 0x10404fff)
    assign HSEL [6] = ( HADDR [28:12] == `MFP_ALS_ADDR_MATCH       );

endmodule


module ahb_lite_1xN
#(
   parameter HDATA_WIDTH = 32,
             HADDR_WIDTH = 32,
             HPORT_COUNT = 2
)(
   // global wires
   input                                         HCLK,
   input                                         HRESETn,

   // slave port (x1)
   input                       [HADDR_WIDTH-1:0] s_HADDR,
   input                       [            2:0] s_HBURST,
   input                                         s_HMASTLOCK,
   input                       [            3:0] s_HPROT,
   input                       [            2:0] s_HSIZE,
   input                       [            1:0] s_HTRANS,
   input                       [HDATA_WIDTH-1:0] s_HWDATA,
   input                                         s_HWRITE,
   output reg                  [HDATA_WIDTH-1:0] s_HRDATA,
   output reg                                    s_HREADY,
   output reg                                    s_HRESP,

   // master ports (xN)
   output reg [HPORT_COUNT-1:0][HADDR_WIDTH-1:0] m_HADDR,
   output reg [HPORT_COUNT-1:0][            2:0] m_HBURST,
   output reg [HPORT_COUNT-1:0]                  m_HMASTLOCK,
   output reg [HPORT_COUNT-1:0][            3:0] m_HPROT,
   output reg [HPORT_COUNT-1:0]                  m_HSEL,
   output reg [HPORT_COUNT-1:0][            2:0] m_HSIZE,
   output reg [HPORT_COUNT-1:0][            1:0] m_HTRANS,
   output reg [HPORT_COUNT-1:0][HDATA_WIDTH-1:0] m_HWDATA,
   output reg [HPORT_COUNT-1:0]                  m_HWRITE,
   input      [HPORT_COUNT-1:0][HDATA_WIDTH-1:0] m_HRDATA,
   input      [HPORT_COUNT-1:0]                  m_HREADYOUT,
   output reg [HPORT_COUNT-1:0]                  m_HREADY,
   input      [HPORT_COUNT-1:0]                  m_HRESP,

   // addr decoder port
   output                      [HADDR_WIDTH-1:0] d_HADDR,
   input      [HPORT_COUNT-1:0]                  d_HSEL
);
   // addr decoder
   assign m_HSEL  = d_HSEL;
   assign d_HADDR = s_HADDR;

   // request
   always_comb
      for(int i=0; i<HPORT_COUNT; i++) begin
         m_HADDR     [i] = s_HADDR;
         m_HBURST    [i] = s_HBURST;
         m_HMASTLOCK [i] = s_HMASTLOCK;
         m_HPROT     [i] = s_HPROT;
         m_HSIZE     [i] = s_HSIZE;
         m_HTRANS    [i] = s_HTRANS;
         m_HWDATA    [i] = s_HWDATA;
         m_HWRITE    [i] = s_HWRITE;
         //m_HREADY  [i] = s_HREADY;
         m_HREADY    [i] = s_HREADY && m_HREADYOUT [1]; //TODO: SDRAM bug workaround, fix it
      end

   // responce selector
   reg [HPORT_COUNT-1:0] resp_sel;
   always_ff @(posedge HCLK or negedge HRESETn)
      if(~HRESETn)
         resp_sel <= 1;
      else 
         if(s_HREADY) resp_sel <= d_HSEL;

   // responce
   parameter OUTOFRANGE_PORT = 0;

   always_comb begin
      s_HRDATA = m_HRDATA    [OUTOFRANGE_PORT];
      s_HREADY = m_HREADYOUT [OUTOFRANGE_PORT];
      s_HRESP  = m_HRESP     [OUTOFRANGE_PORT];
      for(int i=0; i<HPORT_COUNT; i++)
         if(resp_sel[i]) begin
            s_HRDATA = m_HRDATA    [i];
            s_HREADY = m_HREADYOUT [i];
            s_HRESP  = m_HRESP     [i];
         end
   end

endmodule

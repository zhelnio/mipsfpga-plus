
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

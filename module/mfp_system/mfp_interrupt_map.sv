
module mfp_interrupt_map
#(
    parameter EIC_CHANNELS = 32
)(
    input                         SI_EICPresent,
    input                         SI_TimerInt,
    input      [             1:0] SI_SWInt,
    input                         adc_interrupt,
    input                         uart_interrupt,
    input      [             7:0] EIC_Interrupt,
    output reg [EIC_CHANNELS-1:0] EIC_input,
    output reg [             7:0] SI_Int,
    output reg [             2:0] SI_IPTI 
);
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

    // EIC connections
    always @(*) begin
        EIC_input      = '0;
        EIC_input[7]   =  SI_TimerInt;
        EIC_input[6]   =  adc_interrupt;
        EIC_input[5]   =  uart_interrupt;
        EIC_input[1]   =  SI_SWInt[1];
        EIC_input[0]   =  SI_SWInt[0];
    end

    // internal controller connections
    always @(*) begin
        if(SI_EICPresent) begin
            SI_Int    = EIC_Interrupt;
            SI_IPTI   = 3'b0;
            end
        else begin
            SI_Int    = '0;
            SI_Int[4] = adc_interrupt;
            SI_Int[3] = uart_interrupt;
            SI_IPTI   = 3'h7; //enable MIPS timer interrupt on HW5
        end
    end

endmodule

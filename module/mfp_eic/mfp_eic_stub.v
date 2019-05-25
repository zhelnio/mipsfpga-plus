
module mfp_eic_stub
#(
    parameter EIC_CHANNELS = 32
)(
    input      [ EIC_CHANNELS-1 : 0 ] EIC_input,
    output     [ 17 : 1 ]             EIC_Offset,    // connect to SI_Offset
    output     [  3 : 0 ]             EIC_ShadowSet, // connect to SI_EISS
    output     [  7 : 0 ]             EIC_Interrupt, // connect to SI_Int
    output     [  5 : 0 ]             EIC_Vector,    // connect to SI_EICVector
    output                            EIC_Present,   // connect to SI_EICPresent
    input                             EIC_IAck,      // connect to SI_IAck
    input      [  7 : 0 ]             EIC_IPL,       // connect to SI_IPL
    input      [  5 : 0 ]             EIC_IVN,       // connect to SI_IVN
    input      [ 17 : 1 ]             EIC_ION        // connect to SI_ION
);
    assign EIC_Offset    = 17'b0;
    assign EIC_ShadowSet =  4'b0;
    assign EIC_Vector    =  6'b0;
    assign EIC_Present   =  1'b0;

endmodule

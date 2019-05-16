

module lpddr2_wrapper
(
    input   clk_global,
    input   rst_global_n,

    output [9:0]  mem_ca,           // memory.mem_ca
    output [0:0]  mem_ck,           //       .mem_ck
    output [0:0]  mem_ck_n,         //       .mem_ck_n
    output [0:0]  mem_cke,          //       .mem_cke
    output [0:0]  mem_cs_n,         //       .mem_cs_n
    output [3:0]  mem_dm,           //       .mem_dm
    inout  [31:0] mem_dq,           //       .mem_dq
    inout  [3:0]  mem_dqs,          //       .mem_dqs
    inout  [3:0]  mem_dqs_n,        //       .mem_dqs_n
    input         mem_rzqin,        //       .oct_rzqin

    input         avm_clk,
    input         avm_rst_n,
    output        avm_ready,        //    avl.waitrequest_n
    input         avm_burstbegin,   //       .beginbursttransfer
    input  [26:0] avm_addr,         //       .address
    output        avm_rdata_valid,  //       .readdatavalid
    output [31:0] avm_rdata,        //       .readdata
    input  [31:0] avm_wdata,        //       .writedata
    input  [3:0]  avm_be,           //       .byteenable
    input         avm_read_req,     //       .read
    input         avm_write_req,    //       .write
    input         avm_size          //       .burstcount
);
    wire afi_half_clk;
    wire pll_locked;
    wire local_cal_success;
    wire soft_reset_n;
    wire mpfe_clk;
    wire mpfe_reset_n;

    wire avm_waitrequest_n;
    assign avm_ready = avm_waitrequest_n & mpfe_reset_n;

    lpddr2_reset lpddr2_reset (
        .clk_global                 ( clk_global        ),
        .rst_global_n               ( rst_global_n      ),
        .avm_clk                    ( avm_clk           ),
        .avm_rst_n                  ( avm_rst_n         ),
        .afi_half_clk               ( afi_half_clk      ),
        .pll_locked                 ( pll_locked        ),
        .local_cal_success          ( local_cal_success ),
        .soft_reset_n               ( soft_reset_n      ),
        .mpfe_clk                   ( mpfe_clk          ),
        .mpfe_reset_n               ( mpfe_reset_n      ) 
    );

    lpddr2 lpddr2_ctrl (
        .pll_ref_clk                ( clk_global        ),
        .global_reset_n             ( rst_global_n      ),
        .soft_reset_n               ( soft_reset_n      ),
        .afi_clk                    (                   ),
        .afi_half_clk               ( afi_half_clk      ),
        .afi_reset_n                (                   ),
        .afi_reset_export_n         (                   ),
        .mem_ca                     ( mem_ca            ),
        .mem_ck                     ( mem_ck            ),
        .mem_ck_n                   ( mem_ck_n          ),
        .mem_cke                    ( mem_cke           ),
        .mem_cs_n                   ( mem_cs_n          ),
        .mem_dm                     ( mem_dm            ),
        .mem_dq                     ( mem_dq            ),
        .mem_dqs                    ( mem_dqs           ),
        .mem_dqs_n                  ( mem_dqs_n         ),
        .avl_ready_0                ( avm_waitrequest_n ),
        .avl_burstbegin_0           ( avm_burstbegin    ),
        .avl_addr_0                 ( avm_addr          ),
        .avl_rdata_valid_0          ( avm_rdata_valid   ),
        .avl_rdata_0                ( avm_rdata         ),
        .avl_wdata_0                ( avm_wdata         ),
        .avl_be_0                   ( avm_be            ),
        .avl_read_req_0             ( avm_read_req      ),
        .avl_write_req_0            ( avm_write_req     ),
        .avl_size_0                 ( avm_size          ),
        .mp_cmd_clk_0_clk           ( mpfe_clk          ),
        .mp_cmd_reset_n_0_reset_n   ( mpfe_reset_n      ),
        .mp_rfifo_clk_0_clk         ( mpfe_clk          ),
        .mp_rfifo_reset_n_0_reset_n ( mpfe_reset_n      ),
        .mp_wfifo_clk_0_clk         ( mpfe_clk          ),
        .mp_wfifo_reset_n_0_reset_n ( mpfe_reset_n      ),
        .local_init_done            (                   ),
        .local_cal_success          ( local_cal_success ),
        .local_cal_fail             (                   ),
        .oct_rzqin                  ( mem_rzqin         ),
        .pll_mem_clk                (                   ),
        .pll_write_clk              (                   ),
        .pll_locked                 ( pll_locked        ),
        .pll_write_clk_pre_phy_clk  (                   ),
        .pll_addr_cmd_clk           (                   ),
        .pll_avl_clk                (                   ),
        .pll_config_clk             (                   ),
        .pll_mem_phy_clk            (                   ),
        .afi_phy_clk                (                   ),
        .pll_avl_phy_clk            (                   ) 
    );

endmodule


module lpddr2_reset
(
    // top side
    input      clk_global,
    input      rst_global_n,
    input      avm_clk,
    input      avm_rst_n,

    // fpga_lpddr2 side
    input      afi_half_clk,
    input      pll_locked,
    input      local_cal_success,
    output reg soft_reset_n,
    output     mpfe_clk,
    output reg mpfe_reset_n 
);
    // Altera External Memory Interface Handbook. Volume 3:
    //   soft_reset_n - Assert to cause a complete reset to the PHY, but not to the PLL that the PHY uses
    //   ...
    //   The global_reset_n and soft_reset_n signals are asynchronous
    //   ...
    //   For easiest management of reset signals, Altera recommends the following sequence at power-up:
    //   1. Initially global_reset_n, soft_reset_n, and the MPFE (Multi-Port Front End) reset signals are all asserted.
    //   2. global_reset_n is deasserted.
    //   3. Wait for pll_locked to transition high.
    //   4. soft_reset_n is deasserted.
    //   5. (Optional) If you encounter difficulties, wait for the controller signal local_cal_success to go high,
    //   indicating that the external memory interface has successfully completed calibration, before
    //   deasserting the MPFE FIFO reset signals. This will ensure that read/write activity cannot occur until
    //   the interface is successfully calibrated.

    reg soft_reset_n_buf;
    always @(posedge afi_half_clk)
        { soft_reset_n, soft_reset_n_buf } <= { soft_reset_n_buf, rst_global_n & pll_locked };

    reg a_cal_success, a_cal_success_buf;
    always @(posedge avm_clk)
        { a_cal_success, a_cal_success_buf } <= { a_cal_success_buf, local_cal_success };

    assign mpfe_clk     = avm_clk;

    always @(posedge avm_clk)
        mpfe_reset_n <= avm_rst_n & a_cal_success;

endmodule


vlib work

set p0 -sv05compat 
#-vlog01compat
set p1 +define+SIMULATION
set p2 +define+sg25

set i0 +incdir+../../../core
set i1 +incdir+../../../system_rtl
set i2 +incdir+../../../system_rtl/uart16550
set i3 +incdir+../../../testbench
set i4 +incdir+../../../testbench/sdr_sdram
set i5 +incdir+../../../testbench/mobile_ddr2

set s0 ../../../core/*.v
set s1 ../../../system_rtl/*.v
set s2 ../../../system_rtl/uart16550/*.v
set s3 ../../../testbench/*.v
set s4 ../../../testbench/sdr_sdram/*.v

set s5 ../../../system_rtl/*.sv
set s6 ../../../testbench/mobile_ddr2/*.v
set s7 ../../../boards/c5gx/lpddr*.v

# Quartus specific
# TODO: redesign
set QSYS_SIMDIR ../../../boards/c5gx/ip/lpddr2/lpddr2_sim
source $QSYS_SIMDIR/mentor/msim_setup.tcl
dev_com
com


vlog -sv $p0 $p1 $p2 $i0  $i1 $i2 $i3 $i4 $i5  $s0 $s1 $s2 $s3 $s4 $s5 $s6 $s7

vsim -L work -L work_lib -L dll0 -L oct0 -L c0 -L s0 -L p0 -L pll0 -L lpddr2 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver work.mfp_testbench

add wave -radix hex sim:/mfp_testbench/system/H*
add wave -radix hex sim:/mfp_testbench/lpddr2_wrapper/mem_*

run -all

#wave zoom full

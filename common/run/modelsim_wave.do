onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HADDR
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HRDATA
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HWDATA
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HWRITE
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HREADY
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HTRANS
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HBURST
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HCLK
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HMASTLOCK
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HPROT
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HRESETn
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HRESP
add wave -noupdate -radix hexadecimal /mfp_testbench/system/HSIZE
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_write_req
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_wdata
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_waitrequest_n
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_size
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_rst_n
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_ready
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_read_req
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_rdata_valid
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_rdata
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_clk
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_burstbegin
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_be
add wave -noupdate /mfp_testbench/lpddr2_wrapper/avm_addr
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_ca
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_ck
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_ck_n
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_cke
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_cs_n
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_dm
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_dq
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_dqs
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_dqs_n
add wave -noupdate -radix hexadecimal /mfp_testbench/lpddr2_wrapper/mem_rzqin
add wave -noupdate /mfp_testbench/IO_RedLEDs
add wave -noupdate /mfp_testbench/IO_GreenLEDs
add wave -noupdate /mfp_testbench/IO_7_SegmentHEX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1220817740 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 178
configure wave -valuecolwidth 113
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {10276711 ps} {25186239 ps}

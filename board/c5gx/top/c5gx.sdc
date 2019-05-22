#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 8 [get_ports CLOCK_125_p]
create_clock -period 20 [get_ports CLOCK_50_B5B]
create_clock -period 20 [get_ports CLOCK_50_B6A]
create_clock -period 20 [get_ports CLOCK_50_B7A]
create_clock -period 20 [get_ports CLOCK_50_B8A]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks




#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************
set_clock_groups -asynchronous -group [get_clocks {CLOCK_50_B5B}]



#**************************************************************
# Set False Path
#**************************************************************


#**************************************************************
# Set Multicycle Path
#**************************************************************
#set_multicycle_path -from {Avalon_bus_RW_Test:fpga_lpddr2_Verify|avl_address*} -to {Avalon_bus_RW_Test:fpga_lpddr2_Verify|avl_writedata*} -setup -end 6
#set_multicycle_path -from {Avalon_bus_RW_Test:fpga_lpddr2_Verify|cal_data*} -to {Avalon_bus_RW_Test:fpga_lpddr2_Verify|avl_writedata*} -setup -end 6

#set_multicycle_path -from {Avalon_bus_RW_Test:fpga_lpddr2_Verify|avl_address*} -to {Avalon_bus_RW_Test:fpga_lpddr2_Verify|avl_writedata*} -hold -end 6
#set_multicycle_path -from {Avalon_bus_RW_Test:fpga_lpddr2_Verify|cal_data*} -to {Avalon_bus_RW_Test:fpga_lpddr2_Verify|avl_writedata*} -hold -end 6


#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************




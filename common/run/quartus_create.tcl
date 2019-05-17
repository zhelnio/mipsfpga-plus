package require ::quartus::project

# create project
set project_name "system"
if {[info exists ::env(QUARTUS_PROJECT)]} {
    set project_name $env(QUARTUS_PROJECT)
}

project_new -overwrite -revision $project_name $project_name

# set project top
if {[info exists ::env(QUARTUS_TOP)]} {
    set_global_assignment -name TOP_LEVEL_ENTITY $env(QUARTUS_TOP)
} else {
    puts "QUARTUS_TOP environment variable is not set"
}

# add project files
if {[info exists ::env(QUARTUS_FILES)]} {
    foreach quartus_file $env(QUARTUS_FILES) {

        if { [string match {*.v} $quartus_file] } { 
            set_global_assignment -name VERILOG_FILE $quartus_file 
        }
        
        if { [string match {*.sv} $quartus_file] } { 
            set_global_assignment -name SYSTEMVERILOG_FILE $quartus_file 
        }

        if { [string match {*.qip} $quartus_file] } { 
            set_global_assignment -name QIP_FILE $quartus_file 
        }

        if { [string match {*.sdc} $quartus_file] } { 
            set_global_assignment -name SDC_FILE $quartus_file 
        }

        if { [string match {*.qsys} $quartus_file] } { 
            set_global_assignment -name QSYS_FILE $quartus_file 
        }

        if { [string match {*.vh}  $quartus_file] ||
             [string match {*.svh} $quartus_file] } {
                set include_dir [file dirname $quartus_file]
                set_global_assignment -name SEARCH_PATH $include_dir
        }

        if { [string match {*.hex} $quartus_file] } { 
            set_global_assignment -name HEX_FILE $quartus_file 
        }

        if { [string match {*.tcl} $quartus_file] } { 
            source $quartus_file 
        }
    }
} else { 
    puts  "QUARTUS_FILES environment variable is not set" 
}

# save project
export_assignments

project_close

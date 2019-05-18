
if {![file isdirectory work]} {
   vlib work
   vmap work work
}

if {![info exists ::env(VLOG_OPT)] } { error "VLOG_OPT environment variable is not set"  }
if {![info exists ::env(VSIM_OPT)] } { error "VSIM_OPT environment variable is not set"  }

eval vlog [ split $env(VLOG_OPT) ]
eval vsim [ split $env(VSIM_OPT) ]

#log -recursive /*

set wave_do "wave.do"

if {[file exists $wave_do] } {
    eval do $wave_do
}

run -all

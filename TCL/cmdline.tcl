;# STEP1: Create script:
;#please save follow script into cmdline.tcl
;# sample s cript : cmdline.tcl
puts "The number of command line arguments is: $argc"
puts "The name of the scriptis: $argv0"
puts "The command line arguments are: $argv"
string range $argv 1 2
;#STEP2: Call tclsh to run cmdline.tcl:

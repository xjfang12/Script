#!/bin/tclsh
set f [open sdrm.rbt r]
set wr_f [open config.bit8 w+]

while {[gets $f line] >= 0} {
  if {[string match {[01]*} $line ] == 1} {
     set tmp1 [string range $line 0 7]
     set tmp2 [string range $line 8 15]
     set tmp3 [string range $line 16 23]
     set tmp4 [string range $line 24 31]
     puts $wr_f "$tmp1 $tmp2 $tmp3 $tmp4"
     puts "Converting..."
  } else {
     puts "Searching..."
  }
}
close $f
close $wr_f
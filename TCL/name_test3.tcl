namespace eval catalog {
  proc save {file} {
    variable entries
    set f [open $file w]
    puts $f [list array set ::catalog::entries \
    [array get entries]]
    close $f
  }
  proc autocommit {interval file} {
    after $interval [namespace code [list \
      autocommit $interval $file]]
      save $file
    }
  autocommit 10000 e:/catalogDB.tcl
}


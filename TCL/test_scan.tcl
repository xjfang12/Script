proc next c {
  scan $c %c i
  format %c [expr {$i+1} ]
}

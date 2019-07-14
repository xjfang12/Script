proc forceDecimal {x} {
  set count [scan $x {%11d %c} n c]
  if {$count !=1 } {
    error "not an integer: \"$x\""
    }
  return $n
}

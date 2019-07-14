namespace eval compute {
  variable pi 3.1415927
  namespace export *
  namespace ensemble create
  namespace eval area {
    namespace export *
    namespace ensemble create 
  }
  namespace eval volume {
    namespace export *
    namespace ensemble create 
  }
}
proc compute::area::circle {radius} {
  variable ::compute::pi
  return [expr {$pi * $radius**2}]
}

proc compute::area::square {side} {
  return [expr {$side ** 2}]
}

proc compute::volume::sphere {radius} {
  variable ::compute::pi
  return [expr {4 * $pi / 3* $radius ** 3}]
}

proc compute::volume::cube {edge} {
  return [expr {$edge ** 3}]
}


package provide testp 1.0
namespace eval catalog {
  variable entries
  array set entries {}
  proc add {item} {
	  variable entries
	  incr entries($item)
  }
  proc getEntries {} {
	  variable entries
	  return [lsort [array names entries]]
  }
  proc countInstance {item} {
	  variable entries
	  return $entries($item)
  }
}


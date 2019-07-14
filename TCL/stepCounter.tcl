set counters {
   next 0
}
proc makeCounter {{step 1} {offset 0}} {
  global counters
  set id counter[dict get $counters next]
  dict incr counters next
  dict set counters $id [dict create state 0 step $step offset $offset]
  return $id
}
proc stepCounter {id} {
  global counters
  dict with counters $id {
    return [expr {[incr state $step] + $offset}]
  }
}

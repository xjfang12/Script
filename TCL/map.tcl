proc map {lambda list} {
  set result {}
  foreach item $list {
    lappend result [apply $lambda $item]
  }
  return $result
}


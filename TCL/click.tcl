proc click {period} {
  set t1 [clock clicks]
  after [expr $period * 1000]
  set t2 [clock clicks]
  puts "[expr ($t2-$t1)/$period] Clicks/Second"
}


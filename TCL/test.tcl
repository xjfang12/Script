puts "Interger ASCII"
for {set i 0} {$i <= 101} {incr i} {
  puts [format "%1\$4d     %1\$c" $i]
}

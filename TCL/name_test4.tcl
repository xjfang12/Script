rename string strCore
proc strReverse {string} {
  set result {}
  for {set i [strCore length $string]} {$i>0} {} {
    incr i -1
    append result [strCore index $string $i]
  }
  return $result
}
proc unknowStrCmd {string subcommand args} {
  puts "passing $subcommand through to strCore"
  return [list strCore $subcommand {expand} $args]
}
namespace ensemble create -command string -map {
  reverse {strReverse}
  repeat {strCore repeat}
  replace {strCore replace}
} -unknown unknowStrCmd

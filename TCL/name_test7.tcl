namespace eval ::collector {
  proc collect {command args} {
    variable accumulator {}
    puts "1 step"
    set ns [namespace parent \ 
         [namespace origin $command]]
    namespace eval $ns {
      namespace path ::collector
    }
    $command {expand} $args
    namespace eval $ns {
      namespace path{}
    }
    append accumulator "\[generated \
      [string  length $accumulator] \
        characters\]"
    return [string trimright $accumulator \n]
  }
  proc puts {args} {
    if {[llength $args] == 1} {
      variable accumulator 
      append accumulator [lindex $args 0] \n
         return
       }
       ::puts {expand} $args
     }
 }
 namespace eval ::example {
   proc makeMessage {name age} {
     puts "Hello $name"
       puts "You are $age years old"
     }
   }

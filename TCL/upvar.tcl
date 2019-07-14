proc SetPositive {varName varValue} {
	upvar $varName myvar
	if { $varValue < 0 } {
		set myvar [expr -$varValue]
	} else {
		set myvar $varValue
	}
	return $myvar
}

set x 5
set y -5

puts "Before call SetPositive:"
puts "X:$x Y:$y"

SetPositive x $x
SetPositive y $y
puts "After call SetPositive:"
puts "X: $x Y:$y\n"



proc Second {varName} {
	upvar 1 $varName z
	upvar 2 x a
	puts "In Second: Z:$z A:$a"
	set z 1
	set a 2
}


proc First {varName} {
	upvar $varName z
	puts "In First: Z:$z"
	Second z
}

First y

puts "\n After Call Fisrt: \n X:$x Y:$y\n"

proc SameName {} {
	set x 20 
	upvar #0 x global_x
	puts "In SameName:"
	puts "My X is:$x"
	puts "Global x is: $global_x"
}

SameName




#!/bin/bash

for (( var1 = 1; var1 < 15 ; var1 ++ ))
do
	if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]; then
		continue
	fi
	echo "Iteration number: $var1"
done


var1=0

while echo "while iteration: $var1"
	[ $var1 -lt 5 ]
do
	if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]; then
		continue
	fi
	echo "	Inside iteration number: $var1"
	var1=$[ $var1 + 1 ]
done

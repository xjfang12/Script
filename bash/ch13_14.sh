#!/bin/bash

for var1 in 1 2 3 4 5 6 7 8 9 10
do
	if [ $var1 -eq 5 ]; then
		break
	fi
	echo "Iteration number: $var1"
done
echo "The for loop is completed"

var1=1
while [ $var1 -lt 10 ] 
do
	if [ $var1 -eq 5 ]; then
		break
	fi
	echo "Iteration: $var1"
	var1=$[ $var1 + 1 ]
done
echo "The while loop is completed"

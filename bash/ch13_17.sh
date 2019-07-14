#!/bin/bash

for (( a = 1; a < 10; a++ ))
do
	echo "The number is $a"
done >> test23.txt
echo "The command is finished"


for state in "North Dakota" Connecticut Illinois Alabama  Tennessee
do
	echo "$state is next place to go"
done | sort
echo "This completes our travels"

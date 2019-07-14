#!/bin/bash

for (( a = 1; a < 4; a++ ))
do
	echo "Outer loop: $a"
	for (( b = 1; b < 100; b++))
	do
		if [ $b -eq 5 ]; then
			break
		fi
		echo "		Inner loop: $b"
	done
done



for (( a = 1; a < 4; a++ ))
do
        echo "Outer loop: $a"
        for (( b = 1; b < 100; b++))
        do
                if [ $b -gt 5 ]; then
                        break 2
                fi
                echo "          Inner loop: $b"
        done
done


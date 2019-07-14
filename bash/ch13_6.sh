#!/bin/bash
for file in $HOME/*
do 
	if [ -d "$file" ]; then
		echo "$file is a directory"
		ls -al $file
	elif [ -f "$file" ]; then
		echo "$file is a file"
	fi
done

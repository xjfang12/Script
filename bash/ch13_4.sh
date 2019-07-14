#!/bin/bash
file="status"
IFS=$'\n'
for test in $(cat $file)
do 
  echo "word: $test"
done

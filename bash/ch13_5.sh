#!/bin/bash
file=/etc/passwd
IFS.old=$IFS
IFS=$'\n':
for test in $(cat $file)
do 
  echo "word: $test"
done

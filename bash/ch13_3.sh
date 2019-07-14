#!/bin/bash
list="Alabama Alaska Arizona Arkansas Colorado"
list=$list" Connecticut"
for test in $list
do 
  echo "word: $test"
done

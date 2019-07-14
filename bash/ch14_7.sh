#!/bin/bash
name=$(basename $0)
if [ $# -ne 2 ]; then
  echo
  echo Usage: $name a b
  echo
else
  total=$[ $1 + $2 ]
  echo
  echo The total is $total
  echo
fi

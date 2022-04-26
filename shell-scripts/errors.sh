#!/bin/bash
#this script is to show exit status types

expr 1 + 5
echo $?

rm doodles.txt
echo $?

expr 10 + 10
echo $?
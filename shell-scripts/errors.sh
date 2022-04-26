#!/bin/bash
#this script is to show exit status types
set -e   #with this option we are telling the shell that the moment
         #that it receives an exit error stop the program right there

expr 1 + 5
echo $?

rm doodles.txt
echo $?

expr 10 + 10
echo $?
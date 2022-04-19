#!/bin/bash
#This script is intende dto show how to do simple substitution
shopt -s expand_aliases   #this line is so that the bellow alias work fine
alias TODAY="date"
alias UFILES="find /home -user cloud_user"

TODAYSDATE=`date`
USERFILES=`find /home -user cloud_user`

echo "Today's Date: $TODAYSDATE"
echo "All files Owned by USER: $USERFILES"

A=`TODAY`
B=`UFILES`
echo "with Alias, today is: $A"
echo "with Alias, UFILE is: $B"
#!/bin/bash


MYUSERNAME="username"
MYPASSWORD="password123"
STARTOFSCRIPT=`date`

echo "The current path is: $PATH"

echo "My login name is:$MYUSERNAME"
echo "My login password is: $MYPASSWORD"
echo "I started this script at: $STARTOFSCRIPT"

ENDOFSCRIPT=`date`

echo "I ended this script at:$ENDOFSCRIPT"
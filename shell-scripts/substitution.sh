#!/bin/bash
#This script is intende dto show how to do simple substitution

TODAYSDATE=`date`
USERFILES=`find /home -user cloud_user`

echo "Today's Date: $TODAYSDATE"
echo "All files Owned by USER: $USERFILES"
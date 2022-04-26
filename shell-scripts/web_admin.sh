#!/bin/bash

# Script to allow our web_admin users to perform some 'yum' checks
# Usage: ./web_admin.sh <action> <package>
# check-updates: No package to specify
# check-installed: Please specify a package name
# check-available: Please specify a package name

# Define our variables
# Script inputs
ARG1=$1
ARG2=$2

# Other Variables
YUM=/usr/bin/yum

# Let's go!

if [ "$ARG1" = "check-updates" ] ; then
	$YUM check-update >> web_admin.log
	YUM_RESULT=$?
		case $YUM_RESULT in
			100)
				echo "Updates available!"
				exit 111
				;;
			0)
				echo "No updates available!"
				exit 112
				;;
			1)
				echo "Error!"
				exit 113
				;;
		esac
					

elif [ "$ARG1" = "check-installed" ] ; then
	$YUM list --installed $ARG2 >> web_admin.log 2>&1
	YUM_RESULT=$?
		case $YUM_RESULT in
			0)
				echo "Package is installed!"
				exit 114
				;;
			1)
				echo "Package is NOT installed or not available!"
				exit 115
				;;
		esac

elif [ "$ARG1" = "check-available" ] ; then
	$YUM list --available $ARG2 >> web_admin.log 2>&1
	YUM_RESULT=$?
		case $YUM_RESULT in
			0)
				echo "Package is available!"
				exit 116
				;;
			1)
				echo "Package is NOT available or does not exist!"
				exit 117
				;;
		esac

else
	echo "INVALID OPTIONS.  Please specify one of the following:"
	echo "check-updates: No package to specify"
	echo "check-installed: Please specify a package name"
	echo "check-available: Please specify a package name"
	exit 118
fi

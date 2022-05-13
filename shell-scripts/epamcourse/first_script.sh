#!/bin/bash
echo "My first Bash script!"

echo my second line!

echo "Hello" $0 $1 $2      #arguments provided in the command line

echo $*              #resolves "$1 $2 "

echo "$@"            #resolves "$1" "$2"

echo $#              #number of positional arguments

echo "the name of this script is ${0}"
echo 'the name of this script is ${0}'


cut -d: -f 1 /etc/passwd #it will extract a field from a file

cat |wc -l  #Control+D is the end of file indicator

ls -la |wc -l

read FIRSTNAME LASTNAME

IFS=',' read FIRSTNAME LASTNAME

while read LINE;do echo "+++ ${LINE} +++";done

cat /etc/passwd |while read LINE;do echo "+++ ${LINE} +++";done
cat /etc/passwd |while read LINE;do if grep ':x:' then echo ${LINE};done

while true;do echo -n -e "$(date)\r";sleep 1s;done

NAMES=$(cat /etc/passwd |grep 'mendez' |cut -d: -f 1)

cat /proc/cpuinfo
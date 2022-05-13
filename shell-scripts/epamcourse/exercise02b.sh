#Print the name of the highest-paid employee:

fileemployees=$1
filesalaries=$2

####################################################
## In this part we validate that the files provided in the command line exists##############
if [ ! -e $fileemployees ] || [ "$fileemployees" == "" ]
then
  echo "File NOT exists"
  exit 2
elif [ ! -e $filesalaries ] || [ "$filesalaries" == "" ]
then
  echo "File NOT exists"
  exit 2
fi
#############################################################



### with these 2 instructions we sort the salaries file and extract the last 2 rows 1 for the number id
#### and the other for the salary
number=$(cat $filesalaries | sort -k 2 -n -t, |tail -n 1|cut -d, -f 1)
salary=$(cat $filesalaries | sort -k 2 -n -t, |tail -n 1|cut -d, -f 2)
#############################################################################



####In this part we seek in the salaries.txt file for numberid and we get the employ name
while read line; do  
  workid=$(echo ${line} | cut -d, -f 1 )
  name=$(echo ${line} | cut -d, -f 2 )
  
  if [ $workid == $number ]
  then  
    #echo $workid
    echo "this employee: $name , makes the most of all with: $salary"
    exit 0
  fi
  
done < $fileemployees
##########################
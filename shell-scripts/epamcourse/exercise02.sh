#Print the name of the highest-paid employee:

fileemployees=$1
filesalaries=$2

echo $fileemployees
echo $filesalaries

#if test -e $fileemployees
#then
#  echo "File ${fileemployees} exists"  
#else
#  echo "File ${fileemployees} NOT exists"  
#  exit 2
#fi

#if test -e $filesalaries
#then
#  echo "File ${filesalaries} exists"  
#else
#  echo "File ${filesalaries} NOT exists"  
#  exit 2
#fi


if [ -a $fileemployees ] && [ -a $filesalaries ]
then
  echo "File exists"
else
  echo "File NOT exists"
  exit 2
fi

n=1
higher=10
salary=0

while read line; do
  # reading each line
  #echo ${line}
  workid=$(echo ${line} | cut -d, -f 1)
  salary=$(echo ${line} | cut -d, -f 2)
  
  #echo "this is the ${salary}"
  if [ $n != 1 ]
  then
    #if [ "$higher" -lt "$salary" ]
    
    myvar=echo ${salary//[[:blank:]]/} 
    echo $myvar
    if [[ 5 -lt "$higher" ]]
    then
        #$higher=$salary
        #echo $salary
        echo "hello"
    fi
  fi
  n=$((n+1))
done < "$filesalaries"

echo "Higher salary ${higher}"
#cut -d, -f 2 $filesalaries #it will extract a field from a file


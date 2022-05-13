#!/bin/bash
fileemployees="$1"   # In order to avoid issues with shell injection or issues 
filesalaries="$2"    # with spaces (esp. on Windows), I would wrap $1 and $2 with "" ("$1")
age="$3"

check_file() {    
    if [ ! -e $1 ] || [ "$1" == "" ]  ;then     
         echo "File ${1} NOT exists" >&2   # It's good to print errors to stderr
         exit 2
     fi
}

check_age(){    
    if [ "$1" == "" ]   ;then     
         echo "you need to enter the age ${1} NOT exists" >&2   # It's good to print errors to stderr
         exit 2
    fi
    case $1 in
    ''|*[!0-9]*) echo bad number; exit 2 ;;
    *) echo all data is valid moving on ;;
    esac

}

check_file $fileemployees
check_file $filesalaries
check_age $age

# You can also use "while IFS=, read workid name; do" to avoid extracting columns separately
IFS=','
i=0
ACUM=0
number=0
#declare -i SALARY=0

while read -r EMP_ID FULL_NAME AGE PHONE; do
    if (( i == 1 )); then
        if [[ $AGE > $age ]]; then
            echo "${EMP_ID} ${FULL_NAME} ${AGE} is major than ${age}"
            while read -r  EMP_ID2 SALARY; do
                if [[ $EMP_ID == $EMP_ID2 ]]; then
                    echo "salary of ${EMP_ID} is ${SALARY}"
                    #we are reading the salaries from the file and I was getting a weird error while trying
                    #to do the addition of 2 numbers.
                    #It turns out the number came with a return carriage which prevents the addition '\r'
                    #to fix it I ran the below expansion shown by Pawel
                    number=$SALARY   #This number comes from the file
                    #printf '%q\n' "$number"
                    number=${number:0:-1}  #this part remove the \r from the variable                   
                    #printf '%q\n' "$number"                   
                    ACUM=$((ACUM+number))
                    break
                fi
            done < $filesalaries
        fi
    else
        i=1
    fi
done < $fileemployees

echo "the result is : ${ACUM}"

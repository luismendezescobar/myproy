#Write a script that will:
#• ask the user for employee data
#◦ first/last name
#◦ position
#◦ salary
#• write the data as one row in a CSV file
#• ask the user, whether to enter another employee

CONTINUE="y"
FILENAME="employee.txt"

echo "First name,Last name,position,salary" > $FILENAME

while [ "${CONTINUE}" == "y" ]
do
  echo "Please enter employee info"
    echo -n "First Name:"; read NAME
    echo -n "Last Name:"; read LASTNAME
    echo -n "Position:"; read POSITION
    echo -n "Salary:"; read SALARY 
    echo -n "Continue (y/n)?";read CONTINUE     
    echo "${NAME},${LASTNAME},${POSITION},${SALARY}" >>$FILENAME
done


n=1
while read line; do
    # reading each line
    echo "Line No. $n : $line"
    n=$((n+1))
done < $FILENAME

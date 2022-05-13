#!/bin/bash

echo "Enter your name:"
read NAME
if [ "${NAME}" == "" ]
then
    echo "Name cannot be empty!"
else
    echo "Hello, ${NAME}!"
    TODAY=`date +%A`
    echo "Today is ${TODAY}"
fi


case "${NAME}" in
  "Luis")
  echo "You look gorgeus today!"
  ;;
  "Bob")
  echo "Nice suite!"
  ;;
  *)
  echo "Pleased to meet you!"
esac

echo "Seasons:"
for SEASON in "Spring" "Summer" "Fall" "Winter"
do
  echo "${SEASON}"
done


say_bye() {
  echo "Bye, ${1}!"
}
say_bye ${NAME}


echo "Enter your name again:"
read NAME
while [ "${NAME}" == "" ]
do
  echo "Enter your name again:"
  read NAME
done

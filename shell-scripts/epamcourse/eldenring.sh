#!/bin/bash

#echo "Hey, do you like coffee? (y/n)"
#read coffee
#if [[ $cofee == "y" ]]; then
#    echo "You're awesome"
#else
#    echo "Leave right now!!!"
#fi

#First beast battle

#if [[ 2 >= 1 ]]; then
#    echo "This is true"
#    exit
#fi

echo "YOU DIED GAME!!!"

echo "Welcome gamer, please select your starting class:
1 - Samurai
2 - Prisioner
3 - Prophet"

read class

case $class in 

    1)
        type="Samurai"
        hp=10
        attack=20
        ;;
    2)
        type="Prisoner"
        hp=20
        attack=4
        ;;
    3)
        type="Prophet"
        hp=30
        attack=1
        ;;

esac

echo "You chosen the following specs
type=${type}
hp=${hp}
attack=${attack}
GOOD LUCK!!"









validate_entry() {    
    if [[ $1 < 0 || $1 >1 ]]  ;then     
         echo "Invalid number ${1} " >&2   # It's good to print errors to stderr
         exit 2
     fi
}

validate_entry2() {    
    if [[ $1 == "coffee" ]]; then     
        return
    elif [[ $1 < 1 || $1 >10 || $1 != "coffee" ]]  ;then     
         echo "Invalid number ${1} " >&2   # It's good to print errors to stderr
         exit 2
    fi
}



echo "Your first beast approaches. Prepare to battle. Pick a number between 0-1. (0/1)"
read gamer

validate_entry $gamer

beast=$(( $RANDOM %2 ))

if [[ $gamer == $beast  ]]; then
    echo "You win!!!. Beast number was ${beast} "

else
    echo "you died. Beast number was ${beast}"
    exit 1
fi

#Second beast battle
margit=$(( $RANDOM %10 +1 ))
echo "Your second beast approaches. Prepare to battle. Pick a number between 1-10. (1/10)"
read gamer
validate_entry2 $gamer

if [[ $gamer == $margit || $gamer == "coffee"  ]]; then
    echo "You win!!!. Beast number was ${margit} "

else
    echo "you died. Beast number was ${margit}"
fi
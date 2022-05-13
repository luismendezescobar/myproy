echo -n "Please enter your Name:"; read NAME
echo -n "Please enter your age:"; read AGE
echo "Hello, ${NAME} you are ${AGE} years old"

GETRICH=$((( $RANDOM %15 ) + $AGE ))

echo "Hi Luis, you are going to become reach at ${GETRICH} years old"
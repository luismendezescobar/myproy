
while read LINE
do
    if grep ':x:' LINE
        then 
            echo ${LINE} 
    fi
done



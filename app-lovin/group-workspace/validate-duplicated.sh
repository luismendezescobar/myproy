#!/bin/bash
grep -oP '(?<=^|\n)[^\n]*(?= = )' 02-terraform.tfvars | sort | uniq -d| sed 's/^[ \t]*//' > groups_duplicated.txt
duplicated=0
declare -a ARRAY_N=()
while read j
do 
    cont_line=cont_line+1
    if [[ $j != 'owners' && $j != 'members' && $j != 'managers' ]]; then
        duplicated=1
        ARRAY_N+=($j)         
    fi
done < ./groups_duplicated.txt

rm ./groups_duplicated.txt

if [[ $duplicated == 1 ]]; then
    echo "the following group(s) might be duplicated:"
    # Iterate over the array
    for item in "${ARRAY_N[@]}"
    do
        echo $item
    done
else
    echo "no duplicated groups where found, you may continue"
fi


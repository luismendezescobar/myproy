#!/bin/bash
grep -oP '(?<=^|\n)[^\n]*(?= = )' 02-terraform.tfvars | sort | uniq -d| sed 's/^[ \t]*//' > groups_duplicated.txt
cont_line=0
duplicated=0
while read j
do 
    cont_line=cont_line+1
    if [[ $j != 'owners' && $j != 'members' && $j != 'managers' ]]; then
        duplicated=1
        break
    fi
done < ./groups_duplicated.txt

rm ./groups_duplicated.txt
echo "the following group might be duplicated: $j"


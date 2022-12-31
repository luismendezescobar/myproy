#!/bin/bash
# Script to retrieve GCP IAM roles, users and serviceaccounts
# Author - Luis Mendez - 12/22/2022

echo 'project-name,roles/rolename,user:username-and-serviceaccounts' > iamlist.csv
prjs=( $(gcloud projects list | sed -n "/PROJECT_ID/p"|awk {'print $2'}) )
for i in "${prjs[@]}"
	do
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		echo "Collecting IAM roles & users for Project: $i"
		echo $(gcloud projects get-iam-policy $i --format="table(bindings)[0]" | sed -e 's/^\w*\ *//'|tail -c +2 |python reformat.py $i >> iamlist.csv)			
	done
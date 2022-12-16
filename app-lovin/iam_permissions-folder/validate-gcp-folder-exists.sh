#!/bin/bash
#validate if a file exists
count=`ls -1 ./files-iam-for-folder/*.json 2>/dev/null | wc -l`
if [ $count == 0 ]
then 
echo "there are no files of .json type in the files-project directory"
FOLDER_FOUND=1  # we assing 1 because if we want to delete the last project in the folder
echo 1 > ./folder_found.txt
echo "last file" > ./folder_details.txt
else 

  for file in ./files-iam-for-folder/*.json; do   #loop to extract the group name from all the json files in the directory:      
      echo "folder name again: $file"
      FOLDER_NAME=$(basename -s .json $file)         #this is to remove the extension in the file name

      echo "this is the folder name $FOLDER_NAME"
      #with gcloud we search for the gcp folder
      RESULT_FOLDER=$(gcloud resource-manager folders describe $FOLDER_NAME --format='value(displayName)')
      
      echo "this is the result folder: $RESULT_FOLDER"
      if [[ ${#RESULT_FOLDER} -gt 0 ]]; then
        echo "this is what I found $RESULT_FOLDER"
        FOLDER_FOUND=1
        echo 1 > ./folder_found.txt
        echo "group found" > ./folder_details.txt
      else
        echo "I could not found the folder called $FOLDER_NAME" > ./folder_details.txt
        FOLDER_FOUND=0
        echo 0 > ./folder_found.txt
        break
      fi    
  done

  echo "this is the final value of FOLDER_FOUND: $FOLDER_FOUND"

fi

#https://stackoverflow.com/questions/57903836/how-to-fail-a-job-in-github-actions
#https://stackoverflow.com/questions/70689512/terraform-check-if-resource-exists-before-creating-it
#this script should be called with source ./validate-group
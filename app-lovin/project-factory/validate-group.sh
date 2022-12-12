
#validate if a file exists
count=`ls -1 ./files-project/*.json 2>/dev/null | wc -l`
if [ $count == 0 ]
then 
echo "there are no files of .json type in the files-project directory"
GROUP_FOUND=0
else 

  for file in ./files-projects/*.json; do   #loop to extract the group name from all the json files in the directory:
      #echo "$(basename "$file")"   
      GROUP_NAME=$(jq '.group_name' $file)  #we use jq to extract the file name from the field called group_name inside the json file
      v1=${GROUP_NAME::-1}      #remove last character
      GROUP_NAME=${v1:1}        #remove first character
      GROUP_NAME="$GROUP_NAME@luismendeze.com"        #add the @luismendeze.com


      echo "this is the group name $GROUP_NAME"
      #with gcloud we search for the group
      RESULT_GROUP=$(gcloud identity groups search --labels="cloudidentity.googleapis.com/groups.discussion_forum" --organization=luismendeze.com |sed -n "/$GROUP_NAME/p")
      if [[ ${#RESULT_GROUP} -gt 0 ]]; then
        echo "this is what I found $RESULT_GROUP"
        GROUP_FOUND=1
      else
        echo "I could not found the group called $GROUP_NAME"
        export GROUP_FOUND=0
        break
      fi    
  done

  echo "this is the final value of GROUP_FOUND: $GROUP_FOUND"

fi

#https://stackoverflow.com/questions/57903836/how-to-fail-a-job-in-github-actions
#https://stackoverflow.com/questions/70689512/terraform-check-if-resource-exists-before-creating-it
#this script should be called with source ./validate-group
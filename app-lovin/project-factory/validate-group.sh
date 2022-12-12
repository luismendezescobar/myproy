GROUP_NAME="gcp-new-lui@luismendeze.com"

#extract the group name:

for file in ./*.json; do
    echo "$(basename "$file")"
    GROUP_NAME=$(jq '.group_name' $file)
    v1=${GROUP_NAME::-1}      #remove last character
    GROUP_NAME=${v1:1}        #remove first character
    GROUP_NAME="$GROUP_NAME@luismendeze.com"


    echo "this is the group name $GROUP_NAME"

    RESULT_GROUP=$(gcloud identity groups search --labels="cloudidentity.googleapis.com/groups.discussion_forum" --organization=luismendeze.com |sed -n "/$GROUP_NAME/p")
    if [[ ${#RESULT_GROUP} -gt 0 ]]; then
      echo "this is what I found $RESULT_GROUP"
      GROUP_FOUND=1
    else
      echo "I could not found the group called $GROUP_NAME"
      GROUP_FOUND=0
      break
    fi    
done

echo "this is the final valud of GROUP_FOUND: $GROUP_FOUND"




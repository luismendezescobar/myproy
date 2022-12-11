GROUP_NAME="new-luis@luismendeze.com"
RESULT_GROUP=$(gcloud identity groups search --labels="cloudidentity.googleapis.com/groups.discussion_forum" --organization=luismendeze.com |sed -n "/$GROUP_NAME/p")

if [[ ${#RESULT_GROUP} -gt 0 ]]; then
  echo "this is what I found $RESULT_GROUP"
else
  echo "I could not found the group called $GROUP_NAME"
fi
#!/bin/bash

# Set the project ID
project_id=$1

# Get the user email from the command line
user_email=$2

# Get all roles assigned to the user in the project
roles=($(gcloud projects get-iam-policy $project_id --filter="bindings.members:$user_email" --flatten="bindings[].members" --format="table(bindings.role)"|grep -v "^$" | cut -d ' ' -f2- ))
echo "here are the roles ${roles[@]}"
# Iterate through all roles and remove them for the user
for role in "${roles[@]}"; do
    gcloud projects remove-iam-policy-binding $project_id --member="user:$user_email" --role=$role
    echo "role $role has been removed."
done

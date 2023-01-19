#!/bin/bash

# Set the project ID
project_id="pf-tnt-dev"

# Get the user email from the command line
user_email=$1

# Get all roles assigned to the user in the project
roles=($(gcloud projects get-iam-policy $project_id --format='value(bindings.role)' --filter='bindings.members:$user_email'))

# Iterate through all roles and remove them for the user
for role in "${roles[@]}"; do
    gcloud projects remove-iam-policy-binding $project_id --member=$user_email --role=$role
done

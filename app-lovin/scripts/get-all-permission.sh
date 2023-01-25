#!/bin/bash

# Set the project ID
project_id=$1

# Get all user and roles in the project
gcloud projects get-iam-policy $project_id --format='table(bindings.members, bindings.role)' >"'$project_id'_permissions.txt"

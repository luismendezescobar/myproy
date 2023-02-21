#!/bin/bash

#bash shell script to get project id and parent id using the gcloud command?

# Replace with the path to the input file containing project IDs
INPUT_FILE="input.txt"

# Replace with the path to the output CSV file
OUTPUT_FILE="output.csv"

# Write the CSV header to the output file
echo "Project ID,Parent ID" > $OUTPUT_FILE

# Loop over each project ID in the input file
while read -r project_id; do
  # Run the gcloud command and capture the output
  output=$(gcloud projects describe $project_id --format='csv[no-heading](projectId, parent.id)')

  # Write the output to the CSV file
  echo "$output" >> $OUTPUT_FILE
done < "$INPUT_FILE"

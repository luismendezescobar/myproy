import csv
import json
import shutil

# Replace with the path to the CSV file containing the fields
CSV_FILE = "fields.csv"

# Replace with the path to the template JSON file
TEMPLATE_FILE = "template.json"

# Read the fields from the CSV file
with open(CSV_FILE, "r") as csvfile:
    reader = csv.reader(csvfile)
    fields = next(reader)

# Set the output JSON file name from the first field in the CSV file
output_file = fields[0] + ".json"

# Copy the template JSON file to the output file
shutil.copyfile(TEMPLATE_FILE, output_file)

# Load the copied JSON file into a dictionary
with open(output_file, "r") as jsonfile:
    data = json.load(jsonfile)

# Set the values of the keys in the dictionary
data["key1"] = fields[0]
data["key2"] = fields[1]
data["key3"] = fields[2]

# Write the updated dictionary to the output file
with open(output_file, "w") as jsonfile:
    json.dump(data, jsonfile, indent=4)

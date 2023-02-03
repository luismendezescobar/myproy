#!/usr/bin/env python3

import os
import json
import subprocess
import sys


def validate_keys_exists(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)
        org_id = data.get('org_id', None)
        billing_account = data.get('billing_account', None)
        folder_id = data.get('folder_id', None)
        
        if org_id and billing_account and folder_id:
            print(f"org_id: {org_id}")
            print(f"billing_account: {billing_account}")
            print(f"folder_id: {folder_id}")
            return 0
        else:
            #print("One or more keys were not found in the file.")
            return 1








directory = '../../files-projects'

for filename in os.listdir(directory):
    if filename.endswith('.json'):
        file_path = os.path.join(directory, filename)
        
        if(validate_keys_exists(file_path)):
            print(f"One or more keys were not found in the file.{filename}")
            sys.exit(1)

        
        
        with open(file_path, 'r') as f:
            data = json.load(f)
            org_id = data.get('org_id')
            billing_account = data.get('billing_account')
            folder_id = data.get('folder_id')
            if org_id=="":
                print(f"org_id is in blank, please enter a valid org_id. File:{filename}")                        
            if billing_account=="":
                print(f"billing_account is in blank, please enter a valid billing_account. File:{filename}")                        
            if folder_id=="":
                print(f"folder_id is in blank, please enter a valid folder_id. File:{filename}")                        


            print(f"org_id: {org_id}, billing_account: {billing_account}, folder_id: {folder_id}")

            result = subprocess.run(['python', 'preconditions.py','--org_id',org_id,'--billing_account',billing_account,'--folder_id',folder_id], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            print(f"Exit code: {result.returncode}")

            if result.returncode != 0:
                print(f"Child script failed. Please validate the file:{filename}")
                sys.exit(1)
            else:
                print(f"Child script succeeded. Project:{filename}")  
                #sys.exit(0)



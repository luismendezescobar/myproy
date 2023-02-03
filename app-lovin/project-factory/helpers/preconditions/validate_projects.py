#!/usr/bin/env python3

import os
import json
import subprocess
import sys


directory = '../../files-projects'

for filename in os.listdir(directory):
    if filename.endswith('.json'):
        file_path = os.path.join(directory, filename)
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
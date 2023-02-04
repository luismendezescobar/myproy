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
        svpc_host_project_id = data.get('svpc_host_project_id', None)   
        folder_id = data.get('folder_id', None)        
        labels = data.get('labels', None)
        auto_create_network = data.get('auto_create_network', None)
        shared_vpc_subnets = data.get('shared_vpc_subnets', None)
        activate_apis = data.get('activate_apis', None)
        essential_contacts = data.get('essential_contacts', None)
        
        
        if org_id and billing_account and svpc_host_project_id and folder_id and labels and auto_create_network and shared_vpc_subnets and activate_apis and essential_contacts:
            #good, all the keys are there..
            return 0
        else:
            #print("One or more keys were not found in the file.")
            print(org_id,billing_account,svpc_host_project_id,folder_id,labels,auto_create_network,shared_vpc_subnets,activate_apis,essential_contacts)
            return 1


directory = '../../files-projects'

for filename in os.listdir(directory):
    if filename.endswith('.json'):
        file_path = os.path.join(directory, filename)
        
        if(validate_keys_exists(file_path)):
            with open("file_details.txt", "w") as f:                
                print(f"One or more keys were not found in the file: {filename}")
                f.write(f"One or more keys were not found in the file: {filename}")
                with open("result.txt", "w") as g:
                    g.write("1")                                
                sys.exit(1)

        
        
        with open(file_path, 'r') as f:
            data = json.load(f)
            org_id = data.get('org_id')
            billing_account = data.get('billing_account')
            folder_id = data.get('folder_id')
            
            with open("file_details.txt", "w") as f: 
                if org_id=="":
                    print(f"org_id is in blank, please enter a valid org_id. File:{filename}")
                    f.write(f"org_id is in blank, please enter a valid org_id. File:{filename}")                        
                if billing_account=="":
                    print(f"billing_account is in blank, please enter a valid billing_account. File:{filename}")                        
                    f.write(f"billing_account is in blank, please enter a valid billing_account. File:{filename}")
                if folder_id=="":
                    print(f"folder_id is in blank, please enter a valid folder_id. File:{filename}")
                    f.write(f"folder_id is in blank, please enter a valid folder_id. File:{filename}")                        
                with open("result.txt", "w") as g:
                    g.write("1")                                
                sys.exit(1)

            print(f"org_id: {org_id}, billing_account: {billing_account}, folder_id: {folder_id}")

            result = subprocess.run(['python', 'preconditions.py','--org_id',org_id,'--billing_account',billing_account,'--folder_id',folder_id], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            print(f"Exit code: {result.returncode}")

            if result.returncode != 0:
                print(f"Child script failed. Please validate the file:{filename}")
                sys.exit(1)
            else:
                print(f"Child script succeeded. Project:{filename}")  
                #sys.exit(0)



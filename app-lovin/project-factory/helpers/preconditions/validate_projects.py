#!/usr/bin/env python3

import os
import json
import subprocess
import sys

####### this function will make sure that a minimum set of keys exists in the file 
#these keys are:
# org_id, billing_account, svpc_host_project_id, folder_id, labels, auto_create_network, 
# shared_vpc_subnets, activate_apis, essential_contacts
#######
def validate_keys_exists(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)                
        if "org_id" in data and "billing_account" in data and "svpc_host_project_id" in data and "folder_id" in data and "labels" in data and "auto_create_network" in data and "shared_vpc_subnets" in data and "activate_apis" in data and "essential_contacts" in data:
            #good, all the keys are there..
            return 0
        else:
            #print("One or more keys were not found in the file.")            
            return 1
            

directory = '../../files-projects'
### in this part we iterate over all the directory with the json files
for filename in os.listdir(directory):
    print(os.listdir(directory))
    if filename.endswith('.json'):
        #print(filename)
        file_path = os.path.join(directory, filename)
        ### in this part we validate that all the required keys exists, so we call the function validate_keys_exists
        if(validate_keys_exists(file_path)):
            with open("file_details.txt", "w") as f:                
                print(f"One or more keys were not found in the file: {filename}")
                f.write(f"One or more keys were not found in the file: {filename}")
                with open("result.txt", "w") as g:
                    g.write("1")                                
                sys.exit(1)
        
        ### here we open each one of the files and validate that keys are not in blank
        ### we only care of 3 keys: org_id, billing_account, folder_id, auto_create_network
        ###
        with open(file_path, 'r') as f:
            data = json.load(f)
            org_id = data.get('org_id')
            billing_account = data.get('billing_account')
            folder_id = data.get('folder_id')
            svpc_host_project_id = data.get('svpc_host_project_id')
            auto_create_network=data.get('auto_create_network')
            
            final_result=0
            with open("file_details.txt", "w") as g: 
                if org_id=="":
                    print(f"org_id is in blank, please enter a valid org_id. File:{filename}")
                    g.write(f"org_id is in blank, please enter a valid org_id. File:{filename}")                        
                    final_result=1
                if billing_account=="":
                    print(f"billing_account is in blank, please enter a valid billing_account. File:{filename}")                        
                    g.write(f"billing_account is in blank, please enter a valid billing_account. File:{filename}")
                    final_result=1
                if folder_id=="":
                    print(f"folder_id is in blank, please enter a valid folder_id. File:{filename}")
                    g.write(f"folder_id is in blank, please enter a valid folder_id. File:{filename}")                        
                    final_result=1
                if auto_create_network=="":
                    print(f"auto_create_network is in blank, please enter a valid value like true or false. File:{filename}")
                    g.write(f"folder_id is in blank, please enter a valid folder_id. File:{filename}")                        
                    final_result=1
                #special validation only for auto_create_network value, it must be either true or false
                if auto_create_network!="true" and auto_create_network!="false":
                    print(f"auto_create_network values must be either: true or false. File:{filename}")
                    g.write(f"auto_create_network values must be either: true or false. File:{filename}")
                    final_result=1                        
                
                if final_result==1:
                    with open("result.txt", "w") as h:
                        h.write("1")                                
                    sys.exit(1)

            ## from here is where we are going to run the other script that is going to validate if the values
            ## provided to the keys: org_id, billing_account and folder_id exist inside of the google cloud organization
            ## these 3 keys would be validated in initial "if", in the "else" part it will be validated the initial 3 keys
            ## plus the shared vpc host id represented by the variable: svpc_host_project_id
            print(f"org_id: {org_id}, billing_account: {billing_account}, folder_id: {folder_id}")
            if svpc_host_project_id=="":            
                result = subprocess.run(['python', 'preconditions.py','--org_id',org_id,'--billing_account',billing_account,'--folder_id',folder_id], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                print(f"Exit code: {result.returncode}")
                if result.returncode != 0:
                    print(f"Child script failed. Please validate the file:{filename}")                    
                    with open("file_details.txt", "w") as g: 
                        g.write(f"either the org_id,billing_account or folder_id are invalid. Please validate the file:{filename}")
                    with open("result.txt", "w") as h:
                        h.write("1")       
                    sys.exit(1)
                else:
                    print(f"Child script succeeded. Project:{filename}")  
                    with open("result.txt", "w") as h:
                        h.write("0")       
                    sys.exit(0)
            else:
                result = subprocess.run(['python', 'preconditions.py','--org_id',org_id,'--billing_account',billing_account,'--folder_id',folder_id,'--shared_vpc',svpc_host_project_id], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                if result.returncode != 0:
                    print(f"Child script failed. Please validate the file:{filename}")                    
                    with open("file_details.txt", "w") as g: 
                        g.write(f"either the org_id,billing_account,folder_id or svpc_host_project_id are invalid. Please validate the file:{filename}")
                    with open("result.txt", "w") as h:
                        h.write("1")       
                    sys.exit(1)
                else:
                    print(f"Child script succeeded. Project:{filename}")  
                    with open("result.txt", "w") as h:
                        h.write("0")       





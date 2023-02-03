#!/usr/bin/env python3

import os
import json

directory = '/path/to/directory'

for filename in os.listdir(directory):
    if filename.endswith('.json'):
        file_path = os.path.join(directory, filename)
        with open(file_path, 'r') as f:
            data = json.load(f)
            org_id = data.get('org_id')
            billing_account = data.get('billing_account')
            folder_id = data.get('folder_id')
            print(f"org_id: {org_id}, billing_account: {billing_account}, folder_id: {folder_id}")

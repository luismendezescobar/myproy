import base64
import json
from datetime import datetime
from google.cloud import storage
from google.cloud import secretmanager
import requests


def process_log_entry(data, context):    
    #this block loads the alert as it comes from pubsub
    data_buffer = base64.b64decode(data["data"])
    #log_entry = json.loads(data_buffer)    
    # convert into JSON:
    #y = json.dumps(log_entry)
    print("hello there, we're entering the cloud function")
    
    print(data_buffer)




#we are going to need this to install the ops agent
#https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent/installation
import base64
import json
from datetime import datetime
from google.cloud import storage
from google.cloud import secretmanager
import requests

#this part in which we are getting the secret can be written outside of the cloud function that way 
#you can save in calls as this block will be executed only the first time the cloud function was executed
client = secretmanager.SecretManagerServiceClient()
secret_name = "my-secret"
resource_name = {"name":f"projects/data-proc-277723/secrets/{secret_name}/versions/latest"}
response = client.access_secret_version(resource_name)
secret_string = response.payload.data.decode("UTF-8")

def process_log_entry(data, context):
    
    #this block loads the alert as it comes from pubsub
    data_buffer = base64.b64decode(data["data"])
    log_entry = json.loads(data_buffer)
    print("Hello there, this is the instance name:")
    print(log_entry['labels']['compute.googleapis.com/resource_name']) ##the output would be instance-1  , see below json file with the alert
    #{'insertId': '4jk88amodk3vszyi5', 'labels': {'compute.googleapis.com/resource_name': 'instance-1'}, 'logName': 'projects/playground-s-11-b4968a10/logs/service-now-test', 'receiveTimestamp': '2021-07-19T22:56:20.098794931Z', 'resource': {'labels': {'instance_id': '1913782471889538009', 'project_id': 'playground-s-11-b4968a10', 'zone': 'us-central1-a'}, 'type': 'gce_instance'}, 'textPayload': 'Cloud router is down', 'timestamp': '2021-07-19T22:56:14.952948355Z'}
    print(log_entry["textPayload"]) #output will Cloud router is down
    #######################################################
    #note, storage, and files must exist before executing the cloud function    
    #in this block we are going to update the file (cloud-router-down.txt) in the bucket(mybucket-7-19) with the current date where this event happened.
    client = storage.Client()
    bucket = client.get_bucket("mybucket-7-21")
    blob = bucket.get_blob("cloud-router-down.txt")
    now = datetime.now()
    dt = now.strftime("%Y-%m-%d %H:%M:%S")
    previous_date = blob.download_as_string()   #before updating the file, it will download the previous date (if any) where this same event happened.
    print(f"Last date and time -  router is down - {previous_date}") #output: Last date and time - router is down - b'2021-07-21 15:14:19'
    blob.upload_from_string(dt)
    ##########################################################
    
    #in this block we are going to gather from write-to-snow.txt this can be either 1 or 0 (the first time the file was uploaded I set it with value of 1)
    blob = bucket.get_blob("write-to-snow.txt")
    cani = str(blob.download_as_string())
    print(f"servicenow - write - status - {cani}") #output servicenow - write - status - b'1'   , that means you are free to write to snow!!!

    if cani == "b'1'":
        print("Inside the if statement!!!")
        ##in this part we are going to get the json secret so that we can call a service-now api
        #print("trying to get the secret")
        #print(secret_string)

        # here we supossedly call the snow api
        """
        url = "https://demo.service-now.com/api/now/table/incident"
        auth = ("username", "password")
        data = {"caller_id" : "xxxxxxxxxxxxxxxxxxxxxxx",
                "category" : "Fault",
                "subcategory" : "Issues",
                "cmdb_ci" : "xxxxxxxxxxxxxxxxxxxxxxx",
                "short_description" : "google cloud testing",
                "description" : "Testing Google-cloud service - Cloud router is down",
		"assignment_group": "test group",
                }
        #data = json.dumps(data)
        headers = {"Content-type" : "application/json", "Accept" : "application/json"}
        r = requests.post(url, auth = auth, headers = headers, json = data)
        scode = r.status_code
        """
        #this incident number is bogus to continue testing the code
        scode="INC0001,SYSID=001"
        print(f"Status Code - {scode}")
        
        #rjson = r.json()
        #print(f"Result - {rjson}")
        
        #create incident.txt file before running this code
        #in this block we are going to update the incident.txt file with the information of the incident that was created.
        blob = bucket.get_blob('incident.txt')
        #inc = rjson['result']['number']
        inc="INC0001"
        #sys_id = rjson['result']['sys_id']
        sys_id="001"
        inc = inc + " , https://demo.service-now.com/api/now/table/incident/" + sys_id
        blob.upload_from_string(inc)

        #since we successfully created a ticket for this google incident, we are going to update the write-to-snow.txt to zero
        blob = bucket.get_blob("write-to-snow.txt")
        nw = "0"
        blob.upload_from_string(nw)








"""
            GENERAL NOTES:
storage to be created:


This one will generate messages for a pub/sub topic
gcloud pubsub topics publish greetings --message "Everyone"
gcloud pubsub topics publish greetings-topic --message "Test01"

the above cloud function requires the below 
requirements.txt
google-cloud-storage==1.13.0
google-cloud-secret-manager==2.0.0
  

this is to generate the sink, you have to change the instance_id accordingly
resource.type="gce_instance"
resource.labels.instance_id="7678628198105148117"
"router is down"

resource.type="gce_instance"
resource.labels.instance_id="7678628198105148117"
"router is up"
-------------------------------------------------------
this is what are you going to find in the alert:
#{'insertId': '4jk88amodk3vszyi5', 'labels': {'compute.googleapis.com/resource_name': 'instance-1'}, 'logName': 'projects/playground-s-11-b4968a10/logs/service-now-test', 'receiveTimestamp': '2021-07-19T22:56:20.098794931Z', 'resource': {'labels': {'instance_id': '1913782471889538009', 'project_id': 'playground-s-11-b4968a10', 'zone': 'us-central1-a'}, 'type': 'gce_instance'}, 'textPayload': 'Cloud router is down', 'timestamp': '2021-07-19T22:56:14.952948355Z'}
------------------------------------------------------------------------------------------
The scripts to simulate a router down were modified as below:
router-down.sh
#! /bin/bash
echo "Cloud router is down" >> /tmp/service-now-test.log
----------------------------------------------------------------------
router-up.sh
! /bin/bash 
echo "Cloud router is up" >> /tmp/service-now-test.log



with this json string you can test the function from the test section, you have to remove the first lines related with base64 decodification
{"labels":{"compute.googleapis.com/resource_name":"instance-1"},"textPayload":"Cloud router is down"}

this is the code that would need modification:
#this block loads the alert as it comes from pubsub    
#data_buffer = base64.b64decode(data["data"])
#print(data_buffer)
#log_entry = json.loads(data_buffer)
log_entry = data        #this is part important as it doesn't require converstion from base64
print(log_entry)
print("Hello there, this is the instance name:")
print(log_entry['labels']['compute.googleapis.com/resource_name'])
print(log_entry["textPayload"])



"""

"""
{'incident': {'incident_id': '0.m55664cf5st4', 'resource_id': '', 'resource_name': 'mck-esit-prod-ec3b gke-esit-cluster-pro-esit-flex-np-pro-20db0f03-4g74', 'resource': {'type': 'gce_instance', 'labels': {'instance_id': '9149886609902380708', 'project_id': 'mck-esit-prod-ec3b', 'zone': 'us-east4-a'}}, 'resource_display_name': 'gke-esit-cluster-pro-esit-flex-np-pro-20db0f03-4g74', 'resource_type_display_name': 'VM Instance', 'metric': {'type': 'compute.googleapis.com/guest/cpu/load_1m', 'displayName': 'CPU load average (1m)'}, 'started_at': 1626910793, 'policy_name': 'fake alert', 'condition_name': 'CPU load average (1m) [MEAN]', 'condition': {'name': 'projects/cops-cloudmonus-prod-b71c/alertPolicies/14022155012417054955/conditions/14022155012417056230', 'displayName': 'CPU load average (1m) [MEAN]', 'conditionThreshold': {'filter': 'metric.type="compute.googleapis.com/guest/cpu/load_1m" resource.type="gce_instance"', 'aggregations': [{'alignmentPeriod': '60s', 'perSeriesAligner': 'ALIGN_MEAN'}], 'comparison': 'COMPARISON_GT', 'thresholdValue': 0.1, 'duration': '0s', 'trigger': {'count': 1}}}, 'url': 'https://console.cloud.google.com/monitoring/alerting/incidents/0.m55664cf5st4?project=cops-cloudmonus-prod-b71c', 'state': 'open', 'ended_at': None, 'summary': 'CPU load average (1m) for mck-esit-prod-ec3b gke-esit-cluster-pro-esit-flex-np-pro-20db0f03-4g74 with metric labels {instance_name=gke-esit-cluster-pro-esit-flex-np-pro-20db0f03-4g74} is above the threshold of 0.100 with a value of 0.190.'}, 'version': '1.2'}
{'incident': {'incident_id': '0.m55686tu5vd0', 'resource_id': '', 'resource_name': 'mck-esit-prod-ec3b gke-esit-cluster-pro-esit-def-np-prod-69f4073b-bqja', 'resource': {'type': 'gce_instance', 'labels': {'instance_id': '7131609790213691366', 'project_id': 'mck-esit-prod-ec3b', 'zone': 'us-east4-b'}}, 'resource_display_name': 'gke-esit-cluster-pro-esit-def-np-prod-69f4073b-bqja', 'resource_type_display_name': 'VM Instance', 'metric': {'type': 'compute.googleapis.com/guest/cpu/load_1m', 'displayName': 'CPU load average (1m)'}, 'started_at': 1626910943, 'policy_name': 'fake alert', 'condition_name': 'CPU load average (1m) [MEAN]', 'condition': {'name': 'projects/cops-cloudmonus-prod-b71c/alertPolicies/14022155012417054955/conditions/14022155012417056230', 'displayName': 'CPU load average (1m) [MEAN]', 'conditionThreshold': {'filter': 'metric.type="compute.googleapis.com/guest/cpu/load_1m" resource.type="gce_instance"', 'aggregations': [{'alignmentPeriod': '60s', 'perSeriesAligner': 'ALIGN_MEAN'}], 'comparison': 'COMPARISON_GT', 'thresholdValue': 0.1, 'duration': '0s', 'trigger': {'count': 1}}}, 'url': 'https://console.cloud.google.com/monitoring/alerting/incidents/0.m55686tu5vd0?project=cops-cloudmonus-prod-b71c', 'state': 'open', 'ended_at': None, 'summary': 'CPU load average (1m) for mck-esit-prod-ec3b gke-esit-cluster-pro-esit-def-np-prod-69f4073b-bqja with metric labels {instance_name=gke-esit-cluster-pro-esit-def-np-prod-69f4073b-bqja} is above the threshold of 0.100 with a value of 0.160.'}, 'version': '1.2'}

"""
"""
#Manish Patel's code

import requests
import base64

 

sn_user = <user>
sn_password = <pass>
sn_url = "https://mckessondev.service-now.com/api/now/table/em_event"

 

user_pass = sn_user + ':' + sn_password

 

byte1 = user_pass.encode('ascii')
byte2 = base64.b64encode(byte1)
byte3 = "Basic " + byte2.decode('ascii')

 

sn_headers = {'content-type': 'application/json','Authorization': byte3}

 


sn_data = {
        "source": "PubSub",
        "message_key": <inc #>,
        "node": <name>,
        "ci_type":<type>,
        "type": vtype,
        "resource":<resource>,
        "event_class": <>,
        "severity":"5",
        "description": <dec>,
        "additional_info": <full json>
        }
res  = requests.post(sn_url, data=json.dumps(sn_data), headers=sn_headers)
res = res.json()
"""


import base64
import json
from datetime import datetime
from google.cloud import storage
import requests

def process_log_entry(data, context):
    #this block loads the alert as it comes from pubsub
    data_buffer = base64.b64decode(data["data"])
    log_entry = json.loads(data_buffer)
    print(log_entry["textPayload"])
    
    #in this block we are going to update the file (cloud-router-up.txt) in the bucket(mybucket-7-21) with the current date where this event happened.
    client = storage.Client()
    bucket = client.get_bucket("mybucket-7-21")
    blob = bucket.get_blob("cloud-router-up.txt")
    now = datetime.now()
    dt = now.strftime("%Y-%m-%d %H:%M:%S")    
    print(f"router is up - {dt}")   #output:  router is up - 2021-07-21 17:45:04
    blob.upload_from_string(dt)

    #in this block we are going to get details of the incident that are in the incident.txt file
    #the content will look like this: INC0001 , https://demo.service-now.com/api/now/table/incident/001
    blob = bucket.get_blob("incident.txt")
    inc = str(blob.download_as_string())
    inc_array = [x.strip() for x in inc.split(',')]
    inc_api = inc_array[1]
    #the content of inc_array would be:
    #0:b'INC0001
    #1:https://demo.service-now.com/api/now/table/incident/001'

    #for i in range(0,len(inc_array)):
    #    print(f"{i}:{inc_array[i]}")

    print(f"first inc_api:{inc_api}")#the output would be:  first inc_api:https://demo.service-now.com/api/now/table/incident/001'
    inc_api = inc_api[:-1]    #this one will remove the last '
    print(f"Incident api - {inc_api}") #the output would be: Incident api - https://demo.service-now.com/api/now/table/incident/001
    
    #in this block we are going to gather from write-to-snow.txt this can be either 1 or 0 (the first time the file was uploaded I set it with value of 1)
    #so in this case it should be equal to 0
    blob = bucket.get_blob("write-to-snow.txt")
    ciwSnow = str(blob.download_as_string())
    print(f"servicenow - write - status - {ciwSnow}")  #output usually should be: servicenow - write - status - b'0'

    if ciwSnow == "b'0'":
        url = inc_api
         # here we supossedly call the snow api
        """
        auth = ("username", "password")
        cdata = {
		"assigned_to" : "Googlecloud",
                "work_notes" : "Testing Google-cloud service - Cloud router is up on " + dt ,
                "close_notes" : "Closed automatically by google cloud ",
                "state" : "7"
                }
        fdata = json.dumps(cdata)
        headers = {"Content-type" : "application/json", "Accept" : "application/json"}
        r = requests.put(url, auth = auth, headers = headers, data = fdata)
        scode = r.status_code
        """
        #in this block 
        #since we successfully closed the ticket for this google incident, we are going to update the write-to-snow.txt to 1
        scode=200
        print(f"Status Code - {scode}")
        if scode == 200:
            #rjson = r.json()
            rjson="ticket successfully closed"
            print(f"Result - {rjson}")

            blob = bucket.get_blob("write-to-snow.txt")
            nw = "1"
            blob.upload_from_string(nw)



#Requirements
#google-cloud-storage==1.13.0
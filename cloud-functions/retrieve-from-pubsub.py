import base64


def greetings(data, context):
  #data comes from pubsu  
  if 'data' in data:    
    name = base64.b64decode(data['data']).decode('utf-8')
  else:
     name = 'folks'
  print('Hello {} from Cloud Functions!'.format(name))
  print(name)


  #gcloud pubsub topics publish greetings --message "Everyone"

  #gcloud pubsub topics publish greetings-topic --message "Test01"

  """
  


  resource.type="gce_instance"
  resource.labels.instance_id="1913782471889538009"
  "router is down"

  resource.type="gce_instance"
  resource.labels.instance_id="1913782471889538009"
  "router is up"

  this is what are you going to find in the alert:
  {'insertId': '4jk88amodk3vszyi5', 'labels': {'compute.googleapis.com/resource_name': 'instance-1'}, 'logName': 'projects/playground-s-11-b4968a10/logs/service-now-test', 'receiveTimestamp': '2021-07-19T22:56:20.098794931Z', 'resource': {'labels': {'instance_id': '1913782471889538009', 'project_id': 'playground-s-11-b4968a10', 'zone': 'us-central1-a'}, 'type': 'gce_instance'}, 'textPayload': 'Cloud router is down', 'timestamp': '2021-07-19T22:56:14.952948355Z'}




  """
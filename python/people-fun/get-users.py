
#!/usr/bin/env python
# Python script to reformat IAM json data
# Rajathithan Rajasekar - 03/03/2020
import json,ast,sys

data = []

project = ""

def hello(jdata, project):
    nicedata = ast.literal_eval(json.dumps(jdata, indent=4, sort_keys=True))
    for i in range(len(nicedata)):
        indrow = nicedata[i]
        usersandservice = indrow['members']
        for j in range(len(usersandservice)):
            print("{},{},{}".format(project, indrow['role'], usersandservice[j]))


project = sys.argv[1]
data = sys.stdin.read()
#data = data.encode("ascii", "replace")
data = data.replace("u\'", "\"")
data = data.replace("\'", "\"")
# print(data)
jdata = json.loads(data)
hello(jdata, project)


#GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-pipeline-iam@devops-369900.iam.gserviceaccount.com auth print-access-token)" python3 get-users.py central-tech-gcp-resources
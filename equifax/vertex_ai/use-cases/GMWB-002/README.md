# GMWB-002 Delete a GM-WB instance
### Description:
Delete instance is a clean up process to destroy everything related to an instance. It would be required to avoid starting those machines or even to destroy and release attached disks.


### Prerequisites
- The bellow service accounts are required:

| Automation account Name | Description | Permissions |Notes|
| ------ | ------ | ------ | ------ |
| tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com  | This account is used to deploy all the code in this repo | efx.vertexAiRuntimesCreator||

- Export environment variables:

``` sh
export GMWB_NAME = "notebookname"
export TS_SA="tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
export PROJECT_ID="ta-cse-rd1-dev-npe-d026"
export TS_SA_ROLE="roles/efx.vertexAiRuntimesEditor"
export REGION="us-central1"
```

Impersonate the terraform service account.
If you are log on to a server that already has set the terraform service account as active, specified in the prerequisites section you can skip this section.

``` sh
export ACCESS_TOKEN=$(gcloud auth print-access-token --impersonate-service-account=$TF_SA)
```
You can execute this section if the terraform account is already set as active:
``` sh
ACCESS_TOKEN=`gcloud auth print-access-token`
```

Assigning role (roles/efx.vertexAiRuntimesCreator) for TF account with just-in-time assignment. What this means is, you can assign this role to TF account (TF account assigning a role to itself) and remove it at the end of the script when all the activities/processing requiring this role are done:
``` sh
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$TS_SA \
    --role=$TS_SA_ROLE \
    --impersonate-service-account=$TS_SA 
```

To delete a notebook and all of its content, send a DELETE request by using the projects.locations.runtimes.delete method.

Execute the following command:

``` sh
curl -X DELETE \
-H "Authorization: Bearer $ACCESS_TOKEN" \
"https://notebooks.googleapis.com/v1/projects/$PROJECT_ID/locations/$REGION/runtimes/$GMWB_NAME
```

Removing role (roles/aiplatform.featurestoreAdmin) for TF account.
```sh
gcloud projects remove-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$TS_SA \
    --role=$TS_SA_ROLE \
    --impersonate-service-account=$TS_SA
```

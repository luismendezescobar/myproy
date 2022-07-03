# GMWB-001 Create a GM-WB instance
### Description:

Create a google managed workbench instance and open JupyterLab using the Google Cloud console.

This option will allow you to create an instance running on a virtual machine allocated to the network that you define.

### Prerequisites
- The bellow service accounts are required:

| Automation account Name | Description | Permissions |Notes|
| ------ | ------ | ------ | ------ |
| tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com  | This account is used to deploy all the code in this repo | efx.vertexAiRuntimesCreator||
| profiles-controller@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com  | it will access the Jupyterlab | efx.vertexAiRuntimesEditor||
| User or group  | Users interacting with service resources from Google Cloud Console | efx.vertexAiRuntimesViewer||

- Export environment variables:

``` sh
export PROJECT_ID="ta-cse-rd1-dev-npe-d026"
export TS_SA="tf-ta-cse-rd1-dev-npe@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
export TS_SA_ROLE="roles/efx.vertexAiRuntimesEditor"
export SA_JUPYTER="profiles-controller@ta-cse-rd1-dev-npe-d026.iam.gserviceaccount.com"
export SA_JUPYTER_ROLE="roles/efx.vertexAiRuntimesEditor"
export REGION="us-west1"
```
This command will create the service account that will access the Jupyterlab
``` sh
gcloud iam service-accounts create $SA_JUPYTER --display-name="SA to access the Jupiterlab notebook"
```
This command will assing the permission efx.vertexAiRuntimesEditor to the SA that will access the Jupyternotebook
``` sh
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$SA_JUPYTER \
    --role=$SA_JUPYTER_ROLE \
```
Assigning role (roles/efx.vertexAiRuntimesCreator) for TF account with just-in-time assignment. What this means is, you can assign this role to TF account (TF account assigning a role to itself) and remove it at the end of the script when all the activities/processing requiring this role are done:

``` sh
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$TS_SA \
    --role=$TS_SA_ROLE \
    --impersonate-service-account=$TS_SA 
```



From here we run the terraform code to create the notebook:


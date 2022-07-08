# Linux NAT service

Using NAT to connect isolated VPC

There is Peering limitation that doesn’t allow to connect the 2 VPC .
### Solution
Use a linux nat servers to enable connectivity, see below details:

- For testing we are creating a single linux server


##### Permissions for the terraform account:
- Compute Instance Admin
- Compute Load Balancer Admin

# Linux NAT service

Using NAT to connect isolated VPC

There is Peering limitation that doesn’t allow to connect the 2 VPC .
### Solution
Use a linux nat servers to enable connectivity, see below details:

- Create a managed instance group composed of 2 instances of centos 7 linux server with ip forwarding enabled
- The nat linux servers should have 2 nics, each one connected to a different VPC. the first nic0 (ens4 for ubuntu or eth0 for centos) needs to be connected to the local vpc , the second nic1 (ens5 for ubuntu or eth1 for centos) needs to be connected to the outbound vpc, that is the shared vpc.
- Create 1 load balancer server pointing out to the backend
- Create 1 custom routes the next hop will be the load balancer front end (forwarding rule)
- Create the firewall rules to allow health checks for the managed instance group.
- Here are the links that were taken into account for this solution:
- [https://cloud.google.com/blog/products/ai-machine-learning/extending-network-reachability-of-vertex-pipelines]
- [https://cloud.google.com/load-balancing/docs/internal/setting-up-ilb-next-hop#gcloud_2]




##### Permissions for the terraform account:
- Compute Instance Admin
- Compute Load Balancer Admin

##### Firewall rules that will be required for the health checks 

| Name | Network | Project |Ranges|Target tags|Protocol
| ------ | ------ | ------ | ------ | ------ | ------ |
| Allow-hc-local | Network for the primary nic01 | project where this solution is being deployed|"130.211.0.0/22", "35.191.0.0/16"|allow-health-check| TCP
| Allow-hc-shared | Network for the sec nic02 | project of the shared network|"130.211.0.0/22", "35.191.0.0/16"|allow-health-check|TCP

Here is the link to request the firewall rules
https://equifax.atlassian.net/wiki/spaces/IaaS/pages/696893357/Ask+CSA+-+GCP+Commercial+NPE

## GCP routes that will be required:

 As per google, all traffic to the Internet is being forwarded to the Default Internet Gateway located in the Google Managed Project, this is because even when a 0.0.0.0/0 route is being imported from our peering, the traffic will prefer any route in the local network over any other route in any peered network.
So the way to resolve this would be to identify a CIDR range that covers all the desired destinations in the internet, and create a static route in your VPC with that range, this way the most specific route will be preferred over the default route and traffic will be forwarded as you want.
   | Name | Network | Project |destination range|next-hop-ilb|Region
| ------ | ------ | ------ | ------ | ------ | ------ |
| from-local-to-github-full | Local network in the project | local project|140.82.112.0/20|front-end-name| Front-end Region
| from-local-to-github-nexus | Local network in the project | local project|10.17.98.194/32|front-end-name| Front-end Region

Also the above routes created in the gcp console need to be added internally in the nat server.
These routes are added in the startupscript file name called: nat_init.sh
and everytime a new route is required the route needs to be added at the end of the nat_init.sh script.

```sh
sudo ip route add 140.82.112.0/20 via $nic1_gw dev $nic1_id
sudo ip route add 10.17.98.194/32 via $nic1_gw dev $nic1_id
```


## for the encryption of the disk
Specs of kms key that can be used:
| Name | Service account access key | Project |Region|type|type
| ------ | ------ | ------ | ------ | ------ | ------ |
| gmwb-us-central | service-[PROJECT-NUMBER]@compute-system.iam.gserviceaccount.com | local project|us-central1 or us-west1|Encryption| Symmetric

The service account must have the Encryp-Decrypt permission
service-[PROJECT-NUMBER]@compute-system.iam.gserviceaccount.com
roles/cloudkms.cryptoKeyEncrypterDecrypter

Here is the link to request for the kms key:
https://equifax.atlassian.net/wiki/spaces/SKB/pages/591916034/IAM-CM-FedRAMP+User+Guide

##


## DNS resolution for notebooks.
- We have to follow the following procedure:
https://cloud.google.com/vpc/docs/configure-private-services-access#dns-peering

- This command has to ran to add dns resolution in the notebooks.
- gcloud services peered-dns-domains create secure-equifax-dns \
    --network=ta-cse-rd1-dev-npe-rd1-dev-vpc-1-useast1 \
    --dns-suffix=.


## Variables to be modified
The following variables need to be updated every time a new NAT server needs to be created in a new project:
| Variable | Description | Example |Required|
| ------ | ------ | ------ | ------ |
|`tf_service_account` | Terraform SA used in the pipeline|tf_service_account=tf-sa@projectid.iam.gserviceaccount.com|Yes|
|`instance_template_map` | This is the name of the entire map which contains all the info to create a instance template|See structure below|
|key | this goes outside of the map, it should be the project id |"project_id_number"= { here goes the rest of the below vars }|Yes|
| project_id | Project id where the nat-linux servers are going to be deployed | project_id  = "my-project_01"|Yes
| name_prefix |name that will have the linux-nat servers  | name_prefix = "nat-server-us-central1"|Yes|
|subnetwork | The primary subnetwork that will be used for the nic 0 of the linux-nat servers |subnetwork = "projects/project-id/regions/region-name/subnetworks/my-subnetwork_01"|Yes|
|subnetwork_project | The project where the primary network lives, it should be the one local in the project |subnetwork_project="my_project_01"|Yes|
| source_image | it has to be a gold image of centos 7 | source_image=efx-centos-7-v20220608" or in blank ""|Yes|
| source_image_family | family for centos 7 | source_image_family  = "efx-centos-7" or "efx-ubuntu-1804-s1"|Yes
| source_image_project | project where the gold image is stored | source_image_project  = "sec-eng-images-prd-5d4d"|Yes|
| init_script | Init script to modify the linux iptables, no need to modify | init_script= "./modules/nat_init.sh"|Yes|
|  additional_networks | this variables is to define the secondary nic1 for the linux-nat | see structure below|Yes|
| network | The secondary vpc network that will be used for the nic 1 of the linux-nat servers |network = "my-vpc-02"|Yes|
|subnetwork | The secondary subnetwork that will be used for the nic 1 of the linux-nat servers |subnetwork = "projects/project-id/regions/region-name/subnetworks/my-subnetwork_02"|Yes|
|subnetwork_project | The project where the secondary network lives, it should be the one shared by the host project |subnetwork_project="my_project_02"|Yes|
| service_account | See the structure bellow: | |
|  email |the service account for the linux-nat-vms  | email="tf-account@project_id.iam.gserviceaccount.com|Yes|
| scopes | the scope of access to the google services  | scopes=["cloud-platform"]|Yes|
| region |usually will be us-central1 or us-west1, because only these are supported by vertex IA  |region="us-central1" |Yes|
| disk_encryption_key | the key to encrypt the disks, it will requireAssign the Cloud KMS CryptoKey Encrypter/Decrypter role to the Compute Engine Service Agent. This account has the following form: service-$PROJECT_NUMBER@compute-system.iam.gserviceaccount.com  | gcloud projects add-iam-policy-binding $KMS_PROJECT_ID --member serviceAccount:service-$PROJECT_NUMBER@compute-system.iam.gserviceaccount.com  --role roles/cloudkms.cryptoKeyEncrypterDecrypter|Yes|
| network_tags | it will be required for the health check tag  | network_tags=["allow-health-check"]|Yes|
| machine_type | size of cpu and memory  | machine_type="e2-medium"|Yes|
|disk_size_gb  | size of the local drive | disk_size_gb="30"|Yes|
| auto_delete  | delete disk after the server deletion | auto_delete="true" |Yes|
|can_ip_forward | very important to allow the forwarding function of this linux nat  |can_ip_forward="true" |Yes|
|on_host_maintenance |what to do if the host goes under maintenance|on_host_maintenance |Yes|
|metadata|any metadata required|example:ssh-keys="sshkey goes here"|Yes|
||||
|`mig_map` | This is the name of the entire map which contains all the info to create a managed instance group|See structure below|
|key | this goes outside of the map, it should be the project id |"project_id_number"= { here goes the rest of the below vars }|Yes|
| project_id | The project id where all this is being created | project_id  = "my-project_01"|Yes|
| region |usually will be us-central1 or us-west1, because only these are supported by vertex IA  |region="us-central1" |Yes|
| hostname | the name of the managed instance group, it can be mig-nat-(plus the region)  | hostname = "mig-nat-us-central1"  |Yes|
| distribution_policy_zones |zones where the linux-nat are going to live  | distribution_policy_zones=["us-central1-a", "us-central1-b"]|Yes|
|the rest as default||
|||
|`load_balancer_info` | This is the name of the entire map which contains all the info to create `load balancers`|See structure below|
|key | this goes outside of the map, it should be the project id + the last 2 parts of the subnetwork name |"project_id_number_subnet_id_01"= { here goes the rest of the below vars (see below }|Yes|
| project_id | The project id where all this is being created  | project_id  = "my-project_01"|Yes|
| lb_name | load balancer name  | lb_name  = "lb-backend-isolated" |Yes|
| forwarding_name | the front end name, it should be frontend-lb + the last 2 parts of the subnetwork name  | forwarding_name  = "frontend-lb-my-subnetwork-01"|Yes|
| region |usually will be us-central1 or us-west1, because only these are supported by vertex IA  |region="us-central1" |Yes|
| network | the vpc where the load balancer will be deployed, same network as one used for the primary nic0 | network = "projects/projectid/global/networks/my-vpc-01”|Yes|
| subnetwork |the subnetwork where the load balancer will be deployed, same network as one used for the primary nic0 | subnetwork = “projects/project-id/regions/region-name/subnetworks/my-subnetwork_01"|Yes|
| The rest as default || |


### How to execute the terraform code:

terraform init
terraform apply -var-file=var-file.tfvars
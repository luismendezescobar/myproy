

module "group" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.1"

  for_each = var.map_for_groups
  id           = "${each.key}@${each.value.domain}"
  display_name = each.key
  description  = each.value.description
  domain       = each.value.domain
  owners       = each.value.owners
  managers     = each.value.managers
  members      = each.value.members
}

output "group_output" {
  value = module.group
}




/*some links
https://gmusumeci.medium.com/how-to-manage-google-groups-users-and-service-accounts-in-gcp-using-terraform-fadf472e574a
https://medium.com/google-cloud/local-remote-authentication-with-google-cloud-platform-afe3aa017b95
https://jryancanty.medium.com/stop-downloading-google-cloud-service-account-keys-1811d44a97d9
https://medium.com/google-cloud/create-google-groups-via-terraform-de99524f92e0
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-pipeline-iam@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=${SERVICE_ACCOUNT} auth print-access-token)" terraform apply -var-file=02-terraform.tfvars

GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform init
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply

for group creation the SA account, only requires the following permissions:
at project level (where the SA was created)
"roles/serviceusage.serviceUsageConsumer" : [
    "serviceAccount:sa-project-factory@devops-369900.iam.gserviceaccount.com"
]      
At organization level:
sa-project-factory@devops-369900.iam.gserviceaccount.com	sa-project-factory	
Organization Viewer

at gsuite (worskpace level)
add the account to the group admin level
*/


/*
module "group" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.1"
  for_each     = local.json_data
  id           = "${each.value.group_name}@luismendeze.com"
  display_name = each.value.group_name
  description  = "Group to be used the in the gcp project name ${each.value.name}"
  domain       = "luismendeze.com"
  owners       = each.value.group_owners
  members      = each.value.group_members
}
*/

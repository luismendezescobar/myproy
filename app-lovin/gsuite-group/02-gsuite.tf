/*
resource "gsuite_group" "example" {
  email       = "test_group@luismendeze.com"
  name        = "test_group@luismendeze.com"
  description = "Example group"
}
*/

provider "google-beta" {
  user_project_override = true
  billing_project       = "devops-369900"
}

module "group" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.1"

  id           = "example-group@luismendeze.com"
  display_name = "example-group"
  description  = "Example group"
  domain       = "luismendeze.com"
  owners       = ["luis@luismendeze.com"]
  managers     = []
  members      = ["test@luismendeze.com","devops-user01@luismendeze.com"]
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

SA account, only requires the following permissions:
at project level
"roles/serviceusage.serviceUsageConsumer" : [
    "serviceAccount:sa-project-factory@devops-369900.iam.gserviceaccount.com"
]      
At organization level:
sa-project-factory@devops-369900.iam.gserviceaccount.com	sa-project-factory	
Organization Viewer

at gsuite (worskpace level)
add the account to the group admin level




*/

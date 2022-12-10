

data "google_organization" "org" {
  domain = "luismendeze.com"
}

/*
data "google_cloud_identity_group" "group" {
  name="new-luis"
}
*/

output "bucket" {
  value = data.google_organization.org
}

/*
module "project-factory" {
  source = "terraform-google-modules/project-factory/google"
  version = "~> 14.1"
  for_each = var.map_for_project_factory

  name               = each.value.name
  random_project_id  = true
  random_project_id_length =4  
  org_id             = each.value.org_id
  billing_account    = each.value.billing_account
  auto_create_network = true
  activate_apis       = []

  svpc_host_project_id= each.value.svpc_host_project_id
  shared_vpc_subnets = each.value.shared_vpc_subnets
  group_name         = each.value.group_name
  group_role         = each.value.group_role
  folder_id          = each.value.folder_id 
  
  
  #sa_group           = each.value.sa_group
  #shared_vpc         = each.value.shared_vpc

}
*/
/*
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply -var-file=02-terraform.tfvars
*/
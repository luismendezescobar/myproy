locals {
  json_files = fileset("${path.module}/files-projects", "*.json")
  json_data = { for file_name in local.json_files :
  replace(file_name, ".json", "") => jsondecode(file("${path.module}/files-projects/${file_name}")) }

}


module "project-factory" {
  source                = "./modules/core_project_factory"  
  
  for_each              = local.json_data
  name                  = each.value.key
  project_id            = each.value.project_id
  org_id                = each.value.org_id
  billing_account       = each.value.billing_account
  folder_id             = each.value.folder_id  
  labels                = each.value.labels
  auto_create_network   = each.value.auto_create_network
  activate_apis         = each.value.activate_apis

}


/*
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply -var-file=02-terraform.tfvars
*/
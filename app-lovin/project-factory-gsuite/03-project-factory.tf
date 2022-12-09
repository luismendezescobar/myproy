
module "project-factory" {
  source = "terraform-google-modules/project-factory/google//modules/gsuite_enabled"
  version = "~> 14.1"
  for_each = var.map_for_project_factory

  create_group      = true
  name               = each.value.name
  random_project_id  = true
  org_id             = each.value.org_id
  billing_account    = each.value.billing_account
  #svpc_host_project_id= each.value.svpc_host_project_id
  shared_vpc          = each.value.shared_vpc


  shared_vpc_subnets = each.value.shared_vpc_subnets

  group_name         = each.value.group_name
  group_role         = each.value.group_role
  


  folder_id          = each.value.folder_id 
  
  
  sa_group           = each.value.sa_group

    
}

/*
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform init
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply

see the required permissions here:
https://github.com/terraform-google-modules/terraform-google-project-factory

*/
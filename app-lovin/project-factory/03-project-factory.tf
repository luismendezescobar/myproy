

module "group" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.1"
  providers = {google-beta=google-beta.provider-for-groups}

  id           = "example-group@luismendeze.com"
  display_name = "example-group"
  description  = "Example group"
  domain       = "luismendeze.com"
  owners       = ["luis@luismendeze.com"]
  managers     = []
  members      = ["test@luismendeze.com","devops-user01@luismendeze.com"]
}



module "project-factory" {
  source = "terraform-google-modules/project-factory/google"
  version = "~> 14.1"
  for_each = var.map_for_project_factory

  name               = each.value.name
  random_project_id  = true
  random_project_id_length =4  
  org_id             = each.value.org_id
  billing_account    = each.value.billing_account
  svpc_host_project_id= each.value.svpc_host_project_id
  shared_vpc_subnets = each.value.shared_vpc_subnets



  group_name         = each.value.group_name
  folder_id          = each.value.folder_id 
  group_role         = each.value.group_role
  
  sa_group           = each.value.sa_group
  shared_vpc         = each.value.shared_vpc
    
}

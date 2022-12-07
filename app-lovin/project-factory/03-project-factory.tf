module "project-factory" {
  source = "terraform-google-modules/project-factory/google//modules/gsuite_enabled"
  version = "~> 14.1"
  for_each = var.map_for_project_factory

  name               = each.value.name  
  billing_account    = each.value.billing_account
  create_group       = each.value.create_group
  group_name         = each.value.group_name
  folder_id          = each.value.folder_id 
  group_role         = each.value.group_role
  org_id             = each.value.org_id
  random_project_id  = each.value.random_project_id
  sa_group           = each.value.sa_group
  shared_vpc         = each.value.shared_vpc
  shared_vpc_subnets = each.value.shared_vpc_subnets  
}

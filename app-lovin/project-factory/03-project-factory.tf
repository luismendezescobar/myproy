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

/*
erros
Error: error creating group member: googleapi: Error 403: Request had insufficient authentication scopes.
│ Details:
│ [
│   {
│     "@type": "type.googleapis.com/google.rpc.ErrorInfo",
│     "domain": "googleapis.com",
│     "metadata": {
│       "method": "ccc.hosted.frontend.directory.v1.DirectoryMembers.Insert",
│       "service": "admin.googleapis.com"
│     },
│     "reason": "ACCESS_TOKEN_SCOPE_INSUFFICIENT"
│   }
│ ]
│
│ More details:
│ Reason: insufficientPermissions, Message: Insufficient Permission
│
│
│   with module.project-factory["service_project01"].gsuite_group_member.service_account_sa_group_member[0],
│   on .terraform/modules/project-factory/modules/gsuite_enabled/main.tf line 24, in resource "gsuite_group_member" "service_account_sa_group_member":
│   24: resource "gsuite_group_member" "service_account_sa_group_member" {


Error: [ERROR] Error creating group: googleapi: Error 403: Request had insufficient authentication scopes.
│ Details:
│ [
│   {
│     "@type": "type.googleapis.com/google.rpc.ErrorInfo",
│     "domain": "googleapis.com",
│     "metadata": {
│       "method": "ccc.hosted.frontend.directory.v1.DirectoryGroups.Insert",
│       "service": "admin.googleapis.com"
│     },
│     "reason": "ACCESS_TOKEN_SCOPE_INSUFFICIENT"
│   }
│ ]
│
│ More details:
│ Reason: insufficientPermissions, Message: Insufficient Permission
│
*/
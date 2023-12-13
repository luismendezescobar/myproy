#https://github.com/terraform-google-modules/terraform-google-org-policy
# wordsearch dev server first to test and then move up to wordchums, and then wordscapes prod

module "project-policy-disable-tls" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 3.0.2"
  
  for_each          = var.gcp_policies
  policy_for        = each.value.policy_for
  
  project_id        = each.value.project_id
  organization_id   = each.value.organization_id
  folder_id         = each.value.folder_id
  
  constraint        = each.value.constraint
  policy_type       = each.value.policy_type
  deny_list_length  = each.value.deny_list_length
  deny              = each.value.deny
  allow_list_length = each.value.allow_list_length
  allow             = each.value.allow


  exclude_folders   = each.value.exclude_folders
  exclude_projects  = each.value.exclude_projects
  enforce           = each.value.enforce           

  
}
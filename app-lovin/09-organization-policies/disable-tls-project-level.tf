#https://github.com/terraform-google-modules/terraform-google-org-policy

module "project-policy-disable-tls" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 3.0.2"
  
  for_each          = var.project_policies
  policy_for        = each.value.policy_for
  project_id        = each.value.project_id
  constraint        = each.value.constraint
  policy_type       = each.value.policy_type
  deny_list_length  = each.value.deny_list_length
  deny              = each.value.deny
  
}
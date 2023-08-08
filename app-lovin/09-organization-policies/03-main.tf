module "org-policy" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 3.0.2"

  policy_for        = "project"  
  project_id        = "prod-project-369617"
  constraint        = "constraints/gcp.restrictTLSVersion"  
  policy_type       = "list"  
  deny_list_length  = 2
  deny              = ["TLS_VERSION_1","TLS_VERSION_1_1"]
#  enforce           = true
  
}
gcp_policies = {
/*  
    prod-project-369617 = {
      policy_for        = "project"
      project_id        = "prod-project-369617"
      constraint        = "constraints/gcp.restrictTLSVersion"
      policy_type       = "list"
      deny_list_length  = "2"
      deny              = ["TLS_VERSION_1","TLS_VERSION_1_1"]
    }
    another-prod-project-98jp = {
      policy_for        = "project"
      project_id        = "another-prod-project-98jp"
      constraint        = "constraints/gcp.restrictTLSVersion"
      policy_type       = "list"
      deny_list_length  = "2"
      deny              = ["TLS_VERSION_1","TLS_VERSION_1_1"]
    }
*/    
/*
    org-tls-disable = {
      policy_for        = "organization"      
      organization_id   = "65202286851"
      constraint        = "constraints/gcp.restrictTLSVersion"
      policy_type       = "list"
      deny_list_length  = "2"
      deny              = ["TLS_VERSION_1","TLS_VERSION_1_1"]
    }
*/
  wordscapes-dev-appengine-runtimeDeploymentExemption = {
    policy_for        = "project"
    project_id        = "prod-project-369617"
    constraint        = "constraints/appengine.runtimeDeploymentExemption"
    policy_type       = "list"
    allow_list_length  = "1"
    allow              = ["python27"]    
  }

}
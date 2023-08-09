module "create_ssl_policy" {
  source                      = "./module/"
  name            = "ssl-policy-pt-services-dev"  
  project_id      = "prod-project-369617"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}



output "name" {
  value=module.create_ssl_policy.ssl_policy  
}
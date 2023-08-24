resource "google_compute_ssl_policy" "custom-ssl-policy" {  
  name            = var.name
  project         = var.project_id
  profile         = var.profile
  min_tls_version = var.min_tls_version 
  custom_features = var.custom_features
}
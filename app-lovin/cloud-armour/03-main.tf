module "security_policy" {
  source = "GoogleCloudPlatform/cloud-armor/google"
  version = "~> 2.0"

  project_id                           = var.project_id
  name                                 = "security-policy-throttle"
  description                          = "Test Security Policy"
  #recaptcha_redirect_site_key          = google_recaptcha_enterprise_key.primary.name
  default_rule_action                  = "allow"
  type                                 = "CLOUD_ARMOR"
  layer_7_ddos_defense_enable          = false
  layer_7_ddos_defense_rule_visibility = "STANDARD"
  
  # Action against specific IP addresses or IP adress ranges
  security_rules = {

    "throttle_project" = {
      action        = "throttle"
      priority      = 1100
      description   = "Throttle"
      src_ip_ranges = []

      rate_limit_options = {
        exceed_action                        = "deny(502)"
        rate_limit_http_request_count        = 10
        rate_limit_http_request_interval_sec = 30
        enforce_on_key_configs = [
          {
            enforce_on_key_type = "ALL"
          },          
        ]
      }
    }
  }
    
}
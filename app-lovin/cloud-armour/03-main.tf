
/*
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
      src_ip_ranges = ["true"]

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
*/

module "create_cloud_armor_policy" {
  source                      = "/module/"
  for_each                    = var.map_armor
  name                        = each.value.name
  project_id                  = each.value.project_id
  layer_7_ddos_defense_config = each.value.layer_7_ddos_defense_config  
  rule_visibility             = each.value.rule_visibility
  rules                       = each.value.rules  
}

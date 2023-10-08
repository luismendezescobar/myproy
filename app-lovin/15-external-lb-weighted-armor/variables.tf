### General variables ###############
variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}
############## Variable for external lb weighted########
variable "map_lb" {
  type = map(object({
    lb_name               = string    
    //prefix_match          = string
    paths_class           = bool
    weighted_class        = bool
    ipv4_name             = string
    ipv4_project          = string
    enable_ipv6           = bool
    ipv6_name             = string
    ipv6_project          = string
    https_redirect        = bool
    enable_cdn            = bool
    log_config_enable     = bool
    default_service       = string
    load_balancing_scheme = string
    end_points = map(object({
      service_name    = string
      service         = string
      tag             = string
      version         = string
      type            = string
      region_endpoint = string
      iap             = object({
        enable                = optional(bool,false)
        oauth2_client_id      = optional(string,"")
        oauth2_client_secret  = optional(string,"")
      })
      security_policy         = string
      custom_request_headers  = optional(list(string))
      custom_response_headers = optional(list(string))
    }))
    url_map = map(object({
      path_matcher    = string
      domain          = string
      default_service = string
      end_point_maps = map(object({
        service_name          = optional(string)
        path                  = optional(list(string))
        path_prefix_rewrite   = optional(string)
        #weight               = optional(number)
        priority              = optional(number)
        prefix_match          = optional(string)
        weighted_be_services  = optional(list(object({
          service_name        = string
          weight              = number          
        })))
      }))
    }))
  }))
}

variable "map_armor" {
  type = map(object({
    name                          = string
    layer_7_ddos_defense_config   = bool
    rule_visibility               = string
    rules       = list(object({
      action          = string
      priority        = number
      description     = string
      versioned_expr  = string
      src_ip_ranges   = list(string)
      expression      = string      
    }))
  }))
}
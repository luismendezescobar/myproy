### General variables ###############
variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}
############## Variable for external lb weighted########
variable "map_lb" {
  type = map(object({
    lb_name               = string    
    prefix_match          = string
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
        service_name        = string
        path                = list(string)
        path_prefix_rewrite = string
        weight              = number
      }))
    }))
  }))
}

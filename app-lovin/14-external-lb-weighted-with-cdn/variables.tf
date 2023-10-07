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
##########variables for cdn for load balancer #########
    create_storage        = bool
    storage = map(object({
      backend_name        = string
      bucket_name         = string
      enable_cdn          = bool
      bucket_location     = string
      uniform_bucket_level_access = string
      storage_class       = string
      force_destroy       = string	
      description         = string
      member              = string
    }))
    cdn_policy = optional(object({
      cache_mode                   = optional(string)      
      client_ttl                   = optional(number)
      default_ttl                  = optional(number)
      max_ttl                      = optional(number)      
      negative_caching             = optional(bool)
      serve_while_stale            = optional(number)
    }))

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

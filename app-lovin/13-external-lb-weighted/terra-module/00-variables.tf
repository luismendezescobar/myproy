variable "project_id" {
  type = string
}
variable "lb_name" {
  type = string
}
variable "prefix_match" {
  type = string
}
variable "paths_class" {
  type = bool
}
variable "weighted_class" {
  type = bool
}
variable "ipv4_name" {
  type = string
}
variable "ipv4_project" {
  type = string
}
variable "enable_ipv6" {
  type = bool
}
variable "ipv6_name" {
  type = string
}
variable "ipv6_project" {
  type = string
}
/*
variable "certificates" {
  type = list(string)
}
*/
variable "https_redirect" {
  type = bool
}
variable "enable_cdn" {
  type = bool
}
variable "log_config_enable" {
  type = bool
}
variable "default_service" {
  type = string
}
variable "load_balancing_scheme" {
  type    = string
  default = "EXTERNAL_MANAGED"
}
variable "end_points" {
  type = map(object({
    service_name    = string
    service         = string
    tag             = string
    version         = string
    type            = string
    region_endpoint = string
    iap = object({
      enable               = optional(bool, false)
      oauth2_client_id     = optional(string, "")
      oauth2_client_secret = optional(string, "")
    })
    security_policy         = string
    custom_request_headers  = optional(list(string))
    custom_response_headers = optional(list(string))
  }))
  description = "An object mapping between backend services"
}

variable "url_map" {
  type = map(object({
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
}

variable "ssl_policy" {
  type    = string
  default = null
}                
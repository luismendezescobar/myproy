variable "project_id" {
  type = string
}
variable "region" {
  description = "Location for load balancer and Cloud Run resources"
  type        = string
}
variable "domain" {
  type = string
}

variable "map_services" {
  type = list(object({
    service_name        = string
    service             = string
    tag                 = string
    type                = string
    path                = string
    path_prefix_rewrite = string
  }))
}

variable "map_services2" {
  type = map(object({
    lb_name         = string
    domain          = string
    prefix_match    = string
    settings = map(object({
      service_name        = string
      service             = string
      tag                 = string
      type                = string
      path                = string
      path_prefix_rewrite = string
    }))          
  }))
  description = "An object mapping between backend services"
}

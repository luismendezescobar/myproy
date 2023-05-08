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
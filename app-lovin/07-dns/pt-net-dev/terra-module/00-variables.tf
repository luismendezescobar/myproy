
variable "project_id" {
  type = string
}
variable "region" {
  description = "Location for load balancer and Cloud Run resources"
  type = string
}

variable "map_certificates" {
  type = map(object({
    dns_zone_name              = string
    domain                     = string
    certificate_description    = string
    certificate_domain_names   = list(string)
    project_id_certificate_map = string
  }))
  description = "An object mapping for the certificates"
}

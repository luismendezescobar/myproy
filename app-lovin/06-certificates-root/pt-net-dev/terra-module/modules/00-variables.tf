variable "dns_zone_name" {
  type= string
}
variable "certificate_description" {
  type = string
}
variable "certificate_domain_names" {
  type= list(string)
}
variable "domain" {
  type = string
}
variable "project_id_certificate_map" {
  type = string  
}
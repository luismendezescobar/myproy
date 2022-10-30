/*general variables*/
variable "region" {
  type = string
  default = "us-centra1"
}
variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "container.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

/*variables for network*/
variable "authorized_source_ranges" {
  type        = list(string)
  description = "Addresses or CIDR blocks which are allowed to connect to GKE API Server."
  default=["189.190.250.146/32","104.151.30.190/32"]
}

/*variables for GKE*/
variable "gke_master_ipv4_cidr_block" {
  type    = string
  default = "172.23.0.0/28"
}

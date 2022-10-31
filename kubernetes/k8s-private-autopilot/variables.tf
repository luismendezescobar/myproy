/*general variables*/
variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "container.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

/*variables for network*/
//with this you can check your shell ip:  curl checkip.dyndns.com
variable "authorized_source_ranges" {
  type        = list(string)
  description = "Addresses or CIDR blocks which are allowed to connect to GKE API Server."
  default=["34.74.91.220/32"]
}

/*variables for GKE*/
variable "gke_master_ipv4_cidr_block" {
  type    = string
  default = "172.23.0.0/28"
}
# minimum permissions for gke service account
#https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster
variable "roles_for_gke_service_account" {
  type = list(string)
  default=[
    "roles/container.nodeServiceAccount",
    "roles/artifactregistry.reader",
    "roles/storage.objectViewer"
  ]

}
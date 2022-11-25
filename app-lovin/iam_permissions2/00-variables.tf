variable "project_id" {    
  type=string
  #default = "playground-s-11-43db1e5a"
  default = ""
}

variable "region" {
  type=string
  default = "us-east1"
}

/*
variable "roles_for_gke_service_account" {
  type = list(string)
  default=[
    "roles/container.nodeServiceAccount",
    "roles/storage.objectViewer",
  ]

}
*/

/*to enable all the required apis*/
/*
variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "secretmanager.googleapis.com",
    "servicenetworking.googleapis.com",
  ]
}
*/


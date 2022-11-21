variable "project_id" {    
  type=string
  default = "playground-s-11-fe523968"
}

variable "region" {
  type=string
  default = "us-east1"
}


variable "roles_for_gke_service_account" {
  type = list(string)
  default=[
    "roles/container.nodeServiceAccount",
    "roles/storage.objectViewer",
  ]

}

/*general variables*/
variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "container.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

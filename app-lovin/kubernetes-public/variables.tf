variable "project_id" {    
  type=string
  default = "triggering-a-198-9ce4078d"
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
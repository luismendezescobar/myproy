variable "project_id" {    
  type=string
  default = "triggering-a-198-a5a3b51c"
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

/*to enable all the required apis*/
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


/*variables for SQL*/
variable "mysql_location_preference" {
  type = string
  default = "us-east1-b"
}
variable "mysql_machine_type" {
  type = string
  default = "db-n1-standard-2"
}
variable "mysql_database_version" {
  type = string
  default = "MYSQL_8_0"
}
variable "mysql_default_disk_size" {
  type = string
  default = "100"
}
variable "mysql_availability_type" {
  type = string
  default = "REGIONAL"
}
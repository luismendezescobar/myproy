variable "server_name" {type=string}
variable "gce_image_family"{type=string}
variable "compute_image_project" {type=string}
variable "project_id" {type=string}
variable "machine_type" {type=string}
variable "zone" {type=string}
variable "labels" {type=map(string)}
variable "auto_delete" {type=bool}
variable "kms_key_self_link" {type=string}
variable "disk_size" {type=number}
variable "disk_type" {type= string}
variable "subnetwork_project" {type=string}
variable "subnetwork" {type=string}
variable "external_ip" {type=list(string)}
variable "additional_networks" {
  type = list(object({
    network            = string
    subnetwork         = string
    subnetwork_project = string
    network_ip         = string
    access_config = list(object({
      nat_ip       = string
      network_tier = string
    }))
  }))
}
variable "service_account" {
  type = object({
    email  = string
    scopes = list(string)
  })
}
variable "tags" {type=list(string)}
variable "metadata" {type=map(string)}
variable "startup_script" {type=string}
variable "description" {type=string}
variable "can_ip_forward" {type=bool}
variable "allow_stopping_for_update" {type=bool}
variable "additional_disks" {
  description = "List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#disk_name"
  type = list(object({
    name         = string
    disk_size_gb = number
    disk_type    = string
  }))
  default = []
}



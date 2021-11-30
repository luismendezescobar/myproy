variable "additional_disks" {
  description = "List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#disk_name"
  type = list(object({
    name         = string
    disk_size_gb = number
    disk_type    = string    
  }))
  default = []
}
variable "project_id" {type=string}
variable "instance_name" {type=string}
variable "zone" {type=string}
variable "instance_machine_type" {type=string}
variable "instance_tags" {type=list}
variable "instance_description" {type=string}
variable "init_script" {type=string}
variable "auto_delete" {type=bool}
variable "disk_size_gb" {type=number}
variable "source_image" {type=string}
variable "boot_disk_type" {type=string}
variable "subnetwork_project" {type=string}
variable "subnetwork" {type=string}
variable "network_ip" {type=string}
variable "metadata" {type=map(string)}
 

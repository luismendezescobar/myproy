
variable "project_id" {
  type=string
}
/*
variable "vpc_name" {
  type=string
}
variable "region" {
  type=string
}
variable "region2" {
  type=string
}
variable "subnet_name" {               //create an string instead of these 2
  type=string
}
variable "subnet_name2" {
    type = string
}

variable "ip_cidr_range" {
  type=string
}
variable "ip_cidr_range2" {
  type=string
}
*/


variable "server_vm_info" {
  description = "the number of DB server instances"
  type = map(object({
    zone              = string
    instance_type     = string
    source_image      = string
    boot_disk_size_gb = number    
    boot_disk_type    = string
    network_tags     = list(string)    
    description       = string
    init_script       = string
    auto_delete       = bool
    subnet_name       = string
    external_ip       = list(string)
    can_ip_forward    = bool
    additional_disks = list(object({
      name         = string
      disk_size_gb = number
      disk_type    = string
    }))
  }))
  default = {}
}



variable "vpc_info" {
  description = "information about the vpc"
  type = map(object({
    auto_create_subnetworks = bool
    subnetworks = list(object({
      subnet_name   = string
      ip_cidr_range = string
      region        = string
    }))
  }))
  default = {}
}



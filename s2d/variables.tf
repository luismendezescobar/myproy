
variable "project_id" {
  type=string
}
variable "vpc_name" {
  type=string
}
variable "region" {
  type=string
}
variable "subnet_name" {
  type=string
}
variable "ip_cidr_range" {
  type=string
}



variable "server_vm_info" {
  description = "the number of DB server instances"
  type = list(object({
    zone              = string
    name              = string
    network_ip        = string
    instance_type     = string
    source_image      = string
    boot_disk_size_gb = number    
    boot_disk_type    = string
    metadata          = map(string)
    instance_tags     = list(string)    
    description       = string
    init_script       = string
    auto_delete       = bool
    additional_disks = list(object({
      name         = string
      disk_size_gb = number
      disk_type    = string
    }))
  }))
  default = []
}


variable "server_dc" {
  description = "for the creation of the AD"
  type = map(object({
    zone              = string
    name              = string
    network_ip        = string
    instance_type     = string
    source_image      = string
    boot_disk_size_gb = number    
    boot_disk_type    = string
    metadata          = map(string)
    instance_tags     = list(string)    
    description       = string
    init_script       = string
    auto_delete       = bool
    additional_disks = list(object({
      name         = string
      disk_size_gb = number
      disk_type    = string
    }))
  }))
  default = []
}




variable "internal_ips" {
  type=map
}
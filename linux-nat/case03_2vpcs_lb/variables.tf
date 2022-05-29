
variable "project_id" {
  type=string
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

variable "lb_mig_nat_var" {
  description = "the number of DB server instances"
  type = map(object({
    zone              = string
    region            = string
    instance_type     = string
    source_image      = string
    boot_disk_size_gb = number    
    boot_disk_type    = string
    network_tags     = list(string)    
    description       = string
    init_script       = string
    auto_delete       = bool    
    subnet_name1      = string    
    subnet_name2      = string
    external_ip       = list(string)
    can_ip_forward    = bool

  }))
  default = {}
}

variable "health_check" {type = map }
variable "mig_info" {type = map }
variable "mig_zones" {type=list(string)}
variable "load_balancer_info01" {type = map }
variable "load_balancer_info02" {type = map }
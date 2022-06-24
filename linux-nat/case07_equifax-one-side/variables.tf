
variable "project_id" {
  type=string
}
/*
variable "service_account" {
  type=object({
    email  = string
    scopes = set(string)
  })
}
*/
variable "vpc_info" {
  description = "information about the vpc"
  type = map(object({
    auto_create_subnetworks = bool
    subnets = list(map(string)) //you can put any string that you want
    secondary_ranges=map(list(object({ 
      range_name = string
      ip_cidr_range = string 
    })))
  }))
  default = {}
}

variable "firewall_rules" {
  description = "Firewall rules"
  type = map(object({
    network_name       = string
    rules=list(object({        
      name        =string
      description =string
      direction   =string
      priority    =string
      ranges      =list(string)
      source_tags =list(string)
      source_service_accounts = list(string)
      target_tags             = list(string)
      target_service_accounts = list(string)
      allow   = list(object({
        protocol    = string
        ports       = list(string)              
      }))
      deny = list(object({
        protocol = string
        ports    = list(string)
      }))
      log_config = object({
        metadata = string
      })
    }))
  }))
  default = {}
}

variable "cloud_nat_map" {
  type = map(object({    
    region      = string    
    router_name =string
    bgp         = any
    network     = string
    nat_ip_allocate_option  = bool
    source_subnetwork_ip_ranges_to_nat = string
    log_config_enable       = bool
    log_config_filter       = string

  }))
}


variable "server_vm_info_two_nics" {
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
    subnet_name1       = string
    subnet_name2       = string
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

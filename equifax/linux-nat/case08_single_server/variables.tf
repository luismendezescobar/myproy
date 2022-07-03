
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


variable "server_nat_info" {
  description = "the number of DB server instances"
  type = map(object({
    gce_image_family      = string
    compute_image_project = string
    project_id        = string
    machine_type     = string
    zone              = string        
    labels            = map(string)
    auto_delete       = bool
    kms_key_self_link = string
    disk_size         = number
    disk_type         = string
    subnetwork_project= string
    subnetwork        = string
    external_ip       = list(string)
    additional_networks =list(object({
      network             = string
      subnetwork          = string
      subnetwork_project  = string
      network_ip          = string
      access_config = list(object({
        nat_ip       = string
        network_tier = string
      }))
    }))
    service_account = object({
      email  = string
      scopes = list(string)
    })
    tags                = list(string)
    metadata            = map(string)
    startup_script       = string
    description         =string
    can_ip_forward    = bool
    allow_stopping_for_update=bool 
    additional_disks = list(object({
      name         = string
      disk_size_gb = number
      disk_type    = string
    }))
  }))
  default = {}
}

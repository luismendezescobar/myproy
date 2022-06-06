
variable "project_id" {
  type=string
}

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
/*
variable "cloud_router_map" {
  type = map(object({    
    region      = string
    network     = string
    bgp         = number
  }))
}
*/

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


variable "instance_template_map" {
  description = "the number of DB server instances"
  type = map(object({
    name_prefix       = string
    zone              = string
    region            = string
    machine_type      = string
    source_image      = string
    source_image_family=string
    source_image_project=string
    disk_size_gb      = string    
    disk_type         = string
    network_tags      = list(string)    
    #description       = string
    init_script       = string
    auto_delete       = string        
    subnetwork        = string
    subnetwork_project= string
    external_ip       = list(string)
    can_ip_forward    = string
    on_host_maintenance = string
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
    service_account=object({
      email  = string
      scopes = set(string)
    })
  }))
  default = {}
}

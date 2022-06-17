
variable "project_id" {
  type=string
}
variable "service_account" {
  type=object({
    email  = string
    scopes = set(string)
  })
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


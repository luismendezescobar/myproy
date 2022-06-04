
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

variable "firewall_rules" {
  description = "Firewall rules"
  type = list(object({
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

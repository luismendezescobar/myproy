
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

variable "mig_map"  {
  type = map(object({
    hostname                  = string
    region                    = string
    distribution_policy_zones = list(string)
    update_policy         = list(object({
      max_surge_fixed              = number
      instance_redistribution_type = string
      max_surge_percent            = number
      max_unavailable_fixed        = number
      max_unavailable_percent      = number
      min_ready_sec                = number
      replacement_method           = string
      minimal_action               = string
      type                         = string
    }))
    health_check=object({
      type                = string
      initial_delay_sec   = number
      check_interval_sec  = number
      healthy_threshold   = number
      timeout_sec         = number
      unhealthy_threshold = number
      response            = string
      proxy_header        = string
      port                = number
      request             = string
      request_path        = string
      host                = string    
    })
    autoscaling_enabled   = bool
    max_replicas          = number
    min_replicas          = number
    cooldown_period       = number
    autoscaling_cpu       = list(map(number))
    autoscaling_metric    = list(object({
      name   = string
      target = number
      type   = string
    }))
    autoscaling_lb        = list(map(number))
    autoscaling_scale_in_control = object({
      fixed_replicas   = number
      percent_replicas = number
      time_window_sec  = number
    })


  }))
}

variable "load_balancer_info01" {type = map }
variable "load_balancer_info02" {type = map }
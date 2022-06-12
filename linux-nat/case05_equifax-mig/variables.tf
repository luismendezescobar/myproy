
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
      instance_redistribution_type = string
      max_surge_fixed              = number
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

/*
variable "load_balancer_info01" {type = map }
variable "load_balancer_info02" {type = map }
*/
variable "load_balancer_info" {
  description = "backend and front end details"
  type = map(object({
    region                = string
    protocol              = string
    load_balancing_scheme = string
    session_affinity      = string
    balancing_mode        = string
    vpc                   = string
    forwarding_name       = string
    ip_protocol           = string
    all_ports             = bool
    allow_global_access   = bool
    network               = string
    subnetwork            = string
  }))
}



variable "server_vm_info" {
  description = "the number of DB server instances"
  type = map(object({
    disk_size             = number
    compute_image_project = string
    gce_image_family      = string
    labels                = map(string) 
    machine_type          = string
    project               = string
    service_account       = object({
      email   = string
      scopes  = list(string)
    })
    metadata              = map(string)
    startup_script_file   = string
    subnetwork            = string
    zone                  = string
  }))
  default = {}
}

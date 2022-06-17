variable "instance_template_map" {
  description = "the number of DB server instances"
  type = map(object({
    project_id        = string
    subnetwork        = string
    subnetwork_project= string
    source_image      = string
    source_image_family=string
    source_image_project=string
    init_script       = string    
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
   // zone              = string
    region            = string      
    network_tags      = list(string)    
    name_prefix       = string
    machine_type      = string
    disk_size_gb      = string    
    disk_type         = string
    auto_delete       = string        
   // external_ip       = list(string)
    can_ip_forward    = string
    on_host_maintenance = string
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
*/
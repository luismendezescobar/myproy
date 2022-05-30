resource "google_compute_instance_template" "instance_template" {
  project         = var.project_id
  region          = var.region
  name            = lower(var.server_name)
  machine_type    = var.instance_machine_type
  tags            = var.network_tags
  description     = var.instance_description
  can_ip_forward  = var.can_ip_forward

  metadata_startup_script = file(var.init_script)  

//boot disk
  disk {
      auto_delete = true 
      disk_size_gb  = var.disk_size_gb
      source_image = var.source_image
      disk_type  = var.boot_disk_type
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  /*
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
*/
  network_interface {
    subnetwork_project = var.subnetwork_project
    subnetwork         = var.subnetwork1    
  }
  network_interface {
    subnetwork_project = var.subnetwork_project
    subnetwork         = var.subnetwork2    
  }

}



resource "google_compute_health_check" "tcp_health_check22" {
  name                = lookup(var.health_check, "name", null)
  project             = var.project_id
  check_interval_sec  = lookup(var.health_check, "check_interval_sec", null)
  timeout_sec         = lookup(var.health_check, "timeout_sec", null)
  healthy_threshold   = lookup(var.health_check, "healthy_threshold", null)
  unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold", null)
  tcp_health_check {
    port = lookup(var.health_check, "port", null)
  }
}


resource "google_compute_region_instance_group_manager" "mig_nat" {
  name = lookup(var.mig_info, "name", null)

  base_instance_name = lookup(var.mig_info, "base_instance_name", null)     //change here to change the name of the servers
  region = var.region
  distribution_policy_zones  = var.mig_zones
  
  target_size = lookup(var.mig_info, "target_size", null)

  version {
    instance_template  =google_compute_instance_template.instance_template.id

  }

  auto_healing_policies {
    health_check      = google_compute_health_check.tcp_health_check22.id
    initial_delay_sec = lookup(var.mig_info, "initial_delay_sec", null)
  }
}

resource "google_compute_region_autoscaler" "default" {
  name   = "autoscaler-nat"
  zone   = "us-east1-b"
  target = google_compute_region_instance_group_manager.mig_nat.id

  autoscaling_policy {
    max_replicas    = 4
    min_replicas    = 2
    cooldown_period = 60
    cpu_utilization {
      target = 0.6
    }

/*
    metric {
      name                       = "pubsub.googleapis.com/subscription/num_undelivered_messages"
      filter                     = "resource.type = pubsub_subscription AND resource.label.subscription_id = our-subscription"
      single_instance_assignment = 65535
    }*/
  }
}


############################VPC SHARED#########################################################

# backend service
resource "google_compute_region_backend_service" "backend_service_shared_tcp" {
  name                  = lookup(var.load_balancer_info01, "lb_name", null) ///this is the load balancer name
  region                = var.region
  protocol              = lookup(var.load_balancer_info01, "protocol", null)
  load_balancing_scheme = lookup(var.load_balancer_info01, "load_balancing_scheme", null)
  session_affinity      = lookup(var.load_balancer_info01, "session_affinity", null)
  health_checks         = [google_compute_health_check.tcp_health_check22.id]
  backend {
    group               = google_compute_region_instance_group_manager.mig_nat.instance_group
    balancing_mode      = lookup(var.load_balancer_info01, "balancing_mode", null)
  }
  network               = lookup(var.load_balancer_info01, "network", null)
}


# forwarding rule
resource "google_compute_forwarding_rule" "forwarding_rule_shared_tcp" {
  name                  = lookup(var.load_balancer_info01, "forwarding_name", null)
  backend_service       = google_compute_region_backend_service.backend_service_shared_tcp.id  
  region                = var.region
  ip_protocol           = lookup(var.load_balancer_info01, "ip_protocol", null)
  load_balancing_scheme = lookup(var.load_balancer_info01, "load_balancing_scheme", null)
  all_ports             = lookup(var.load_balancer_info01, "all_ports", true)
  allow_global_access   = lookup(var.load_balancer_info01, "allow_global_access", false)
  network               = lookup(var.load_balancer_info01, "network", false)
  subnetwork            = lookup(var.load_balancer_info01, "subnetwork", false)
}

################################# VPC LOCAL ##################################################
# backend service
resource "google_compute_region_backend_service" "backend_service_local_tcp" {
  name                  = lookup(var.load_balancer_info02, "lb_name", null) ///this is the load balancer name
  region                = var.region
  protocol              = lookup(var.load_balancer_info02, "protocol", null)
  load_balancing_scheme = lookup(var.load_balancer_info02, "load_balancing_scheme", null)
  session_affinity      = lookup(var.load_balancer_info02, "session_affinity", null)
  health_checks         = [google_compute_health_check.tcp_health_check22.id]
  backend {
    group               = google_compute_region_instance_group_manager.mig_nat.instance_group
    balancing_mode      = lookup(var.load_balancer_info02, "balancing_mode", null)
  }
  network               = lookup(var.load_balancer_info02, "network", null)
}

# forwarding rule
resource "google_compute_forwarding_rule" "forwarding_rule_local_tcp" {
  name                  = lookup(var.load_balancer_info02, "forwarding_name", null)
  backend_service       = google_compute_region_backend_service.backend_service_local_tcp.id  
  region                = var.region
  ip_protocol           = lookup(var.load_balancer_info02, "ip_protocol", null)
  load_balancing_scheme = lookup(var.load_balancer_info02, "load_balancing_scheme", null)
  all_ports             = lookup(var.load_balancer_info02, "all_ports", true)
  allow_global_access   = lookup(var.load_balancer_info02, "allow_global_access", false)
  network               = lookup(var.load_balancer_info02, "network", false)
  subnetwork            = lookup(var.load_balancer_info02, "subnetwork", false)
}



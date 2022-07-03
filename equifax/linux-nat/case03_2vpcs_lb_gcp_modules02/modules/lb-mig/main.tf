############################VPC SHARED#########################################################

# backend service
resource "google_compute_region_backend_service" "backend_service_shared_tcp" {
  name                  = lookup(var.load_balancer_info01, "lb_name", null) ///this is the load balancer name
  region                = var.region
  protocol              = lookup(var.load_balancer_info01, "protocol", null)
  load_balancing_scheme = lookup(var.load_balancer_info01, "load_balancing_scheme", null)
  session_affinity      = lookup(var.load_balancer_info01, "session_affinity", null)
  health_checks         = var.health_check
  backend {
    group               = var.mig_group
    balancing_mode      = lookup(var.load_balancer_info01, "balancing_mode", null)
  }
  network               = lookup(var.load_balancer_info01, "network", null)
}


# forwarding rule it's the front end
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
  health_checks         = var.health_check
  backend {
    group               = var.mig_group
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



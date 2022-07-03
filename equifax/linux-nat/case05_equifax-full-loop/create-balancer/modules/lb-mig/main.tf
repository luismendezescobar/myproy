############################VPC SHARED#########################################################

# backend service
resource "google_compute_region_backend_service" "backend_service_shared_tcp" {
  name                  = var.lb_name ///this is the load balancer name
  project               = var.project_id
  region                = var.region
  protocol              = var.protocol
  load_balancing_scheme = var.load_balancing_scheme
  session_affinity      = var.session_affinity
  health_checks         = var.health_check
  backend {
    group               = var.mig_group
    balancing_mode      = var.balancing_mode
  }
  network               = var.network
}


# forwarding rule it's the front end
resource "google_compute_forwarding_rule" "forwarding_rule_shared_tcp" {
  name                  = var.forwarding_name
  backend_service       = google_compute_region_backend_service.backend_service_shared_tcp.id  
  region                = var.region
  ip_protocol           = var.ip_protocol
  load_balancing_scheme = var.load_balancing_scheme
  all_ports             = var.all_ports
  allow_global_access   = var.allow_global_access
  network               = var.network
  subnetwork            = var.subnetwork
}

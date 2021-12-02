
locals {
  distinct_zones = {
    for zone in distinct([for server in var.instances : server.zone]) : zone => zone
  }
  ports     = var.named_port[*].port
  all_ports = var.frontend_ports != [] ? concat(var.frontend_ports, local.ports) : local.ports
}


resource "google_compute_instance_group" "webservers_zone" {
  for_each = local.distinct_zones

  name        = join("-", [var.name, each.value])
  description = "Connect Ship Instance group for zone: ${each.value}"

  instances = [for instance in var.instances : instance.self_link if instance.zone == each.value]
 

  dynamic "named_port" {
    for_each = var.named_port
    content {
      name = lookup(named_port.value, "name", null)
      port = lookup(named_port.value, "port", null)
    }
  }

  zone = each.value
}



resource "google_compute_health_check" "ilb_health_check" {
  name    = join("-", [var.name, "health"])
  project = var.project_id

  check_interval_sec  = lookup(var.health_check, "check_interval_sec", null)
  description         = lookup(var.health_check, "description", null)
  healthy_threshold   = lookup(var.health_check, "healthy_threshold", null)
  timeout_sec         = lookup(var.health_check, "timeout_sec", null)
  unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold", null)
  

  tcp_health_check {
    request            = lookup(var.health_check, "request", null)
    response           = lookup(var.health_check, "response", null)
    port               = lookup(var.health_check, "port", null)
    port_name          = lookup(var.health_check, "port_name", null)
    proxy_header       = lookup(var.health_check, "proxy_header", null)
    port_specification = lookup(var.health_check, "port_specification", null)
  }
}

resource "google_compute_region_backend_service" "backend" {
  health_checks = [google_compute_health_check.ilb_health_check.self_link]
  name          = join("-", [var.name, "backend-service"])

  dynamic "backend" {
    for_each = google_compute_instance_group.webservers_zone
    content {
      group = lookup(backend.value, "id")
    }
  }
  load_balancing_scheme = "INTERNAL"
  protocol              = "TCP"
  network               = var.network
  region                = var.region
}

resource "google_compute_forwarding_rule" "rule" {
  count                 = length(local.all_ports) == 0 ? 0 : 1
  name                  = join("-", [var.name, var.frontend_name])
  region                = var.region
  load_balancing_scheme = "INTERNAL"
  ports                 = local.all_ports
  backend_service       = google_compute_region_backend_service.backend.id
  network               = var.network
  subnetwork            = var.subnetwork
  allow_global_access   = true
}

resource "google_compute_forwarding_rule" "rule_all_ports" {
  count                 = length(local.all_ports) == 0 ? 1 : 0
  name                  = join("-", [var.name, var.frontend_name])
  region                = var.region
  load_balancing_scheme = "INTERNAL"
  all_ports             = true
  backend_service       = google_compute_region_backend_service.backend.id
  network               = var.network
  subnetwork            = var.subnetwork
  allow_global_access   = true
}

resource "google_compute_region_network_endpoint_group" "default" {
  for_each = var.end_points

  name                  = each.value.service_name
  network_endpoint_type = "SERVERLESS"
  region                = each.value.region_endpoint
  project               = var.project_id
  dynamic "cloud_run" {
    for_each = each.value.type == "cloud_run" ? [{
      service = each.value.service
      tag     = each.value.tag
    }] : []
    content {
      service = cloud_run.value.service
      tag     = cloud_run.value.tag
    }
  }
  dynamic "app_engine" {
    for_each = each.value.type == "app_engine" ? [{
      service = each.value.service
      version = each.value.version
    }] : []
    content {
      service = app_engine.value.service
      version = app_engine.value.version
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "google_compute_url_map" "url_map" {
  name            = var.lb_name
  description     = "url mapping for ${var.lb_name}"
  project         = var.project_id
  default_service = module.lb-http.backend_services[var.default_service].self_link

  dynamic "host_rule" {
    for_each = var.url_map
    content {
      hosts        = [host_rule.value.domain]
      path_matcher = host_rule.value.path_matcher
    }
  }

  dynamic "path_matcher" {
    for_each = var.url_map
    content {
      name            = path_matcher.value.path_matcher
      default_service = module.lb-http.backend_services[path_matcher.value.default_service].self_link
      dynamic "route_rules" {
        for_each = var.weighted_class == true ? [1] : []
        content {          
          dynamic "match_rules" {
            for_each=path_matcher.value.end_point_maps
            content {
              priority     = match_rules.value.priority
              prefix_match = match_rules.value.prefix_match            
              route_action {
                dynamic "weighted_backend_services" {
                  for_each = match_rules.value.weightedBEServices
                  content {
                    backend_service = module.lb-http.backend_services[weighted_backend_services.value.service_name].self_link
                    weight          = weighted_backend_services.value.weight
                  }
                }
              }
            }
          }    
        }
      }
      dynamic "path_rule" {
        for_each = var.paths_class == true ? path_matcher.value.end_point_maps : {}
        content {
          paths   = path_rule.value.path
          service = module.lb-http.backend_services[path_rule.value.service_name].self_link
          dynamic "route_action" {
            for_each = can(path_rule.value.path_prefix_rewrite) ? [{ "path_prefix_rewrite" : path_rule.value.path_prefix_rewrite }] : []
            content {
              url_rewrite {
                path_prefix_rewrite = route_action.value.path_prefix_rewrite
              }
            }
          }
        }
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
/*
data "google_compute_global_address" "service-lb-ipv4" {
  name    = var.ipv4_name
  project = var.ipv4_project
}
data "google_compute_global_address" "service-lb-ipv6" {
  count   = var.enable_ipv6 ? 1 : 0
  name    = var.ipv6_name
  project = var.ipv6_project
}
*/
module "lb-http" {
  source = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"

  version              = "~> 8.0.0"
  name                 = var.lb_name
  project              = var.project_id
  #address              = data.google_compute_global_address.service-lb-ipv4.address
  #enable_ipv6          = var.enable_ipv6
  #ipv6_address         = var.enable_ipv6 ? data.google_compute_global_address.service-lb-ipv6[0].address : null
  #create_address       = false
  #ssl                  = true
  #use_ssl_certificates = true
  #ssl_certificates     = var.certificates
  #https_redirect       = var.https_redirect
  #http_forward                    = false
  load_balancing_scheme = var.load_balancing_scheme
  create_url_map        = false
  url_map               = google_compute_url_map.url_map.self_link
  #ssl_policy            = var.ssl_policy

  backends = {
    for serviceObj in var.end_points :
    serviceObj.service_name => {
      description = "${serviceObj.service_name}${serviceObj.tag}"
      groups = [
        {
          group = google_compute_region_network_endpoint_group.default[serviceObj.service_name].self_link
        }
      ]
      enable_cdn              = var.enable_cdn
      security_policy         = serviceObj.security_policy != null ? "projects/${var.project_id}/global/securityPolicies/${serviceObj.security_policy}" : null
      custom_request_headers  = serviceObj.custom_request_headers
      custom_response_headers = serviceObj.custom_response_headers
      timeout_sec             = 300
      compression_mode        = null
      protocol                = null
      port                    = 443
      port_name               = null
      iap_config              = serviceObj.iap
      log_config = {
        enable      = var.log_config_enable
        sample_rate = var.log_config_enable ? 1 : null
      }
    }
  }
}
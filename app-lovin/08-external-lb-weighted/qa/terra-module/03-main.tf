resource "google_compute_region_network_endpoint_group" "default" {
  for_each = { for item in var.map_services :
  item.service_name => item }

  name                  = each.value.service_name
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  project               = var.project_id
  dynamic "cloud_run" {
    for_each = each.value.type == "cloud_run" ? [{
      service = each.value.service
      #tag     = each.value.tag
    }] : []
    content {
      service = cloud_run.value.service
      #tag     = cloud_run.value.tag
    }
  }
  dynamic "app_engine" {
    for_each = each.value.type == "app_engine" ? [{ 
      service = each.value.service 
    }] : []
    content {
      service = app_engine.value.service
    }
  }
}

resource "google_compute_url_map" "url-map" {
  name            = "dev-url-map"
  description     = "dev url mapping for ${var.domain}"
  project         = var.project_id
  default_service = module.lb-http.backend_services["default"].self_link
  host_rule {
    hosts        = [var.domain]
    path_matcher = "main"
  }
  path_matcher {
    name            = "main"
    default_service = module.lb-http.backend_services["default"].self_link
    route_rules {
      priority = 1
      match_rules {
        prefix_match = "/"
      }
      route_action {
        weighted_backend_services {          
          backend_service = module.lb-http.backend_services["default"].self_link
          weight = 50
        }        
        weighted_backend_services {
          backend_service = module.lb-http.backend_services["pt-identity"].self_link
          weight = 50
          /*header_action {
            request_headers_to_remove = ["RemoveMe"]
            request_headers_to_add {
              header_name = "AddMe"
              header_value = "MyValue"
              replace = true
            }
            response_headers_to_remove = ["RemoveMe"]
            response_headers_to_add {
              header_name = "AddMe"
              header_value = "MyValue"
              replace = false
            }
          }*/
        }
        /*        
        url_rewrite {
          #host_rewrite = "google.com"
          path_prefix_rewrite   = "/api/v1/identity/device/login"          
        }
        */
      }        
    }
  }
}


data "google_compute_global_address" "service-lb-ipv4" {
  name    = "wordscapes-lb-ipv4-qa"
  project = "pt-net-dev-1j8y"
}
data "google_compute_global_address" "service-lb-ipv6" {
  name    = "wordscapes-lb-ipv6-qa"
  project = "pt-net-dev-1j8y"
}

module "lb-http" {
  source = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"

  version              = "~> 7.0.0"
  name                 = "dev-net-lb"
  project              = var.project_id
  address              = data.google_compute_global_address.service-lb-ipv4.address
  enable_ipv6          = true
  ipv6_address         = data.google_compute_global_address.service-lb-ipv6.address 
  create_address       = false
  ssl                  = true
  use_ssl_certificates = true
  ssl_certificates     = ["projects/pt-services-dev-wepg/global/sslCertificates/wordscapes-cert-api-cdn-qa"]
  https_redirect       = true
  #http_forward                    = false
  load_balancing_scheme = "EXTERNAL_MANAGED"
  create_url_map        = false
  url_map               = google_compute_url_map.url-map.self_link

  backends = {
    for serviceObj in var.map_services :
    serviceObj.service_name => {
      description = "${serviceObj.service_name}${serviceObj.tag}"
      groups = [
        {
          group = google_compute_region_network_endpoint_group.default[serviceObj.service_name].self_link
        }
      ]
      enable_cdn              = true
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null
      timeout_sec             = 300
      compression_mode        = null
      protocol                = null
      port                    = 443
      port_name               = null

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
    }
  }
}



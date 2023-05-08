resource "google_compute_region_network_endpoint_group" "default" {
  for_each = {for item in var.map_services: 
              item.service_name => item}

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
}

resource "google_compute_url_map" "url-map" {
  name        = "dev-url-map"
  description = "dev url mapping for ${var.domain}"
  project     = var.project_id
  default_service = module.lb-http.backend_services["default"].self_link
  host_rule {
      hosts        =  [var.domain]
      path_matcher = "main"
  }
  path_matcher {
    name            = "main"
    default_service = module.lb-http.backend_services["default"].self_link 
    dynamic "path_rule" {
      for_each = var.map_services
      content {
        paths   = [path_rule.value.path]
        service = module.lb-http.backend_services[path_rule.value.service_name].self_link
      }
    }
  }
}


data "google_compute_global_address" "service-lb-ip" {
  name = "dev-lb-ip"
}

module "lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  
  version = "~> 7.0.0"
  name    = "dev-net-lb"
  project = var.project_id
  address        = data.google_compute_global_address.service-lb-ip.address
  create_address = false
  ssl                             = true
  use_ssl_certificates            = true
  #ssl_certificates                = [resource.google_compute_ssl_certificate.default.self_link]
  ssl_certificates                = ["projects/pt-net-dev-1j8y/locations/global/certificates/rootcert-7bd1"]
  #this was added to try to add the root certificate
  certificate_map= "projects/pt-net-dev-1j8y/locations/global/certificateMaps/certmap-peoplefungames-dev-com-7bd1"
  https_redirect                  = true
  #https_redirect                  = false
  #http_forward                    = false
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  create_url_map                  = false  
  url_map                         = google_compute_url_map.url-map.self_link

  backends = {
    for serviceObj in var.map_services :
    serviceObj.service_name => {
      description = "${serviceObj.service_name}${serviceObj.tag}"
      groups = [
        {
          group = google_compute_region_network_endpoint_group.default[serviceObj.service_name].self_link
        }
      ]
      enable_cdn              = false
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null
      timeout_sec             = 300
      compression_mode        = null
      protocol                = null
      port                    = 443
      port_name               =null

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



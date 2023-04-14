resource "random_string" "random" {
  count   = var.notebook_name == "" ? 1 : 0
  length  = 16
  special = false
}
resource "google_compute_region_network_endpoint_group" "default" {
  for_each = {for item in var.map_services: 
              item.service_name => item}

  name                  = lower("${each.value.service_name}-${resource.random_string.random[0].result}")
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
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_url_map" "url-map" {
  name        = lower("dev-url-map-${resource.random_string.random[0].result}")
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
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_ssl_certificate" "default" {
  name_prefix = "my-certificate"
  description = "a description"
  private_key = file("./helpers/private.key")
  certificate = file("./helpers/certificate.crt")

  lifecycle {
    create_before_destroy = true
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
  ssl_certificates                = [resource.google_compute_ssl_certificate.default.self_link]
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




/*
module "lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version           = "~> 7.0"
  project = var.project_id
  name    = "extlb"

  ssl                             = true
  use_ssl_certificates            = true
  ssl_certificates                = [resource.google_compute_ssl_certificate.default.self_link]
  https_redirect                  = true
  http_forward                    = false
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  
  #we need to test this option tomorrow
  url_map                         = google_compute_url_map.urlmap.self_link
  backends = {
    default = {
      description            = "backend-pets-adopt-white"
      enable_cdn             = true
      compression_mode       = null
      custom_request_headers = null
      custom_response_headers= null
      protocol                        = "HTTPS"
      port                            = 443
      port_name             =null
      log_config = {
        enable      = true
        sample_rate = 1.0
      }
      groups = [        
        {
          group = "projects/${var.project_id}/regions/us-central1/networkEndpointGroups/neg-pets-adopt-white"
        }
      ]
      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
      security_policy = null
    }
    backend-pets-adopt-dodger = {
      description            = "backend-pets-adopt-blue-dodger"
      enable_cdn             = true
      compression_mode       = null
      custom_request_headers = null
      custom_response_headers= null
      protocol                        = "HTTPS"
      port                            = 443
      port_name             =null
      log_config = {
        enable      = true
        sample_rate = 1.0
      }
      groups = [        
        {
          group = "projects/${var.project_id}/regions/us-central1/networkEndpointGroups/neg-pets-adopt-dodger"
        }
      ]
      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
      security_policy = null
    }

  }
  depends_on = [
    google_compute_region_network_endpoint_group.default
  ]
}
*/

#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
#https://github.com/terraform-google-modules/terraform-google-lb-http/blob/v7.0.0/examples/multi-backend-multi-mig-bucket-https-lb/main.tf
/*
resource "google_compute_url_map" "urlmap" {
  name        = "urlmap"
  description = "a description for url map"
  default_service = module.lb-http.backend_services["default"].self_link

  host_rule {
    hosts        = ["luismendeze.com"]
    path_matcher = "luismendeze"
  }
  path_matcher {
      name            = "luismendeze"
      default_service = module.lb-http.backend_services["default"].self_link

      path_rule {
        paths   = ["/white"]
        service = module.lb-http.backend_services["default"].self_link
      }
      path_rule {
        paths   = ["/dodger"]
        service = module.lb-http.backend_services["backend-pets-adopt-dodger"].self_link
      }

  }
}
*/
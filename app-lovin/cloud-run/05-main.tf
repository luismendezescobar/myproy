#https://github.com/terraform-google-modules/terraform-google-lb-http/blob/master/examples/cloudrun/main.tf


provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.2.0"
  for_each = var.cloud_run_map  

  # Required variables
  service_name           = each.key
  generate_revision_name = each.value.generate_revision_name
  image                  = each.value.image
  limits                 = each.value.limits
  location               = each.value.location
  members                = each.value.members
  ports                  = each.value.ports
  project_id             = each.value.project_id
  service_account_email  = each.value.service_account_email
  service_annotations    = each.value.service_annotations
  traffic_split          = each.value.traffic_split

}
resource "google_compute_region_network_endpoint_group" "default" {
  for_each = local.cloud_run_services

  name                  = "neg-${each.value.service_name}"
  network_endpoint_type = "SERVERLESS"
  region                = each.value.location
  cloud_run {
    service = each.value.service_name
  }
}

resource "google_compute_ssl_certificate" "default" {
  name_prefix = "my-certificate-"
  description = "a description"
  private_key = file("./helpers/certificates/private.key")
  certificate = file("./helpers/certificates/certificate.crt")

  lifecycle {
    create_before_destroy = true
  }
}

module "lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version           = "~> 7.0"
  project = var.project_id
  name    = "extlb"  
  ssl                             = true
  use_ssl_certificates            = true
  ssl_certificates                = [resource.google_compute_ssl_certificate.default.self_link]
    https_redirect                  = false
  http_forward                    = false
  load_balancing_scheme           = "EXTERNAL_MANAGED"
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
#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
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

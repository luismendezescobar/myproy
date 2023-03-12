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
resource "google_compute_global_address" "external_ip" {
  project      = var.project_id # Replace this with your service project ID in quotes
  name         = "lb-address"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}


module "lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version           = "~> 7.0"

  project = var.project_id
  name    = "external_lb"
  address = resource.google_compute_global_address.external_ip
  use_ssl_certificates            = false
  certificate                     = "../helpers/certificates/certificate.crt"
  private_key                     = "../helpers/certificates/private.key"
  
  https_redirect                  = true

 

  backends = {
    pets-adopt-white = {
      description            = "backend-pets-adopt-white"
      enable_cdn             = true
      compression_mode       = null
      custom_request_headers = null
      custom_response_headers= null
      protocol                        = "HTTPS"
      port                            = 443
      port_name                       = "https"


      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [        
        {
          group = "neg-pets-adopt-white"
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
}

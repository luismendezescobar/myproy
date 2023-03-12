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
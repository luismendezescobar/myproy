locals {   
  project_org_id    = var.folder_id != "" ? null : var.org_id
  project_folder_id = var.folder_id != "" ? var.folder_id : null  
}

resource "google_project" "main" {
  name                = var.name
  project_id          = var.project_id
  org_id              = local.project_org_id
  folder_id           = local.project_folder_id
  billing_account     = var.billing_account  
  auto_create_network = var.auto_create_network
  labels              = var.labels
}
/******************************************
  APIs configuration
 *****************************************/
resource "google_project_service" "project_services" {
  for_each                   = toset(var.activate_apis)
  project                    = google_project.main.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services
}
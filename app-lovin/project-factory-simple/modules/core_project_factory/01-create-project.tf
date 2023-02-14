resource "google_project" "main" {
  name                = var.name
  project_id          = local.temp_project_id
  org_id              = local.project_org_id
  billing_account     = var.billing_account
  folder_id           = local.project_folder_id  
  auto_create_network = var.auto_create_network
  labels              = var.labels
}


/******************************************
  APIs configuration
 *****************************************/
/*
module "project_services" {
  source = "../project_services"

  project_id                  = google_project.main.project_id
  activate_apis               = var.activate_apis
  disable_services_on_destroy = var.disable_services_on_destroy
  disable_dependent_services  = var.disable_dependent_services
}
*/
resource "google_project_service" "project_services" {
  for_each                   = toset(var.activate_apis)
  project                    = google_project.main.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services
}
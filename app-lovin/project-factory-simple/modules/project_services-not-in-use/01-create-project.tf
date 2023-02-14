locals {  
  services = var.enable_apis ? toset(concat(var.activate_apis, [for i in var.activate_api_identities : i.api])) : toset([])
 
}


/******************************************
  APIs configuration
 *****************************************/
resource "google_project_service" "project_services" {
  for_each                   = toset(var.activate_apis)
  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services
}
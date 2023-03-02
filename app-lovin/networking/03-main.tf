/*
we are going to use this module
https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/vpc

*/

module "map_to_vpc_config_module" {
  source  = "terraform-google-modules/network/google"
  version = "~> 6.0"

  for_each         = var.map_vpc_config
  project_id       = each.value.project_id
  network_name     = each.value.network_name
  routing_mode     = each.value.routing_mode
  subnets          = each.value.subnets
  secondary_ranges = each.value.secondary_ranges
  routes           = each.value.routes
}

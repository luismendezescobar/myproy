
/*
module "vpc_creation" {
  for_each = var.vpc_info
  source  = "terraform-google-modules/network/google//modules/vpc"
  version="~> 5.1.0"
  project_id              = var.project_id
  network_name            = each.key
  auto_create_subnetworks = each.value.auto_create_subnetworks

}

module "subnets_creation" {
  for_each = var.vpc_info
  source  = "terraform-google-modules/network/google//modules/subnets"
  version="~> 5.1.0"
  project_id        = var.project_id
  network_name      = each.key
  subnets           = each.value.subnets
  secondary_ranges  = each.value.secondary_ranges
  depends_on = [
    module.vpc_creation
  ]
}


module "firewall_rules_create" {
  for_each = var.firewall_rules
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version="~> 5.1.0"
  project_id   = var.project_id 
  network_name = each.value.network_name
  rules        = each.value.rules
  depends_on = [
    module.subnets_creation
  ]
}

module "cloud_router_creation" {
  for_each=var.cloud_nat_map
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 2.0.0"

  name    = each.value.router_name
  project = var.project_id
  region  = each.value.region
  network = each.value.network
  bgp     = each.value.bgp
  depends_on = [
    module.firewall_rules_create
  ]
}

output "router_name" {
  value = [for item in module.cloud_router_creation:item.router.name ]
  
}

module "cloud_nat_gtw_create" {
  for_each = var.cloud_nat_map
  source        = "terraform-google-modules/cloud-nat/google"  
  version       = "~> 1.2"
  project_id    = var.project_id
  name          = each.key
  region        = each.value.region
  router        = each.value.router_name
  nat_ip_allocate_option            = each.value.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat= each.value.source_subnetwork_ip_ranges_to_nat
  log_config_enable                 = each.value.log_config_enable
  log_config_filter                 = each.value.log_config_filter


  depends_on = [
    module.cloud_router_creation
  ]
}

*/

module "nat_single_server_creation" {
  source                    = "./modules/create-vm"
  for_each                  = var.server_nat_info
  server_name               = each.key
  gce_image_family          = each.value.gce_image_family
  compute_image_project     = each.value.compute_image_project
  project_id                = var.project_id    
  machine_type              = each.value.machine_type
  zone                      = each.value.zone
  labels                    = each.value.labels
  auto_delete               = each.value.auto_delete
  kms_key_self_link         = each.value.kms_key_self_link
  disk_size                 = each.value.disk_size
  disk_type                 = each.value.disk_type
  subnetwork_project        = var.project_id
  subnetwork                = each.value.subnetwork
  external_ip               = each.value.external_ip
  additional_networks       = each.value.additional_networks
  service_account           = each.value.service_account
  tags                      = each.value.tags
  metadata                  = each.value.metadata
  startup_script            = each.value.startup_script
  description               = each.value.description
  can_ip_forward            = each.value.can_ip_forward
  allow_stopping_for_update = each.value.allow_stopping_for_update
  additional_disks          = each.value.additional_disks


}


module "create_routes" {
  source                    = "./modules/gcp-routes"  
  depends_on = [
    module.nat_single_server_creation
  ]
}
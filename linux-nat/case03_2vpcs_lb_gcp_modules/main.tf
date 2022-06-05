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

module "instance_template_creation" {
  for_each        = var.instance_template_map
  source          = "terraform-google-modules/vm/google//modules/instance_template"
  version         = "~> 7.7.0"
  name_prefix     = each.key
  project_id      = var.project_id
  region          = each.value.region
  machine_type    = each.value.machine_type
  tags            = each.value.network_tags
  description     = each.value.description
  can_ip_forward  = each.value.can_ip_forward
  startup_script  = file(each.value.init_script)
  auto_delete     = each.value.auto_delete
  disk_size_gb    = each.value.disk_size_gb
  source_image    = each.value.source_image
  disk_type       = each.value.boot_disk_type
  on_host_maintenance = each.value.on_host_maintenance
  subnetwork          = each.value.subnet_name1
  subnetwork_project  = var.project_id
  additional_networks = each.value.additional_networks
  service_account     = each.value.service_account

  depends_on = [
    module.cloud_nat_gtw_create
  ]
  
}
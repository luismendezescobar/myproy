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

output "map1" {
  value=var.instance_template_map.nat-server
}
output "map2" {
  value=var.instance_template_map
}
output "map3" {
  value=var.instance_template_map.nat-server.region
}
*/
///////// we are going to start from there /////////
/*
module "instance_template_creation" {
  source          = "terraform-google-modules/vm/google//modules/instance_template"
  version         = "~> 7.7.0"
  name_prefix     = var.instance_template_map.nat-server.name_prefix
  project_id      = var.project_id
  region          = var.instance_template_map.nat-server.region
  machine_type    = var.instance_template_map.nat-server.machine_type
  tags            = var.instance_template_map.nat-server.network_tags
  #description     = each.value.description
  can_ip_forward  = var.instance_template_map.nat-server.can_ip_forward
  startup_script  = file(var.instance_template_map.nat-server.init_script)
  auto_delete     = var.instance_template_map.nat-server.auto_delete
  disk_size_gb    = var.instance_template_map.nat-server.disk_size_gb
  #source_image    = each.value.source_image
  source_image_family=var.instance_template_map.nat-server.source_image_family
  source_image_project=var.instance_template_map.nat-server.source_image_project
  disk_type       = var.instance_template_map.nat-server.disk_type
  on_host_maintenance = var.instance_template_map.nat-server.on_host_maintenance
  subnetwork          = var.instance_template_map.nat-server.subnetwork
  subnetwork_project  = var.project_id
  //modify the project id in the 
  additional_networks = var.instance_template_map.nat-server.additional_networks
  service_account     = var.instance_template_map.nat-server.service_account

  depends_on = [
    module.cloud_nat_gtw_create
  ]
  
}

module "vm_mig_creation" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "7.7.0"
  # insert the 4 required variables here
  project_id            = var.project_id
  hostname              = var.mig_map.mig-nat.hostname
  region                = var.mig_map.mig-nat.region
  instance_template     = module.instance_template_creation.self_link
  //target_size               = var.target_size
  //target_pools              = var.target_pools
  distribution_policy_zones =var.mig_map.mig-nat.distribution_policy_zones
  update_policy         = var.mig_map.mig-nat.update_policy
  //  health check 
  health_check          = var.mig_map.mig-nat.health_check

  // autoscaler 
  autoscaling_enabled          = var.mig_map.mig-nat.autoscaling_enabled
  max_replicas                 = var.mig_map.mig-nat.max_replicas
  min_replicas                 = var.mig_map.mig-nat.min_replicas
  cooldown_period              = var.mig_map.mig-nat.cooldown_period
  autoscaling_cpu              = var.mig_map.mig-nat.autoscaling_cpu
  autoscaling_metric           = var.mig_map.mig-nat.autoscaling_metric
  autoscaling_lb               = var.mig_map.mig-nat.autoscaling_lb
  autoscaling_scale_in_control = var.mig_map.mig-nat.autoscaling_scale_in_control

}

module "lb_creation" {
  for_each              = var.load_balancer_info
  source                = "./modules/lb-mig"  
  region                = each.value.region
  health_check          = module.vm_mig_creation.health_check_self_links 
  mig_group             = module.vm_mig_creation.instance_group
  lb_name               = each.key
  protocol              = each.value.protocol
  load_balancing_scheme = each.value.load_balancing_scheme
  session_affinity      = each.value.session_affinity
  balancing_mode        = each.value.balancing_mode
  vpc                   = each.value.vpc
  forwarding_name       = each.value.forwarding_name
  ip_protocol           = each.value.ip_protocol
  all_ports             = each.value.all_ports
  allow_global_access   = each.value.allow_global_access
  network               = each.value.network
  subnetwork            = each.value.subnetwork
}
*/
/* this will be done by the network team
module "create_routes" {
  source                    = "./modules/gcp-routes"  
  depends_on = [
    module.lb_creation
  ]
}
*/
module "vm_instances_creation" {
  for_each                  = var.server_vm_info
  source                    = "git::https://github.com/Equifax/7265_GL_GCE_IAAS.git?ref=v2.1.4"
  blocksshkeys              = true
  disk_size                 = each.value.boot_disk_size_gb
  compute_image_project     = each.value.compute_image_project
  gce_image_family          = each.value.gce_image_family
  labels                    = each.value.labels
  machine_type              = each.value.machine_type
  name                      = each.key
  oslogin                   = false 
  project                   =  each.value.project
  service_account           = each.value.service_account
  metadata                  = each.value.metadata
  startup_script_file       = each.value.startup_script_file
  subnetwork                = each.value.subnetwork
  zone                      = each.value.zone


}

output "vm_instances_creation_ip" {
  value=[for i in module.vm_instances_creation:i]
}
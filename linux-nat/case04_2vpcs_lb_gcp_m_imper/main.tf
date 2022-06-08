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


module "instance_template_creation" {
  //for_each        = var.instance_template_map
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

output "template" {
  value=module.instance_template_creation.self_link
}



/* good code here but I will change the design
output "name2" { //this is the good
  value={for key, value in module.instance_template_creation:key=>value.self_link}
//output
//{
//"nat-server" = "https://www.googleapis.com/compute/v1/projects/playground-s-11-c77f7b64/global/instanceTemplates/nat-server-20220606000717456600000001"
//"nat-server2" = "https://www.googleapis.com/compute/v1/projects/playground-s-11-c77f7b64/global/instanceTemplates/nat-server-20220606000717456600000001"
//... etc
//}

}

output "name3" {
  value=[for key,value in module.instance_template_creation:lookup(value,"self_link")if key=="nat-server"] 
}

locals {
  map_mig_self_links={for key, value in module.instance_template_creation:key=>value.self_link}
  self_link_real= join("",[for key,value in local.map_mig_self_links:value if key=="nat-server"])
}
output "name_final_good" {
  value=local.self_link_real  
}
//with this one we remove the brackets and convert to string
//instance_template=join("",[for key,value in local.map_mig_self_links:value if key=="nat-server"])
*/


//this is pending

module "vm_mig_creation" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "7.7.0"
  # insert the 4 required variables here
  project_id            = var.project_id
  hostname              = var.mig_map.mig-nat.hostname
  region                = var.mig_map.mig-nat.region
  #autoscaling_mode      = "ON"
  instance_template     = module.instance_template_creation.self_link
  //target_size               = var.target_size
  //target_pools              = var.target_pools
  distribution_policy_zones =var.mig_map.mig-nat.distribution_policy_zones
  update_policy         = var.mig_map.mig-nat.update_policy
   /* health check */
  health_check          = var.mig_map.mig-nat.health_check

  /* autoscaler */
  autoscaling_enabled          = var.mig_map.mig-nat.autoscaling_enabled
  max_replicas                 = var.mig_map.mig-nat.max_replicas
  min_replicas                 = var.mig_map.mig-nat.min_replicas
  cooldown_period              = var.mig_map.mig-nat.cooldown_period
  autoscaling_cpu              = var.mig_map.mig-nat.autoscaling_cpu
  autoscaling_metric           = var.mig_map.mig-nat.autoscaling_metric
  autoscaling_lb               = var.mig_map.mig-nat.autoscaling_lb
  autoscaling_scale_in_control = var.mig_map.mig-nat.autoscaling_scale_in_control

}

output "vm_mig_creation01" {
  value=module.vm_mig_creation.health_check_self_links 
}
output "vm_mig_creation02" {
  value=module.vm_mig_creation.self_link  
}

module "lb_creation" {
  source                    = "./modules/lb-mig"  
  region                    = "us-east1"
  load_balancer_info01      = var.load_balancer_info01
  load_balancer_info02      = var.load_balancer_info02
  health_check              = module.vm_mig_creation.health_check_self_links 
  mig_group                 = module.vm_mig_creation.instance_group

}

module "create_routes" {
  source                    = "./modules/gcp-routes"  
  depends_on = [
    module.lb_creation
  ]
}



module "vm_instances_creation" {
  for_each                  = var.server_vm_info
  source                    = "./modules/create-vm"  
  server_name               = each.key
  project_id                = var.project_id
  zone                      = each.value.zone
  instance_description      = each.value.description
  network_tags             = each.value.network_tags
  instance_machine_type     = each.value.instance_type
  source_image              = each.value.source_image
  subnetwork_project        = var.project_id
  subnetwork                = each.value.subnet_name
  init_script               = each.value.init_script
  auto_delete               = each.value.auto_delete
  disk_size_gb              = each.value.boot_disk_size_gb
  boot_disk_type            = each.value.boot_disk_type
  additional_disks          = each.value.additional_disks
  external_ip               = each.value.external_ip 
  can_ip_forward            = each.value.can_ip_forward

  depends_on = [
    module.create_routes
  ]

}

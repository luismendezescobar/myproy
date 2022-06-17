
module "instance_template_creation" {
  for_each        = var.instance_template_map
  source          = "terraform-google-modules/vm/google//modules/instance_template"
  version         = "~> 7.7.0"
  name_prefix     = each.value.name_prefix
  project_id      = each.value.project_id
  region          = each.value.region
  machine_type    = each.value.machine_type
  tags            = each.value.network_tags
  can_ip_forward  = each.value.can_ip_forward
  startup_script  = file(each.value.init_script)
  auto_delete     = each.value.auto_delete
  disk_size_gb    = each.value.disk_size_gb
  source_image_family=each.value.source_image_family
  source_image_project=each.value.source_image_project
  disk_type       = each.value.disk_type
  on_host_maintenance = each.value.on_host_maintenance
  subnetwork          = each.value.subnetwork
  subnetwork_project  = each.value.subnetwork_project  
  additional_networks = each.value.additional_networks
  service_account     = each.value.service_account
  

}

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
  self_link_real= join("",[for key,value in local.map_mig_self_links:value if key=="projectx-nat-server"])
  #mig_map={for key, value in var.mig_map:key=>value}

}
output "name_final_good" {
  value=local.self_link_real
}
//with this one we remove the brackets and convert to string
//instance_template=join("",[for key,value in local.map_mig_self_links:value if key=="nat-server"])



/*
module "vm_mig_creation" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "7.7.0"
  # insert the 4 required variables here
  project_id            = var.project_id
  hostname              = var.mig_map.mig-nat.hostname
  region                = var.mig_map.mig-nat.region
  #autoscaling_mode      = "ON"
  instance_template     = module.instance_template_creation.self_link   //we want this one
  //target_size               = var.target_size
  //target_pools              = var.target_pools
  distribution_policy_zones =var.mig_map.mig-nat.distribution_policy_zones
  update_policy         = var.mig_map.mig-nat.update_policy
   // health check 
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

output "vm_mig_creation01" {
  value=module.vm_mig_creation.health_check_self_links 
}
output "vm_mig_creation02" {
  value=module.vm_mig_creation.self_link  
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
*/
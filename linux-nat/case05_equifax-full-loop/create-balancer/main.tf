
module "instance_template_creation" {
  for_each             = var.instance_template_map
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  version              = "~> 7.7.0"
  project_id           = each.value.project_id
  subnetwork           = each.value.subnetwork
  subnetwork_project   = each.value.subnetwork_project
  additional_networks  = each.value.additional_networks
  source_image         = each.value.source_image
  source_image_family  = each.value.source_image_family
  source_image_project = each.value.source_image_project
  startup_script       = file(each.value.init_script)
  service_account      = each.value.service_account
  region               = each.value.region

  tags                = each.value.network_tags
  name_prefix         = each.value.name_prefix
  machine_type        = each.value.machine_type
  disk_size_gb        = each.value.disk_size_gb
  disk_type           = each.value.disk_type
  auto_delete         = each.value.auto_delete
  can_ip_forward      = each.value.can_ip_forward
  on_host_maintenance = each.value.on_host_maintenance



}

output "name2" { //this is the good
  value = { for key, value in module.instance_template_creation : key => value.self_link }
  //output
  //{
  //"nat-server" = "https://www.googleapis.com/compute/v1/projects/playground-s-11-c77f7b64/global/instanceTemplates/nat-server-20220606000717456600000001"
  //"nat-server2" = "https://www.googleapis.com/compute/v1/projects/playground-s-11-c77f7b64/global/instanceTemplates/nat-server-20220606000717456600000001"
  //... etc
  //}

}

output "name3" {
  value = [for key, value in module.instance_template_creation : lookup(value, "self_link") if key == "nat-server"]
}

locals {
  mig_tpl_self_links = { for key, value in module.instance_template_creation : key => value.self_link }

  mig_self_links = { for key, value in module.vm_mig_creation : key => value.self_link }
  health_check_self_links = { for key, value in module.vm_mig_creation : key => value.health_check_self_links }
  

}
/*
output "name_final_good" {
  value = local.self_link_real
}
*/
//with this one we remove the brackets and convert to string
//instance_template=join("",[for key,value in local.map_mig_self_links:value if key=="nat-server"])




module "vm_mig_creation" {
  source                    = "terraform-google-modules/vm/google//modules/mig"
  version                   = "7.7.0"
  for_each                  = var.mig_map
  project_id                = each.value.project_id
  region                    = each.value.region
  distribution_policy_zones = each.value.distribution_policy_zones
  instance_template         = join("", [for key, value in local.mig_tpl_self_links : value if key == each.key])

  hostname      = each.value.hostname
  update_policy = each.value.update_policy
  // health check 
  health_check = each.value.health_check
  // autoscaler 
  autoscaling_enabled          = each.value.autoscaling_enabled
  max_replicas                 = each.value.max_replicas
  min_replicas                 = each.value.min_replicas
  cooldown_period              = each.value.cooldown_period
  autoscaling_cpu              = each.value.autoscaling_cpu
  autoscaling_metric           = each.value.autoscaling_metric
  autoscaling_lb               = each.value.autoscaling_lb
  autoscaling_scale_in_control = each.value.autoscaling_scale_in_control
}

output "vm_mig_creation01" {
 // value = module.vm_mig_creation.health_check_self_links
 value = [for key, value in module.vm_mig_creation : lookup(value, "health_check_self_links")]
}
output "vm_mig_creation02" {
  //value = module.vm_mig_creation.self_link
  value = [for key, value in module.vm_mig_creation : lookup(value, "self_link")]
}
/*
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
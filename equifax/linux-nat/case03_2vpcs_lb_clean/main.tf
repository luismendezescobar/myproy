module "vpc_creation" {
  for_each = var.vpc_info
  source  = "terraform-google-modules/network/google//modules/vpc"
  version="~> 2.0.0"
  project_id    = var.project_id
  network_name  = each.key

}
/*
module "firewall_rules" {
  source = "./modules/firewall-rules"
  project_id    = var.project_id
  depends_on = [
    module.vpc_creation
  ]
}
*/
/*
module "create_cloud_nat_gtw" {
  source                    = "./modules/create-nat"  
  depends_on = [
    module.firewall_rules
  ]
}

module "lb_mig_module" {
  for_each                  = var.lb_mig_nat_var
  source                    = "./modules/lb-mig"  
  server_name               = each.key
  project_id                = var.project_id
  zone                      = each.value.zone
  region                    = each.value.region
  instance_description      = each.value.description
  network_tags             = each.value.network_tags
  instance_machine_type     = each.value.instance_type
  source_image              = each.value.source_image
  subnetwork_project        = var.project_id
  subnetwork1               = each.value.subnet_name1
  subnetwork2               = each.value.subnet_name2
  init_script               = each.value.init_script
  auto_delete               = each.value.auto_delete
  disk_size_gb              = each.value.boot_disk_size_gb
  boot_disk_type            = each.value.boot_disk_type
  external_ip               = each.value.external_ip 
  can_ip_forward            = each.value.can_ip_forward
  #service_account           = each.value.service_account
  health_check              = var.health_check
  mig_info                  = var.mig_info
  mig_zones                 = var.mig_zones
  load_balancer_info01      = var.load_balancer_info01
  load_balancer_info02      = var.load_balancer_info02
  depends_on = [
    module.create_cloud_nat_gtw
  ]
}




module "create_routes" {
  source                    = "./modules/gcp-routes"  
  depends_on = [
    module.lb_mig_module
  ]
}

module "vm_instances_creation" {
  for_each                  = var.server_vm_info
  source                    = "./modules/create-vm"  
  server_name               = each.key

  project_id                = var.project_id
  #region                    = var.region
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
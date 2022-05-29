module "vpc_creation" {
  for_each = var.vpc_info
  source = "./modules/network"
  project_id    = var.project_id
  vpc_name      = each.key
  subnetworks   = each.value.subnetworks  
}

module "firewall_rules" {
  source = "./modules/firewall-rules"
  project_id    = var.project_id
  depends_on = [
    module.vpc_creation
  ]
}

module "create_cloud_nat_gtw" {
  source                    = "./modules/create-nat"  
  depends_on = [
    module.firewall_rules
  ]
}

module "image_managed_instance_group" {
  for_each                  = var.image_managed_instance_group
  source                    = "./modules/image_mgd_instance"  
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
  service_account           = each.value.service_account

  depends_on = [
    module.create_cloud_nat_gtw
  ]

}

module "create_routes" {
  source                    = "./modules/gcp-routes"  
  depends_on = [
    module.image_managed_instance_group
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

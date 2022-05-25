module "network" {
  source = "./modules/network"
  project_id    = var.project_id
  vpc_name      = var.vpc_name
  subnet_name   = var.subnet_name
  subnet_name2  = var.subnet_name2

  ip_cidr_range = var.ip_cidr_range
  region        = var.region  
}

module "vm_instances_creation" {
  for_each                  = var.server_vm_info
  source                    = "./modules/create-vm"  
  server_name               = each.key

  project_id                = var.project_id
  #region                    = var.region
  zone                      = each.value.zone
  
  instance_description      = each.value.description
  instance_tags             = each.value.instance_tags
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

  depends_on = [
    module.network
  ]

}

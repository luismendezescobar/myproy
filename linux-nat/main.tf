module "network" {
  for_each = var.vpc_info
  source = "./modules/network"
  project_id    = var.project_id
  vpc_name      = each.key
  subnetworks   = each.value.subnet_name  
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region  
  

}

//we need to create another rule to allow the comunication in the network (allow all)

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
    module.network
  ]

}

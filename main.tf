
terraform {
    required_providers {
        google = {      
            version = "~> 3.23.0"
        }
    }
}

module "network" {
  source = "./modules/network"
  project_id    = var.project_id
  vpc_name      = var.vpc_name
  subnet_name   = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region  
}

locals {
  instances_to_build = { for server in var.server_vm_info : server.name => server }
}

module "vm_instances_creation" {
  for_each                  = local.instances_to_build

  source                    = "./modules/create-vm-windows"  
  project_id                = var.project_id  
  zone                      = each.value.zone
  instance_name             = each.value.name
  network_ip                = each.value.network_ip
  instance_description      = each.value.description
  metadata                  = each.value.metadata
  instance_tags             = each.value.instance_tags
  instance_machine_type     = each.value.instance_type
  source_image              = each.value.source_image
  subnetwork_project        = var.project_id
  subnetwork                = var.subnet_name
  init_script               = each.value.init_script
  auto_delete               = each.value.auto_delete
  disk_size_gb              = each.value.boot_disk_size_gb
  boot_disk_type            = each.value.boot_disk_type
  additional_disks          = each.value.additional_disks
  

  depends_on = [module.network]
}



module "create_internal_ip" {
  for_each            = var.internal_ips
  
  source = "./modules/create-ip"
  name_internal_ip    = each.value.name
  project_id          = var.project_id
  vpc_name            = var.vpc_name
  subnet_name         = var.subnet_name
  region              = var.region  
  
  
  depends_on = [module.vm_instances_creation]
}

output "internal_ip" {
  for_each =module.create_internal_ip.instance_ip_addr
  value=each.value
}
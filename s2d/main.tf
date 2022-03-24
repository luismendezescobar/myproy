
terraform {
    required_providers {
        google = {      
            version = "~> 3.23.0"
        }
    }
}

locals {
  storage_name="mystorage-${formatdate("DDMMYYss", timestamp())}"
}

module "network" {
  source = "./modules/network"
  project_id    = var.project_id
  vpc_name      = var.vpc_name
  subnet_name   = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region  
}

module "create_storage" {
  source      = "./modules/create-storage"
  project_id  = var.project_id
  name        = local.storage_name
}

//gs://storage-3-19-2022-05
module "vm_instance_windows_DC" {
  source                    = "./modules/create-dc"  
  for_each                  = var.server_dc
  instance_name             = each.key
  project_id                = var.project_id  
  zone                      = each.value.zone  
  network_ip                = each.value.network_ip
  instance_description      = each.value.description  
  metadata                  = each.value.metadata
  storage_name              = local.storage_name
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
  
  depends_on = [module.network,module.create_storage]
}


module "vm_instances_creation" {
  source                    = "./modules/create-vm-windows"    
  for_each                  = var.server_vm_info  
  instance_name             = each.key
  project_id                = var.project_id  
  zone                      = each.value.zone  
  network_ip                = each.value.network_ip
  instance_description      = each.value.description
  metadata                  = each.value.metadata
  storage_name              = local.storage_name
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
  
  depends_on = [module.vm_instance_windows_DC,module.create_storage]
}



module "create_internal_ip" {
  source        = "./modules/create-ip"  
  
  internal_ips  = var.internal_ips
  project_id    = var.project_id
  vpc_name      = var.vpc_name
  subnet_name   = var.subnet_name
  region        = var.region  
  
  depends_on = [module.vm_instances_creation]
}

output "internal_ip" {
  value=module.create_internal_ip.testout
}


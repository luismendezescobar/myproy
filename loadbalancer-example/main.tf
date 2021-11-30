
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

  loadbalancers = distinct([for vm in var.server_vm_info : lookup(vm, "loadbalancer", "")])
  loadbalancer_map = { for loadbalancer in local.loadbalancers : loadbalancer => {
    vms = [for item in var.server_vm_info : item.name if item.loadbalancer == loadbalancer]
    }
  }

  network_self_link    = "projects/${var.project_id}/global/networks/${var.vpc_name}"
  subnetwork_self_link = "projects/${var.project_id}/regions/${var.region}/subnetworks/${var.subnet_name}"

}

output "loadbalancers" {
  value=local.loadbalancers
}
output "loadbalancer_map" {
  value=local.loadbalancer_map
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


module "unmanaged_instance_group" {
  source = "./modules/uig"  

  for_each      = local.loadbalancer_map
  name          = join("-", ["unmanaged-instance", lower(each.key)]) 
  project_id    = var.project_id
  region        = var.region 
  network       = local.network_self_link
  subnetwork    = local.subnetwork_self_link
  //instances     = [for vm in module.vm_instances_creation : vm if contains(each.value.vms, vm.name)]  
  instances     = [for vm in module.vm_instances_creation : vm ]  
  named_port    = var.named_port
  health_check  = var.health_check
  frontend_ports= var.frontend_ports
  frontend_name = var.frontend_name

  depends_on = [module.vm_instances_creation]
}


output "instances_out" {
  value=[for vm in module.vm_instances_creation : vm ]  
}


  


/*
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
*/
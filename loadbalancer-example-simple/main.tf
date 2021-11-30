
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


output "instances_to_build" {
  value=local.instances_to_build.node-1
}


module "vm_instances_creation" {


  source                    = "./modules/create-vm-windows"  
  project_id                = var.project_id  
  zone                      = lookup(local.instances_to_build.node-1, "zone", null)
  instance_name             = lookup(local.instances_to_build.node-1, "name", null)
  network_ip                = lookup(local.instances_to_build.node-1, "network_ip", null)
  instance_description      = lookup(local.instances_to_build.node-1, "description", null)
  metadata                  = lookup(local.instances_to_build.node-1, "metadata", null)
  instance_tags             = lookup(local.instances_to_build.node-1, "instance_tags", null)
  instance_machine_type     = lookup(local.instances_to_build.node-1, "instance_type", null)
  source_image              = lookup(local.instances_to_build.node-1, "source_image", null)
  subnetwork_project        = var.project_id
  subnetwork                = var.subnet_name
  init_script               = lookup(local.instances_to_build.node-1, "init_script", null)
  auto_delete               = lookup(local.instances_to_build.node-1, "auto_delete", null)
  disk_size_gb              = lookup(local.instances_to_build.node-1, "boot_disk_size_gb", null)
  boot_disk_type            = lookup(local.instances_to_build.node-1, "boot_disk_type", null)
  additional_disks          = lookup(local.instances_to_build.node-1, "additional_disks", null)
  
  
  depends_on = [module.network]
}


data "google_compute_instance" "instance_to_balancer" {
   name     = "node-1"
   zone     = "us-east1-b"
   depends_on = [
     module.vm_instances_creation
   ]
}
  

module "unmanaged_instance_group" {
  source = "./modules/uig"  

  //for_each      = local.loadbalancer_map
  //name          = join("-", ["unmanaged-instance", lower(each.key)]) 
  name          = join("-", ["unmanaged-instance", "serviceweb"])   
  project_id    = var.project_id
  region        = var.region 
  network       = local.network_self_link
  subnetwork    = local.subnetwork_self_link
  //instances     = [for vm in module.vm_instances_creation : vm if contains(each.value.vms, vm.name)]  
  //instances     = [data.google_compute_instance.instance_to_balancer.self_link]  
  instances     = [for element in module.vm_instances_creation:element]  
  named_port    = var.named_port
  health_check  = var.health_check
  frontend_ports= var.frontend_ports
  frontend_name = var.frontend_name

  depends_on = [module.vm_instances_creation]
}





output "instances_out" {
  value=data.google_compute_instance.instance_to_balancer.self_link
}




module "nat_single_server_creation" {
  source                    = "./modules/create-single-nat"
  for_each                  = var.server_nat_info
  server_name               = each.key
  gce_image_family          = each.value.gce_image_family
  compute_image_project     = each.value.compute_image_project
  project_id                = each.value.project_id    
  machine_type              = each.value.machine_type
  zone                      = each.value.zone
  labels                    = each.value.labels
  auto_delete               = each.value.auto_delete
  kms_key_self_link         = each.value.kms_key_self_link
  disk_size                 = each.value.disk_size
  disk_type                 = each.value.disk_type
  subnetwork_project        = each.value.subnetwork_project
  subnetwork                = each.value.subnetwork
  external_ip               = each.value.external_ip
  additional_networks       = each.value.additional_networks
  service_account           = each.value.service_account
  tags                      = each.value.tags
  metadata                  = each.value.metadata
  startup_script            = each.value.startup_script
  description               = each.value.description
  can_ip_forward            = each.value.can_ip_forward
  allow_stopping_for_update = each.value.allow_stopping_for_update
  additional_disks          = each.value.additional_disks
}

module "vm_instances_creation" {
  for_each              = var.server_vm_info
  source                = "git::https://github.com/Equifax/7265_GL_GCE_IAAS.git?ref=v2.1.4"
  blocksshkeys          = true
  disk_size             = each.value.disk_size
  compute_image_project = each.value.compute_image_project
  gce_image_family      = each.value.gce_image_family
  labels                = each.value.labels
  machine_type          = each.value.machine_type
  name                  = each.key
  oslogin               = false
  project               = each.value.project
  service_account       = each.value.service_account
  metadata              = each.value.metadata
  startup_script_file   = each.value.startup_script_file
  subnetwork            = each.value.subnetwork
  zone                  = each.value.zone
  tags                  = each.value.tags
}

output "vm_instances_creation_ip" {
  value = [for i in module.vm_instances_creation : i]
}

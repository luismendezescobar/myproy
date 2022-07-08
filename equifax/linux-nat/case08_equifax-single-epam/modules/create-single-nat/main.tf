
locals {
  vm_disks = {
    for i in var.additional_disks : i.name => i
  }
  user_labels = merge(
    var.labels,
    {
      terraform_module_version = "v1-0-11"
      provisioned_by           = "terraform"
    }
  )
}


/******************************************
 Creating additional disks for VM
 *****************************************/
resource "google_compute_disk" "gce_machine_disks" {
  for_each = local.vm_disks

  project = var.project_id
  name    = join("-", [lower(var.server_name), each.value.name])
  type    = each.value.disk_type
  zone    = var.zone  
  size    = each.value.disk_size_gb
}

/*************************************************/
//image
data "google_compute_image" "image" {
  family  = var.gce_image_family
  project = var.compute_image_project
}


/******************************************
 Current Multi-disk vm
 *****************************************/
resource "google_compute_instance" "gce_machine" {
  project         = var.project_id
  name            = lower(var.server_name)
  machine_type    = var.machine_type
  zone            = var.zone  
  labels          = local.user_labels
  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  # OS Image
  boot_disk {
    auto_delete = var.auto_delete
    kms_key_self_link = var.kms_key_self_link
    initialize_params {
      image  = data.google_compute_image.image.self_link
      size  = var.disk_size      
      type  = var.disk_type
      labels = local.user_labels
    }
  }

  # Network details
  network_interface {
    subnetwork_project = var.subnetwork_project
    subnetwork         = var.subnetwork    
    #network_ip         = var.static_internal_ip == "" ? "" : google_compute_address.static_internal_address[0].address
    dynamic "access_config" {
      for_each =var.external_ip[0] == "true"?[1]:[]
        content {
            //Ephemeral public ip (no need to specify)
        }
    }
  }

  dynamic "network_interface" {
    for_each = var.additional_networks
    content {
      network            = network_interface.value.network
      subnetwork         = network_interface.value.subnetwork
      subnetwork_project = network_interface.value.subnetwork_project
      network_ip         = length(network_interface.value.network_ip) > 0 ? network_interface.value.network_ip : null
      dynamic "access_config" {
        for_each = network_interface.value.access_config
        content {
          nat_ip       = access_config.value.nat_ip
          network_tier = access_config.value.network_tier
        }
      }
    }
  }
  
  dynamic "service_account" {
    for_each = var.service_account == null ? [] : [var.service_account]
    content {
      email  = lookup(service_account.value, "email", null)
      scopes = lookup(service_account.value, "scopes", [])
    }
  }
  # Network tag if you have any
  tags = var.tags == null ? [] : var.tags  
  # Metadata Tags
  metadata = var.metadata
  # Startup Script
  metadata_startup_script = file(var.startup_script)    
  description     = var.description
  can_ip_forward  = var.can_ip_forward
  allow_stopping_for_update = var.allow_stopping_for_update


  dynamic "attached_disk" {
    for_each = local.vm_disks
    iterator = disk
    content {
      source      = lookup(google_compute_disk.gce_machine_disks[disk.value.name], "id", null)
      device_name = disk.value.name
    }
  }

  # This is needed to insure that your server won't rebuild when a new server image is available
  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }


}

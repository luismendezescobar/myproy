
locals {
  vm_disks = {
    for i in var.additional_disks : i.name => i
  }
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

/******************************************
 Current Multi-disk vm
 *****************************************/
resource "google_compute_instance" "gce_machine" {
  project         = var.project_id
  name            = lower(var.server_name)
  machine_type    = var.instance_machine_type
  zone            = var.zone  
  tags            = var.network_tags
  description     = var.instance_description
  can_ip_forward  = var.can_ip_forward

  metadata_startup_script = file(var.init_script)  

  allow_stopping_for_update = false

  boot_disk {
    auto_delete = var.auto_delete
    initialize_params {
      size  = var.disk_size_gb
      image = var.source_image
      type  = var.boot_disk_type
    }
  }

  dynamic "attached_disk" {
    for_each = local.vm_disks
    iterator = disk
    content {
      source      = lookup(google_compute_disk.gce_machine_disks[disk.value.name], "id", null)
      device_name = disk.value.name
    }
  }

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
}

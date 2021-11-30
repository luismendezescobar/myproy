
locals {
  vm_disks = {
    for i in var.additional_disks : i.name => i
  }

  subnetwork_self_link  = format("projects/%s/regions/%s/subnetworks/%s", var.project_id,substr(var.zone, 0, -3),var.subnetwork)
}


/******************************************
 Creating additional disks for VM
 *****************************************/
resource "google_compute_disk" "gce_machine_disks" {
  for_each = local.vm_disks

  project = var.project_id
  name    = join("-", [lower(var.instance_name), each.value.name])
  type    = each.value.disk_type
  zone    = var.zone  
  size    = each.value.disk_size_gb
}

/******************************************
 Current Multi-disk vm
 *****************************************/
resource "google_compute_instance" "gce_machine" {
  project      = var.project_id
  name         = lower(var.instance_name)
  machine_type = var.instance_machine_type
  zone         = var.zone  
  tags         = var.instance_tags
  metadata     = var.metadata
  description  = var.instance_description

  metadata_startup_script = var.init_script == "" ? "" : file(var.init_script) 

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
    network_ip         = google_compute_address.static_internal_address.address
        
    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    #email  = var.service_account
    scopes = ["cloud-platform"]
  }

  depends_on = [google_compute_address.static_internal_address]

}



resource "google_compute_address" "static_internal_address" {
  count        = var.network_ip == "" ? 0 : 1
  name         = join("-", ["static-int-ip", lower(var.instance_name)])
  subnetwork   = local.subnetwork_self_link
  address_type = "INTERNAL"
  address      = var.network_ip
  project      = var.project_id
  region       = substr(var.zone, 0, -3)
}
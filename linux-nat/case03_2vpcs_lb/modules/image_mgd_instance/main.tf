/*
locals {
  vm_disks = {
    for i in var.additional_disks : i.name => i
  }
}
*/

/******************************************
 Creating additional disks for VM
 *****************************************/
/*
resource "google_compute_disk" "gce_machine_disks" {
  for_each = local.vm_disks

  project = var.project_id
  name    = join("-", [lower(var.server_name), each.value.name])
  type    = each.value.disk_type
  zone    = var.zone  
  size    = each.value.disk_size_gb
}
*/

/******************************************
 Current Multi-disk vm
 *****************************************/
resource "google_compute_instance_template" "instance_template" {
  project         = var.project_id
  region          = var.region
  name            = lower(var.server_name)
  machine_type    = var.instance_machine_type
  tags            = var.network_tags
  description     = var.instance_description
  can_ip_forward  = var.can_ip_forward

  metadata_startup_script = file(var.init_script)  

 

//boot disk
  disk {
      auto_delete = true 
      disk_size_gb  = var.disk_size_gb
      source_image = var.source_image
      disk_type  = var.boot_disk_type
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account
    scopes = ["cloud-platform"]
  }

/*
  dynamic "attached_disk" {
    for_each = local.vm_disks
    iterator = disk
    content {
      source      = lookup(google_compute_disk.gce_machine_disks[disk.value.name], "id", null)
      device_name = disk.value.name
    }
  }
*/
  network_interface {
    subnetwork_project = var.subnetwork_project
    subnetwork         = var.subnetwork1    
  }
  network_interface {
    subnetwork_project = var.subnetwork_project
    subnetwork         = var.subnetwork2    
  }

}



resource "google_compute_health_check" "tcp-health_check22" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

 
  tcp_health_check {
    port = "22"
  }
}

resource "google_compute_instance_group_manager" "appserver" {
  name = "nat-managed-instance-group"

  base_instance_name = "app"
  zone               = var.zone
  target_size = 2

  version {
    instance_template  =google_compute_instance_template.instance_template.id

  }

  auto_healing_policies {
    health_check      = google_compute_health_check.tcp-health_check22.id
    initial_delay_sec = 300
  }
}
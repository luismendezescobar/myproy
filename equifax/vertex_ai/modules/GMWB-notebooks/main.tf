resource "random_string" "random" {
  length  = 16
  special = false
}
locals {
  notebook_instance_name = lower("GMWB-notebook-${resource.random_string.random.result}")
}

resource "google_notebooks_runtime" "runtime" {
  project  = var.project
  name     = local.notebook_instance_name
  location = var.location
  access_config {
    access_type   = var.access_type
    runtime_owner = var.notebook_service_account
  }

  software_config {
    idle_shutdown         = var.idle_shutdown
    idle_shutdown_timeout = var.idle_shutdown_timeout
    install_gpu_driver    = var.install_gpu_driver
  }

  virtual_machine {
    virtual_machine_config {
      machine_type     = var.machine_type
      internal_ip_only = var.internal_ip_only
      network          = var.notebook_network
      subnet           = var.notebook_subnet
      labels           = var.efx_labels
      
      container_images {
        repository = var.container_image_repository
        tag        = var.tag 
      }
      data_disk {
        initialize_params {
          disk_size_gb = var.notebook_disk_size
          disk_type    = var.notebook_disk_type
        }
      }
      encryption_config {
        kms_key = var.notebook_disk_cmek_key
      }
      metadata = {
        notebook-disable-downloads = var.disable_download
        notebook-disable-nbconvert = var.disable_nbconvert
        notebook-disable-terminal  = var.disable_terminal
      }
    }
  }

  lifecycle { ignore_changes = [virtual_machine[0].virtual_machine_config[0].encryption_config[0].kms_key] }
}

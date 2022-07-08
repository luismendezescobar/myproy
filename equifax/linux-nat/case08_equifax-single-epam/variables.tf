
variable "project_id" {
  type = string
}

variable "tf_service_account" {
  type = string
}

variable "server_nat_info" {
  description = "the number of DB server instances"
  type = map(object({
    gce_image_family      = string
    compute_image_project = string
    project_id            = string
    machine_type          = string
    zone                  = string
    labels                = map(string)
    auto_delete           = bool
    kms_key_self_link     = string
    disk_size             = number
    disk_type             = string
    subnetwork_project    = string
    subnetwork            = string
    external_ip           = list(string)
    additional_networks = list(object({
      network            = string
      subnetwork         = string
      subnetwork_project = string
      network_ip         = string
      access_config = list(object({
        nat_ip       = string
        network_tier = string
      }))
    }))
    service_account = object({
      email  = string
      scopes = list(string)
    })
    tags                      = list(string)
    metadata                  = map(string)
    startup_script            = string
    description               = string
    can_ip_forward            = bool
    allow_stopping_for_update = bool
    additional_disks = list(object({
      name         = string
      disk_size_gb = number
      disk_type    = string
    }))
  }))
  default = {}
}

variable "server_vm_info" {
  description = "the number of DB server instances"
  type = map(object({
    disk_size             = number
    compute_image_project = string
    gce_image_family      = string
    labels                = map(string)
    machine_type          = string
    project               = string
    service_account = object({
      email  = string
      scopes = list(string)
    })
    metadata            = map(string)
    startup_script_file = string
    subnetwork          = string
    zone                = string
    tags                = list(string)
  }))
  default = {}
}


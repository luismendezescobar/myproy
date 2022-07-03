variable "project" {
  type        = string
  description = "The ID of the project in which the resource belongs."
}
variable "location" {
  type        = string
  description = "A reference to the zone where the machine resides."
}
variable "access_type" {
  type        = string
  description = "SERVICE_ACCOUNT"
}
variable "notebook_service_account" {
  type        = string
  description = "The service account on this instance, giving access to other Google Cloud services."
}
variable "idle_shutdown" {
  type        = bool
  description = "Runtime will automatically shutdown after a time defined on timeout"
}
variable "idle_shutdown_timeout" {
  type        = number
  description = "Time in minutes to wait before shuting down runtime"
}
variable "install_gpu_driver" {
  type        = bool
  description = "Whether the end user authorizes Google Cloud to install GPU driver on this instance."
}
variable "machine_type" {
  type        = string
  description = "A reference to a machine type which defines VM kind."
}
variable "container_image_repository" {
  type        = string
  description = "The path to the container image repository. For example: gcr.io/{project_id}/{imageName}"
}
variable "internal_ip_only" {
  type        = bool
  default     = true
  description = "If true, runtime will only have internal IP addresses."
  # This validation rule enforces compliance with Security Requirement GCP-VER-012. 
  # Any modifications to this code must be consulted with Security Advisement team to avoid exposure to security threats.
  validation {
    condition     = var.internal_ip_only == true
    error_message = "Enabling public ip for notebooks is a security risk and doesn't comply with Equifax Public Cloud Requirements."
  }
}
variable "notebook_network" {
  type        = string
  description = "The name of the VPC that this instance is in."
}
variable "notebook_subnet" {
  type        = string
  description = "The name of the subnet that this instance is in."
}
variable "notebook_disk_size" {
  type        = number
  description = "The size of the boot disk in GB attached to this instance, up to a maximum of 64000 GB (64 TB)"
}
variable "notebook_disk_type" {
  type        = string
  description = "Possible disk types for notebook instances."
}
variable "notebook_disk_cmek_key" {
  type        = string
  default     = ""
  description = "The KMS key used to encrypt the disks, encryption is CMEK"
  # This validation rule enforces compliance with Security Requirement GCP-VER-003. 
  # Any modifications to this code must be consulted with Security Advisement team to avoid exposure to security threats.
}
variable "disable_download" {
  nullable    = true
  type        = string
  description = "Disable file downloading from JupyterLab UI."
}
variable "disable_nbconvert" {
  type        = string
  description = "Disable export and download notebooks as other types of files."
}
variable "disable_terminal" {
  nullable    = true
  type        = string
  description = "Disable terminal."
}
variable "efx_labels" {
  description = "Labels to apply to resources"
  type = object({
    cost_center     = string,
    division        = string,
    cmdb_bus_svc_id = string,
    data_class      = string
  })
  # This validation rule enforces compliance with Security Requirement GCP-VER-016. 
  # Any modifications to this code must be consulted with Security Advisement team to avoid exposure to security threats.
  validation {
    condition     = alltrue([for k, v in var.efx_labels : v != ""])
    error_message = "Must define labels for compliance with Equifax Public Cloud Labeling Requirements."
  }
}




variable "azure_location" {
  description = "Azure Location (Region) where the resources are to be deployed."
  type = string
}

variable "region" {
  description = "Region where the resources will be placed. This is the abbreviated version (i.e. WUS for West US)"
  type = string
}

variable "appabbrev" {
  description = "Three letter abbreviation for the application name."
  type = string
}

variable "resource_tags" {
  description = "Map value containing the resource tags."
  type = map
}

variable "azure_resource_group_name" {
  description = "Azure Resource Group Name where the resources are to be deployed"
  type = string
}

variable "bootdiags_primary_blob_endpoint" {
  description = "Blob Endpoint for the Storage Account used to store Boot Diagnostics"
  type = string
}

variable "azure_subnet_id" {
  description = "Azure Resoruce ID String identifying the Subnet where the resources will be deployed"
  type = string
}
/*
variable "shared_services_data" {
  description = "Map containing all of the information from the Shared Services needed to support the VMs."
  type = map
}
*/
variable "local_vm_adminusername" {
  description = "Local user account name to be setup as primary load Administrator within the OS."
  type = string
  default = "localvmadmin"
}

variable "local_vm_password" {
  description = "Password for the Local Admin User on the VM."
  type = string
}

variable "vm_timezone" {
  description = "Timezone for the VM to be setup in. Default is Pacific Standard Time."
  type = string
  default = "Pacific Standard Time"
}
/*
variable "core_image_reference" {
  description = "Azure Resource Id of the image to use to build the VM. This typically points to the CORE CIS Hardened Image."
  type = string
}
*/
variable "node_count" {
  description = "How many nodes to deploy."
  type = number
}

variable "node_size" {
  description = "VM Size"
  type = string
}

variable "sql_data_disk_size_gb" {
  description = "Size of disk (in GB) to use for SQL Data. Value will be used for all disks defined by sql_data_disk_count."
  type = number
}

variable "sql_data_disk_count" {
  description = "Number of disks to create and attach for SQL Data."
  type = number
}

variable "sql_logs_disk_size_gb" {
  description = "Size of disk (in GB) to use for SQL Logs. Value will be used for all disks defined by sql_logs_disk_count."
  type = number
}

variable "sql_logs_disk_count" {
  description = "Number of disks to create and attach for SQL Logs."
  type = number
}

variable "sql_tempdb_disk_size_gb" {
  description = "Size of disk (in GB) to use for SQL TempDB. Value will be used for all disks defined by sql_tempdb_disk_count."
  type = number
}

variable "sql_tempdb_disk_count" {
  description = "Number of disks to create and attach for SQL TempDB."
  type = number
}
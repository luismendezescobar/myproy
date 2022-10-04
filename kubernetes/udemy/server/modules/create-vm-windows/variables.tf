variable "server_vm_info" {
  description = "Contain object of vm name and additional disks"
  type = map(object({
    server_name               = string
    location                  = string
    size                      = string    
    azure_subnet_id           = string
    private_ip_address_allocation =string
    admin_username            = string
    admin_password            = string
    disk_size_gb              = number
    caching_type              = string
    storage_account_type      = string
    source_image_id           = string
    enable_automatic_updates  = string
    patch_mode                = string    
    custom_data              = string

    additional_disks = list(object({
      name                    = string
      disk_size_gb            = number
      storage_account_type    = string      
      create_option           = string      
    }))
  }))

  default = {}
}
#######################################
variable "server_name" {
  type = string
}
variable "location" {
  type = string
}

variable "nic_name" {
  type = string
}
variable "size" {
  type = string
}
variable "azure_subnet_id" {
  type = string
}
variable "private_ip_address_allocation" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type = string
}
variable "disk_size_gb" {
  type =string
}
variable "caching_type" {
  type = string
}
variable "storage_account_type" {
  type = string
}
variable "source_image_id" {
  type = string
}
variable "enable_automatic_updates" {
  type = string
}
variable "patch_mode" {
  type = string
}

variable "primary_blob_endpoint" {
  type = string
}



  
#################################################
 variable "additional_disks" {
  type = list(object({
      name                    = string
      disk_size_gb            = number
      storage_account_type    = string
      create_option           = string 
      caching                 = string     
      lun_number              = number 
  }))
  default =[]
 }

#############################################    
variable "resource_tags" {
  description = "Map value containing the resource tags."
  type = map
}

variable "resource_group_location" {
  type=string
}

variable "resource_group_name" {
  type=string
}
/* 
variable "boot_diagnostic_account_name" {
  type=string
}
*/
variable "custom_data" {
  type=string
}

variable "static_ip" {
  type=string
}

variable "availability_set_id" {
  type=string  
}
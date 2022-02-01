variable "server_vm_info" {
  description = "Contain object of vm name and additional disks"
  type = map(object({    
    location                  = string
    size                      = string    
    azure_subnet_id           = string
    private_ip_address_allocation =string
    static_ip                 =string         #only needed if private_ip_address_allocation is set to static
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
      caching                 = string
      lun_number              = number      
    }))
  }))

  default = {}
}
variable "server_vm_info_additional" {
  description = "Contain object of vm name and additional disks"
  type = map(object({    
    location                  = string
    size                      = string    
    azure_subnet_id           = string
    private_ip_address_allocation =string
    static_ip                 =string         #only needed if private_ip_address_allocation is set to static
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
      caching                 = string
      lun_number              = number      
    }))
  }))

  default = {}
}

variable "server_vm_info_linux" {
  description = "Contain object of vm name and additional disks"
  type = map(object({
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
    additional_disks = list(object({
      name                    = string
      disk_size_gb            = number
      storage_account_type    = string      
      create_option           = string
      caching                 = string
      lun_number              = number      
    }))
  }))

  default = {}
}



variable "subguid" {
  description = "Subscription GUID"
  type = string
}

variable "azure_resource_group_name" {
  type=string  
}


    
variable "resource_tags" {
  description = "Map value containing the resource tags."
  type = map
}
/*
variable "boot_diagnostic_account_name" {
  type=string
}
*/
variable "storage_account_for_boot_diag" {
  type=string

}
variable "storage_container_for_boot_diag" {
  type=string
}

#############
variable "lb_name" {
  type=string
}


variable "lb_location"{
  type = string
}

variable "lb_azure_subnet_id" {
  type=string
}

variable "lb-backendpool-name" {
  type=string
}

variable "lb_probe_ntc" {
  type=string
}

variable "lb_probe_sql" {
  type=string
}

variable "lb_rule_ntc" {
  type=string
}

variable "lb_rule_sql" {
  type=string
}

variable "avset_name" {
  type=string
}
terraform{
    backend "azurerm"{
        resource_group_name ="1-d01a02f5-playground-sandbox"                    #variables can not be used, you have to put this manually here
        storage_account_name="mystorage1292022"              #"myaccount1292022"   ##this has to be created manually##       #variables can not be used, you have to put this manually here
        container_name      ="statecontainer"                       ##this has to be created manually
        key                 ="terraform.tfstate"
    }
    required_providers {
      azurerm={
        source  = "hashicorp/azurerm"
        version = "~>2.0"
      }
    }
}

# Configure the Azure provider
provider "azurerm" {    
	  subscription_id  = var.subguid
    #tenant_id       = "da67ef1b-ca59-4db2-9a8c-aa8d94617a16"      #manually here
    features {}
    skip_provider_registration = "true"
}


data "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group_name
}



#01.first create the storage account for boot diagnostics
resource "azurerm_storage_account" "dev_boot_diag" {
  name                     = var.storage_account_for_boot_diag
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags={
        environment="Terraform Storage"
        CreatedBy= "Luis Mendez"
    }
}
resource "azurerm_storage_container" "lab" {
  name                  = var.storage_container_for_boot_diag
  storage_account_name  = azurerm_storage_account.dev_boot_diag.name
  container_access_type = "private"
}





module "vm_instance_windows" {
  for_each                  = var.server_vm_info
  source                    = "./modules/create-vm-windows"  
  server_name               = each.key                                #this is the server name
  location                  = each.value.location
  nic_name                  = "prod-${lower(each.key)}"
  size                      = each.value.size
  azure_subnet_id           = each.value.azure_subnet_id
  private_ip_address_allocation = each.value.private_ip_address_allocation  
  static_ip                 = each.value.static_ip
  admin_username            = each.value.admin_username
  admin_password            = each.value.admin_password  
  caching_type              = each.value.caching_type
  additional_disks          = each.value.additional_disks
  storage_account_type      = each.value.storage_account_type
  disk_size_gb              = each.value.disk_size_gb
  source_image_id           = each.value.source_image_id
  enable_automatic_updates  = each.value.enable_automatic_updates
  patch_mode                = each.value.patch_mode  
  custom_data               = each.value.custom_data 
  resource_tags             = var.resource_tags
  resource_group_location   = data.azurerm_resource_group.rg.location
  resource_group_name       = data.azurerm_resource_group.rg.name
  boot_diagnostic_account_name=var.boot_diagnostic_account_name
  primary_blob_endpoint     = azurerm_storage_account.dev_boot_diag.primary_blob_endpoint

  depends_on = [azurerm_storage_account.dev_boot_diag]

}




module "vm_instance_dev_ansible-linux-uswest" {
  for_each                  = var.server_vm_info_linux
  source                    = "./modules/create-vm-linux"  
  server_name               = each.key                                #this is the server name
  location                  = each.value.location
  nic_name                  = "prod-${lower(each.key)}"
  size                      = each.value.size
  azure_subnet_id           = each.value.azure_subnet_id
  private_ip_address_allocation = each.value.private_ip_address_allocation  
  admin_username            = each.value.admin_username
  admin_password            = each.value.admin_password
  public_key                = file("~/.ssh/id_rsa.pub")  
  caching_type              = each.value.caching_type
  additional_disks          = each.value.additional_disks
  storage_account_type      = each.value.storage_account_type
  disk_size_gb              = each.value.disk_size_gb
  source_image_id           = each.value.source_image_id
  resource_tags             = var.resource_tags
  resource_group_location   = data.azurerm_resource_group.rg.location
  resource_group_name       = data.azurerm_resource_group.rg.name
  boot_diagnostic_account_name=var.boot_diagnostic_account_name
  primary_blob_endpoint     = azurerm_storage_account.dev_boot_diag.primary_blob_endpoint

  depends_on = [azurerm_storage_account.dev_boot_diag]

}

/*
module "create_lb" {
  source            = "./modules/create-load-balancer"  
  lb_name           = var.lb_name
  lb_location       = var.lb_location
  azure_resource_group_name =var.azure_resource_group_name 
  resource_tags     = var.resource_tags 
  lb_azure_subnet_id= var.lb_azure_subnet_id
  lb-backendpool-name=var.lb-backendpool-name
  lb_probe_ntc      = var.lb_probe_ntc
  lb_probe_sql      = var.lb_probe_sql
  lb_rule_ntc       = var.lb_rule_ntc
  lb_rule_sql       = var.lb_rule_sql
  avset_name        = var.avset_name
  instances         = [for vm in module.vm_instance_windows: vm]

}
*/





output "instances_out" {
  value= [for vm in module.vm_instance_windows: vm ]
}
/*
output "instances_out-02" {
  value= [for vm in module.vm_instance_windows: vm.testout.id]
}

output "instances_out-03" {
  value= [for vm in module.vm_instance_windows: vm.testout.ip_configuration]
}

output "instances_out-04" {
  value= [for vm in module.vm_instance_windows: vm.testout]
}

output "instances_out-05" {
  value={
    for key in module.vm_instance_windows : key.testout.name =>key.testout.id
  }

}

output "instances_out-06" {
  value = [for vm in module.vm_instance_windows.Nic0: vm.id]
}

*/

output "instances_out-06" {
  value={
    for key in module.vm_instnce_windows : key =>key.Nic0
  }

}

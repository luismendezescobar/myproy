#we are going to use the following links:
#https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/availability-group-manually-configure-prerequisites-tutorial-single-subnet
#https://docs.microsoft.com/en-us/windows-server/failover-clustering/deploy-cloud-witness
#troubleshooting
#https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/trouble-shooting-availability-group-listener-in-azure-sql-vm/ba-p/371317

terraform{
    backend "azurerm"{
        resource_group_name ="1-2d3be0ec-playground-sandbox"                    #variables can not be used, you have to put this manually here
        storage_account_name="mystorage352022"              #"myaccount1292022"   ##this has to be created manually##       #variables can not be used, you have to put this manually here
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

  #location                 = data.azurerm_resource_group.rg.location     #this has to be enabled in production
  location                 = "Central US"

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

########Create storage account for witness for the failover cluster#############################


resource "azurerm_storage_account" "storage_witness" {
  name                     = var.storage_account_for_witness
  resource_group_name      = data.azurerm_resource_group.rg.name                    

  #location                 = data.azurerm_resource_group.rg.location     #this has to be enabled in production
  location                 = "Central US"

  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags={
        environment="Terraform Storage"
        CreatedBy= "Luis Mendez"
    }
}

##############################################################

module "create_networks" {
  for_each=local.vnet_json_data
  vnet_json_data=each.value







}

resource "azurerm_availability_set" "sqlAS" {
  name                = var.avset_name
  location            = var.lb_location
  resource_group_name = var.azure_resource_group_name
  managed             = true
  tags                = var.resource_tags  
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
  primary_blob_endpoint     = azurerm_storage_account.dev_boot_diag.primary_blob_endpoint
  availability_set_id       = azurerm_availability_set.sqlAS.id

  depends_on = [module.vm_instance_windows_DC]
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
  primary_blob_endpoint     = azurerm_storage_account.dev_boot_diag.primary_blob_endpoint

  depends_on = [azurerm_storage_account.dev_boot_diag]

}


module "create_lb" {
  source              = "./modules/create-load-balancer"  
  lb_name             = var.lb_name
  lb_location         = var.lb_location
  azure_resource_group_name =var.azure_resource_group_name 
  resource_tags       = var.resource_tags 
  lb_azure_subnet_id  = var.lb_azure_subnet_id
  lb-backendpool-name =var.lb-backendpool-name
  lb_probe_ntc        = var.lb_probe_ntc
  lb_probe_sql        = var.lb_probe_sql
  lb_rule_ntc         = var.lb_rule_ntc
  lb_rule_sql         = var.lb_rule_sql
  avset_name          = var.avset_name
  cluster_front_end_ip= var.cluster_front_end_ip
  sql_front_end_ip    = var.sql_front_end_ip

  instances={
    for key in module.vm_instance_windows : key.testout.name =>key.testout.id
  }
  depends_on = [module.vm_instance_windows]
}

output "instances_out" {
  value= [for vm in module.vm_instance_windows: vm.testout ]
}
output "instances_out-05" {
  value={
    for key in module.vm_instance_windows : key.testout.name =>key.testout.id
  }

}
output "instances_out-06" {
  value={
    for key in module.vm_instance_windows : "key" =>key.Nic0...
  }
}



module "vm_instance_windows_DC" {
  for_each                  = var.server_vm_info_additional
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
  primary_blob_endpoint     = azurerm_storage_account.dev_boot_diag.primary_blob_endpoint
  availability_set_id       = azurerm_availability_set.sqlAS.id
  

}

/*
module "vm_instance_windows_bastion_host" {
  for_each                  = var.server_vm_info_external
  source                    = "./modules/create-vm-windows-external"  
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
  primary_blob_endpoint     = azurerm_storage_account.dev_boot_diag.primary_blob_endpoint

  depends_on = [module.create_lb]

}*/
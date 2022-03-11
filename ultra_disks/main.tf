#we are going to use the following links:
#https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/availability-group-manually-configure-prerequisites-tutorial-single-subnet
#https://docs.microsoft.com/en-us/windows-server/failover-clustering/deploy-cloud-witness
#troubleshooting
#https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/trouble-shooting-availability-group-listener-in-azure-sql-vm/ba-p/371317

terraform{
    backend "azurerm"{
        resource_group_name ="1-6db0d38e-playground-sandbox"                    #variables can not be used, you have to put this manually here
        storage_account_name="mystorage3102022"              #"myaccount1292022"   ##this has to be created manually##       #variables can not be used, you have to put this manually here
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

#############################################################################################################################################################
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
  source                    = "./modules/create-networks"  
  for_each=local.vnet_json_data
  vnet_name=each.key
  vnet_json_data=each.value
}

resource "azurerm_availability_set" "sqlAS" {
  name                = var.avset_name
  location            = var.lb_location
  resource_group_name = var.azure_resource_group_name
  managed             = true
  tags                = var.resource_tags  
}

data "azurerm_subnet" "net_master" {
  depends_on = [module.create_networks]
  name="master"
  resource_group_name = var.azure_resource_group_name
  virtual_network_name="general-vnet"
}

module "vm_instance_windows" {
  for_each                  = var.server_vm_info
  source                    = "./modules/create-vm-windows"  
  server_name               = each.key                                #this is the server name
  location                  = each.value.location
  nic_name                  = "prod-${lower(each.key)}"
  size                      = each.value.size
  #azure_subnet_id           = each.value.azure_subnet_id
  azure_subnet_id           = data.azurerm_subnet.net_master.id
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


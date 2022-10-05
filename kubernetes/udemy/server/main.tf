#we are going to use the following links:
#https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/availability-group-manually-configure-prerequisites-tutorial-single-subnet
#https://docs.microsoft.com/en-us/windows-server/failover-clustering/deploy-cloud-witness
#troubleshooting
#https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/trouble-shooting-availability-group-listener-in-azure-sql-vm/ba-p/371317



data "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group_name
}



#01.first create the storage account for boot diagnostics
/*
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
*/
/*
resource "azurerm_availability_set" "sqlAS" {
  name                = var.avset_name
  location            = var.lb_location
  resource_group_name = var.azure_resource_group_name
  managed             = true
  tags                = var.resource_tags  
}
*/




module "vm-linux" {
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

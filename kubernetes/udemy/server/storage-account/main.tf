/*create teh storage account to be used with the main file*/
data "azurerm_resource_group" "my_resource_group" {
  name     = "1-93db68cb-playground-sandbox"
}

resource "random_string" "random" {  
  length  = 10
  special = false
}



resource "azurerm_storage_account" "my_storage_account" {
  name                     = lower("mystorage${resource.random_string.random.result}")
  resource_group_name      = data.azurerm_resource_group.my_resource_group.name
  location                 = data.azurerm_resource_group.my_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


resource "azurerm_storage_container" "my_blob_container" {
  name                  = "statecontainer"
  storage_account_name  = azurerm_storage_account.my_storage_account.name
  container_access_type = "private"
}

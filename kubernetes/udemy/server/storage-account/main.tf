/*create teh storage account to be used with the main file*/
resource "azurerm_resource_group" "my_resource_group" {
  name     = "1-93db68cb-playground-sandbox"
  location = "East US"
}

resource "random_string" "random" {  
  length  = 16
  special = false
}



resource "azurerm_storage_account" "my_storage_account" {
  name                     = "mystorage-${resource.random_string.random.result}"
  resource_group_name      = azurerm_resource_group.my_resource_group.name
  location                 = azurerm_resource_group.my_resource_group.location
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

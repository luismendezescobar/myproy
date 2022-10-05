terraform{
    backend "azurerm"{
        resource_group_name ="1-93db68cb-playground-sandbox"                    #variables can not be used, you have to put this manually here
        storage_account_name="mystorage1kchrcu6gu"              #"myaccount1292022"   ##this has to be created manually##       #variables can not be used, you have to put this manually here
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

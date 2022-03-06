
resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  location            = var.vnet_json_data.location
  resource_group_name = var.vnet_json_data.Resource_Grp
  address_space       = var.vnet_json_data.AddressSpace
  dns_servers         = var.vnet_json_data.dns_servers


  dynamic "subnet" {
    for_each=var.vnet_json_data.Subnets
    content{
      name=subnet.key
      address_prefix=subnet.value.address_prefix
    }
  }
}
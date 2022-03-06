locals {
  vnet_json_data = jsondecode(file("./files/config_data.json")).VirtualNetworks

}
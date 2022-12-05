/*
we are going to use this module
https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/vpc

*/

module "map_to_vpc_non_prod_module" {
    source  = "terraform-google-modules/network/google//modules/vpc"
    version = "~> 6.0.0"
    for_each = var.map_to_vpc_non_prod
    project_id   = each.value.project_id
    network_name = each.value.network_name
    shared_vpc_host = each.value.shared_vpc_host
}
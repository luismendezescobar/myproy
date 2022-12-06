/*
we are going to use this module
https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/vpc

*/

module "vpc_subnets_non_prod" {
    source  = "terraform-google-modules/network/google//modules/subnets"
    version = "~> 6.0.0"
    for_each = var.map_to_vpc_subnets_non_prod
    project_id   = each.value.project_id
    network_name = each.value.network_name
    subnets = each.value.subnets
    secondary_ranges = each.value.secondary_ranges
}
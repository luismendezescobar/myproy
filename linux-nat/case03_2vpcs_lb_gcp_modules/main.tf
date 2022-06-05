module "vpc_creation" {
  for_each = var.vpc_info
  source  = "terraform-google-modules/network/google//modules/vpc"
  version="~> 2.0.0"
  project_id              = var.project_id
  network_name            = each.key
  auto_create_subnetworks = each.value.auto_create_subnetworks

}

module "subnets_creation" {
  for_each = var.vpc_info
  source  = "terraform-google-modules/network/google//modules/subnets"
  version="~> 2.0.0"
  project_id        = var.project_id
  network_name      = each.key
  subnets           = each.value.subnetworks
  secondary_ranges  = each.value.secondary_ranges
}


module "firewall_rules" {
  for_each = var.firewall_rules
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id 
  network_name = each.value.network_name
  rules        = each.value.rules
  depends_on = [
    module.subnets_creation
  ]
}
/*
module "create_cloud_nat_gtw" {
  source                    = "./modules/create-nat"  
  depends_on = [
    module.firewall_rules
  ]
}
*/
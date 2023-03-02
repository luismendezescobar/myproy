
module "subnet_iam" {
  source = "./modules"
  for_each = var.map_to_subnet
  
  project       = each.value.project
  subnet        = each.value.subnet
  subnet_region = each.value.region
  principal     = each.value.principal

}

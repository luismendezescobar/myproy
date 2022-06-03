module "vpc_creation" {
  for_each = var.vpc_info
  source  = "terraform-google-modules/network/google//modules/vpc"
  version="~> 2.0.0"
  project_id    = var.project_id
  network_name  = each.key

}

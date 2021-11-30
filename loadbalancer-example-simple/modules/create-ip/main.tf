data "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_name  
}
data "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = var.subnet_name  
  region       = var.region  
}

/******************************************
 Creating Static Internal IP 
 *****************************************/
resource "google_compute_address" "static_internal_address" {   
  for_each = var.internal_ips

  name         = each.value.name
  subnetwork   = data.google_compute_subnetwork.network-with-private-secondary-ip-ranges.id
  address_type = "INTERNAL"  
  project      = var.project_id
  region       = var.region
}

output "testout" {
 value={for x in resource.google_compute_address.static_internal_address:x.name=>x.address}
}
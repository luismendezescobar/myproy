data "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_name  
}

data "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = var.subnet_name  
  region       = var.region  
  #network       = data.google_compute_network.vpc_network.id
}



/******************************************
 Creating Static Internal IP 
 *****************************************/
resource "google_compute_address" "static_internal_address" {   
  name         = var.name_internal_ip
  subnetwork   = data.google_compute_subnetwork.network-with-private-secondary-ip-ranges.id
  address_type = "INTERNAL"
  #address      = var.static_internal_ip
  project      = var.project_id
  region       = var.region
}



output "instance_ip_addr" {
  value       = google_compute_address.static_internal_address.address
  
}




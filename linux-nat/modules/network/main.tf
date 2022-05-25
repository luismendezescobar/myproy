locals {
  subnetworks_map = {
    for i in var.subnetworks : i.subnet_name => i
  }
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = false  
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  for_each = local.subnetworks_map

  name          = each.value.subnet_name
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = google_compute_network.vpc_network.id

}

/************firewall rule creation*************************************/


resource "google_compute_firewall" "allow_ssh" {
  name    = join(var.vpc_name,"ssh-allow")
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges=["0.0.0.0/0"]
}



/*
resource "google_compute_firewall" "allow-all-between-wsfc-nodes" {
  name    = "all-allow-wsfc"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  } 
  allow {
    protocol = "udp"
  }  
  source_tags = ["wsfc"]
  target_tags = ["wsfc"]
}

resource "google_compute_firewall" "allow-sql-to-wsfc-nodes" {
  name    = "all-sql-wsfc"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["1433"]
  }
  
  target_tags = ["wsfc-node"]
}

resource "google_compute_firewall" "allow-health-check-to-wsfc-nodes" {
  name    = "allow-health-check"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
  }
  source_ranges="130.211.0.0/22,35.191.0.0/16"

  target_tags = ["wsfc-node"]
}

*/




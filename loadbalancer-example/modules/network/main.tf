resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = false  
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}


/************firewall rule creation*************************************/

resource "google_compute_firewall" "rdp" {
  name    = "rdp-allow"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges=["0.0.0.0/0"]
}


resource "google_compute_firewall" "allow-http" {
  name    = "http-allow"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges=["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-all-between-nodes" {
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
  
}

resource "google_compute_firewall" "allow-health-check-to-wsfc-nodes" {
  name    = "allow-health-check"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
  }
  source_ranges=["130.211.0.0/22","35.191.0.0/16","209.85.204.0/22","209.85.152.0/22"]

  target_tags = ["fw-gcp-hc-all"]
}


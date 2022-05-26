resource "google_compute_firewall" "vpc_shared_ssh_allow" {
  project = var.project_id
  name    = join("-",["vpc-shared","ssh-allow"])
  network = "vpc-shared"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges=["0.0.0.0/0"]
}

resource "google_compute_firewall" "vpc_local_ssh_allow" {
  project = var.project_id
  name    = join("-",["vpc-local","ssh-allow"])
  network = "vpc-local"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges=["0.0.0.0/0"]
}
/*******************************************************************/

resource "google_compute_firewall" "vpc_shared_allow_all" {
  project = var.project_id
  name    = join("-",["vpc-shared","allow-all"])
  network = "vpc-shared"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  } 
  allow {
    protocol = "udp"
  }  
  source_ranges=["10.10.10.0/24"]
}
resource "google_compute_firewall" "vpc_local_allow_all" {
  project = var.project_id
  name    = join("-",["vpc-local","allow-all"])
  network = "vpc-local"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  } 
  allow {
    protocol = "udp"
  }  
  source_ranges=["10.10.11.0/24"]
}
/****************************************************************************/

resource "google_compute_firewall" "vpc_shared_http_allow" {
  project = var.project_id
  name    = join("-",["vpc-shared","http-allow"])
  network = "vpc-shared"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges=["0.0.0.0/0"]
}

resource "google_compute_firewall" "vpc_local_http_allow" {
  project = var.project_id
  name    = join("-",["vpc-local","http-allow"])
  network = "vpc-local"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges=["0.0.0.0/0"]
}
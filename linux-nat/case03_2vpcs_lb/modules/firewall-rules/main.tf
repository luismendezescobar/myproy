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

resource "google_compute_firewall" "vpc_shared_allow_all_internal" {
  project = var.project_id
  name    = join("-",["vpc-shared","allow-all-internal"])
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
resource "google_compute_firewall" "vpc_local_allow_all_internal" {
  project = var.project_id
  name    = join("-",["vpc-local","allow-all-internal"])
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
/**************************************************************************/
resource "google_compute_firewall" "vpc_shared_allow_from_local" {
  project = var.project_id
  name    = join("-",["vpc-shared","allow-from-local"])
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
  source_ranges=["10.10.11.0/24"]
}
resource "google_compute_firewall" "vpc_local_allow_from_shared" {
  project = var.project_id
  name    = join("-",["vpc-local","allow-from-internal"])
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
  source_ranges=["10.10.10.0/24"]
}
/***************************************************************************/
resource "google_compute_firewall" "vpc_shared_allow_health_check" {
  project = var.project_id
  name    = join("-",["vpc-shared","allow-health-check"])
  network = "vpc-shared"
  allow {
    protocol = "tcp"
  } 
  source_ranges=["130.211.0.0/22","35.191.0.0/16"]
}
resource "google_compute_firewall" "vpc_local_allow_health_check" {
  project = var.project_id
  name    = join("-",["vpc-local","allow-health-check"])
  network = "vpc-local"
  allow {
    protocol = "tcp"
  } 
  source_ranges=["130.211.0.0/22","35.191.0.0/16"]
}

















/****************************************************************************/
/*
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
*/
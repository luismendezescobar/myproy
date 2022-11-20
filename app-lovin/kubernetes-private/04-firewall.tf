
/*--------Configure firewall ----------------------------------
1. A rule to restrict access to the Cloud SQL MySQL 
instance port to only GKE nodes.
*/

resource "google_compute_firewall" "mysql" {
  name    = "allow-only-gke-cluster"
  network = google_compute_network.main_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  priority = 1000

  source_ranges = ["10.71.0.0/20"]
}
/*
2. A rule to restrict network access to kubernetes to only authorized networks. 
not needed as we are going to access from the shell
*/
/*
resource "google_compute_firewall" "web" {
  name    = "allow-only-authorized-networks"
  network = google_compute_network.custom.name

  allow {
    protocol = "tcp"
  }

  priority = 1000

  source_ranges = var.authorized_source_ranges
}
*/
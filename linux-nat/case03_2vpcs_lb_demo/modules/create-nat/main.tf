resource "google_compute_router" "router_shared_vpc" {
  name    = "my-router"
  region  = "us-east1"
  network = "vpc-shared"

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat_gtw_shared_vpc" {
  name                               = "nat-gtw-shared-vpc"
  router                             = google_compute_router.router_shared_vpc.name
  region                             = google_compute_router.router_shared_vpc.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
/*
Private connection
We need to configure private services access to allocate an 
IP address range and create a private service connection. 
This will allow resources in the Web subnet to connect 
to the Cloud SQL instance.
*/

resource "google_compute_global_address" "private-ip-peering" {
  name          = "google-managed-services-custom"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.main_vpc.id
}

resource "google_service_networking_connection" "private-vpc-connection" {
  network = google_compute_network.main_vpc.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private-ip-peering.name
  ]
}
#enable all the necesary apis

resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)  
  service = each.key
}

#first define the network and 2 subnetworks

resource "google_compute_network" "custom" {
  name                    = "custom"
  auto_create_subnetworks = "false" 
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "subnet-gke-east1" {
  name          = "subnet-gke-east1"
  ip_cidr_range = "10.71.0.0/20"
  network       = google_compute_network.custom.id
  region        = data.google_client_config.this.region

  secondary_ip_range  = [
    {
        range_name    = "pods"
        ip_cidr_range = "10.72.0.0/14"
    },
    {
        range_name    = "services"
        ip_cidr_range = "10.76.0.0/20"
    },
  ]

  private_ip_google_access = true
}

/*--------Configure firewall ----------------------------------
1. A rule to restrict access to the Cloud SQL MySQL instance port to only GKE nodes.
2. A rule to restrict network access to only authorized networks. notneeded as we are going to access from the shell
*/
/*
resource "google_compute_firewall" "mysql" {
  name    = "allow-only-gke-cluster"
  network = google_compute_network.custom.name

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  priority = 1000

  source_ranges = ["10.10.10.0/24"]
}
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


/*Represents a Global Address resource. 
Global addresses are used for HTTP(S) load balancing.*/
/*
with this command you can list the range that was created with the below terraform
resource
gcloud compute addresses list --global --filter="purpose=VPC_PEERING"
by example it's going to create the below 
ADDRESS/RANGE: 10.11.19.0/24
*/
/*
resource "google_compute_global_address" "private-ip-peering" {
  name          = "google-managed-services-custom"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.custom.id
}
*/
/*Manages a private VPC connection with a GCP service provider.*/
/*
resource "google_service_networking_connection" "private-vpc-connection" {
  network = google_compute_network.custom.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private-ip-peering.name
  ]
}
*/
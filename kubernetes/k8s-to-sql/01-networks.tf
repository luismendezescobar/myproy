#enable all the necesary apis

resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  #project = "your-project-id"
  service = each.key
}

#first define the network and 2 subnetworks

resource "google_compute_network" "custom" {
  name                    = "custom"
  auto_create_subnetworks = "false" 
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "web" {
  name          = "web"
  ip_cidr_range = "10.10.10.0/24"
  network       = google_compute_network.custom.id
  region        = var.region

  secondary_ip_range  = [
    {
        range_name    = "services"
        ip_cidr_range = "10.10.11.0/24"
    },
    {
        range_name    = "pods"
        ip_cidr_range = "10.1.0.0/20"
    }
  ]

  private_ip_google_access = true
}

resource "google_compute_subnetwork" "data" {
  name          = "data"
  ip_cidr_range = "10.20.10.0/24"
  network       = google_compute_network.custom.id
  region        = var.region

  private_ip_google_access = true
}

//////////////////////////Now we are going to create cloud NAT////////////////////////////////////////////////
resource "google_compute_address" "web" {           #internal static ip??
  name    = "web"
  region  = var.region
}

resource "google_compute_router" "web" {
  name    = "web"
  network = google_compute_network.custom.id
}

resource "google_compute_router_nat" "web" {
  name                               = "web"
  router                             = google_compute_router.web.name
  nat_ip_allocate_option             = "MANUAL_ONLY"    #How external IPs should be allocated for this NAT. MANUAL_ONLY for only user-allocated NAT IP addresses.
  nat_ips                            = [ google_compute_address.web.self_link ] # Self-links of NAT IPs. Only valid if natIpAllocateOption is set to MANUAL_ONLY.
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"   #A list of Subnetworks that are allowed to Nat (specified in the field subnetwork below).
  subnetwork {
    name                    = google_compute_subnetwork.web.id        #only web address is allowed to go outside
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  depends_on                         = [ google_compute_address.web ]
}

/*--------Configure firewall ----------------------------------
1. A rule to restrict access to the Cloud SQL MySQL instance port to only GKE nodes.
2. A rule to restrict network access to only authorized networks. notneeded as we are going to access from the shell
*/

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
resource "google_compute_global_address" "private-ip-peering" {
  name          = "google-managed-services-custom"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.custom.id
}

/*Manages a private VPC connection with a GCP service provider.*/
resource "google_service_networking_connection" "private-vpc-connection" {
  network = google_compute_network.custom.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private-ip-peering.name
  ]
}
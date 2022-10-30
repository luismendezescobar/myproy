data "google_project" "project" {
}

resource "google_container_cluster" "private" {
  provider                 = google-beta

  name                     = "private"
  location                 = data.google_project.project.region    #var.region

  network                  = google_compute_network.custom.name
  subnetwork               = google_compute_subnetwork.web.id

  private_cluster_config {    
    enable_private_nodes    = true #In a private cluster, nodes only have RFC 1918 
                                   #private addresses and communicate with 
                                   #the master's private endpoint via private networking.   
    enable_private_endpoint = true    #access through the public endpoint is disabled
    master_ipv4_cidr_block  = var.gke_master_ipv4_cidr_block  #range for the master plane
  }
  /*  for this lab we are going to access from the cloud shell 
  master_authorized_networks_config {
    dynamic "cidr_blocks" {
        for_each = var.authorized_source_ranges
        content {
            cidr_block = cidr_blocks.value
        }
    }
   }
   */
  maintenance_policy {
    recurring_window {
      start_time = "2021-06-18T00:00:00Z"
      end_time   = "2050-01-01T04:00:00Z"
      recurrence = "FREQ=WEEKLY"
    }
  }

  # Enable Autopilot for this cluster
  enable_autopilot = true

  # Configuration of cluster IP allocation for VPC-native clusters
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters.
  release_channel {
    channel = "REGULAR"
  }
}
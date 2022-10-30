data "google_client_config" "this" {  
  #get the project id and region from the provider
}

resource "google_service_account" "default" {
  account_id   = "k8s-cluster-account"
  display_name = "Service Account for kubernetes cluster"
}

resource "google_project_iam_binding" "binding" {
  dynamic  binding {
    for_each=toset(var.roles_for_gke_service_account)
    content{
      role = binding.value
      members = [
        "ServiceAccount:${resource.google_service_account.default.email}"
      ]
    }
  }  
}



resource "google_container_cluster" "private" {
  provider                 = google-beta
  name                     = "cluster-1"
  location                 = data.google_client_config.this.region  #var.region
  network                  = google_compute_network.custom.name
  subnetwork               = google_compute_subnetwork.web.id

  node_config {
    service_account = resource.google_service_account.default.email
  }


  private_cluster_config {    
    enable_private_nodes    = true #In a private cluster, nodes only have RFC 1918 
                                   #private addresses and communicate with 
                                   #the master's private endpoint via private networking.   
    enable_private_endpoint = true    #access through the public endpoint is disabled
    master_ipv4_cidr_block  = var.gke_master_ipv4_cidr_block  #range for the master plane
  }
  /*  for this lab we are going to access from the cloud shell */
  /*with this you can check your shell ip  curl checkip.dyndns.com*/
  master_authorized_networks_config {
    dynamic "cidr_blocks" {
        for_each = var.authorized_source_ranges
        content {
            cidr_block = cidr_blocks.value
        }
    }
   }
   
  maintenance_policy {
    recurring_window {
      start_time = "2021-06-18T00:00:00Z"
      end_time   = "2050-01-01T04:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=SA,SU"
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
data "google_client_config" "this" {  
  #get the project id and region from the provider
}

resource "google_service_account" "default" {
  account_id   = "k8s-cluster-account"
  display_name = "Service Account for kubernetes cluster"
}
/*we should use this one
resource "google_project_iam_member" "service-a" {
  project = "devops-v4"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.service-a.email}"
}
*/
resource "google_project_iam_binding" "binding" {  
  project= data.google_client_config.this.project
  count=length(var.roles_for_gke_service_account)
  role = var.roles_for_gke_service_account[count.index]
  members = [
    "serviceAccount:${resource.google_service_account.default.email}"
  ]     
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.project_id
  name                       = "gke-private-1"
  region                     = "us-east1"
  zones                      = ["us-east1-b", "us-east1-c", "us-east1-d"]
  network                    = resource.google_compute_network.main_vpc.name
  subnetwork                 = resource.google_compute_subnetwork.subnet-gke-east1.name
  ip_range_pods              = "gke-private-1-pods"
  ip_range_services          = "gke-private-1-services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  enable_private_endpoint    = false
  enable_private_nodes       = true
  remove_default_node_pool   = true
  release_channel            = "REGULAR"
  master_ipv4_cidr_block     = "172.16.0.0/28"
  logging_service            = "logging.googleapis.com/kubernetes"
  monitoring_service         = "monitoring.googleapis.com/kubernetes"
  identity_namespace         = "enabled" //(Default value of enabled automatically sets project-based pool [project_id].svc.id.goog)
 #master_authorized_networks= [
#     {
  #       cidr_block   = "10.0.0.0/18"
  #       display_name = "private-subnet-w-jenkins"
  #    }
  #   
  #]

  node_pools = [
    {
      name                      = "first-node-pool"
      machine_type              = "e2-small"   #"e2-standard-2"
      node_locations            = "us-east1-b" #"us-east1-b,us-east1-c,us-east1-d"
      min_count                 = 1
      max_count                 = 3
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      auto_repair               = true
      auto_upgrade              = true
      service_account           = resource.google_service_account.default.email
      preemptible               = false
      initial_node_count        = 1
    },
    {
      name                      = "spot-node-pool"
      machine_type              = "e2-standard-2"
      node_locations            = "us-east1-c"#"us-east1-b,us-east1-c,us-east1-d"
      min_count                 = 1
      max_count                 = 3
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      auto_repair               = true
      auto_upgrade              = true
      service_account           = resource.google_service_account.default.email
      preemptible               = true
      initial_node_count        = 1
    },

  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}
    first-node-pool = {
      first-node-pool = true,
      role            = "general"
    }
    spot-node-pool ={
      spot-node-pool = true,
      role           = "devops"
    }

  }

  node_pools_metadata = {
    all = {}

    first-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    first-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
    spot-node-pool = [
      {
        key    = "spot-node-pool"
        value  = true
        effect = "NO_SCHEDULE"
      },
    ]

  }

  node_pools_tags = {
    all = []

    first-node-pool = [
      "first-node-pool",
    ]
  }
}
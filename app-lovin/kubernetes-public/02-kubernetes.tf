data "google_client_config" "this" {  
  #get the project id and region from the provider
}

resource "google_service_account" "default" {
  account_id   = "k8s-cluster-account"
  display_name = "Service Account for kubernetes cluster"
}

resource "google_project_iam_binding" "binding" {  
  project= data.google_client_config.this.project
  count=length(var.roles_for_gke_service_account)
  role = var.roles_for_gke_service_account[count.index]
  members = [
    "serviceAccount:${resource.google_service_account.default.email}"
  ]     
}


module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster"
  project_id                 = var.project_id
  name                       = "gke-test-1"
  region                     = "us-east1"
  zones                      = ["us-east1-b", "us-east1-c", "us-east1-d"]
  network                    = resource.google_compute_network.custom.name
  subnetwork                 = resource.google_compute_subnetwork.subnet-gke-east1.name
  ip_range_pods              = "pods"
  ip_range_services          = "services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  istio                      = false
  cloudrun                   = false
  dns_cache                  = false

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "us-east1-b,us-east1-c,us-east1-d"
      min_count                 = 1
      max_count                 = 10
      local_ssd_count           = 0
      spot                      = false
      local_ssd_ephemeral_count = 0
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
      name                      = "another-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "us-east1-b"
      min_count                 = 1
      max_count                 = 10
      local_ssd_count           = 0
      spot                      = false
      local_ssd_ephemeral_count = 0
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
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
#https://github.com/terraform-google-modules/terraform-google-lb-http/blob/master/examples/cloudrun/main.tf


provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

resource "google_cloud_run_service" "default" {
  name     = "pets-adopt-white"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/pets-adopt-white:01"
        limits = {
            cpu    = "1000m"
            memory = "512M"
        }
        tcp_socket {
            port = 8080
        }
      }
    }
  }
  metadata {
    annotations = {
      # For valid annotation values and descriptions, see
      # https://cloud.google.com/sdk/gcloud/reference/run/deploy#--ingress
      #"run.googleapis.com/ingress" = "all"
      "run.googleapis.com/ingress"       = "internal-and-cloud-load-balancing"      
      "autoscaling.knative.dev/maxScale" = "1" # Limit scale up to prevent any cost blow outs!
      "run.googleapis.com/max-instances" = "1"
      "run.googleapis.com/cpu"           = "2"
      "run.googleapis.com/memory"        = "2Gi"
      "run.googleapis.com/platform"      = "managed"
    }
  }
}

resource "google_cloud_run_service_iam_member" "public-access" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
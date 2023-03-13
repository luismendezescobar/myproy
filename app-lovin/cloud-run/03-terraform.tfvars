project_id = "qwiklabs-gcp-01-bfc21df9e136"
region     = "us-central1"

cloud_run_map = {
  "pets-adopt-white" = {
    generate_revision_name = true
    image = "gcr.io/qwiklabs-gcp-01-bfc21df9e136/pets-adopt-white:01"
    limits = {
        cpu    = "1000m"
        memory = "512M"
    }
    location = "us-central1"
    members = [ "allUsers" ]
    ports = {
      name = "http1"
      port = 8080
    }
    project_id = "qwiklabs-gcp-01-bfc21df9e136"
    service_account_email = "431759965987-compute@developer.gserviceaccount.com"
    service_annotations = {
      "run.googleapis.com/ingress"       = "internal-and-cloud-load-balancing"            
      "run.googleapis.com/max-instances" = "2"            
      "run.googleapis.com/cpu"           = "2"
      "run.googleapis.com/memory"        = "2Gi"
      "run.googleapis.com/platform"      = "managed"
    }
    traffic_split = []
  },
  "pets-adopt-dodger" = {
    generate_revision_name = true
    image = "gcr.io/qwiklabs-gcp-01-bfc21df9e136/pets-adopt-dodge:01"
    limits = {
        cpu    = "1000m"
        memory = "512M"
    }
    location = "us-central1"
    members = [ "allUsers" ]
    ports = {
      name = "http1"
      port = 8080
    }
    project_id = "qwiklabs-gcp-01-bfc21df9e136"
    service_account_email = "431759965987-compute@developer.gserviceaccount.com"
    service_annotations = {
      "run.googleapis.com/ingress"       = "internal-and-cloud-load-balancing"            
      "run.googleapis.com/max-instances" = "3"            
      "run.googleapis.com/cpu"           = "2"
      "run.googleapis.com/memory"        = "2Gi"
      "run.googleapis.com/platform"      = "managed"
    }
    traffic_split = []
  }

}
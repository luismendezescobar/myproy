terraform {
  backend "gcs" {
    bucket  = "mybucket5-19-2022-02"
    prefix  = "nat-linux/state"
  }  
  
  required_version = "~> 1.1.0"  //terraform version required in the shell
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.23.0"       //this is the hashicorp modules version
    }
  }
}

provider "google" {
  alias = "impersonation"
  scopes = [ 
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider = google.impersonation
  target_service_account = var.tf_service_account
  scopes = ["userinfo-email","cloud-platform"]
  lifetime = "3600s"
}



provider "google" {
  project = var.project_id
  access_token = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
}
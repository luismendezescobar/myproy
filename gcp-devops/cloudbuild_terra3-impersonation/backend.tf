
terraform {
  backend "gcs" {
    bucket  = "mybucket5-19-2022-11"
    prefix  = "state"
    impersonate_service_account = "terraform@triggering-a-198-af66ffeb.iam.gserviceaccount.com"
  }  
  required_version = ">= 0.12.7"  
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "3.82.0"
      version = "~> 3.90.0, >= 3.82.0"
    }
  }
}


locals{
    terraform_service_account = var.terraform_service_account
    project_id = var.project_id
}


provider "google" { 
  alias   = "tokengen"
}
data "google_client_config" "default" {
  provider = google.tokengen
}
data "google_service_account_access_token" "sa" {
  provider               = google.tokengen
  target_service_account = local.terraform_service_account
  lifetime               = "600s"
scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}


provider "google" {  
  access_token = data.google_service_account_access_token.sa.access_token
  project      = var.project_id
}


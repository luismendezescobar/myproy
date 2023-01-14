terraform {
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = ">4.43, <=5"       //this is the hashicorp modules version
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}
provider "google-beta" {
  project = var.project_id
  region  = var.region
}

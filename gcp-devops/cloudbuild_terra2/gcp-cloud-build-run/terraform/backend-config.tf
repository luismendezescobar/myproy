terraform {
  backend "gcs" {
    bucket = "terraform-tutorial-3247"
    prefix = "state"

  }
  required_version = ">= 0.12.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.82.0"
    }
  }
}
provider "google" {

  project = var.project_id
  region  = "europe-west1"
  zone    = "europe-west1-a"
}

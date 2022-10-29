terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.71.0"
    }
  }
}

provider "google" {
  region  = "us-west1"
  project="triggering-a-198-1b0562d3"
}
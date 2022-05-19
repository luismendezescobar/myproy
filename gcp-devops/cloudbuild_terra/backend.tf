terraform {
  backend "gcs" {
    bucket  = var.terraform_bucket
    prefix  = "state"
  }  
  required_version = ">= 0.12.7"  
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "3.82.0"
    }
  }
}
provider "google" {
  project = "triggering-a-198-cfefe4f5"
  #region  = "<regione_name>"
  #zone    = "<zone_name>"
}
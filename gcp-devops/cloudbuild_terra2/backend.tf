terraform {
  backend "gcs" {
    bucket  = "mybucket5-19-2022-05"
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
  project = "triggering-a-198-05de657e"
  #region  = "<regione_name>"
  #zone    = "<zone_name>"
}
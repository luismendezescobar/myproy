terraform {
  backend "gcs" {
    bucket  = "mybucket5-19-2022-10"
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
  project = "triggering-a-198-f7b37e90"
  #region  = "<regione_name>"
  #zone    = "<zone_name>"
}
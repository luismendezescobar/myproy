terraform {
  backend "gcs" {
    bucket  = "mybucket5-19-2022-02"
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
  project = "triggering-a-198-bbf43ea6"
  #region  = "<regione_name>"
  #zone    = "<zone_name>"
}
/*we used this article
https://antonputra.com/google/create-gke-cluster-using-terraform/#gke-workload-identity-tutorial-example-2
https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/vpc
*/
terraform {
  backend "gcs" {
    bucket  = "app-lovin-tf-states"
    prefix  = "tf-state-networking"
  }  
  
  //required_version = "~> 1.3"  //terraform version required in the shell
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.43"       //this is the hashicorp modules version
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
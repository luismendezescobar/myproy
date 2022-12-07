/*we used this article
https://antonputra.com/google/create-gke-cluster-using-terraform/#gke-workload-identity-tutorial-example-2
https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/vpc
*/
terraform {
/*backend "gcs" {
    bucket  = "mybucket5-19-2022-02"
    prefix  = "state"
  }  
  */
  //required_version = "~> 1.3"  //terraform version required in the shell
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = ">=4.43,<=5"       //this is the hashicorp modules version
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
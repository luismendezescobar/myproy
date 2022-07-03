terraform {
  backend "gcs" {
    bucket  = "rd1-terraform-state-epam"
    prefix  = "workbench/gmwb-001"    
  }  
}



module "firewall-rules" {
  source = "terraform-google-modules/network/google//modules/firewall-rules"
  version = "~> 6.0"  
  
  project_id   = var.project_id
  network_name = var.network_name
  rules        = var.rules
  
}


/*
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-vpc-landing-pipe@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply -var-file=./core-vpc/02-terraform.tfvars
*/
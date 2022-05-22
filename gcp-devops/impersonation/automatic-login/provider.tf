locals {
 terraform_service_account = "luismendezescobar@gmail.com"
}
provider "google" {
 alias = "impersonation"
 scopes = [
   "https://www.googleapis.com/auth/cloud-platform",
   "https://www.googleapis.com/auth/userinfo.email",
 ]
}
data "google_service_account_access_token" "default" {
 provider               	= google.impersonation
 target_service_account 	= local.terraform_service_account
 scopes                 	= ["terraform@triggering-a-198-c6ee8586.iam.gserviceaccount.com", "cloud-platform"]
 lifetime               	= "1200s"
}

provider "google" {
 project 		= "triggering-a-198-c6ee8586"
 access_token	= data.google_service_account_access_token.default.access_token
 request_timeout 	= "60s"
 
}

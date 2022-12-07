/*
resource "gsuite_group" "example" {
  email       = "test_group@luismendeze.com"
  name        = "test_group@luismendeze.com"
  description = "Example group"
}
*/

provider "google-beta" {
  user_project_override = true
  billing_project       = "devops-369900"
}

module "group" {
  source  = "terraform-google-modules/group/google"
  version = "~> 0.1"

  id           = "example-group@luismendeze.com"
  display_name = "example-group"
  description  = "Example group"
  domain       = "luismendeze.com"
  owners       = ["luis@luismendeze.com"]
  managers     = []
  members      = ["test@luismendeze.com","devops-user01@luismendeze.com"]
}
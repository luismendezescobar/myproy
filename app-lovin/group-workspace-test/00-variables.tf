variable "project_id" {
  type    = string
  default = "devops-369900"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "owners" {
  type=list(string)
  default=["luis@luismendeze.com"]
}
variable "managers" {
  type=list(string)
  default=["test@luismendeze.com"]
}
variable "members" {
  type=list(string)
  default=["devops-user01@luismendeze.com","devops-user02@luismendeze.com"]
}


variable "project_id" {    
  type=string
  default = "devops-369900"
}

variable "region" {
  type=string
  default = "us-central1"
}

variable "domain_name" {
  type=string
  default = "luismendeze.com"
}

variable "map_for_groups" {
  type = map(object ( {
    owners       = list(string)
    members      = list(string)
  }))
}


variable "project_id" {    
  type=string
  default = "devops-369900"
}

variable "region" {
  type=string
  default = "us-central1"
}

variable "map_for_groups" {
  type = map(object ( {    
    domain       = optional(string,"luismendeze.com")
    owners       = optional(list(string))
    managers     = optional(list(string))
    description  = optional(string)
    members      = optional(list(string))
  }))
}


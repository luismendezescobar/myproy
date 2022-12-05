variable "project_id" {    
  type=string
  default = ""
}

variable "region" {
  type=string
  default = "us-east1"
}

variable "map_to_vpc_non_prod" {
  type = map(object({
    project_id       = string
    network_name     = string
    shared_vpc_host  = bool    
  }))
  default ={}
  description = "An object mapping of IAM assignment on a vpc"
}

variable "map_to_vpc_prod" {
  type = map(object({
    project_id       = string
    network_name     = string
    shared_vpc_host  = bool    
  }))
  default ={}
  description = "An object mapping of IAM assignment on a vpc"  
}

variable "project_id" {    
  type=string
  default = ""
}

variable "region" {
  type=string
  default = "us-east1"
}

variable "map_to_vpc_subnets_non_prod" {
  type = map(object({
    project_id       = string
    network_name     = string
    subnets		     = list(map(string)) 
    secondary_ranges = map(list(object({ range_name = string, ip_cidr_range = string })))
  }))
  default ={}
  description = "An object mapping of IAM assignment on a vpc"
}

variable "project_id" {    
  type=string
  default = ""
}

variable "region" {
  type=string
  default = "us-east1"
}

//this variable works for all the projects
variable "map_vpc_config" {
  type = map(object({
    project_id   = string
    network_name = string
    routing_mode = string
    subnets      = list(map(string)) 
    secondary_ranges = map(list(object({
      range_name    = string
      ip_cidr_range = string
    })))
    routes=list(map(string))
  }))
}
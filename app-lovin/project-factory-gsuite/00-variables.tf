variable "project_id" {    
  type=string
  default = ""
}

variable "region" {
  type=string
  default = "us-east1"
}

variable "map_for_project_factory" {
  type = map(object({
    name              = string
    org_id            = string    
    billing_account   = string
    folder_id         = string
    svpc_host_project_id = string

    group_name        = string
    group_role        = string        
    sa_group          = string
    shared_vpc        = string
    shared_vpc_subnets= list(string)
  }))
  default ={}
  description = "An object mapping of project factory assignment"
}


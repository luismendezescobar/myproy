variable "project_id" {    
  type=string
  default = ""
}

variable "region" {
  type=string
  default = "us-east1"
}

variable "map_to_subnet" {
  type = map(object({
    project       = string
    subnet        = string
    subnet_region = string
    principal     = list(string)
  }))
  description = "An object mapping of IAM assignment on a subnet"
}

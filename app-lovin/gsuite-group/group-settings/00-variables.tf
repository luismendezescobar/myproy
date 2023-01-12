
variable "map_for_groups" {
  type = map(object ( {    
    domain          = optional(string,"luismendeze.com")
    owners          = optional(list(string))
    managers        = optional(list(string))
    description     = optional(string)
    members         = optional(list(string))
    allow_external  = optional(bool,false)
  }))
}
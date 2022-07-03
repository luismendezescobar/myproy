variable "region" {type=string}
#variable "load_balancer_info01" {type = map }
#variable "load_balancer_info02" {type = map }
variable "health_check" {
    type = list(string)    
}
variable "mig_group" {
  type =string
}
variable "lb_name" {
  type =string
}
variable "protocol" {
  type =string
}
variable "load_balancing_scheme" {
  type =string
}
variable "session_affinity" {
  type =string
}
variable "balancing_mode" {
  type =string
}
variable "vpc" {
  type =string
}
variable "forwarding_name" {
  type =string
}
variable "ip_protocol" {
  type =string
}   
variable "all_ports" {
  type =bool
}
variable "allow_global_access" {
  type =bool
}
variable "network" {
  type =string
}
variable "subnetwork" {
  type =string
}


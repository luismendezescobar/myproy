variable "region" {type=string}
variable "load_balancer_info01" {type = map }
variable "load_balancer_info02" {type = map }
variable "health_check" {
    type = list(string)    
}
variable "mig_group" {
    type =string
}

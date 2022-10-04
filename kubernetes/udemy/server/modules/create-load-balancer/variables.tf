variable "lb_name" {
  type=string
}
variable "lb_location"{
  type = string
}
variable "azure_resource_group_name" {
  type=string  
}  
variable "resource_tags" {
  description = "Map value containing the resource tags."
  type = map
}
variable "lb_azure_subnet_id" {
  type=string
}
variable "lb-backendpool-name" {
  type=string
}
variable "lb_probe_ntc" {
  type=string
}
/*
variable "lb_probe_sql" {
  type=string
}
*/
variable "lb_rule_ntc" {
  type=string
}
/*
variable "lb_rule_sql" {
  type=string
}
*/
variable "avset_name" {
  type=string
}
variable "instances" {
  description = "Instances to be put behind the unmanaged instance group"
}
variable "cluster_front_end_ip" {
  type=string
}
/*
variable "sql_front_end_ip" {
  type=string
}
*/
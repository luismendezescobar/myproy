variable "name" {
  type = string
}
variable "project_id" {
  type = string
}
variable "layer_7_ddos_defense_config" {
  type = bool
}
variable "rule_visibility" {
  type = string
}
variable "rules" {
  type = list(object({
    action         = string
    priority       = number
    description    = string
    preview        = optional(bool)
    versioned_expr = string
    src_ip_ranges  = list(string)
    expression     = string
  }))
}

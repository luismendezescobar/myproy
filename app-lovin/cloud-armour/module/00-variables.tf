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
    rate_limit          = optional(bool,false)
    ban_duration_sec    = optional(number,0)
    conform_action      = optional(string,"allow")
    exceed_action       = optional(string,"deny(502)")
    enforce_on_key_type = optional(string,"ALL")
    rate_limit_count    = optional(number,0)
    interval_sec        = optional(number,0)    
  }))
}

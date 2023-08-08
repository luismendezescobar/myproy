variable "project_policies" {
  type = map(object({
    policy_for        = string
    project_id        = optional(string)
    constraint        = optional(string)
    policy_type       = optional(string)
    deny_list_length  = optional(string)
    deny              = optional(list(string))
  }))
}
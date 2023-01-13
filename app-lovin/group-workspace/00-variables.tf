variable "project_id" {
  type    = string
  default = "devops-369900"
}

variable "region" {
  type    = string
  default = "us-central1"
}


variable "map_for_groups" {
  type = map(object({
    domain                         = optional(string, "luismendeze.com")
    owners                         = optional(list(string))
    managers                       = optional(list(string))
    description                    = optional(string,"group created with terraform")
    members                        = optional(list(string))
    aliases                        = optional(list(string),[])
    allow_ext                      = optional(bool, false)
    allow_web_posting              = optional(bool, true)
    archive_only                   = optional(bool, false)
    enable_collaborative_inbox     = optional(bool, false)
    include_custom_footer          = optional(bool, false)
    include_in_global_address_list = optional(bool, true)
    is_archived                    = optional(bool, false)
    members_can_post_as_the_group  = optional(bool, false)
    message_moderation_level       = optional(string, "MODERATE_NONE")
    reply_to                       = optional(string, "REPLY_TO_IGNORE")
    send_message_deny_notification = optional(bool, false)
    spam_moderation_level          = optional(string, "MODERATE")
    who_can_assist_content         = optional(string, "NONE")
    who_can_contact_owner          = optional(string, "ALL_IN_DOMAIN_CAN_CONTACT")
    who_can_discover_group         = optional(string, "ALL_IN_DOMAIN_CAN_DISCOVER")
    who_can_join                   = optional(string, "ALL_IN_DOMAIN_CAN_JOIN")
    who_can_leave_group            = optional(string, "ALL_MEMBERS_CAN_LEAVE")
    who_can_moderate_content       = optional(string, "OWNERS_AND_MANAGERS")
    who_can_moderate_members       = optional(string, "OWNERS_AND_MANAGERS")
    who_can_view_group             = optional(string, "ALL_MEMBERS_CAN_VIEW")
    who_can_view_membership        = optional(string, "ALL_MEMBERS_CAN_VIEW")
  }))
}


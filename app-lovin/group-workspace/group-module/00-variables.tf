variable "id" {
  description = "ID of the group. For Google-managed entities, the ID must be the email address the group"
}
variable "display_name" {
  description = "Display name of the group"
  default     = ""
}
variable "description" {
  description = "Description of the group"
  default     = ""
}
variable "domain" {
  description = "Domain of the organization to create the group in. One of domain or customer_id must be specified"
  default     = ""
}
variable "owners" {
  description = "Owners of the group. Each entry is the ID of an entity. For Google-managed entities, the ID must be the email address of an existing group, user or service account"
  default     = []
}
variable "managers" {
  description = "Managers of the group. Each entry is the ID of an entity. For Google-managed entities, the ID must be the email address of an existing group, user or service account"
  default     = []
}
variable "members" {
  description = "Members of the group. Each entry is the ID of an entity. For Google-managed entities, the ID must be the email address of an existing group, user or service account"
  default     = []
}
variable "aliases" {
  description = "alias for the group"
  default     = []
}
variable "allow_ext" {
  description = "allow external contacts"
  default     = []
}
variable "allow_web_posting" {
  description = "allow_web_posting"
  default     = []
}
variable "archive_only" {
  description = "archive_only"
  default     = []
}
variable "enable_collaborative_inbox" {
  description = "enable_collaborative_inbox"
  default     = []
}
variable "include_custom_footer" {
  description = "include_custom_footer"
  default     = []
}
variable "include_in_global_address_list" {
  description = "include_in_global_address_list"
  default     = []
}
variable "is_archived" {
  description = "is_archived"
  default     = []
}
variable "members_can_post_as_the_group" {
  description = "members_can_post_as_the_group"
  default     = []
}
variable "message_moderation_level" {
  description = "message_moderation_level"
  default     = []
}
variable "reply_to" {
  description = "reply_to"
  default     = []
}
variable "send_message_deny_notification" {
  description = "send_message_deny_notification"
  default     = []
}
variable "spam_moderation_level" {
  description = "spam_moderation_level"
  default     = []
}
variable "who_can_assist_content" {
  description = "who_can_assist_content"
  default     = []
}
variable "who_can_contact_owner" {
  description = "who_can_contact_owner"
  default     = []
}
variable "who_can_discover_group" {
  description = "who_can_discover_group"
  default     = []
}
variable "who_can_join" {
  description = "who_can_join"
  default     = []
}
variable "who_can_leave_group" {
  description = "who_can_leave_group"
  default     = []
}
variable "who_can_moderate_content" {
  description = "who_can_moderate_content"
  default     = []
}
variable "who_can_moderate_members" {
  description = "who_can_moderate_members"
  default     = []
}
variable "who_can_view_group" {
  description = "who_can_view_group"
  default     = []
}
variable "who_can_view_membership" {
  description = "who_can_view_membership"
  default     = []
}







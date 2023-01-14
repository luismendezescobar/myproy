module "group" {
  source = "./group-module"

  for_each                       = var.map_for_groups
  id                             = "${each.key}@${each.value.domain}"
  display_name                   = each.key
  description                    = each.value.description
  domain                         = each.value.domain
  owners                         = each.value.owners != null ? each.value.owners : []
  managers                       = each.value.managers != null ? each.value.managers : []
  members                        = each.value.members != null ? each.value.members : []
  aliases                        = each.value.aliases
  allow_ext                      = each.value.allow_ext
  allow_web_posting              = each.value.allow_web_posting
  archive_only                   = each.value.archive_only
  enable_collaborative_inbox     = each.value.enable_collaborative_inbox
  include_custom_footer          = each.value.include_custom_footer
  include_in_global_address_list = each.value.include_in_global_address_list
  is_archived                    = each.value.is_archived
  members_can_post_as_the_group  = each.value.members_can_post_as_the_group
  message_moderation_level       = each.value.message_moderation_level
  reply_to                       = each.value.reply_to
  send_message_deny_notification = each.value.send_message_deny_notification
  spam_moderation_level          = each.value.spam_moderation_level
  who_can_assist_content         = each.value.who_can_assist_content
  who_can_contact_owner          = each.value.who_can_contact_owner
  who_can_discover_group         = each.value.who_can_discover_group
  who_can_join                   = each.value.who_can_join
  who_can_leave_group            = each.value.who_can_leave_group
  who_can_moderate_content       = each.value.who_can_moderate_content
  who_can_moderate_members       = each.value.who_can_moderate_members
  who_can_view_group             = each.value.who_can_view_group
  who_can_view_membership        = each.value.who_can_view_membership
}
/*
output "group_output" {
  value = module.group
}
*/

# ------------------------------------------------
# Creating required usrs and groups inside workspace
#-------------------------------------------------
resource "googleworkspace_group" "create_group" {
  email       = var.id
  name        = var.display_name
  description = var.description
  aliases     = var.aliases
}
resource "googleworkspace_group_settings" "group_settings" {
  email = googleworkspace_group.create_group.email
  allow_external_members = var.allow_ext
  allow_web_posting              = var.allow_web_posting
  archive_only                   = var.archive_only
  enable_collaborative_inbox     = var.enable_collaborative_inbox
  include_custom_footer          = var.include_custom_footer
  include_in_global_address_list = var.include_in_global_address_list
  is_archived                    = var.is_archived
  members_can_post_as_the_group  = var.members_can_post_as_the_group
  message_moderation_level       = var.message_moderation_level
  reply_to                       = var.reply_to
  send_message_deny_notification = var.send_message_deny_notification
  spam_moderation_level          = var.spam_moderation_level
  who_can_assist_content         = var.who_can_assist_content
  who_can_contact_owner          = var.who_can_contact_owner
  who_can_discover_group         = var.who_can_discover_group
  who_can_join                   = var.who_can_join
  who_can_leave_group            = var.who_can_leave_group
  who_can_moderate_content       = var.who_can_moderate_content
  who_can_moderate_members       = var.who_can_moderate_members
  who_can_view_group             = var.who_can_view_group
  who_can_view_membership        = var.who_can_view_membership
  lifecycle { ignore_changes = [is_archived] }
}
resource "googleworkspace_group_members" "group_members_add" {
  count  = var.members != null ? 1 : 0
  group_id = googleworkspace_group.create_group.id
  dynamic "members" {
    for_each = var.members
    content {
      email = members.value
      role  = "MEMBER"
    }    
  }
}
resource "googleworkspace_group_members" "group_managers_add" {  
  group_id = googleworkspace_group.create_group.id
  dynamic "members" {
    for_each = toset(var.managers)
    content {
      email = members.value
      role  = "MANAGER"
    }    
  }
}
resource "googleworkspace_group_members" "group_owners_add" {
  count  = var.owners != null ? 1 : 0
  group_id = googleworkspace_group.create_group.id
  dynamic "members" {
    for_each = var.owners
    content {
      email = members.value
      role  = "OWNER"
    }    
  }
}





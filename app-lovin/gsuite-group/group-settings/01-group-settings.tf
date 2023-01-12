/*
resource "googleworkspace_group" "sales" {
  email = "sales@example.com"
}
*/

resource "googleworkspace_group_settings" "sales-settings" {
  for_each = var.map_for_groups
  email = "${each.key}@${each.value.domain}"

  allow_external_members = each.value.allow_external

  /*
  who_can_join            = "INVITED_CAN_JOIN"
  who_can_view_membership = "ALL_MANAGERS_CAN_VIEW"
  who_can_post_message    = "ALL_MEMBERS_CAN_POST"
*/
 


}
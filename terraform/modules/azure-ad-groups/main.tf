
data "azuread_user" "member_upn" {
  for_each = var.members

  user_principal_name = each.value
}

resource "azuread_group" "group" {
  display_name               = var.display_name
  assignable_to_role         = length(var.azure_ad_role_names) > 0 ? true : false
  prevent_duplicate_names    = true
  security_enabled           = true
  auto_subscribe_new_members = false
}

resource "azuread_group_member" "group_member" {
  for_each = var.members

  group_object_id  = azuread_group.group.id
  member_object_id = data.azuread_user.member_upn[each.value].id
}
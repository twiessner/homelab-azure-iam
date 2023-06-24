
module "users" {
  for_each = var.users
  source   = "./modules/azuread/users"

  primary_domain = var.primary_domain

  account_enabled = each.value.account_enabled
  given_name      = each.value.given_name
  surname         = each.value.surname
}

module "groups" {
  for_each = var.groups
  source   = "./modules/azuread/groups"

  display_name        = each.key
  members             = each.value.members
  azure_ad_role_names = each.value.azure_ad_role_names

  depends_on = [
    module.users
  ]
}

/**
module "pim" {
  for_each = var.groups
  source   = "./modules/azuread/pim"

  group_id               = module.groups[each.key].object_id
  azure_ad_role_names    = each.value.azure_ad_role_names
  azure_rbac_assignments = each.value.azure_rbac_assignments
}
**/
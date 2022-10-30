
module "azure-ad-users" {
  for_each = var.users
  source   = "./modules/azure-ad-users"

  account_enabled     = each.value.account_enabled
  given_name          = each.value.given_name
  surname             = each.value.surname
  user_principal_name = each.value.user_principal_name
}

module "azure-ad-groups" {
  for_each = var.groups
  source   = "./modules/azure-ad-groups"

  display_name        = each.key
  members             = each.value.members
  azure_ad_role_names = each.value.azure_ad_role_names

  depends_on = [
    module.azure-ad-users
  ]
}

module "azure-ad-pim" {
  for_each = var.groups
  source   = "./modules/azure-ad-pim"

  group_id               = module.azure-ad-groups[each.key].object_id
  azure_ad_role_names    = each.value.azure_ad_role_names
  azure_rbac_assignments = each.value.azure_rbac_assignments

}
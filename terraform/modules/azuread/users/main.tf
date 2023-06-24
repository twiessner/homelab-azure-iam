
locals {
  user_principal_name = "${lower(var.given_name)}.${lower(var.surname)}@${lower(var.primary_domain)}"
}

resource "azuread_user" "user" {
  display_name        = join(" ", [var.given_name, var.surname])
  user_principal_name = local.user_principal_name
  account_enabled     = var.account_enabled

  given_name = var.given_name
  surname    = var.surname
  password   = var.password
}
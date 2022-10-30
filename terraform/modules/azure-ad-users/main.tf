
resource "azuread_user" "user" {
  display_name        = join(" ", [var.given_name, var.surname])
  user_principal_name = var.user_principal_name
  account_enabled     = var.account_enabled
  company_name        = "Homelab"
  given_name          = var.given_name
  surname             = var.surname
  password            = "$s3cur3d!"
}

variable "tenant_id" {
  type = string
}

variable "groups" {
  type = map(object({
    members             = set(string)
    azure_ad_role_names = set(string)
    azure_rbac_assignments = map(object({
      management_group_name = string
      role_name             = string
    }))
  }))
}

variable "users" {
  type = map(object({
    given_name          = string
    surname             = string
    account_enabled     = bool
    user_principal_name = string
  }))
}
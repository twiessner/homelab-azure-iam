
variable "group_id" {
  type = string
}

variable "azure_ad_role_names" {
  type = set(string)
}

variable "azure_rbac_assignments" {
  type = map(object({
    management_group_name = string
    role_name             = string
    expiration_days       = number
  }))
}
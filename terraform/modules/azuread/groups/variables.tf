
variable "display_name" {
  type = string
}

variable "members" {
  type = set(string)
}

variable "azure_ad_role_names" {
  type = set(string)
}
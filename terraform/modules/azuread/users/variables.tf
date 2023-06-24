
variable "primary_domain" {
  type = string
}

variable "account_enabled" {
  type = bool
}

variable "given_name" {
  type = string
}

variable "surname" {
  type = string
}

variable "password" {
  type    = string
  default = "$s3cur3d!"
}
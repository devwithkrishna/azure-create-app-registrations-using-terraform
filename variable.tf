variable "app_registration_name" {
  default     = "reader"
  type        = string
  description = "New azure App registration name"
}

variable "app_registration_owners" {
  type        = string
  description = "App registration owners"
}

variable "app_registration_description" {
  type    = string
  default = "Azure App registration created using terraform"
}
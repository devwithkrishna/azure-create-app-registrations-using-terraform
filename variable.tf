variable "app_registration_name" {
  default     = "test-app"
  type        = string
  description = "New azure App registration name"
}

variable "app_registration_owners" {
  type        = string
  description = "App registration owners"
}

variable "app_registration_description" {
  type        = string
  description = "Description for you app"
  default     = "Azure App registration created using terraform"
}
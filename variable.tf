variable "app_registration_name" {
  default     = "new-sp-app-test"
  type        = string
  description = "New azure App registration name"
}

variable "app_registration_owners" {
  type        = string
  description = "App registration owners"
  default     = "krishnadhasnk@gmail.com"
}

variable "app_registration_description" {
  type        = string
  description = "Description for you app"
  default     = "Azure App registration created using terraform"
}

variable "app_registration_expiry" {
  type        = string
  description = "App registration secret expiration period"
  default     = "10"
}

variable "azure_keyvalut_name" {
  type        = string
  description = "Azure Keyvault name to store secrets"
  default     = "ARCHITECTS-KEYVAULT"
}

variable "azure_keyvalut_rg_name" {
  type        = string
  description = "Azure Keyvault Rg"
  default     = "ARCHITECTS-KEYVAULT-RG"
}


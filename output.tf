output "azure_app_registration_id" {
  value = azuread_application.app.client_id
}

# output "azure_app_registration_secret" {
#   value     = nonsensitive(azuread_application_password.app.value)
#   sensitive = false
# }

output "azure_app_registation_tenant" {
  value = azuread_service_principal.sp.application_tenant_id
}

output "azure_app_registation_owners" {
  value = var.app_registration_owners
}

output "azure_app_registation_expiry_date" {
  value = azuread_application_password.app.end_date
}

output "azure_keyvault_secret_identifier" {
  value = azurerm_key_vault_secret.secret.id
}

output "azure_keyvault_secret_appid_identifier" {
  value = azurerm_key_vault_secret.app_id.id
}

output "azure_keyvault_secret_tenantid_identifier" {
  value = azurerm_key_vault_secret.tenant.id
}
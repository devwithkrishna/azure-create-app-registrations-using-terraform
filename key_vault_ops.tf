# To get tenant details
data "azurerm_client_config" "current" {}

# To get KV details
data "azurerm_key_vault" "kv_details" {
  name                = var.azure_keyvalut_name
  resource_group_name = var.azure_keyvalut_rg_name
}

# Configure Secret permissions on keyvault for automation to set secret
resource "azurerm_key_vault_access_policy" "kv" {
  key_vault_id = data.azurerm_key_vault.kv_details.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  # Secret permissions
  secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
}

# Keyvault secrets

resource "azurerm_key_vault_secret" "secret" {
  name         = upper("${var.app_registration_name}-secret")
  value        = azuread_application_password.app.value
  key_vault_id = data.azurerm_key_vault.kv_details.id
  content_type = "${var.app_registration_name}-secret"
  depends_on   = [azurerm_key_vault_access_policy.kv]
}

resource "azurerm_key_vault_secret" "app_id" {
  name         = upper("${var.app_registration_name}-appid")
  value        = azuread_application.app.client_id
  key_vault_id = data.azurerm_key_vault.kv_details.id
  content_type = "${var.app_registration_name}-appid"
  depends_on   = [azurerm_key_vault_access_policy.kv]
}

resource "azurerm_key_vault_secret" "tenant" {
  name         = upper("${var.app_registration_name}-tenant")
  value        = data.azurerm_client_config.current.tenant_id
  key_vault_id = data.azurerm_key_vault.kv_details.id
  content_type = "${var.app_registration_name}-tenantid"
  depends_on   = [azurerm_key_vault_access_policy.kv]
}

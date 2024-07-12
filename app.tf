# Get Obj ID of users to be added as owners
# data "azuread_user" "user" {
# # Splitting the owners received as a strings seperated by commas into a list using split function
#   for_each = toset(split(",", var.app_registration_owners))
#   mail     = each.value
# }
data "azuread_user" "owners" {
  for_each = toset(split(",", var.app_registration_owners))
  mail     = each.key
}


# Azure app registration 
resource "azuread_application" "app" {
  display_name = var.app_registration_name
  owners       = [for user in data.azuread_user.owners : user.object_id]
  description  = var.app_registration_description
}

# Azure app registration secret
resource "azuread_application_password" "app" {
  application_id    = azuread_application.app.id
  end_date_relative = "720h" # a month
  display_name      = "Secret Created Using Terraform"
}

# Azure service principal linked to App registration
resource "azuread_service_principal" "sp" {
  client_id   = azuread_application.app.client_id
  owners      = [for user in data.azuread_user.owners : user.object_id]
  description = var.app_registration_description
}

resource "azurerm_user_assigned_identity" "uai" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = local.managed_identity_name
  tags                = local.common_tags
}

# TODO: reduce footprint by using custom role only containing required actions
resource "azurerm_role_assignment" "vault_reader" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
}

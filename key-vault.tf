resource "azurerm_key_vault" "main" {
  name                            = local.key_vault_name
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  tenant_id                       = var.tenant_id
  sku_name                        = try(var.settings.sku_name, "standard")
  enabled_for_deployment          = try(var.settings.enabled_for_deployment, false)
  enabled_for_disk_encryption     = try(var.settings.enabled_for_disk_encryption, false)
  enabled_for_template_deployment = try(var.settings.enabled_for_template_deployment, false)
  purge_protection_enabled        = try(var.settings.purge_protection_enabled, false)
  soft_delete_retention_days      = try(var.settings.soft_delete_retention_days, 7)
  enable_rbac_authorization       = try(var.settings.enable_rbac_authorization, false)

  timeouts {
    delete = "60m"
  }

  network_acls {
    default_action             = "Deny"          # Allow / Deny
    bypass                     = "AzureServices" # AzureServices / None
    virtual_network_subnet_ids = [azurerm_subnet.websubnet.id]
    ip_rules                   = var.ip_whitelist
  }

  tags       = local.common_tags
  depends_on = []
}

resource "azurerm_key_vault_access_policy" "deployer_identity" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = var.deployer_object_id

  secret_permissions = [
    "Get", "List", "Delete", "Purge", "Set", "Backup", "Restore", "Recover"
  ]

  key_permissions = [
    "Get",
  ]
}

resource "azurerm_key_vault_access_policy" "user_assigned_managed_identity" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.uai.principal_id

  key_permissions = [
    "Get", "List",
  ]

  secret_permissions = [
    "Get", "List"
  ]
}

resource "azurerm_key_vault_secret" "mysql_conn_string" {
  name         = "bfa-mysql-conn-string"
  value        = local.bfa_mysql_db_connection_string
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault_access_policy.user_assigned_managed_identity, azurerm_key_vault_access_policy.deployer_identity]
}

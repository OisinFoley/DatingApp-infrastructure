variable "settings" {
  default = {
    sku_name                        = "standard"
    enabled_for_deployment          = true
    enabled_for_disk_encryption     = false
    enabled_for_template_deployment = false
    purge_protection_enabled        = false
    soft_delete_retention_days      = 7
    enable_rbac_authorization       = false
    public_network_access_enabled   = true
  }
  type = map(any)
}

resource "azurerm_storage_account" "storage_account" {
  name                            = local.storage_account_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_kind                    = var.storage_account_kind
  account_tier                    = var.storage_account_tier
  account_replication_type        = var.storage_replication_type
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = false
  tags                            = local.common_tags

  blob_properties {
    last_access_time_enabled = true
  }

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }
}

resource "azurerm_storage_management_policy" "web_container_to_cold_tier" {
  storage_account_id = azurerm_storage_account.storage_account.id

  rule {
    name    = "move-static-site-blobs-to-cold"
    enabled = true
    filters {
      prefix_match = ["$web"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        # enable_auto_tier_to_hot_from_cool = true
        tier_to_cool_after_days_since_last_access_time_greater_than = 1
      }
    }
  }
}

resource "azurerm_cdn_profile" "bfa" {
  name                = "${local.resource_name_prefix}-cdn-bfa"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.cdn_sku
  tags                = local.common_tags
}

resource "azurerm_cdn_endpoint" "bfa" {
  name                = var.bfa_endpoint_name
  profile_name        = azurerm_cdn_profile.bfa.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  origin {
    name      = "bobbingforapples"
    host_name = azurerm_storage_account.storage_account.primary_web_host
  }
  origin_host_header = azurerm_storage_account.storage_account.primary_web_host

  # Rules for Rules Engine
  delivery_rule {
    name  = "spaURLReroute"
    order = "1"

    url_file_extension_condition {
      operator     = "LessThan"
      match_values = ["1"]
    }

    url_rewrite_action {
      destination             = var.cdn_fallback_url
      preserve_unmatched_path = "false"
      source_pattern          = "/"
    }
  }

  delivery_rule {
    name  = "EnforceHTTPS"
    order = "2"

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }
}

# Resource-1: Create Public IP Address
resource "azurerm_public_ip" "web_linuxvm_publicip" {
  name                = local.web_linuxvm_public_ip
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = var.pip_sku
  domain_name_label   = "app1-vm-${random_string.myrandom.id}"
  tags                = local.common_tags
}

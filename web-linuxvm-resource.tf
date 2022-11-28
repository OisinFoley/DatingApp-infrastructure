# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name                  = local.web_linuxvm_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.web_linuxvm_sku
  admin_username        = var.web_linuxvm_username
  network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]
  admin_ssh_key {
    username   = var.web_linuxvm_username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.web_linuxvm_osdisk_storage_type
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("web-linuxvm-init-script.tftpl", {
    web_linuxvm_username                  = var.web_linuxvm_username
    web_linuxvm_api_repo_url              = var.web_linuxvm_api_repo_url
    web_linuxvm_app_token                 = var.web_linuxvm_app_token
    web_linuxvm_app_cloudinary_name       = var.web_linuxvm_app_cloudinary_name
    web_linuxvm_app_cloudinary_api_key    = var.web_linuxvm_app_cloudinary_api_key
    web_linuxvm_app_cloudinary_api_secret = var.web_linuxvm_app_cloudinary_api_secret
    key_vault_name                        = local.key_vault_name
    key_vault_mysql_conn_string_name      = azurerm_key_vault_secret.mysql_conn_string.name
  }))
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uai.id]
  }
}

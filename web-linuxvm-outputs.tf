## Public IP Address
output "web_linuxvm_public_ip" {
  description = "Web Linux VM Public Address"
  value       = azurerm_public_ip.web_linuxvm_publicip.ip_address
}

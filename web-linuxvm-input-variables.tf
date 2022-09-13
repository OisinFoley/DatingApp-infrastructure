# Linux VM Input Variables Placeholder file.
# Database Subnet Address Space
variable "web_linuxvm_sku" {
  description = "Virtual Machine SKU Size"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "web_linuxvm_username" {
  description = "Virtual Machine Username"
  type        = string
  default     = "oisinfoley"
}

variable "web_linuxvm_osdisk_storage_type" {
  description = "Storage Type of Underlying VM Disk"
  type        = string
  default     = "Standard_LRS"
}

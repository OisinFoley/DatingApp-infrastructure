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

variable "web_linuxvm_app_token" {
  description = "Web token for dating app"
  type        = string
}

variable "web_linuxvm_app_cloudinary_name" {
  description = "Name of account used for storing Cloudinary photo assets"
  type        = string
}

variable "web_linuxvm_app_cloudinary_api_key" {
  description = "API key for use when storing Cloudinary photo assets"
  type        = string
  default     = ""
}

variable "web_linuxvm_app_cloudinary_api_secret" {
  description = "Secret for use when storing Cloudinary photo assets"
  type        = string
  default     = ""
}

variable "web_linuxvm_api_repo_url" {
  description = "URL of git repo"
  type        = string
  default     = ""
}

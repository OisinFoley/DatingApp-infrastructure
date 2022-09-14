variable "storage_account_kind" {
  type    = string
  default = "StorageV2"
}

variable "storage_account_tier" {
  type    = string
  default = "Standard"
}

variable "storage_replication_type" {
  type    = string
  default = "ZRS"
}

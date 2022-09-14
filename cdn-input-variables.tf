variable "cdn_sku" {
  description = "SKU for CDN service"
  type        = string
  default     = "Standard_Microsoft"
}

variable "cdn_fallback_url" {
  description = "Fallback URL for not found static site path"
  type        = string
  default     = "/index.html"
}

variable "bfa_endpoint_name" {
  description = "Name to describe Bobbing for Apples endpoint"
  type        = string
  default     = "bobbing-for-apples"
}

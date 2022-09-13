# Generic Input Variables

# Business Division
variable "business_division" {
  description = "Business Division in the organization this Infrastructure belongs"
  type        = string
  default     = "oisinprj"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "dev"
}

variable "region_abbreviation" {
  description = "Region abbreviation to be used as suffix"
  type        = string
  default     = "eun" # Eu North
}

# Azure Resources Location
variable "resource_group_location" {
  description = "Region in which Azure Resources to be created"
  type        = string
  default     = "northeurope"
}

variable "project_contact" {
  description = "tag value to indicate who is responsible for project"
  type        = string
  default     = "oisinfoley@yahoo.co.uk"
}

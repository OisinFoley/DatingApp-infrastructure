# Define Local Values in Terraform
locals {
  owners      = var.business_division
  environment = var.environment
  common_tags = {
    owners         = local.owners
    environment    = local.environment
    workload       = "personal project"
    classification = "non-business"
    criticality    = "low"
    business_unit  = "none"
    responsibility = var.project_contact
    budget         = "n/a"
    start_date     = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
    end_date       = "to be decided"
    service_class  = "dev"
    ticket_number  = "n/a"
  }
  resource_name_prefix          = "${var.business_division}-${var.environment}-${var.region_abbreviation}"
  resource_name_prefix_dashless = "${var.business_division}${var.environment}${var.region_abbreviation}"
  resource_group_name           = "${local.resource_name_prefix}-rg"
  virtual_network_name          = "${local.resource_name_prefix}-vnet"
  subnet_web_name               = "${var.web_subnet_name}-${local.resource_name_prefix}"
  nsg_web_subnet                = "${local.subnet_web_name}-nsg"
  web_linuxvm_prefix            = "web-bobbing-for-apples-linuxvm"
  web_linuxvm_name              = "${local.resource_name_prefix}-${local.web_linuxvm_prefix}"
  web_linuxvm_nic_name          = "${local.resource_name_prefix}-${local.web_linuxvm_prefix}-nic"
  web_linuxvm_public_ip         = "${local.resource_name_prefix}-${local.web_linuxvm_prefix}-publicip"
  managed_identity_name         = "${local.resource_name_prefix}-user-assigned-mid"
  key_vault_name                = "${local.resource_name_prefix_dashless}kv"
  storage_account_name          = "${local.resource_name_prefix_dashless}str"
}

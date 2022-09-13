# Dating App Infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.web_linuxvm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.web_linuxvm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.web_vmnic_nsg_associate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.web_subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.web_vmnic_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.web_nsg_rule_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.web_nsg_rule_outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.web_vmnic_nsg_rule_inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.web_linuxvm_publicip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.websubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.web_subnet_nsg_associate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_string.myrandom](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_business_division"></a> [business\_division](#input\_business\_division) | Business Division in the organization this Infrastructure belongs | `string` | `"oisinprj"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Variable used as a prefix | `string` | `"dev"` | no |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | public ip sku | `string` | `"Standard"` | no |
| <a name="input_project_contact"></a> [project\_contact](#input\_project\_contact) | tag value to indicate who is responsible for project | `string` | `"oisinfoley@yahoo.co.uk"` | no |
| <a name="input_region_abbreviation"></a> [region\_abbreviation](#input\_region\_abbreviation) | Region abbreviation to be used as suffix | `string` | `"eun"` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Region in which Azure Resources to be created | `string` | `"northeurope"` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Virtual Network address\_space | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_web_linuxvm_osdisk_storage_type"></a> [web\_linuxvm\_osdisk\_storage\_type](#input\_web\_linuxvm\_osdisk\_storage\_type) | Storage Type of Underlying VM Disk | `string` | `"Standard_LRS"` | no |
| <a name="input_web_linuxvm_sku"></a> [web\_linuxvm\_sku](#input\_web\_linuxvm\_sku) | Virtual Machine SKU Size | `string` | `"Standard_DS1_v2"` | no |
| <a name="input_web_linuxvm_username"></a> [web\_linuxvm\_username](#input\_web\_linuxvm\_username) | Virtual Machine Username | `string` | `"oisinfoley"` | no |
| <a name="input_web_subnet_address"></a> [web\_subnet\_address](#input\_web\_subnet\_address) | Virtual Network Web Subnet Address Spaces | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_web_subnet_name"></a> [web\_subnet\_name](#input\_web\_subnet\_name) | Virtual Network Web Subnet Name | `string` | `"snet-web"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | Virtual Network ID |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | Virtual Network Name |
| <a name="output_web_linuxvm_public_ip"></a> [web\_linuxvm\_public\_ip](#output\_web\_linuxvm\_public\_ip) | Web Linux VM Public Address |
| <a name="output_web_subnet_id"></a> [web\_subnet\_id](#output\_web\_subnet\_id) | WebTier Subnet ID |
| <a name="output_web_subnet_name"></a> [web\_subnet\_name](#output\_web\_subnet\_name) | WebTier Subnet Name |
| <a name="output_web_subnet_nsg_id"></a> [web\_subnet\_nsg\_id](#output\_web\_subnet\_nsg\_id) | WebTier Subnet NSG ID |
| <a name="output_web_subnet_nsg_name"></a> [web\_subnet\_nsg\_name](#output\_web\_subnet\_nsg\_name) | WebTier Subnet NSG Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

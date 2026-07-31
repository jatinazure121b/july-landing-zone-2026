resource "azurerm_subnet" "subnet" {
 for_each = var.rgx
 name =  each.value.subnet
 resource_group_name = each.value.rg
 virtual_network_name = each.value.vnet
 address_prefixes = each.value.subnet_address
}
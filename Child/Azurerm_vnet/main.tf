resource "azurerm_virtual_network" "vnet" {
for_each = var.rgx
name = each.value.vnet
address_space = each.value.vnet_address
location = each.value.location
resource_group_name = each.value.rg
  
}
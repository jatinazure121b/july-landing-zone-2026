resource "azurerm_network_security_group" "nsg" {
 for_each = var.rgx
name = each.value.nsg
location = each.value.location
resource_group_name = each.value.rg

  security_rule {
    name                       = each.value.security_rule.name
    priority                   = each.value.security_rule.priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
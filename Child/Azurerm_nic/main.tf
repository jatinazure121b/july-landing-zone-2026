resource "azurerm_network_interface" "nic" {
 for_each = var.rgx
  name                = each.value.nic
  location            = each.value.location
  resource_group_name = each.value.rg

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id = data.azurerm_subnet.subnet_id[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip_id[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

data "azurerm_subnet" "subnet_id" {
  for_each = var.rgx
  name                 = each.value.subnet
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rg
}
data "azurerm_public_ip" "pip_id" {

  for_each = var.rgx
  name                = each.value.pip
  resource_group_name = each.value.rg
}
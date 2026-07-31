resource "azurerm_lb" "lb" {
    for_each = var.rgx
  name                = each.value.lb
  location            = each.value.location
  resource_group_name = each.value.rg

  frontend_ip_configuration {
    name                 = "each.value.fronend_ip.PublicIP"
    public_ip_address_id = data.azurerm_public_ip.pip_id[each.key].id
  }
}

data "azurerm_public_ip" "pip_id" {
  for_each = var.rgx
  name                = each.value.pip
  resource_group_name = each.value.rg
}
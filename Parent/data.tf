data "azurerm_subnet" "subnet_id" {
  depends_on           = [module.subnet]
  for_each = var.rgx
  name                 = each.value.subnet
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rg
}

data "azurerm_public_ip" "pip_id" {
  depends_on          = [module.pip]
  for_each = var.rgx
  name                = each.value.pip
  resource_group_name = each.value.rg
}

data "azurerm_network_interface" "nic" {
  depends_on          = [module.nic]
  for_each = var.rgx
  name                = each.value.nic
  resource_group_name = each.value.rg
}
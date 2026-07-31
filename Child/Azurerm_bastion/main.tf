resource "azurerm_subnet" "subnet-bastion" {
for_each = var.rgx
  name = each.value.bastionsub
 resource_group_name = each.value.rg
 virtual_network_name = each.value.vnet
  address_prefixes = each.value.bastsubaddr
}

resource "azurerm_bastion_host" "bastion" {
    depends_on = [ azurerm_subnet.subnet-bastion ]

  for_each = var.rgx
  name                = each.value.bastion
  location            = each.value.location
  resource_group_name = each.value.rg

  ip_configuration {
    name                 = each.value.configuration.name
    subnet_id = data.azurerm_subnet.subnet_bastion[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip_id[each.key].id
  }
}

data "azurerm_public_ip" "pip_id" {

  for_each = var.rgx
  name                = each.value.pip
  resource_group_name = each.value.rg
}

data "azurerm_subnet" "subnet_bastion" {
      depends_on = [ azurerm_subnet.subnet-bastion ]
  for_each = var.rgx
  name                 = each.value.bastionsub
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rg
}
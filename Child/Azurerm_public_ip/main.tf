resource "azurerm_public_ip" "pip10" {
    for_each = var.rgx
    name = each.value.pip
  location = each.value.location
  resource_group_name = each.value.rg
allocation_method = "Static"
}
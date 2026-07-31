resource "azurerm_resource_group" "rg" {
for_each = var.rgx
name  = each.value.rg
location = each.value.location
  }
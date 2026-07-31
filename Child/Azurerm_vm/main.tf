resource "azurerm_virtual_machine" "vm" {
    for_each = var.rgx
  name = each.value.vm
  location = each.value.location
  resource_group_name = each.value.rg
  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id]  
  vm_size               = "Standard_D2s_v3"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "vmadmin1"
    admin_password = "Password@1234"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  
}
data "azurerm_network_interface" "nic" {
  for_each = var.rgx
  name                = each.value.nic
  resource_group_name = each.value.rg
}
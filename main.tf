resource "azurerm_resource_group" "rg" {
  for_each = var.nic
  name     = each.value.nic_rg
  location = each.value.location
}

resource "azurerm_virtual_network" "vnet" {
  depends_on          = [azurerm_resource_group.rg]
  for_each            = var.nic
  name                = each.value.nic_vnet
  address_space       = each.value.nic_address
  resource_group_name = each.value.nic_rg
  location            = each.value.location
}

resource "azurerm_subnet" "subnet" {
  depends_on           = [azurerm_virtual_network.vnet]
  for_each             = var.nic
  name                 = each.value.nic_subnet
  virtual_network_name = each.value.nic_vnet
  address_prefixes     = each.value.nic_subnet_address
  resource_group_name  = each.value.nic_rg
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nic
  name                = each.value.nic_nsg
  location            = each.value.location
  resource_group_name = each.value.nic_rg

  security_rule {
    name                       = each.value.rule_name
    priority                   = each.value.nic_priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_public_ip" "pip" {
  depends_on          = [azurerm_subnet.subnet]
  for_each            = var.nic
  name                = each.value.nic_pip
  location            = each.value.location
  resource_group_name = each.value.nic_rg
  allocation_method   = "Static"
}

data "azurerm_subnet" "subnetid" {
  depends_on           = [azurerm_subnet.subnet]
  for_each             = var.nic
  name                 = each.value.nic_subnet
  virtual_network_name = each.value.nic_vnet
  resource_group_name  = each.value.nic_rg
}

data "azurerm_public_ip" "pipid" {
  depends_on          = [azurerm_public_ip.pip]
  for_each            = var.nic
  name                = each.value.nic_pip
  resource_group_name = each.value.nic_rg
}

resource "azurerm_network_interface" "nic" {
  depends_on          = [azurerm_subnet.subnet]
  for_each            = var.nic
  name                = each.value.nic_name
  resource_group_name = each.value.nic_rg
  location            = each.value.location
  ip_configuration {
    name                          = each.value.nic_config
    subnet_id                     = data.azurerm_subnet.subnetid[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.pipid[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

data "azurerm_network_interface" "nic" {
  depends_on          = [azurerm_network_interface.nic]
  for_each            = var.nic
  name                = each.value.nic_name
  resource_group_name = each.value.nic_rg
}
resource "azurerm_virtual_machine" "vm" {
  depends_on            = [azurerm_network_interface.nic]
  for_each              = var.nic
  name                  = each.value.nic_vm
  location              = each.value.location
  resource_group_name   = each.value.nic_rg
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
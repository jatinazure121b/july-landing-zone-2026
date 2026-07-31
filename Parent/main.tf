module "rg" {
  source = "../Child/Azurerm_resource_group"
  rgx    = var.rgx
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../Child/Azurerm_vnet"
  rgx        = var.rgx

}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../Child/Azurerm_subnet"
  rgx        = var.rgx
}

module "nic" {
  depends_on = [module.subnet]
  source     = "../Child/Azurerm_nic"
  rgx        = var.rgx
}

module "pip" {
  depends_on = [module.subnet]
  source     = "../Child/Azurerm_public_ip"
  rgx        = var.rgx
}
module "nsg" {
  depends_on = [module.rg]
  source     = "../Child/Azurerm_nsg"
  rgx        = var.rgx
}

module "vm" {
  depends_on = [module.nic]
  source     = "../Child/Azurerm_vm"
  rgx        = var.rgx
}

module "bastion" {
  depends_on = [module.vm]
  source     = "../Child/Azurerm_bastion"
  rgx        = var.rgx
}

module "loadbalance" {
  depends_on = [module.bastion, module.pip]
  source     = "../Child/azurerm_loadbalance"
  rgx        = var.rgx
}

module "appgw" {
  depends_on = [module.vm, module.pip]
  source     = "../Child/Azurerm_appgw"
  rgx        = var.rgx
}
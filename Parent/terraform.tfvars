rgx = {
  rg1 = {
    rg             = "rg100"
    location       = "centralindia"
    vnet           = "vnet10"
    vnet_address   = ["10.0.0.0/16"]
    subnet         = "Frontend"
    subnet_address = ["10.0.0.0/24"]
    bastionsub = "AzureBastionSubnet"
    bastsubaddr = ["10.0.3.0/24"]
    subnetgw = "subnet-gw"
    subnet_appgw = ["10.0.1.0/24"]
    nic            = "nic10"
    ip_configuration = {
      name = "internal1"
    }
    nsg = "nsg10"
    security_rule = {
      name     = "sgr10"
      priority = "100"
    }
    pip     = "pip10"
    bastion = "bastion10"
    configuration = {
      name = "configuration1"
    }
    frontend_ip = {
      name = "PublicIP1"
    }
    vm = "vm10"
    lb    = "loadbalance10"
    appgw = "application-gw10"
  }

}
